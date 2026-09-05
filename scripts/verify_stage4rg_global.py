from __future__ import annotations

import math
import sympy as sp


def strip_zero_at_origin(poly_expr, var):
    poly = sp.Poly(sp.factor(poly_expr), var, domain="QQ")
    power = 0
    while poly.degree() > 0 and poly.eval(0) == 0:
        q, r = sp.div(poly, sp.Poly(var, var, domain="QQ"))
        assert r.is_zero
        poly = q
        power += 1
    return poly.as_expr(), power


def assert_rational_sign(expr, var, expected_sign: int, label: str):
    expr = sp.cancel(expr)
    num, den = sp.together(expr).as_numer_denom()
    num0, _ = strip_zero_at_origin(num, var)
    den0, _ = strip_zero_at_origin(den, var)
    assert sp.Poly(num0, var).count_roots(0, 1) == 0, f"{label}: numerator has a root on [0,1]"
    assert sp.Poly(den0, var).count_roots(0, 1) == 0, f"{label}: denominator has a root on [0,1]"
    val = sp.N(expr.subs(var, sp.Rational(1, 2)), 50)
    if expected_sign > 0:
        assert val > 0, f"{label}: expected positive"
    else:
        assert val < 0, f"{label}: expected negative"


def canonical_symbolic_certificate():
    t = sp.symbols("t", nonnegative=True, real=True)
    sA, hA, sB, hB = sp.symbols("sA hA sB hB", real=True)
    s, h = sp.symbols("s h", real=True)

    # Canonical rational witness.
    kx = sp.Rational(4)
    kg = sp.Rational(18)
    mu = sp.Rational(9, 10)
    nu = sp.Rational(6, 5)
    kappa = sp.Rational(4, 5)
    d = sp.Rational(2)
    e = sp.Rational(11, 10)
    beta = sp.Rational(17, 10)
    xi = sp.Rational(1, 10)
    m = sp.Rational(2)

    b = mu / kg
    R = 1 / kx + mu**2 / kg
    assert R == sp.Rational(59, 200)
    D = 4 - t**2
    lam = 4 * R / D
    L = 2 - lam
    det = sp.factor(L**2 - t**2)

    # R < 3/4 implies L > theta for the whole canonical interval.
    assert R < sp.Rational(3, 4)
    assert_rational_sign(L - t, t, +1, "L-theta")

    wA = m + b * sA + nu * hA
    wB = m + b * sB + nu * hB

    # Interior-duopoly continuation after the firms' investment stage.
    qA = sp.factor((L * wA - t * wB) / det)
    qB = sp.factor((L * wB - t * wA) / det)
    ellA = 4 * qA / D
    xA = ellA / kx
    gA = (sA + mu * ellA) / kg
    CS = sp.Rational(1, 2) * (qA**2 + qB**2) + t * qA * qB
    PS = qA**2 - kx * xA**2 / 2 - kg * gA**2 / 2
    EA = e * qA - beta * gA - xi * hA
    WA_D = sp.factor(CS / 2 + PS - kappa * hA**2 / 2 - d * EA**2 / 2)

    # Solve the symmetric policy FOCs on the duopoly branch exactly.
    f1 = sp.factor(sp.diff(WA_D, sA).subs({sA: s, sB: s, hA: h, hB: h}))
    f2 = sp.factor(sp.diff(WA_D, hA).subs({sA: s, sB: s, hA: h, hB: h}))
    A, rhs = sp.linear_eq_to_matrix([f1, f2], [s, h])
    sol = A.LUsolve(rhs)
    s_star = sp.factor(sol[0])
    h_star = sp.factor(sol[1])
    assert_rational_sign(s_star, t, +1, "s_star")
    assert_rational_sign(h_star, t, +1, "h_star")

    # The duopoly-branch government objective is strictly concave for all theta.
    H_D = sp.hessian(WA_D, (sA, hA))
    assert_rational_sign(H_D[0, 0], t, -1, "H_D_ss")
    assert_rational_sign(sp.factor(H_D.det()), t, +1, "det_H_D")

    wB_star = sp.factor(wB.subs({sB: s_star, hB: h_star}))

    # Against the symmetric rival, nonnegative own policies cannot reach the
    # rival-monopoly / rival-kink regions.  The minimum own intercept is m.
    assert_rational_sign(m * L - t * wB_star, t, +1, "lower-regimes-inaccessible")

    # Construct the A-kink and A-monopoly government branches.
    WB = sp.symbols("WB", positive=True, real=True)
    wA_own = m + b * sA + nu * hA

    q_K = WB / t
    ell_K = (2 * WB / t - wA_own) / R
    x_K = ell_K / kx
    g_K = (sA + mu * ell_K) / kg
    W_K = sp.factor(
        sp.Rational(1, 4) * q_K**2
        + q_K**2
        - kx * x_K**2 / 2
        - kg * g_K**2 / 2
        - kappa * hA**2 / 2
        - d * (e * q_K - beta * g_K - xi * hA) ** 2 / 2
    )

    q_M = wA_own / (2 - R)
    ell_M = q_M
    x_M = ell_M / kx
    g_M = (sA + mu * ell_M) / kg
    W_M = sp.factor(
        sp.Rational(1, 4) * q_M**2
        + q_M**2
        - kx * x_M**2 / 2
        - kg * g_M**2 / 2
        - kappa * hA**2 / 2
        - d * (e * q_M - beta * g_M - xi * hA) ** 2 / 2
    )

    H_K = sp.hessian(W_K, (sA, hA))
    H_M = sp.hessian(W_M, (sA, hA))
    assert H_K[0, 0] == -sp.Rational(33775, 563922)
    assert sp.factor(H_K.det()) == sp.Rational(195095, 563922)
    assert H_M[0, 0] == -sp.Rational(1223659, 18837522)
    assert sp.factor(H_M.det()) == sp.Rational(188291, 8562510)

    # The common K/M boundary is theta*w_A=(2-R)*w_B.  Optimize policy
    # composition along this boundary, then use the gradient signs to certify
    # that it is the global maximum of each outside branch.
    boundary_w = sp.factor((2 - R) * wB_star / t)
    z = sp.symbols("z", real=True)
    h_boundary = sp.factor((boundary_w - m - b * z) / nu)
    W_boundary = sp.factor(
        W_M.subs({sA: z, hA: h_boundary})
    )
    dz = sp.factor(sp.diff(W_boundary, z))
    Az, bz = sp.linear_eq_to_matrix([dz], [z])
    s_boundary = sp.factor(Az.LUsolve(bz)[0])
    h_boundary_star = sp.factor(h_boundary.subs(z, s_boundary))
    assert_rational_sign(s_boundary, t, +1, "s_boundary")
    assert_rational_sign(h_boundary_star, t, +1, "h_boundary")

    subs_K = {WB: wB_star, sA: s_boundary, hA: h_boundary_star}
    grad_K = [sp.factor(sp.diff(W_K, v).subs(subs_K)) for v in (sA, hA)]
    grad_M = [sp.factor(sp.diff(W_M, v).subs({sA: s_boundary, hA: h_boundary_star})) for v in (sA, hA)]
    # Tangential derivative is zero: nu ds - b dh is tangent to w_A=constant.
    assert sp.simplify(nu * grad_K[0] - b * grad_K[1]) == 0
    assert sp.simplify(nu * grad_M[0] - b * grad_M[1]) == 0
    multiplier_K = sp.factor(grad_K[1] / nu)
    multiplier_M = sp.factor(grad_M[1] / nu)
    assert_rational_sign(multiplier_K, t, +1, "kink-boundary-multiplier")
    assert_rational_sign(multiplier_M, t, -1, "monopoly-boundary-multiplier")

    # Hence the only outside-branch challenger is the common K/M boundary.
    W_eq = sp.factor(WA_D.subs({sA: s_star, sB: s_star, hA: h_star, hB: h_star}))
    W_alt = sp.factor(W_boundary.subs(z, s_boundary))
    global_gap = sp.factor(W_eq - W_alt)
    assert_rational_sign(global_gap, t, +1, "global-policy-gap")

    # Numerical checkpoints only; the sign claims above are exact Sturm/root-count certificates.
    checkpoints = {}
    for tv in (sp.Rational(1, 2), sp.Rational(9, 10), sp.Rational(1)):
        checkpoints[float(tv)] = {
            "s": float(sp.N(s_star.subs(t, tv), 16)),
            "h": float(sp.N(h_star.subs(t, tv), 16)),
            "gap": float(sp.N(global_gap.subs(t, tv), 16)),
        }

    return t, checkpoints, global_gap


def no_x_counterexample():
    """Independently verify that conventional investment is not globally necessary."""
    t = sp.symbols("t", positive=True, real=True)
    sA, hA, sB, hB = sp.symbols("sA hA sB hB", real=True)
    kg = sp.Rational(18)
    mu = sp.Rational(9, 10)
    nu = sp.Rational(6, 5)
    kappa = sp.Rational(4, 5)
    d = sp.Rational(2)
    e = sp.Rational(11, 10)
    beta = sp.Rational(13, 10)
    xi = sp.Rational(1, 10)
    m = sp.Rational(2)

    R = mu**2 / kg
    D = 4 - t**2
    lam = 4 * R / D
    L = 2 - lam
    det = L**2 - t**2
    b = mu / kg
    wA = m + b * sA + nu * hA
    wB = m + b * sB + nu * hB
    qA = (L * wA - t * wB) / det
    qB = (L * wB - t * wA) / det
    gA = (sA + 4 * mu * qA / D) / kg
    CS = sp.Rational(1, 2) * (qA**2 + qB**2) + t * qA * qB
    PS = qA**2 - kg * gA**2 / 2
    E = e * qA - beta * gA - xi * hA
    W = sp.factor(CS / 2 + PS - kappa * hA**2 / 2 - d * E**2 / 2)
    psi = sp.factor(
        sp.diff(W, sA, hA) * sp.diff(W, sA, sB)
        - sp.diff(W, sA, 2) * sp.diff(W, hA, sB)
    )
    target = 2778500 * t**4 - 13520550 * t**2 + 9769111
    assert sp.rem(sp.together(psi).as_numer_denom()[0], target, domain=sp.QQ) == 0
    roots = [complex(r) for r in sp.nroots(target, n=30, maxsteps=200)]
    unit = sorted(r.real for r in roots if abs(r.imag) < 1e-12 and 0 < r.real < 1)
    assert len(unit) == 1
    assert abs(unit[0] - 0.9394850555573323) < 1e-12
    return unit[0]


def hostile_counterexample_regression():
    """Reproduce the fatal counterexample that triggered the rollback."""
    p = dict(kx=8.0, kg=18.0, mu=1.0, nu=1.4, kappa=0.42, d=2.0,
             e=1.4, beta=2.8, xi=0.08, m=2.0)
    theta = 0.9
    s0, h0 = 6.3919487510, 2.6740204872

    def continuation(sA, hA, sB, hB):
        R = 1 / p["kx"] + p["mu"] ** 2 / p["kg"]
        D = 4 - theta**2
        lam = 4 * R / D
        L = 2 - lam
        b = p["mu"] / p["kg"]
        wA = p["m"] + b * sA + p["nu"] * hA
        wB = p["m"] + b * sB + p["nu"] * hB
        if theta * wA >= (2 - R) * wB:
            reg = "MA"
            qA, qB = wA / (2 - R), 0.0
            ellA, ellB = qA, 0.0
        elif theta * wA >= L * wB:
            reg = "KA"
            qA, qB = wB / theta, 0.0
            ellA, ellB = (2 * wB / theta - wA) / R, 0.0
        elif theta * wB >= (2 - R) * wA:
            reg = "MB"
            qA, qB = 0.0, wB / (2 - R)
            ellA, ellB = 0.0, qB
        elif theta * wB >= L * wA:
            reg = "KB"
            qA, qB = 0.0, wA / theta
            ellA, ellB = 0.0, (2 * wA / theta - wB) / R
        else:
            reg = "D"
            det = L**2 - theta**2
            qA = (L * wA - theta * wB) / det
            qB = (L * wB - theta * wA) / det
            ellA, ellB = 4 * qA / D, 4 * qB / D
        xA = ellA / p["kx"]
        gA = (sA + p["mu"] * ellA) / p["kg"]
        return reg, qA, qB, xA, gA

    def welfare(sA, hA, sB, hB):
        reg, qA, qB, xA, gA = continuation(sA, hA, sB, hB)
        CS = 0.5 * (qA * qA + qB * qB) + theta * qA * qB
        PS = qA * qA - p["kx"] * xA * xA / 2 - p["kg"] * gA * gA / 2
        E = p["e"] * qA - p["beta"] * gA - p["xi"] * hA
        W = 0.5 * CS + PS - p["kappa"] * hA * hA / 2 - p["d"] * E * E / 2
        return W, (reg, qA, qB, xA, gA)

    W0, z0 = welfare(s0, h0, s0, h0)
    Wd, zd = welfare(60.0, 22.0, s0, h0)
    assert z0[0] == "D"
    assert zd[0] == "MA"
    assert abs(zd[1] - 13008 / 655) < 1e-10
    assert abs(zd[3] - 1626 / 655) < 1e-10
    assert abs(zd[4] - 2906 / 655) < 1e-10
    assert Wd - W0 > 0.64
    return W0, Wd


def main():
    _, checkpoints, _ = canonical_symbolic_certificate()
    theta_no_x = no_x_counterexample()
    W0, Wd = hostile_counterexample_regression()
    print("canonical global-SPNE checkpoints:", checkpoints)
    print(f"no-x counterexample threshold={theta_no_x:.12f}")
    print(f"hostile counterexample welfare: candidate={W0:.10f}, deviation={Wd:.10f}")
    print("STAGE4R-G GLOBAL EQUILIBRIUM REPAIR PASS")


if __name__ == "__main__":
    main()
