"""Stage 4 N1: exact rivalry reentrant symmetry and nested-model separation.
No numerical policy boxes. All arithmetic is SymPy Rational.
Models: canonical full, mu=0, and no conventional R&D, with selected
noncooperative global policy outside option independently challenged
for both nested models at theta=3/10 and 1/2.
"""
import sympy as S
from itertools import combinations

Q=S.Rational
sa,ha,sb,hb=S.symbols("sa ha sb hb")
z=[sa,ha,sb,hb];s,h=S.symbols("s h")
kg=18;nu=Q(6,5);kap=Q(4,5);e=Q(11,10);beta=Q(17,10);xi=Q(1,10)

def mk(invkx,mu,t):
    R=invkx+mu**2/kg
    D=4-t*t;L=2-4*R/D
    wa=2+mu*sa/kg+nu*ha
    wb=2+mu*sb/kg+nu*hb
    def welfare(qa,qb,ua,ub):
        ga=sa/kg+mu*ua/(R*kg)
        gb=sb/kg+mu*ub/(R*kg)
        ea=e*qa-beta*ga-xi*ha
        eb=e*qb-beta*gb-xi*hb
        cs=(qa*qa+qb*qb)/2+t*qa*qb
        A=cs/2+qa*qa-ua*ua/(2*R)-sa*mu*ua/(R*kg)-sa*sa/(2*kg)-kap*ha*ha/2-ea*ea
        B=cs/2+qb*qb-ub*ub/(2*R)-sb*mu*ub/(R*kg)-sb*sb/(2*kg)-kap*hb*hb/2-eb*eb
        return S.expand(A),S.expand(B)
    def branch(name):
        if name=="D":
            qa=(L*wa-t*wb)/(L*L-t*t)
            qb=(L*wb-t*wa)/(L*L-t*t)
            ua=4*R*qa/D;ub=4*R*qb/D
        elif name=="K":
            qa=wb/t;qb=0;ua=2*qa-wa;ub=0
        else:
            qa=wa/(2-R);qb=0;ua=R*qa;ub=0
        return welfare(qa,qb,ua,ub)
    return R,L,wa,wb,welfare,branch

def negdef(f,x):
    H=S.hessian(f,x)
    minor=[S.factor((-H)[:k,:k].det()) for k in range(1,len(x)+1)]
    assert all(v>0 for v in minor),minor
    return minor

def critical(f,x):
    H=S.hessian(f,x)
    G=S.Matrix([S.diff(f,v) for v in x])
    point=-H.inv()*G.subs({v:0 for v in x})
    P=dict(zip(x,point))
    return P,S.factor(f.subs(P))

def ne(b):
    A,_=b("D")
    sy={sa:s,ha:h,sb:s,hb:h}
    g=S.Matrix([S.diff(A,sa).subs(sy),S.diff(A,ha).subs(sy)])
    pt=-g.jacobian([s,h]).inv()*g.subs({s:0,h:0})
    p={sa:pt[0],ha:pt[1],sb:pt[0],hb:pt[1]}
    assert all(v>0 for v in p.values())
    return p,S.factor(A.subs(p))

def host_bound(R,wa,welfare,b):
    # Every sole-operating-firm continuation (including K) obeys u>=R*q.
    u=S.symbols("u")
    q=(wa+u)/2
    host=welfare(q,0,u,0)[0]
    hm=b("M")[0]
    negdef(hm,[sa,ha])
    p,value=critical(hm,[sa,ha])
    Qhost={**p,u:S.factor(R*wa.subs(p)/(2-R))}
    condition=u-R*q
    assert S.factor(condition.subs(Qhost))==0
    H=-S.hessian(host,[sa,ha,u])
    mins=[S.factor(H.extract(list(c),list(c)).det())
          for k in (1,2,3) for c in combinations(range(3),k)]
    assert all(v>=0 for v in mins)
    lam=S.factor(-S.diff(host,u).subs(Qhost)/S.diff(condition,u))
    assert lam>=0
    assert all(S.factor((S.diff(host,v)+lam*S.diff(condition,v)).subs(Qhost))==0
               for v in [sa,ha,u])
    return value

def full(t):
    R,L,wa,wb,welfare,b=mk(Q(1,4),Q(9,10),t)
    A,B=b("D");F=A+B
    p_ne,out=ne(b)
    host=host_bound(R,wa,welfare,b)
    assert out>host
    if t in [Q(1,10),Q(7,10),Q(9,10)]:
        for kind in ("D","K","M"):negdef(sum(b(kind)),z)
        p,v=critical(F,z)
        assert p[sa]==p[sb] and p[ha]==p[hb]
        assert all(x>0 for x in p.values())
        assert all(S.factor(x.subs(p))>0 for x in [L*wa-t*wb,L*wb-t*wa])
        assert A.subs(p)>out and B.subs(p)>out
        print("FULL UNIQUE SYMMETRIC",t,"aggregate welfare",float(v))
    else:
        H=S.hessian(F,z)
        # For nonnegative controls, z'H z <= z'Hplus z, where
        # Hplus discards negative OFF-DIAGONAL entries, not diagonal entries.
        Hplus=S.Matrix(4,4,lambda i,j:H[i,j] if i==j or H[i,j]>0 else 0)
        negdef(S.expand((S.Matrix(z).T*Hplus*S.Matrix(z))[0]/2),z)
        negdef(sum(b("K")),z);negdef(sum(b("M")),z)
        # Therefore global joint welfare is coercive on the full nonnegative
        # policy orthant (five continuation regimes).
        sy={sa:s,ha:h,sb:s,hb:h}
        f_sym=S.expand(F.subs(sy));negdef(f_sym,[s,h])
        q,_=critical(f_sym,[s,h])
        p={sa:q[s]+Q(1,10),ha:q[h]+Q(1,20),
           sb:q[s]-Q(1,10),hb:q[h]-Q(1,20)}
        gain=S.factor(F.subs(p)-f_sym.subs(q))
        assert gain>0
        assert all(x.subs(p)>0 for x in [sa,ha,sb,hb,L*wa-t*wb,L*wb-t*wa])
        assert A.subs(p)>out and B.subs(p)>out
        print("FULL ALL GLOBAL OPTIMA ASYMMETRIC",t,
              "strict witness gain",gain)

def reduced(inv,mu,t):
    R,L,wa,wb,welfare,b=mk(inv,mu,t)
    A,B=b("D");F=A+B
    negdef(F,z)
    pne,out=ne(b)
    # Independent full-policy unilateral challenger audit for nested cases:
    fixed={sb:pne[sb],hb:pne[hb]}
    assert S.factor(t*wb.subs(fixed)-2*L)<0   # B kink/monopoly infeasible for all own policies
    own=S.expand(A.subs(fixed));negdef(own,[sa,ha])
    opt,ownbest=critical(own,[sa,ha])
    assert opt[sa]==pne[sa] and opt[ha]==pne[ha]
    assert ownbest==out
    for name in ("K","M"):
        challenger=S.expand(b(name)[0].subs(fixed))
        H=S.hessian(challenger,[sa,ha])
        if H.det()==0:
            assert S.diff(challenger,sa)==0
            negdef(challenger,[ha])
            _,upper=critical(challenger,[ha])
        else:
            negdef(challenger,[sa,ha])
            _,upper=critical(challenger,[sa,ha])
        assert upper<out,(name,upper,out)
    host=host_bound(R,wa,welfare,b)
    assert host<out
    p,v=critical(F,z)
    assert p[sa]==p[sb] and p[ha]==p[hb]
    assert all(x>0 for x in p.values())
    assert all(x.subs(p)>0 for x in [L*wa-t*wb,L*wb-t*wa])
    assert A.subs(p)>out and B.subs(p)>out
    print("NESTED UNIQUE SYMMETRIC",("mu=0" if not mu else "no-x"),t,
          "welfare",float(v),"outside",float(out),"host bound",float(host))

for t in (Q(1,10),Q(3,10),Q(1,2),Q(7,10),Q(9,10)):
    full(t)
for t in (Q(3,10),Q(1,2)):
    reduced(Q(1,4),S.Integer(0),t)
    reduced(S.Integer(0),Q(9,10),t)
print("PASS exact Stage-4 N1 full-game finite-interval, coercivity, and parent benchmarks")
