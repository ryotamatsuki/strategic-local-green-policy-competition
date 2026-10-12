"""Stage 4A N1 independent primitive-payoff audit (SymPy exact rationals).

Does not import the Stage-4 construction code. Independently reconstructs
investment COSTS, Cournot region actions, regional welfare, firm-exit host
envelope, policy deviation upper bounds and symmetry classes. Baseline
model/benchmark claims are conditional on the exhibited local-policy SPNE.
"""
import sympy as S
from itertools import combinations

Q=S.Rational
a,b,c,d=S.symbols("sA hA sB hB")
x=[a,b,c,d]
T=S.symbols("theta")

def primitive(theta,mu=Q(9,10),invkx=Q(1,4)):
    kg=18;R=invkx+mu*mu/kg;D=4-theta*theta
    L=2-4*R/D
    wA=2+mu*a/kg+Q(6,5)*b
    wB=2+mu*c/kg+Q(6,5)*d
    def regional(qA,qB,uA,uB):
        q=[qA,qB];u=[uA,uB]
        cs=(qA*qA+qB*qB)/2+theta*qA*qB
        out=[]
        for i,(sub,infra) in enumerate(((a,b),(c,d))):
            green=sub/kg+mu*u[i]/(R*kg)
            investment_cost=invkx*u[i]**2/(2*R**2)+kg*green**2/2
            emissions=Q(11,10)*q[i]-Q(17,10)*green-Q(1,10)*infra
            out.append(S.expand(cs/2+q[i]*q[i]-investment_cost
                                -Q(2,5)*infra**2-emissions**2))
        return out
    def regime(label):
        if label=="both":
            qA=(L*wA-theta*wB)/(L*L-theta*theta)
            qB=(L*wB-theta*wA)/(L*L-theta*theta)
            uA=4*R*qA/D;uB=4*R*qB/D
        elif label=="kink":
            qA=wB/theta;qB=S.Integer(0)
            uA=2*qA-wA;uB=S.Integer(0)
        else:
            qA=wA/(2-R);qB=S.Integer(0)
            uA=R*qA;uB=S.Integer(0)
        return regional(qA,qB,uA,uB)
    return R,L,wA,wB,regional,regime

def negative_definite(f,variables):
    h=S.hessian(f,variables)
    assert all(S.factor((-h)[:i,:i].det())>0 for i in range(1,len(variables)+1))

def critical(f,variables):
    h=S.hessian(f,variables)
    grad=S.Matrix([S.diff(f,v) for v in variables])
    vec=-h.inv()*grad.subs({v:0 for v in variables})
    p=dict(zip(variables,vec))
    assert all(S.factor(S.diff(f,v).subs(p))==0 for v in variables)
    return p,S.factor(f.subs(p))

def outside(theta,regime):
    s,h=S.symbols("s h")
    A=regime("both")[0]
    common={a:s,b:h,c:s,d:h}
    gradients=S.Matrix([S.diff(A,v).subs(common) for v in (a,b)])
    z=-gradients.jacobian([s,h]).inv()*gradients.subs({s:0,h:0})
    p={a:z[0],b:z[1],c:z[0],d:z[1]}
    W=S.factor(A.subs(p))
    assert all(v>0 for v in p.values())
    return p,W

def host_upper(R,wA,regional,regime):
    u=S.symbols("u")
    q=(wA+u)/2
    f=regional(q,S.Integer(0),u,S.Integer(0))[0]
    mono=regime("monopoly")[0]
    negative_definite(mono,[a,b])
    p,v=critical(mono,[a,b])
    pt={**p,u:R*wA.subs(p)/(2-R)}
    constraint=u-R*q
    H=-S.hessian(f,[a,b,u])
    principal=[S.factor(H.extract(list(c),list(c)).det())
               for k in (1,2,3) for c in combinations(range(3),k)]
    assert all(vv>=0 for vv in principal)  # no-x may be semidefinite
    lm=S.factor(-S.diff(f,u).subs(pt)/S.diff(constraint,u))
    assert lm>=0
    assert S.factor(constraint.subs(pt))==0
    assert all(S.factor((S.diff(f,vv)+lm*S.diff(constraint,vv)).subs(pt))==0
               for vv in (a,b,u))
    return v

def symmetric_candidate(F):
    s,h=S.symbols("s h")
    restricted=S.expand(F.subs({a:s,c:s,b:h,d:h}))
    negative_definite(restricted,[s,h])
    p,v=critical(restricted,[s,h])
    return {a:p[s],c:p[s],b:p[h],d:p[h]},v

def audit_full(theta):
    R,L,wa,wb,pay,reg=primitive(theta)
    A,B=reg("both");F=A+B
    pne,out=outside(theta,reg)
    # Crucial: the coalition's outside option must be a TRUE stage-1 global
    # best-response policy, not a convenient active-branch stationary point.
    rival={c:pne[c],d:pne[d]}
    assert S.factor(theta*wb.subs(rival)-2*L)<0
    own=S.expand(A.subs(rival))
    negative_definite(own,[a,b])
    pbest,bestval=critical(own,[a,b])
    assert pbest[a]==pne[a] and pbest[b]==pne[b] and bestval==out
    for other_region in ("kink","monopoly"):
        alt=S.expand(reg(other_region)[0].subs(rival))
        negative_definite(alt,[a,b])
        _,ub=critical(alt,[a,b])
        assert ub<out
    assert out>host_upper(R,wa,pay,reg)
    p,vs=symmetric_candidate(F)
    assert all(v>0 for v in p.values())
    assert all(S.factor(v.subs(p))>0 for v in (L*wa-theta*wb,L*wb-theta*wa))
    assert all(S.factor(W.subs(p))>out for W in (A,B))
    if theta in (Q(1,10),Q(7,10),Q(9,10)):
        for region in ("both","kink","monopoly"):
            negative_definite(sum(reg(region)),x)
        negative_definite(F,x)
        global_p,global_W=critical(F,x)
        assert global_p==p and global_W==vs
        print("BASELINE",theta,"unique globally symmetric",float(vs))
    else:
        H=S.hessian(F,x)
        # Exact coercivity on the nonnegative orthant despite
        # the active-duopoly Hessian being indefinite on signed R^4.
        Hp=S.Matrix(4,4,lambda i,j:H[i,j] if i==j or H[i,j]>0 else 0)
        negative_definite(S.expand((S.Matrix(x).T*Hp*S.Matrix(x))[0]),x)
        for region in ("kink","monopoly"):
            negative_definite(sum(reg(region)),x)
        q={a:p[a]+Q(1,10),b:p[b]+Q(1,20),
           c:p[c]-Q(1,10),d:p[d]-Q(1,20)}
        gain=S.factor(F.subs(q)-vs)
        assert gain>0 and all(v>0 for v in q.values())
        assert all(S.factor(v.subs(q))>0 for v in (L*wa-theta*wb,L*wb-theta*wa))
        assert all(S.factor(W.subs(q))>out for W in (A,B))
        # Closed nonempty IR set, globally continuous and coercive welfare
        # -> at least one maximum. Strict gain rules out all symmetric maxima.
        print("BASELINE",theta,"all global maximizers asymmetric",gain)

def audit_nested(theta,mu,invkx):
    R,L,wa,wb,pay,reg=primitive(theta,mu,invkx)
    A,B=reg("both");F=A+B
    negative_definite(F,x)
    p_ne,out=outside(theta,reg)
    rival={c:p_ne[c],d:p_ne[d]}
    # For all own nonnegative actions: wa >=2. Inactive A is impossible.
    assert S.factor(theta*wb.subs(rival)-2*L)<0
    unilateral=S.expand(A.subs(rival))
    negative_definite(unilateral,[a,b])
    best,top=critical(unilateral,[a,b])
    assert top==out and best[a]==p_ne[a] and best[b]==p_ne[b]
    for region in ("kink","monopoly"):
        f=S.expand(reg(region)[0].subs(rival))
        H=S.hessian(f,[a,b])
        if S.factor(H.det())==0:
            assert S.diff(f,a)==0
            negative_definite(f,[b])
            _,v=critical(f,[b])
        else:
            negative_definite(f,[a,b])
            _,v=critical(f,[a,b])
        assert v<out
    ceiling=host_upper(R,wa,pay,reg)
    assert ceiling<out
    best,top=critical(F,x)
    sym,v_sym=symmetric_candidate(F)
    assert best==sym and top==v_sym and all(v>0 for v in best.values())
    assert all(S.factor(v.subs(best))>0 for v in (L*wa-theta*wb,L*wb-theta*wa))
    assert all(S.factor(W.subs(best))>out for W in (A,B))
    print("NESTED",theta,"mu=",mu,"1/kx=",invkx,
          "unique symmetric IR optimum",float(top),
          "host ceiling",float(ceiling),"outside",float(out))

for t in (Q(1,10),Q(3,10),Q(1,2),Q(7,10),Q(9,10)):
    audit_full(t)
for t in (Q(3,10),Q(1,2)):
    audit_nested(t,S.Integer(0),Q(1,4))
    audit_nested(t,Q(9,10),S.Integer(0))
print("Stage 4A N1 independent primitive reconstruction: PASS")
