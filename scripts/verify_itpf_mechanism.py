"""Exact ITPF mechanism and investment-feedback boundary certificate.

All statements concern the active-duopoly government problem. The existing
canonical global-SPNE certificate remains a separate premise and is NOT
silently extended to every investment-feedback value tested here.
"""
from __future__ import annotations

import sympy as sp


def bernstein_coefficients_2d(expr, x, y):
    """Exact tensor-product Bernstein coefficients on [0,1]^2."""
    poly = sp.Poly(sp.expand(expr), x, y, domain="QQ")
    nx, ny = poly.degree(x), poly.degree(y)
    coefficients = []
    for i in range(nx + 1):
        for j in range(ny + 1):
            value = sum(
                poly.coeff_monomial(x**p * y**q)
                * sp.binomial(i, p) / sp.binomial(nx, p)
                * sp.binomial(j, q) / sp.binomial(ny, q)
                for p in range(i + 1)
                for q in range(j + 1)
            )
            coefficients.append(sp.factor(value))
    return coefficients


def even_rational_polynomials(expr, theta, u):
    num, den = sp.fraction(sp.cancel(expr))
    numerator = sp.Poly(sp.expand(num), theta)
    denominator = sp.Poly(sp.expand(den), theta)
    assert all(m[0] % 2 == 0 for m in numerator.monoms())
    assert all(m[0] % 2 == 0 for m in denominator.monoms())
    def convert(poly):
        return sp.expand(sum(
            poly.coeff_monomial(theta ** (2 * j)) * u**j
            for j in range(poly.degree() // 2 + 1)
        ))
    return convert(numerator), convert(denominator)


def verify_mechanism_and_feedback_boundary():
    theta, u, r, z = sp.symbols("theta u r z", real=True)
    d = sp.symbols("d", real=True)
    k_g, mu, nu = sp.Rational(18), sp.Rational(9, 10), sp.Rational(6, 5)
    kappa, e, beta, xi = (
        sp.Rational(4, 5), sp.Rational(11, 10),
        sp.Rational(17, 10), sp.Rational(1, 10),
    )
    r_min, r_max = sp.Rational(9, 200), sp.Rational(59, 200)
    D = 4 - theta**2
    L = 2 - 4*r/D
    delta = L**2 - theta**2
    t0, t1 = L/delta, -theta/delta
    b, cg = mu/k_g, 4*mu/(D*k_g)
    own = sp.Matrix([t0*b, t0*nu, t1*b, t1*nu])
    rival = sp.Matrix([t1*b, t1*nu, t0*b, t0*nu])
    es, eh = sp.Matrix([1, 0, 0, 0]), sp.Matrix([0, 1, 0, 0])
    outer = lambda v, w: v*w.T
    emissions = (e-beta*cg)*own - beta/k_g*es - xi*eh
    rho = 1-8*r/D**2

    # Reconstruct the four-policy Hessian from the primitive regional
    # welfare after the firms' interior investment response is substituted.
    H = (
        (outer(own, own)+outer(rival, rival))/2
        + theta*(outer(own, rival)+outer(rival, own))/2
        + 2*rho*outer(own, own)
        - cg*(outer(own, es)+outer(es, own))
        - outer(es, es)/k_g - kappa*outer(eh, eh)
        - d*outer(emissions, emissions)
    )
    Hss, Hhh, Hsh = H[0, 0], H[1, 1], H[0, 1]
    HssB, HhsB = H[0, 2], H[1, 2]
    psi = Hsh*HssB-Hss*HhsB
    det_h = Hss*Hhh-Hsh**2

    # Parameter variation changes 1/k_x, holding every other primitive
    # at its rational canonical value. r_min is the no-x limit.
    Q = (
        -120500*u**4 + 1620310*u**3
        - 2*(83620*r+3934143)*u**2
        - 8*(135400*r**2+579467*r-2036302)*u
        - 32*(241000*r**2-680025*r+378779)
    )
    denminus = 4*r-theta**3+2*theta**2+4*theta-8
    denplus = 4*r+theta**3+2*theta**2-4*theta-8
    psi_expected = (
        -theta*(theta-2)*(theta+2)*Q.subs(u, theta**2)
        / (43200000*denminus**2*denplus**2)
    )
    assert sp.cancel(psi.subs(d, 2)-psi_expected) == 0

    # A positive two-dimensional Bernstein certificate means the entire
    # rational rectangle is controlled, not merely a numerical grid.
    def certificate(expr, sign):
        numerator, denominator = even_rational_polynomials(expr.subs(d, 2), theta, u)
        sub = {r: r_min+(r_max-r_min)*z}
        a = bernstein_coefficients_2d(numerator.subs(sub), z, u)
        bcoeff = bernstein_coefficients_2d(denominator.subs(sub), z, u)
        assert all(sign*c > 0 for c in a)
        assert all(c > 0 for c in bcoeff)
    certificate(Hss, -1)
    certificate(Hhh, -1)
    certificate(det_h, +1)

    # Q is strictly increasing both in substitutability squared and in
    # total firm investment flexibility throughout the exact rectangle.
    for derivative in (sp.diff(Q, u), sp.diff(Q, r)):
        coeffs = bernstein_coefficients_2d(
            derivative.subs(r, r_min+(r_max-r_min)*z), z, u
        )
        assert all(x > 0 for x in coeffs)

    q0 = sp.factor(Q.subs(u, 0))
    q1 = sp.factor(Q.subs(u, 1))
    assert q0 == -32*(241000*r**2-680025*r+378779)
    assert q1 == -4*(2198800*r**2-4239456*r+549747)
    assert sp.Poly(q0, r).count_roots(r_min, r_max) == 0
    assert q0.subs(r, r_min) < 0
    assert q1.subs(r, r_min) < 0 < q1.subs(r, r_max)
    assert sp.Poly(q1, r).count_roots(r_min, r_max) == 1
    critical = (
        sp.Rational(132483, 137425)
        - 3*sp.sqrt(22808771461)/549700
    )
    assert sp.simplify(q1.subs(r, critical)) == 0
    assert sp.Rational(139812, 10**6) < critical < sp.Rational(139813, 10**6)

    # The canonical direct cross-infrastructure effect and joint response
    # have distinct, uniquely characterized roots.
    direct_poly = (
        102500*u**4-1205500*u**3+5196340*u**2
        -8170549*u+1317283
    )
    assert sp.Poly(direct_poly, u).count_roots(0, 1) == 1
    direct_expr = (
        5*theta*(theta-2)*(theta+2)*direct_poly.subs(u,theta**2)
        / (2*(50*theta**3-100*theta**2-200*theta+341)**2
           *(50*theta**3+100*theta**2-200*theta-341)**2)
    )
    assert sp.cancel(HhsB.subs({d: 2, r: r_max})-direct_expr) == 0

    joint_poly = (
        602500*u**4-8101550*u**3+39588109*u**2
        -74143042*u+31863144
    )
    assert sp.factor(Q.subs(r,r_max) + joint_poly/5) == 0
    assert sp.Poly(joint_poly,u).count_roots(0,1) == 1
    assert direct_poly.subs(u,sp.Rational(425736,10**6)**2) > 0
    assert direct_poly.subs(u,sp.Rational(425737,10**6)**2) < 0
    assert joint_poly.subs(u,sp.Rational(773804,10**6)**2) > 0
    assert joint_poly.subs(u,sp.Rational(773805,10**6)**2) < 0

    # Schur complement is an identity, not an independent novelty claim.
    schur = sp.cancel(
        -((HhsB-Hsh*HssB/Hss)/(Hhh-Hsh**2/Hss))
    )
    assert sp.cancel(schur - psi/det_h) == 0
    assert sp.cancel(HhsB.subs({d:2,r:r_max,theta:sp.Rational(1,2)})) > 0
    assert sp.cancel(psi.subs({d:2,r:r_max,theta:sp.Rational(1,2)}) /
                     det_h.subs({d:2,r:r_max,theta:sp.Rational(1,2)})) < 0
    return critical


if __name__ == "__main__":
    threshold = verify_mechanism_and_feedback_boundary()
    print("ITPF MECHANISM AND R-THRESHOLD EXACT CERTIFICATE PASS")
    print("Rcrit =", sp.N(threshold, 16))
