"""Exact-rational local-consent monopoly exclusion lemma, canonical theta=9/10.

Conditional on fixed original firm game and exhibited symmetric policy SPNE:
- max over ALL own nonnegative policies of *host region* welfare while its
  firm alone operates is strictly less than the host's preagreement SPNE welfare.
- Thus no unilateral-hosting monopoly continuation satisfies both local IR
  constraints under a no-transfer unanimous coordination agreement.

This is a global upper bound on hosting-region welfare *within a firm-monopoly
continuation*, NOT a theorem that a welfare-maximizing planner chooses monopoly,
and NOT an all-theta or all-primitives proof.
"""
import sympy as S
t=S.Rational(9,10)
kx,kg,mu,nu,kappa,d,e,beta,xi,m=(
    S.Integer(4),S.Integer(18),S.Rational(9,10),S.Rational(6,5),
    S.Rational(4,5),S.Integer(2),S.Rational(11,10),
    S.Rational(17,10),S.Rational(1,10),S.Integer(2)
)
R=1/kx+mu**2/kg
sA,hA,sB,hB=S.symbols("sA hA sB hB",real=True)
wA=m+mu*sA/kg+nu*hA; wB=m+mu*sB/kg+nu*hB

# Exhibit the preagreement policy SPNE (as independently certified upstream).
D=4-t*t; L=2-4*R/D; Delta=L*L-t*t
qA=(L*wA-t*wB)/Delta; qB=(L*wB-t*wA)/Delta
xA=4*qA/(D*kx);gA=(sA+4*mu*qA/D)/kg
cs=(qA*qA+qB*qB)/2+t*qA*qB
WA_D=cs/2+qA*qA-kx*xA*xA/2-kg*gA*gA/2-kappa*hA*hA/2-d*(e*qA-beta*gA-xi*hA)**2/2
s,h=S.symbols("s h")
sym={sA:s,sB:s,hA:h,hB:h}
f1=S.diff(WA_D,sA).subs(sym);f2=S.diff(WA_D,hA).subs(sym)
NE=S.solve((f1,f2),(s,h),rational=True)
W_NE=S.factor(WA_D.subs({sA:NE[s],sB:NE[s],hA:NE[h],hB:NE[h]}))

# If B is inactive, the active A firm's equilibrium operating output and
# investment are independent of B's positive policy levels. The upper
# bound below therefore holds for any B policies consistent with A monopoly.
q=wA/(2-R);x=q/kx;g=(sA+mu*q)/kg
WA_M=q*q/4+q*q-kx*x*x/2-kg*g*g/2-kappa*hA*hA/2-d*(e*q-beta*g-xi*hA)**2/2
Hess=S.hessian(WA_M,(sA,hA))
assert Hess[0,0]<0 and S.factor(Hess.det())>0
opt=S.solve((S.diff(WA_M,sA),S.diff(WA_M,hA)),(sA,hA),rational=True)
assert opt[sA]>0 and opt[hA]>0
W_HOST_MAX=S.factor(WA_M.subs(opt))
assert W_HOST_MAX==S.Rational(1753200,2071201)
gap=S.factor(W_NE-W_HOST_MAX)
assert gap>0
print("exhibited theta=9/10 SPNE policies:",NE)
print("W_i at exhibited SPNE:",W_NE, float(W_NE))
print("own-optimal HOST policies on monopoly branch:",opt)
print("UNRESTRICTED HOST WELFARE UPPER BOUND on any A-monopoly continuation:",W_HOST_MAX,float(W_HOST_MAX))
print("IR violation gap (exact):",gap,float(gap))
print("PASS exact: no-transfer regional individual rationality rules out A/B monopoly at theta=9/10 canonical witness")
