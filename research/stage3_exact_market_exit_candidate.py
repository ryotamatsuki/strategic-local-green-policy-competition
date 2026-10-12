"""Stage 3 research hypothesis — exact rational one-sided market-exit branch.
Not a proof of global planner optimality, novelty or voluntary implementation.
Frozen canonical model, theta may vary in the regime where A monopoly is feasible.
Run: python research/stage3_exact_market_exit_candidate.py
"""
import sympy as S
Sx, H = S.symbols("s_A h_A", real=True)
kx,kg,mu,nu,kappa,d,e,beta,xi,m=(
    S.Integer(4),S.Integer(18),S.Rational(9,10),S.Rational(6,5),
    S.Rational(4,5),S.Integer(2),S.Rational(11,10),
    S.Rational(17,10),S.Rational(1,10),S.Integer(2)
)
R=1/kx+mu**2/kg
wA=m+mu*Sx/kg+nu*H
qA=wA/(2-R)
xA=qA/kx
gA=(Sx+mu*qA)/kg
EA=e*qA-beta*gA-xi*H
CS=qA**2/2
PS_A=qA**2-kx*xA**2/2-kg*gA**2/2
W_A=S.expand(CS/2+PS_A-kappa*H**2/2-d*EA**2/2)
W_B=CS/2
Wsum=S.expand(W_A+W_B)
Hess=S.hessian(Wsum,(Sx,H))
assert Hess[0,0]<0 and Hess.det()>0
sol=S.solve((S.diff(Wsum,Sx),S.diff(Wsum,H)),(Sx,H),rational=True)
assert sol[Sx]>=0 and sol[H]>=0
theta_min=S.factor((2-R)*m/wA.subs(sol))
assert theta_min==S.Rational(362551,2647720)
assert S.factor(Wsum.subs(sol))==S.Rational(3691600,362551)
wa=S.factor(W_A.subs(sol));wb=S.factor(W_B.subs(sol))
assert wa<0 and wb>0
print("Exact A-monopoly-branch policy optimum:",sol)
print("Welfare A:",wa,float(wa))
print("Welfare B:",wb,float(wb))
print("Aggregate welfare:",S.factor(wa+wb),float(wa+wb))
print("Continuation A-monopoly admissible when theta >=",theta_min, float(theta_min))
print("NOT A CERTIFICATE OF GLOBAL PLANNER OPTIMUM")
