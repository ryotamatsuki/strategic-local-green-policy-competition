from __future__ import annotations

import sympy as sp


TH = sp.symbols("theta", real=True)
A = sp.Rational(18, 25)   # 0.72
B = sp.Rational(21, 25)   # 0.84


def assert_constant_sign(expr, lo=A, hi=B, positive=True):
    """Exact root-count certificate for a rational function on [lo, hi]."""
    expr = sp.cancel(expr)
    num, den = sp.fraction(expr)
    pnum = sp.Poly(num, TH)
    pden = sp.Poly(den, TH)
    assert pnum.count_roots(lo, hi) == 0
    assert pden.count_roots(lo, hi) == 0
    va = sp.sign(expr.subs(TH, lo))
    vb = sp.sign(expr.subs(TH, hi))
    target = 1 if positive else -1
    assert va == target and vb == target


def canonical_system(include_x=True):
    theta = TH
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

    R = (1 / kx if include_x else 0) + mu**2 / kg
    b = mu / kg
    D = 4 - theta**2
    lam = 4 * R / D
    aa = 2 - lam
    det = aa**2 - theta**2

    sA, hA, sB, hB = sp.symbols("sA hA sB hB", real=True)
    yA = b * sA + nu * hA
    yB = b * sB + nu * hB
    qA = sp.cancel((aa * (m + yA) - theta * (m + yB)) / det)
    qB = sp.cancel((aa * (m + yB) - theta * (m + yA)) / det)

    if include_x:
        xA = 4 * qA / (D * kx)
        xB = 4 * qB / (D * kx)
    else:
        xA = xB = sp.Integer(0)
    gA = (4 * mu * qA / D + sA) / kg
    gB = (4 * mu * qB / D + sB) / kg

    CS = sp.Rational(1, 2) * (qA**2 + qB**2) + theta * qA * qB
    PSA = qA**2 - kx * xA**2 / 2 - kg * gA**2 / 2
    EA = e * qA - beta * gA - xi * hA
    WA = sp.cancel(sp.Rational(1, 2) * CS + PSA - kappa * hA**2 / 2 - d * EA**2 / 2)

    s, h = sp.symbols("s h", real=True)
    f1 = sp.diff(WA, sA).subs({sA: s, sB: s, hA: h, hB: h})
    f2 = sp.diff(WA, hA).subs({sA: s, sB: s, hA: h, hB: h})
    sol = sp.solve([f1, f2], [s, h], dict=True, simplify=False)[0]
    sstar = sp.cancel(sol[s])
    hstar = sp.cancel(sol[h])
    qstar = sp.cancel(qA.subs({sA: sstar, sB: sstar, hA: hstar, hB: hstar}))
    Wstar = sp.cancel(WA.subs({sA: sstar, sB: sstar, hA: hstar, hB: hstar}))

    H = sp.hessian(WA, (sA, hA))
    Hss = sp.cancel(H[0, 0])
    Hdet = sp.cancel(H.det())

    return {
        "theta": theta, "kx": kx, "kg": kg, "mu": mu, "nu": nu,
        "kappa": kappa, "d": d, "e": e, "beta": beta, "xi": xi,
        "m": m, "R": R, "b": b, "D": D, "lam": lam,
        "sstar": sstar, "hstar": hstar, "qstar": qstar, "Wstar": Wstar,
        "Hss": Hss, "Hdet": Hdet,
    }


def verify_global_duopoly_interval(include_x=True):
    z = canonical_system(include_x=include_x)
    theta, kg, mu, nu, kappa, d, e, beta, xi, m = (
        z["theta"], z["kg"], z["mu"], z["nu"], z["kappa"], z["d"],
        z["e"], z["beta"], z["xi"], z["m"]
    )
    R, b, D, lam = z["R"], z["b"], z["D"], z["lam"]
    sstar, hstar, qstar, Wstar = z["sstar"], z["hstar"], z["qstar"], z["Wstar"]

    # Interior candidate and government strict concavity on the certified interval.
    assert R < sp.Rational(3, 4)
    assert_constant_sign(sstar)
    assert_constant_sign(hstar)
    assert_constant_sign(qstar)
    assert_constant_sign(-z["Hss"])
    assert_constant_sign(z["Hdet"])

    # Rival policy held at the symmetric candidate.
    MBlow = sp.cancel(m + nu * hstar + b * sstar)

    # If A were inactive, B could exclude it only through either a smooth
    # monopoly optimum or the rival-exit kink.  The kink permits at most
    # M_A <= theta M_B^low/(2-lambda); the smooth-monopoly bound is smaller.
    # Since any nonnegative A policy implies M_A >= m, strict positivity of
    # m - upper_exclusion rules out A-inactive continuations entirely.
    upper_exclusion = sp.cancel(theta * MBlow / (2 - lam))
    assert_constant_sign(m - upper_exclusion)

    # A-monopoly smooth branch.  This is an unconstrained upper bound over
    # every feasible smooth rival-exit deviation.
    sM, hM = sp.symbols("sM hM", real=True)
    qM = sp.cancel((m + nu * hM + b * sM) / (2 - R))
    if include_x:
        xM = qM / z["kx"]
    else:
        xM = sp.Integer(0)
    gM = (sM + mu * qM) / kg
    WM = sp.cancel(
        sp.Rational(1, 4) * qM**2
        + qM**2 - z["kx"] * xM**2 / 2 - kg * gM**2 / 2
        - kappa * hM**2 / 2
        - d * (e * qM - beta * gM - xi * hM) ** 2 / 2
    )
    HM = sp.hessian(WM, (sM, hM))
    assert HM[0, 0] < 0 and sp.factor(HM.det()) > 0
    msol = sp.solve([sp.diff(WM, sM), sp.diff(WM, hM)], [sM, hM], dict=True)[0]
    UM = sp.cancel(WM.subs(msol))
    assert_constant_sign(Wstar - UM)

    # Rival-exit kink.  At q_B=0, q_A=M_B^low/theta and the cost-reduction
    # index must satisfy z_A=2 M_B^low/theta-m-nu h_A.  Maximizing government
    # welfare over all real (s_A,h_A) on this relation is a relaxation of the
    # feasible kink set, hence an upper bound on every kink deviation.
    sK, hK = sp.symbols("sK hK", real=True)
    qK = sp.cancel(MBlow / theta)
    zK = sp.cancel(2 * MBlow / theta - m - nu * hK)
    lowK = b * sK
    shadow = sp.cancel((zK - lowK) / R)
    if include_x:
        xK = shadow / z["kx"]
    else:
        xK = sp.Integer(0)
    gK = (sK + mu * shadow) / kg
    WK = sp.cancel(
        sp.Rational(1, 4) * qK**2
        + qK**2 - z["kx"] * xK**2 / 2 - kg * gK**2 / 2
        - kappa * hK**2 / 2
        - d * (e * qK - beta * gK - xi * hK) ** 2 / 2
    )
    HK = sp.simplify(sp.hessian(WK, (sK, hK)))
    assert HK[0, 0] < 0 and sp.factor(HK.det()) > 0
    ksol = sp.solve([sp.diff(WK, sK), sp.diff(WK, hK)], [sK, hK], dict=True, simplify=False)[0]
    UK = sp.cancel(WK.subs(ksol))
    assert_constant_sign(Wstar - UK)

    return {
        "W_gap_monopoly_left": sp.N((Wstar - UM).subs(theta, A), 12),
        "W_gap_monopoly_right": sp.N((Wstar - UM).subs(theta, B), 12),
        "W_gap_kink_left": sp.N((Wstar - UK).subs(theta, A), 12),
        "W_gap_kink_right": sp.N((Wstar - UK).subs(theta, B), 12),
    }


def verify_astra_counterexample():
    # Exact reconstruction of the fatal Stage-11 counterexample.
    theta = sp.Rational(9, 10)
    kx, kg, mu, nu = sp.Rational(8), sp.Rational(18), sp.Rational(1), sp.Rational(7, 5)
    kappa, d, e, beta, xi, m = (
        sp.Rational(21, 50), sp.Rational(2), sp.Rational(7, 5),
        sp.Rational(14, 5), sp.Rational(2, 25), sp.Rational(2)
    )
    R = 1 / kx + mu**2 / kg
    b = mu / kg
    D = 4 - theta**2
    lam = 4 * R / D
    aa = 2 - lam
    det = aa**2 - theta**2
    sa, ha, sb, hb = sp.symbols("sa ha sb hb")
    qa = (aa * (m + b * sa + nu * ha) - theta * (m + b * sb + nu * hb)) / det
    qb = (aa * (m + b * sb + nu * hb) - theta * (m + b * sa + nu * ha)) / det
    xa, xb = 4 * qa / (D * kx), 4 * qb / (D * kx)
    ga, gb = (4 * mu * qa / D + sa) / kg, (4 * mu * qb / D + sb) / kg
    CS = sp.Rational(1, 2) * (qa**2 + qb**2) + theta * qa * qb
    PSA = qa**2 - kx * xa**2 / 2 - kg * ga**2 / 2
    EA = e * qa - beta * ga - xi * ha
    WA = sp.cancel(sp.Rational(1, 2) * CS + PSA - kappa * ha**2 / 2 - d * EA**2 / 2)
    s, h = sp.symbols("s h")
    sol = sp.solve([
        sp.diff(WA, sa).subs({sa: s, sb: s, ha: h, hb: h}),
        sp.diff(WA, ha).subs({sa: s, sb: s, ha: h, hb: h}),
    ], [s, h], dict=True)[0]
    Wcand = sp.cancel(WA.subs({sa: sol[s], sb: sol[s], ha: sol[h], hb: sol[h]}))

    sdev, hdev = sp.Rational(60), sp.Rational(22)
    qdev = sp.cancel((m + nu * hdev + b * sdev) / (2 - R))
    xdev = qdev / kx
    gdev = (sdev + mu * qdev) / kg
    Wdev = sp.cancel(
        sp.Rational(1, 4) * qdev**2
        + qdev**2 - kx * xdev**2 / 2 - kg * gdev**2 / 2
        - kappa * hdev**2 / 2
        - d * (e * qdev - beta * gdev - xi * hdev) ** 2 / 2
    )
    assert qdev == sp.Rational(13008, 655)
    assert xdev == sp.Rational(1626, 655)
    assert gdev == sp.Rational(2906, 655)
    assert sp.factor(Wdev - Wcand) > 0
    return sp.N(Wcand, 12), sp.N(Wdev, 12)


def verify_threshold_inside_global_interval():
    u = sp.symbols("u", real=True)
    P = (
        sp.Rational(104112, 10) * u**4
        - sp.Rational(139994784, 1000) * u**3
        + sp.Rational(68408252352, 100000) * u**2
        - sp.Rational(128119176576, 100000) * u
        + sp.Rational(55059512832, 100000)
    )
    assert P.subs(u, A**2) > 0
    assert P.subs(u, B**2) < 0
    assert sp.Poly(P, u).count_roots(A**2, B**2) == 1


def verify_no_x_not_universal_necessity():
    # Astra's beta=1.3 counterexample to any universal "x is necessary" prose.
    u = sp.symbols("u", real=True)
    Pbar = sp.Rational(27, 125000) * (u - 4) ** 2 * (
        2778500 * u**2 - 13520550 * u + 9769111
    )
    assert sp.Poly(Pbar, u).count_roots(0, 1) == 1


def main():
    wcand, wdev = verify_astra_counterexample()
    verify_threshold_inside_global_interval()
    full = verify_global_duopoly_interval(include_x=True)
    nox = verify_global_duopoly_interval(include_x=False)
    verify_no_x_not_universal_necessity()
    print(f"Astra counterexample: W_candidate={wcand}, W_deviation={wdev}")
    print("Certified global-SPNE theta interval: [0.72, 0.84]")
    print("Full-model branch gaps:", full)
    print("No-x branch gaps:", nox)
    print("STAGE 4R-G GLOBAL EQUILIBRIUM CERTIFICATE PASS")


if __name__ == "__main__":
    main()
