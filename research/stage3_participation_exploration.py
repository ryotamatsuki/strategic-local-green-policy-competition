"""Stage 3 hypothesis-only numerical exploration.

Compares full piecewise nonnegative Cournot/investment continuation under:
(i) an unrestricted aggregate-welfare coordinator;
(ii) coordinator with voluntary regional participation, W_i >= exhibited NE W_i.

Outputs are numerical *candidates*, not certified global optima.
No redistributive transfers are allowed. No new primitive is introduced.
Requires numpy, scipy. SciPy is for this exploratory research file only;
not in the root pinned verification dependencies.
"""
import numpy as np
from scipy.optimize import differential_evolution, root, minimize

def state(z,t,kx=4.,kg=18.,mu=.9,nu=1.2,kappa=.8,d=2.,e=1.1,beta=1.7,xi=.1,m=2.):
    sA,hA,sB,hB = z
    R=1/kx+mu**2/kg
    D=4-t*t
    L=2-4*R/D
    wA=m+mu*sA/kg+nu*hA
    wB=m+mu*sB/kg+nu*hB
    if t>0 and t*wA >= (2-R)*wB:
        regime="A-monopoly";qA=wA/(2-R);qB=0.;la=qA;lb=0.
    elif t>0 and t*wB >= (2-R)*wA:
        regime="B-monopoly";qA=0.;qB=wB/(2-R);la=0.;lb=qB
    elif t>0 and t*wA >= L*wB:
        regime="A-kink";qA=wB/t;qB=0.;la=(2*wB/t-wA)/R;lb=0.
    elif t>0 and t*wB >= L*wA:
        regime="B-kink";qA=0.;qB=wA/t;la=0.;lb=(2*wA/t-wB)/R
    else:
        regime="duopoly"
        qA=(L*wA-t*wB)/(L*L-t*t)
        qB=(L*wB-t*wA)/(L*L-t*t)
        la=4*qA/D;lb=4*qB/D
    xA,xB=la/kx,lb/kx
    gA,gB=(sA+mu*la)/kg,(sB+mu*lb)/kg
    ea=e*qA-beta*gA-xi*hA
    eb=e*qB-beta*gB-xi*hB
    CS=.5*(qA*qA+qB*qB)+t*qA*qB
    wa=CS/2+qA*qA-kx*xA*xA/2-kg*gA*gA/2-kappa*hA*hA/2-d*ea*ea/2
    wb=CS/2+qB*qB-kx*xB*xB/2-kg*gB*gB/2-kappa*hB*hB/2-d*eb*eb/2
    return np.array([wa,wb]),regime,(qA,qB),(ea,eb)

def ne_policy(t):
    def grad(x):
        s,h=x; eps=2e-5
        def own(s2,h2):return state([s2,h2,s,h],t)[0][0]
        return np.array([(own(s+eps,h)-own(s-eps,h))/(2*eps),
                         (own(s,h+eps)-own(s,h-eps))/(2*eps)])
    sol=root(grad,np.array([3.,1.]),tol=1e-10)
    assert sol.success and min(sol.x)>0, (t,sol.message,sol.x)
    s,h=sol.x
    return sol.x,state([s,h,s,h],t)[0][0]

def unrestricted(t):
    obj=lambda z:-state(z,t)[0].sum()
    result=differential_evolution(obj,[(0,100)]*4,seed=12,popsize=12,
                                  maxiter=230,tol=1e-8,polish=True)
    return result.x, -result.fun

def participation(t,baseline):
    # Multistart local optimization; NOT global certification.
    objective=lambda z:-state(z,t)[0].sum()
    constraint={"type":"ineq","fun":lambda z:state(z,t)[0]-baseline}
    starts=[[3,1,3,1],[20,10,0,0],[0,0,20,10],
            [12,7,12,7],[30,18,1,0],[1,0,30,18],
            [5,3,12,7],[12,7,5,3]]
    feasible=[]
    for start in starts:
        x=minimize(objective,start,bounds=[(0,100)]*4,
                   constraints=[constraint],method="SLSQP",
                   options={"maxiter":600,"ftol":1e-10})
        if x.success and np.min(state(x.x,t)[0]-baseline)>-1e-6:
            feasible.append((x.x,-x.fun))
    assert feasible
    return max(feasible,key=lambda x:x[1])

if __name__=="__main__":
    for t in (.3,.5,.7,.9):
        ne,base=ne_policy(t)
        u,uw=unrestricted(t)
        p,pw=participation(t,base)
        uinfo=state(u,t); pinfo=state(p,t)
        print(f"theta={t} exhibited NE={ne.round(6)}, each regional welfare={base:.6f}")
        print(f" unrestricted candidate W={uw:.6f}, policy={u.round(4)}, regime={uinfo[1]}, regional W={uinfo[0].round(4)}")
        print(f" participation candidate W={pw:.6f}, policy={p.round(4)}, regime={pinfo[1]}, regional W={pinfo[0].round(4)}")
        assert np.min(pinfo[0]) >= base-1e-6
    print("HYPOTHESIS ONLY: all global/threshold/uniqueness results remain unproved")
