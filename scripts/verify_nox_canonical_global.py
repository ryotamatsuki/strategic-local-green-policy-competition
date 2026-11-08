"""Exact global policy-deviation certificate for the matched canonical no-x model.

The no-conventional-investment nested benchmark fixes beta=17/10, unlike the
separate beta=13/10 counterexample proving that no-x switching is possible.
All claims are for the canonical remaining primitives and theta in [0,1].
"""
from __future__ import annotations

import sympy as sp


def _strip_origin(expr, theta):
    p = sp.Poly(expr, theta, domain="QQ")
    while p.degree() > 0 and p.coeff_monomial(theta**0) == 0:
        p = sp.Poly(sp.cancel(p.as_expr()/theta), theta, domain="QQ")
    return p


def _strict_sign(expr, theta, expected, name):
    num, den = sp.fraction(sp.factor(expr))
    pn, pd = _strip_origin(num,theta), _strip_origin(den,theta)
    assert pn.count_roots(0,1) == 0, f"{name}: numerator zero"
    assert pd.count_roots(0,1) == 0, f"{name}: denominator zero"
    assert sp.sign(sp.cancel(expr).subs(theta, sp.Rational(1,2))) == expected, name


def verify_canonical_nox_global():
    theta = sp.symbols("theta", real=True)
    sA,hA,sB,hB,s,h,z = sp.symbols("sA hA sB hB s h z",real=True)
    k_g = sp.Rational(18)
    mu,nu = sp.Rational(9,10),sp.Rational(6,5)
    kappa,d,e = sp.Rational(4,5),sp.Rational(2),sp.Rational(11,10)
    beta,xi,m = sp.Rational(17,10),sp.Rational(1,10),sp.Rational(2)
    R = mu**2/k_g
    D = 4-theta**2
    L = 2-4*R/D
    det = L**2-theta**2
    b = mu/k_g

    wA = m+b*sA+nu*hA
    wB = m+b*sB+nu*hB
    qA = (L*wA-theta*wB)/det
    qB = (L*wB-theta*wA)/det
    gA = (sA+4*mu*qA/D)/k_g
    CS = (qA**2+qB**2)/2+theta*qA*qB
    WD = CS/2 + qA**2-k_g*gA**2/2-kappa*hA**2/2 \
        -d*(e*qA-beta*gA-xi*hA)**2/2

    own = [sp.diff(WD,sA).subs({sA:s,sB:s,hA:h,hB:h}),
           sp.diff(WD,hA).subs({sA:s,sB:s,hA:h,hB:h})]
    mat,rhs=sp.linear_eq_to_matrix(own,[s,h])
    solution=mat.inv()*rhs
    sstar,hstar=sp.factor(solution[0]),sp.factor(solution[1])
    _strict_sign(sstar,theta,+1,"interior subsidy")
    _strict_sign(hstar,theta,+1,"interior infrastructure")
    H=sp.hessian(WD,(sA,hA))
    _strict_sign(-H[0,0],theta,+1,"interior strict concavity ss")
    _strict_sign(H.det(),theta,+1,"interior strict concavity determinant")

    wb=sp.factor(wB.subs({sB:sstar,hB:hstar}))
    _strict_sign(m*L-theta*wb,theta,+1,"rival monopoly/kink unreachable")

    # At a monopoly-triggering deviation, compare the common kink/monopoly
    # boundary. The kink side is flat in the own subsidy in the no-x model.
    qk=sp.symbols("wBpos",positive=True)/theta
    WB=sp.symbols("wBpos",positive=True)
    qk=WB/theta
    ellk=(2*WB/theta-wA)/R
    gk=(sA+mu*ellk)/k_g
    WK=sp.Rational(5,4)*qk**2-k_g*gk**2/2-kappa*hA**2/2 \
        -d*(e*qk-beta*gk-xi*hA)**2/2
    assert sp.simplify(sp.diff(WK,sA)) == 0
    assert sp.simplify(sp.diff(WK,hA,2)) < 0

    qm=wA/(2-R)
    gm=(sA+mu*qm)/k_g
    WM=sp.Rational(5,4)*qm**2-k_g*gm**2/2-kappa*hA**2/2 \
        -d*(e*qm-beta*gm-xi*hA)**2/2
    HM=sp.hessian(WM,(sA,hA))
    assert HM[0,0] < 0 and sp.factor(HM.det()) > 0

    wbnd=sp.factor((2-R)*wb/theta)
    hbnd=sp.factor((wbnd-m-b*z)/nu)
    Wb=sp.factor(WM.subs({sA:z,hA:hbnd}))
    fz=sp.Poly(sp.cancel(sp.diff(Wb,z)),z)
    sbnd=sp.factor(-fz.coeff_monomial(1)/fz.coeff_monomial(z))
    hbndstar=sp.factor(hbnd.subs(z,sbnd))
    _strict_sign(sbnd,theta,+1,"boundary subsidy")
    _strict_sign(hbndstar,theta,+1,"boundary infrastructure")

    # The kink's h optimum is feasible along a full subsidy interval.
    hK=sp.factor(-sp.diff(WK,hA).subs({hA:0,WB:wb})/sp.diff(WK,hA,2))
    assert sp.simplify(hK-hbndstar) == 0
    sLower=sp.factor((L*wb/theta-m-nu*hK)/b)
    sUpper=sp.factor((wbnd-m-nu*hK)/b)
    _strict_sign(hK,theta,+1,"kink infrastructure")
    _strict_sign(sLower,theta,+1,"kink lower subsidy")
    _strict_sign(sUpper-sLower,theta,+1,"kink interval nonempty")

    # Kink FOC at the boundary is zero in both own directions; on the
    # monopoly side the inward directional derivative is strictly negative.
    assert sp.simplify(
        sp.diff(WK,hA).subs({WB:wb,sA:sbnd,hA:hbndstar})) == 0
    lambda_m=sp.factor(
        sp.diff(WM,hA).subs({sA:sbnd,hA:hbndstar})/nu)
    _strict_sign(lambda_m,theta,-1,"monopoly boundary KKT")

    Weq=sp.factor(WD.subs({sA:sstar,sB:sstar,hA:hstar,hB:hstar}))
    Walt=sp.factor(Wb.subs(z,sbnd))
    gap=sp.factor(Weq-Walt)
    _strict_sign(gap,theta,+1,"global policy deviation gap")
    assert sp.limit(theta**2*gap,theta,0,dir="+")>0

    # At theta=0 exclusion is impossible; the active-duopoly solution is
    # the only relevant stage-2 market structure.
    assert R < sp.Rational(3,4)
    return gap


if __name__ == "__main__":
    verify_canonical_nox_global()
    print("CANONICAL NO-X GLOBAL POLICY CERTIFICATE PASS")
