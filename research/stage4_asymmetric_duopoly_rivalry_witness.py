"""Stage-4 exact finite rivalry comparison: theta=.3/.5 vs theta=.9.

Shows that at low/intermediate rivalry, symmetric *consent-compatible*
coordination is strictly dominated by an admissible asymmetric duopoly
policy. At theta=.9 separate five-regime certificate proves unique symmetric
consent optimum. It does NOT prove a unique global switching threshold.
"""
import sympy as S

kx,kg=4,18
mu,nu=S.Rational(9,10),S.Rational(6,5)
kappa,d=S.Rational(4,5),2
e,beta,xi,m=S.Rational(11,10),S.Rational(17,10),S.Rational(1,10),2
R=S.Rational(59,200)
sa,ha,sb,hb=S.symbols("sa ha sb hb")
s,h=S.symbols("s h")
for t in [S.Rational(3,10),S.Rational(1,2),S.Rational(9,10)]:
    D=4-t*t;L=2-4*R/D
    wa=m+mu*sa/kg+nu*ha
    wb=m+mu*sb/kg+nu*hb
    qa=(L*wa-t*wb)/(L*L-t*t)
    qb=(L*wb-t*wa)/(L*L-t*t)
    ua=4*R*qa/D;ub=4*R*qb/D
    xa,xb=ua/(R*kx),ub/(R*kx)
    ga,gb=(sa+mu*ua/R)/kg,(sb+mu*ub/R)/kg
    Ea,Eb=e*qa-beta*ga-xi*ha,e*qb-beta*gb-xi*hb
    cs=(qa*qa+qb*qb)/2+t*qa*qb
    Wa=cs/2+qa*qa-kx*xa*xa/2-kg*ga*ga/2-kappa*ha*ha/2-d*Ea*Ea/2
    Wb=cs/2+qb*qb-kx*xb*xb/2-kg*gb*gb/2-kappa*hb*hb/2-d*Eb*Eb/2
    sym={sa:s,sb:s,ha:h,hb:h}
    def solve_linear(eqs):
        M,rhs=S.linear_eq_to_matrix(eqs,[s,h])
        return M.inv()*rhs
    ne=solve_linear([S.diff(Wa,v).subs(sym) for v in [sa,ha]])
    zne={sa:ne[0],sb:ne[0],ha:ne[1],hb:ne[1]}
    outside=S.factor(Wa.subs(zne))
    total=S.expand((Wa+Wb).subs(sym))
    g=solve_linear([S.diff(total,v) for v in [s,h]])
    symmetric={sa:g[0],sb:g[0],ha:g[1],hb:g[1]}
    Hs=S.hessian(total,[s,h])
    assert Hs[0,0]<0 and Hs.det()>0
    eps=S.Rational(1,10)
    asymmetric={sa:g[0]+eps,sb:g[0]-eps,
                ha:g[1]+eps/2,hb:g[1]-eps/2}
    gain=S.factor((Wa+Wb).subs(asymmetric)-total.subs({s:g[0],h:g[1]}))
    I_RA=S.factor(Wa.subs(asymmetric)-outside)
    I_RB=S.factor(Wb.subs(asymmetric)-outside)
    margins=[S.factor(v.subs(asymmetric)) for v in
             [L*wa-t*wb,L*wb-t*wa]]
    assert all(v>0 for v in [*asymmetric.values(),*margins,I_RA,I_RB])
    if t==S.Rational(3,10):
        assert gain==S.Rational(22617173,4841870418000)>0
    elif t==S.Rational(1,2):
        assert gain==S.Rational(172856,8002000125)>0
    else:
        assert gain<0
    print("theta",t,"symmetric total",float(total.subs({s:g[0],h:g[1]})),
          "asymmetric exact welfare difference",gain,
          "IR gaps",float(I_RA),float(I_RB))

# The antisymmetric quadratic-curvature switch has two roots in (0,1).
theta=S.symbols("theta",real=True)
poly=484600*theta**6-711835*theta**5-3638491*theta**4+4725480*theta**3+7413288*theta**2-7512560*theta+1450204
anti_h11=118900*theta**6-437890*theta**5-545269*theta**4+3265320*theta**3-903108*theta**2-6055040*theta+4862236
assert S.Poly(poly,theta).count_roots(0,1)==2
assert S.Poly(anti_h11,theta).count_roots(0,1)==0
assert poly.subs(theta,S.Rational(2,5))<0
assert poly.subs(theta,0)>0 and poly.subs(theta,1)>0
print("antisymmetric Hessian determinant numerator:",poly)
print("approximate roots:",[x for x in S.nroots(poly,maxsteps=250) if abs(S.im(x))<1e-10 and 0<float(S.re(x))<1])
print("EXACT rivalry-point contrast PASS; globally optimal asymmetry at low rivalry not certified")
