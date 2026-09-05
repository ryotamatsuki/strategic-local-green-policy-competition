from __future__ import annotations

import sympy as sp


def _strip_origin(poly: sp.Poly, var: sp.Symbol) -> sp.Poly:
    while poly.degree() > 0 and poly.eval(0) == 0:
        poly = sp.div(poly, sp.Poly(var, var, domain="QQ"))[0]
    return poly


def _constant_sign_on_unit_interval(expr, theta, expected_sign: int, label: str) -> None:
    num, den = sp.together(sp.cancel(expr)).as_numer_denom()
    pnum = _strip_origin(sp.Poly(num, theta, domain="QQ"), theta)
    pden = _strip_origin(sp.Poly(den, theta, domain="QQ"), theta)
    assert pnum.count_roots(0, 1) == 0, f"{label}: numerator root on [0,1]"
    assert pden.count_roots(0, 1) == 0, f"{label}: denominator root on [0,1]"
    value = sp.N(expr.subs(theta, sp.Rational(1, 2)), 40)
    assert (value > 0) if expected_sign > 0 else (value < 0), label


def _case(d_value: sp.Rational):
    theta = sp.symbols("theta", real=True)
    u = sp.symbols("u", real=True)
    kx = sp.Rational(4)
    kg = sp.Rational(18)
    mu = sp.Rational(9, 10)
    nu = sp.Rational(6, 5)
    kappa = sp.Rational(4, 5)
    e = sp.Rational(11, 10)
    beta = sp.Rational(17, 10)
    xi = sp.Rational(1, 10)

    D = 4 - theta**2
    R = 1 / kx + mu**2 / kg
    lam = 4 * R / D
    A = D - 2 * lam
    Delta = sp.factor(A**2 - theta**2 * lam**2)
    t0 = sp.cancel((2 * A + theta**2 * lam) / Delta)
    t1 = sp.cancel(-theta * D / Delta)
    b = mu / kg

    qa = sp.Matrix([t0 * b, t0 * nu, t1 * b, t1 * nu])
    qb = sp.Matrix([t1 * b, t1 * nu, t0 * b, t0 * nu])
    es = sp.Matrix([1, 0, 0, 0])
    eh = sp.Matrix([0, 1, 0, 0])
    outer = lambda x, y: x * y.T

    cx = 4 / (D * kx)
    cg = 4 * mu / (D * kg)
    rho = 1 - kx * cx**2 / 2 - kg * cg**2 / 2
    emissions = (e - beta * cg) * qa - (beta / kg) * es - xi * eh

    H = (
        2 * (sp.Rational(1, 4) + rho) * outer(qa, qa)
        + sp.Rational(1, 2) * outer(qb, qb)
        + sp.Rational(1, 2) * theta * (outer(qa, qb) + outer(qb, qa))
        - cg * (outer(es, qa) + outer(qa, es))
        - (1 / kg) * outer(es, es)
        - kappa * outer(eh, eh)
        - d_value * outer(emissions, emissions)
    )

    Hoo = H.extract([0, 1], [0, 1])
    _constant_sign_on_unit_interval(Hoo[0, 0], theta, -1, f"d={d_value}: H_ss")
    _constant_sign_on_unit_interval(Hoo.det(), theta, +1, f"d={d_value}: det(H)")

    psi = sp.cancel(H[0, 1] * H[0, 2] - H[0, 0] * H[1, 2])
    num = sp.factor(sp.together(psi).as_numer_denom()[0])
    reduced = sp.factor(num / (theta * (theta**2 - 4)))
    ptheta = sp.Poly(sp.expand(reduced), theta, domain="QQ")
    assert all(m[0] % 2 == 0 for m in ptheta.monoms())
    Pu = sp.Poly(
        sum(ptheta.coeff_monomial(theta ** (2 * j)) * u**j for j in range(ptheta.degree() // 2 + 1)),
        u,
        domain="QQ",
    )
    roots = Pu.count_roots(0, 1)
    return roots, sp.sign(Pu.eval(0)), sp.sign(Pu.eval(1))


def verify_target_intensity_scope():
    cases = {
        sp.Rational(3, 2): (0, +1, +1),
        sp.Rational(2): (1, +1, -1),
        sp.Rational(3): (0, -1, -1),
    }
    results = {}
    for d_value, expected in cases.items():
        actual = _case(d_value)
        assert actual == expected, f"d={d_value}: {actual} != {expected}"
        results[d_value] = actual
    return results


def main() -> None:
    results = verify_target_intensity_scope()
    for d_value, actual in results.items():
        print(f"d={d_value}: roots={actual[0]}, endpoint_signs={actual[1:]}")
    print("STAGE 11R TARGET-SCOPE PASS")


if __name__ == "__main__":
    main()
