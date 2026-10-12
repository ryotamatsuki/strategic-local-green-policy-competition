"""Stage 4A independent adversarial symbolic certificate; canonical witness only.

Rebuilds the five-region joint-welfare quadratic from primitives, using a
different code architecture from research/stage4_global_consent_exact_certificate.py.
Separately checks the host-welfare *relaxation*, including kink/monopoly,
and the antisymmetric policy curvature. SymPy only; not a formal Lean proof.
"""
import sympy as S

T=S.Rational(9,10)
kx=S.Integer(4); kg=S.Integer(18); mu=S.Rational(9,10)
nu=S.Rational(6,5); kappa=S.Rational(4,5); d=S.Integer(2)
e=S.Rational(11,10); beta=S.Rational(17,10); xi=S.Rational(1,10)
m=S.Integer(2); R=1/kx+mu**2/kg
D=4-T*T; L=2-4*R/D
s1,h1,s2,h2=S.symbols("s1 h1 s2 h2")
control=S.Matrix([s1,h1,s2,h2])
w1=m+mu*s1/kg+nu*h1
w2=m+mu*s2/kg+nu*h2

def welfare(q1,q2,u1,u2):
    # Scalar investment reduction comes from cost minimization at fixed u.
    x1,x2=u1/(R*kx),u2/(R*kx)
    g1,g2=s1/kg+mu*u1/(R*kg),s2/kg+mu*u2/(R*kg)
    emissions1=e*q1-beta*g1-xi*h1
    emissions2=e*q2-beta*g2-xi*h2
    cs=(q1*q1+q2*q2)/2+T*q1*q2
    def regional(q,x,g,h,em):
        return cs/2+q*q-kx*x*x/2-kg*g*g/2-kappa*h*h/2-d*em*em/2
    return regional(q1,x1,g1,h1,emissions1),regional(q2,x2,g2,h2,emissions2)

def region(label):
    if label=="D":
        q1=(L*w1-T*w2)/(L*L-T*T)
        q2=(L*w2-T*w1)/(L*L-T*T)
        u1,u2=(2-L)*q1,(2-L)*q2
    elif label=="K1":
        q1,q2=w2/T,S.Integer(0)
        u1,u2=2*q1-w1,S.Integer(0)
    elif label=="K2":
        q1,q2=S.Integer(0),w1/T
        u1,u2=S.Integer(0),2*q2-w2
    elif label=="M1":
        q1,q2=w1/(2-R),S.Integer(0)
        u1,u2=R*q1,S.Integer(0)
    elif label=="M2":
        q1,q2=S.Integer(0),w2/(2-R)
        u1,u2=S.Integer(0),R*q2
    else: raise ValueError(label)
    return welfare(q1,q2,u1,u2)

def exact_unconstrained_quadratic_max(F,vars):
    H=S.hessian(F,vars)
    # Sylvester test, and *not* a numerical eigenvalue approximation.
    minors=[S.factor((-H)[:i,:i].det()) for i in range(1,len(vars)+1)]
    assert all(c>0 for c in minors),(minors,F)
    affine=S.Matrix([S.diff(F,x) for x in vars])
    zero={x:S.Integer(0) for x in vars}
    critical=(-H.inv()*affine.subs(zero))
    pt=dict(zip(vars,critical))
    assert all(S.factor(S.diff(F,x).subs(pt))==0 for x in vars)
    return pt,S.factor(F.subs(pt)),minors

branches={}
for label in ["D","K1","K2","M1","M2"]:
    parts=region(label)
    branches[label]=exact_unconstrained_quadratic_max(sum(parts),control)

maximums={name:r[1] for name,r in branches.items()}
assert maximums["D"]==S.Rational(674272009120,181241003453)
assert maximums["K1"]==maximums["K2"]==S.Rational(75653929312,18482408001)
assert maximums["M1"]==maximums["M2"]==S.Rational(3691600,362551)
assert maximums["M1"]>maximums["K1"]>maximums["D"]
M1pt=branches["M1"][0]
assert M1pt[s1]>0 and M1pt[h1]>0 and M1pt[s2]==M1pt[h2]==0
assert S.factor((T*w1-(2-R)*w2).subs(M1pt))>0

# Selected noncooperative outside option: do not assume global policy NE
# uniqueness; that existence has a separate earlier certificate.
s,h=S.symbols("s h")
wa_duo,_=region("D")
zero_sym={s1:s,s2:s,h1:h,h2:h}
gf=S.Matrix([S.diff(wa_duo,z).subs(zero_sym) for z in [s1,h1]])
eqs=S.linear_eq_to_matrix(gf,[s,h]); zne=eqs[0].inv()*eqs[1]
nept={s1:zne[0],s2:zne[0],h1:zne[1],h2:zne[1]}
outside=S.factor(wa_duo.subs(nept))
assert outside==S.Rational(2129482118801677362193413324880,1947443098557072400775535945289)

# Unilateral host-zero-rival model uses a freer investment variable U. In
# both monopoly and limit-price-kink: U >= R*q, q=(w1+U)/2.
U=S.symbols("U",real=True)
q=(w1+U)/2
host=S.expand(welfare(q,S.Integer(0),U,S.Integer(0))[0])
host_hessian=S.hessian(host,[s1,h1,U])
host_minors=[S.factor((-host_hessian)[:i,:i].det()) for i in (1,2,3)]
assert all(x>0 for x in host_minors)
hostM=region("M1")[0]
host_pt,host_upper,_=exact_unconstrained_quadratic_max(hostM,[s1,h1])
assert host_upper==S.Rational(1753200,2071201)
qhost=w1.subs(host_pt)/(2-R)
constr=S.expand(U-R*q)
test_pt={**host_pt,U:R*qhost}
lm=S.factor(-S.diff(host,U).subs(test_pt)/S.diff(constr,U))
assert lm==S.Rational(177112000,122200859)>0
for x in (s1,h1,U):
    assert S.factor((S.diff(host,x)+lm*S.diff(constr,x)).subs(test_pt))==0
assert S.factor(constr.subs(test_pt))==0
assert outside>host_upper
# NB the inactive firm's subsidized green investment s2/kg is already
# accounted in the joint W of the K1 and M1 regions above.

Cpt=branches["D"][0]
assert Cpt[s1]==Cpt[s2] and Cpt[h1]==Cpt[h2]
assert S.factor((L*w1-T*w2).subs(Cpt))>0
assert S.factor((L*w2-T*w1).subs(Cpt))>0
waC,wbC=region("D")
assert S.factor(waC.subs(Cpt))>outside
assert S.factor(wbC.subs(Cpt))>outside

# At M1 aggregate quadratic optimum, the gradients of the *excluded*
# jurisdiction's policies vanish at their zero bounds: not strict KKT
# complementarity. This does not invalidate the fixed-witness theorem.
m1_joint=sum(region("M1"))
assert S.diff(m1_joint,s2).subs(M1pt)==0
assert S.diff(m1_joint,h2).subs(M1pt)==0

print("REGION SUPREMA:",{k:float(v) for k,v in maximums.items()})
print("GLOBAL FREE-COORDINATOR POLICY:",M1pt)
print("VOLUNTARY GLOBAL-COORDINATOR POLICY:",Cpt)
print("IR HOST BOUND INCLUDING KINK:",host_upper,"NE:",outside)
print("INDEPENDENT EXACT FIVE-REGIME AND KKT PASS")
