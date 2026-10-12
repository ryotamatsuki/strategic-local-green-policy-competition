"""Exact-rational Stage 5 benchmark: green investment has no productivity effect.

Check that a non-transfer voluntary coordinator refuses single-firm output,
even when mu=0. This is intentionally adverse evidence for novelty.
Requires SymPy. Not a result about globally unique government NE.
"""
import sympy as S
Q=S.Rational
t=Q(9,10);R=Q(1,4);D=4-t*t;L=2-4*R/D
sa,ha,sb,hb=S.symbols("sa ha sb hb")
z=[sa,ha,sb,hb]
wa=2+Q(6,5)*ha;wb=2+Q(6,5)*hb

def payoff(qa,qb,ua,ub):
    cs=(qa*qa+qb*qb)/2+t*qa*qb
    ea=Q(11,10)*qa-Q(17,10)*sa/18-Q(1,10)*ha
    eb=Q(11,10)*qb-Q(17,10)*sb/18-Q(1,10)*hb
    a=cs/2+qa*qa-ua*ua/(2*R)-sa*sa/36-Q(2,5)*ha*ha-ea*ea
    b=cs/2+qb*qb-ub*ub/(2*R)-sb*sb/36-Q(2,5)*hb*hb-eb*eb
    return a,b

def region(r):
    if r=="D":
        qa=(L*wa-t*wb)/(L*L-t*t);qb=(L*wb-t*wa)/(L*L-t*t)
        ua=4*R*qa/D;ub=4*R*qb/D
    elif r=="K":
        qa=wb/t;qb=0;ua=2*qa-wa;ub=0
    else:
        qa=wa/(2-R);qb=0;ua=R*qa;ub=0
    return payoff(qa,qb,ua,ub)

def quadratic_opt(f,variables):
    H=S.hessian(f,variables)
    assert all(S.factor((-H)[:i,:i].det())>0 for i in range(1,len(variables)+1))
    grad=S.Matrix([S.diff(f,x) for x in variables])
    pt=-H.inv()*grad.subs({x:0 for x in variables})
    vals=dict(zip(variables,pt))
    return vals,S.factor(f.subs(vals))

scores={r:quadratic_opt(sum(region(r)),z) for r in ("D","K","M")}
assert scores["M"][1]>scores["D"][1]>scores["K"][1]
assert all(v>=0 for v in scores["M"][0].values())
assert S.factor((t*wa-(2-R)*wb).subs(scores["M"][0]))>0

u=S.symbols("u");q=(wa+u)/2
host=payoff(q,0,u,0)[0]
hostpt,hostmax=quadratic_opt(region("M")[0],[sa,ha])
assert hostmax==Q(175320,284107)
qh=wa.subs(hostpt)/(2-R)
pt={**hostpt,u:R*qh}
constraint=u-R*q
lm=S.factor(-S.diff(host,u).subs(pt)/S.diff(constraint,u))
assert lm==Q(408080,284107)>0
assert all(S.factor((S.diff(host,x)+lm*S.diff(constraint,x)).subs(pt))==0
           for x in (sa,ha,u))
s,h=S.symbols("s h")
A=region("D")[0]
sym={sa:s,sb:s,ha:h,hb:h}
g=S.Matrix([S.diff(A,v).subs(sym) for v in (sa,ha)])
v=-g.jacobian([s,h]).inv()*g.subs({s:0,h:0})
nept={sa:v[0],sb:v[0],ha:v[1],hb:v[1]}
neW=S.factor(A.subs(nept))
assert neW>hostmax
coopt=scores["D"][0]
assert coopt[sa]==coopt[sb] and coopt[ha]==coopt[hb]
assert all(x>0 for x in coopt.values())
assert S.factor(A.subs(coopt))>neW
print("mu=0 region upper bounds", {x:float(v[1]) for x,v in scores.items()})
print("mu=0 host welfare maximum",hostmax,"versus outside option",neW)
print("PASS: the global consent-vs-exit contrast persists without mu.")
