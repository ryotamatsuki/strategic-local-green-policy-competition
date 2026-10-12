"""Exact Stage-4 global planner vs no-transfer local-consent certificate.

Canonical rational witness theta=9/10; full duopoly, A/B kink, A/B
monopoly downstream continuations. No policy box or numerical optimizer.
Requirements: sympy. This verifies economic mathematics, NOT novelty.
"""
import sympy as S
t=S.Rational(9,10)
kx,kg=4,18
mu,nu=S.Rational(9,10),S.Rational(6,5)
kappa,d=S.Rational(4,5),2
e,beta,xi,m=S.Rational(11,10),S.Rational(17,10),S.Rational(1,10),2
R=S.Rational(59,200);D=4-t*t;L=2-4*R/D
sa,ha,sb,hb=S.symbols("sa ha sb hb",real=True)
Z=[sa,ha,sb,hb];wa=m+mu*sa/kg+nu*ha;wb=m+mu*sb/kg+nu*hb

def welfare(reg):
    if reg=="D":
        qa=(L*wa-t*wb)/(L*L-t*t);qb=(L*wb-t*wa)/(L*L-t*t)
        ua=4*R*qa/D;ub=4*R*qb/D
    elif reg=="AK":
        qa=wb/t;qb=S.Integer(0);ua=2*qa-wa;ub=S.Integer(0)
    elif reg=="BK":
        qb=wa/t;qa=S.Integer(0);ub=2*qb-wb;ua=S.Integer(0)
    elif reg=="AM":
        qa=wa/(2-R);qb=S.Integer(0);ua=R*qa;ub=S.Integer(0)
    elif reg=="BM":
        qb=wb/(2-R);qa=S.Integer(0);ub=R*qb;ua=S.Integer(0)
    else:raise ValueError(reg)
    xa,xb=ua/(R*kx),ub/(R*kx)
    ga,gb=(sa+mu*ua/R)/kg,(sb+mu*ub/R)/kg
    ea=e*qa-beta*ga-xi*ha;eb=e*qb-beta*gb-xi*hb
    cs=(qa*qa+qb*qb)/2+t*qa*qb
    a=cs/2+qa*qa-kx*xa*xa/2-kg*ga*ga/2-kappa*ha*ha/2-d*ea*ea/2
    b=cs/2+qb*qb-kx*xb*xb/2-kg*gb*gb/2-kappa*hb*hb/2-d*eb*eb/2
    return a,b

def strict_concavity(f,variables):
    H=S.hessian(f,variables)
    v=[S.factor((-H)[:k,:k].det()) for k in range(1,len(variables)+1)]
    assert all(x>0 for x in v),v
    return v

def max_quadratic(f,variables):
    strict_concavity(f,variables)
    grad=[S.diff(f,x) for x in variables]
    M,b=S.linear_eq_to_matrix(grad,variables)
    xx=M.inv()*b
    pos=dict(zip(variables,xx))
    assert all(S.factor(g.subs(pos))==0 for g in grad)
    return pos,S.factor(f.subs(pos))

bounds={};argmax={}
for name in ["D","AK","BK","AM","BM"]:
    a,b=welfare(name)
    argmax[name],bounds[name]=max_quadratic(a+b,Z)
assert bounds["D"]==S.Rational(674272009120,181241003453)
assert bounds["AK"]==bounds["BK"]==S.Rational(75653929312,18482408001)
assert bounds["AM"]==bounds["BM"]==S.Rational(3691600,362551)
assert bounds["AM"]>bounds["AK"]>bounds["D"]
p=argmax["AM"]
assert p[sa]==S.Rational(11078064,362551)
assert p[ha]==S.Rational(6458100,362551)
assert p[sb]==p[hb]==0
assert S.factor((t*wa-(2-R)*wb).subs(p))>0
assert all(x>=0 for x in p.values())

# Selected preagreement symmetric SPNE from unilateral FOCs.
WAd,_=welfare("D")
s,h=S.symbols("s h")
sym={sa:s,sb:s,ha:h,hb:h}
g=[S.diff(WAd,x).subs(sym) for x in (sa,ha)]
M,b=S.linear_eq_to_matrix(g,[s,h]);ne=M.inv()*b
z_ne={sa:ne[0],sb:ne[0],ha:ne[1],hb:ne[1]}
Wne=S.factor(WAd.subs(z_ne))
assert Wne==S.Rational(2129482118801677362193413324880,1947443098557072400775535945289)

# Exact host upper bound covering BOTH inactive-rival continuations.
# At A monopoly u=R*q; at A limit-pricing kink u>=R*q.
u=S.symbols("u",real=True)
q=(wa+u)/2;x=u/(R*kx);green=(sa+mu*u/R)/kg
E=e*q-beta*green-xi*ha
Host=S.Rational(5,4)*q*q-kx*x*x/2-kg*green*green/2-kappa*ha*ha/2-d*E*E/2
strict_concavity(Host,[sa,ha,u])
WHm,_=welfare("AM")
hostopt,W_host=max_quadratic(WHm,[sa,ha])
assert W_host==S.Rational(1753200,2071201)
qopt=S.factor((wa/(2-R)).subs(hostopt))
z_host={**hostopt,u:R*qopt}
condition=u-R*q
mult=S.factor(-S.diff(Host,u).subs(z_host)/S.diff(condition,u))
assert mult==S.Rational(177112000,122200859)>0
assert S.factor(condition.subs(z_host))==0
assert all(S.factor(S.diff(Host,v).subs(z_host)+mult*S.diff(condition,v))==0 for v in (sa,ha,u))
assert all(v>0 for v in z_host.values())
assert Wne>W_host
# Since Host is globally concave and u-Rq >=0 on ALL A-only output
# branches, this KKT point is their *global* maximum; symmetric for B.
# Hence an IR-feasible coalition must retain both firms active.

coop=argmax["D"]
assert coop[sa]==coop[sb] and coop[ha]==coop[hb]
assert all(v>0 for v in coop.values())
assert all(S.factor(a.subs(coop))>0 for a in [L*wa-t*wb,L*wb-t*wa])
regional=S.factor(WAd.subs(coop))
assert 2*regional==bounds["D"] and regional>Wne
print("FULL GLOBAL UNRESTRICTED COORDINATOR: one operating firm in A or B")
print("  W_total =",bounds["AM"],"=",float(bounds["AM"]))
print("  A-monopoly policy:",p)
print("HOST IR BOUND inclusive of kink:",W_host,"=",float(W_host))
print("exhibited preagreement SPNE regional welfare:",Wne,"=",float(Wne))
print("VOLUNTARY no-transfer GLOBAL COORDINATOR: both firms active")
print("  exact unique policies:",coop)
print("  W_total =",bounds["D"],"=",float(bounds["D"]))
print("PASSED exact rational 5-regime T1; external Stage 4A and novelty gates still required")
