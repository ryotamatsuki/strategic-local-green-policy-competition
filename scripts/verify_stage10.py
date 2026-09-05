from __future__ import annotations

import math
import sympy as sp


def _outer(x, y):
    return x * y.T


def general_switching_polynomial():
    th, kx, kg, mu, nu, kappa, d, e, beta, xi = sp.symbols(
        "th kx kg mu nu kappa d e beta xi", positive=True
    )
    D = 4 - th**2
    R = 1 / kx + mu**2 / kg
    lam = 4 * R / D
    A = D - 2 * lam
    Delta = sp.factor(A**2 - th**2 * lam**2)
    t0 = sp.factor((2 * A + th**2 * lam) / Delta)
    t1 = sp.factor(-th * D / Delta)
    b = mu / kg
    qa = sp.Matrix([t0 * b, t0 * nu, t1 * b, t1 * nu])
    qb = sp.Matrix([t1 * b, t1 * nu, t0 * b, t0 * nu])
    es = sp.Matrix([1, 0, 0, 0])
    eh = sp.Matrix([0, 1, 0, 0])
    cx = 4 / (D * kx)
    cg = 4 * mu / (D * kg)
    rho = 1 - kx * cx**2 / 2 - kg * cg**2 / 2
    emissions_slope = (e - beta * cg) * qa - (beta / kg) * es - xi * eh
    H = (
        2 * (sp.Rational(1, 4) + rho) * _outer(qa, qa)
        + sp.Rational(1, 2) * _outer(qb, qb)
        + sp.Rational(1, 2) * th * (_outer(qa, qb) + _outer(qb, qa))
        - cg * (_outer(es, qa) + _outer(qa, es))
        - (1 / kg) * _outer(es, es)
        - kappa * _outer(eh, eh)
        - d * _outer(emissions_slope, emissions_slope)
    )
    psi = sp.factor(H[0, 1] * H[0, 2] - H[0, 0] * H[1, 2])
    num, den = sp.fraction(psi)
    P_th = sp.factor(num / (kx**2 * mu * th * (th - 2) * (th + 2)))
    poly = sp.Poly(sp.expand(P_th), th)
    assert poly.degree() == 8
    assert all(power[0] % 2 == 0 for power in poly.monoms())
    return {
        "symbols": (th, kx, kg, mu, nu, kappa, d, e, beta, xi),
        "psi": psi,
        "P_th": P_th,
        "den": den,
    }


def verify_general_factorization():
    obj = general_switching_polynomial()
    th, kx, kg, mu, nu, kappa, d, e, beta, xi = obj["symbols"]
    canonical = {
        kx: 4,
        kg: 18,
        mu: sp.Rational(9, 10),
        nu: sp.Rational(6, 5),
        kappa: sp.Rational(4, 5),
        d: 2,
        e: sp.Rational(11, 10),
        beta: sp.Rational(17, 10),
        xi: sp.Rational(1, 10),
    }
    p = sp.factor(obj["P_th"].subs(canonical))
    u = sp.symbols("u")
    expected = (
        602500 * u**4
        - 8101550 * u**3
        + 39588109 * u**2
        - 74143042 * u
        + 31863144
    )
    p_u = sp.Poly(sp.expand(p), th)
    actual = sum(p_u.coeff_monomial(th ** (2 * j)) * u**j for j in range(5))
    ratio = sp.simplify(actual / expected)
    assert not ratio.has(u)
    assert ratio > 0
    roots = [complex(r) for r in sp.nroots(expected, n=30, maxsteps=200)]
    unit_roots = [r.real for r in roots if abs(r.imag) < 1e-10 and 0 < r.real < 1]
    assert len(unit_roots) == 1
    theta_star = math.sqrt(unit_roots[0])
    assert abs(theta_star - 0.7738043861) < 1e-8
    return theta_star


def _policy_hessian_cournot(theta, omega=1):
    th = sp.Rational(str(theta))
    kx = sp.Rational(4)
    kg = sp.Rational(18)
    mu = sp.Rational(9, 10)
    nu = sp.Rational(6, 5)
    kappa = sp.Rational(4, 5)
    d = sp.Rational(2)
    e = sp.Rational(11, 10)
    beta = sp.Rational(17, 10)
    xi = sp.Rational(1, 10)
    omega = sp.Rational(str(omega))
    D = 4 - th**2
    R = 1 / kx + mu**2 / kg
    lam = 4 * R / D
    A = D - 2 * lam
    Delta = A**2 - th**2 * lam**2
    t0 = (2 * A + th**2 * lam) / Delta
    t1 = -th * D / Delta
    b = mu / kg
    qa = sp.Matrix([t0 * b, t0 * nu, t1 * b, t1 * nu])
    qb = sp.Matrix([t1 * b, t1 * nu, t0 * b, t0 * nu])
    es = sp.Matrix([1, 0, 0, 0])
    eh = sp.Matrix([0, 1, 0, 0])
    cx = 4 / (D * kx)
    cg = 4 * mu / (D * kg)
    rho = 1 - kx * cx**2 / 2 - kg * cg**2 / 2
    emissions_slope = (e - beta * cg) * qa - (beta / kg) * es - xi * eh
    # W^omega = .5 CS + omega*pi - s*g - infrastructure cost - emissions loss.
    H = (
        sp.Rational(1, 2) * _outer(qa, qa)
        + sp.Rational(1, 2) * _outer(qb, qb)
        + sp.Rational(1, 2) * th * (_outer(qa, qb) + _outer(qb, qa))
        + 2 * omega * rho * _outer(qa, qa)
        - cg * (_outer(es, qa) + _outer(qa, es))
        + ((omega - 2) / kg) * _outer(es, es)
        - kappa * _outer(eh, eh)
        - d * _outer(emissions_slope, emissions_slope)
    )
    return sp.simplify(H)


def _cross_h_response(H):
    Hoo = H.extract([0, 1], [0, 1])
    cross = H.extract([0, 1], [2])
    response = -Hoo.inv() * cross
    return float(sp.N(response[1], 16))


def _policy_hessian_bertrand(theta):
    th = sp.Rational(str(theta))
    kx = sp.Rational(4)
    kg = sp.Rational(18)
    mu = sp.Rational(9, 10)
    nu = sp.Rational(6, 5)
    kappa = sp.Rational(4, 5)
    d = sp.Rational(2)
    e = sp.Rational(11, 10)
    beta = sp.Rational(17, 10)
    xi = sp.Rational(1, 10)
    D = 4 - th**2
    eta = 2 * (2 - th**2) / D
    R = 1 / kx + mu**2 / kg
    own = (2 - th**2) / (1 - th**2)
    rival = -th / (1 - th**2)
    M = sp.Matrix([[D - own * eta * R, -rival * eta * R], [-rival * eta * R, D - own * eta * R]])
    b = mu / kg
    Z = sp.Matrix(
        [
            [own * b, own * nu, rival * b, rival * nu],
            [rival * b, rival * nu, own * b, own * nu],
        ]
    )
    Q = sp.simplify(M.inv() * Z)
    qa = sp.Matrix(list(Q.row(0)))
    qb = sp.Matrix(list(Q.row(1)))
    es = sp.Matrix([1, 0, 0, 0])
    eh = sp.Matrix([0, 1, 0, 0])
    cg = eta * mu / kg
    rho = (1 - th**2) - eta**2 / (2 * kx) - eta**2 * mu**2 / (2 * kg)
    emissions_slope = (e - beta * cg) * qa - (beta / kg) * es - xi * eh
    H = (
        2 * (sp.Rational(1, 4) + rho) * _outer(qa, qa)
        + sp.Rational(1, 2) * _outer(qb, qb)
        + sp.Rational(1, 2) * th * (_outer(qa, qb) + _outer(qb, qa))
        - cg * (_outer(es, qa) + _outer(qa, es))
        - (1 / kg) * _outer(es, es)
        - kappa * _outer(eh, eh)
        - d * _outer(emissions_slope, emissions_slope)
    )
    return sp.simplify(H)


def verify_robustness_signs():
    b03 = _cross_h_response(_policy_hessian_bertrand("0.3"))
    b05 = _cross_h_response(_policy_hessian_bertrand("0.5"))
    assert b03 < 0 < b05
    c05 = _cross_h_response(_policy_hessian_cournot("0.5", omega="0.9"))
    c07 = _cross_h_response(_policy_hessian_cournot("0.7", omega="0.9"))
    assert c05 < 0 < c07
    return b03, b05, c05, c07


def main():
    theta_star = verify_general_factorization()
    signs = verify_robustness_signs()
    print(f"canonical_theta_star={theta_star:.10f}")
    print("robustness_cross_h=", [f"{x:.8f}" for x in signs])
    print("STAGE10 VERIFICATION PASS")


if __name__ == "__main__":
    main()
