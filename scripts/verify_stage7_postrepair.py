from __future__ import annotations

import sympy as sp


def build_model():
    theta = sp.symbols("theta", real=True)
    sA, hA, sB, hB = sp.symbols("sA hA sB hB", real=True)

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

    D = 4 - theta**2
    R = 1 / kx + mu**2 / kg
    lam = 4 * R / D
    L = 2 - lam
    b = mu / kg
    det = L**2 - theta**2

    wA = m + b * sA + nu * hA
    wB = m + b * sB + nu * hB
    qA = sp.factor((L * wA - theta * wB) / det)
    qB = sp.factor((L * wB - theta * wA) / det)

    xA = sp.factor(4 * qA / (D * kx))
    xB = sp.factor(4 * qB / (D * kx))
    gA = sp.factor((4 * mu * qA / D + sA) / kg)
    gB = sp.factor((4 * mu * qB / D + sB) / kg)

    CS = sp.factor(sp.Rational(1, 2) * (qA**2 + qB**2) + theta * qA * qB)
    PSA = sp.factor(qA**2 - kx * xA**2 / 2 - kg * gA**2 / 2)
    PSB = sp.factor(qB**2 - kx * xB**2 / 2 - kg * gB**2 / 2)
    EA = sp.factor(e * qA - beta * gA - xi * hA)
    EB = sp.factor(e * qB - beta * gB - xi * hB)

    WA = sp.factor(CS / 2 + PSA - kappa * hA**2 / 2 - d * EA**2 / 2)
    WB = sp.factor(CS / 2 + PSB - kappa * hB**2 / 2 - d * EB**2 / 2)

    return {
        "theta": theta,
        "policies": (sA, hA, sB, hB),
        "params": (kx, kg, mu, nu, kappa, d, e, beta, xi, m),
        "qA": qA,
        "qB": qB,
        "xA": xA,
        "gA": gA,
        "gB": gB,
        "CS": CS,
        "PSA": PSA,
        "EA": EA,
        "EB": EB,
        "WA": WA,
        "WB": WB,
    }


def symmetric_solution(model, coordinated: bool):
    theta = model["theta"]
    sA, hA, sB, hB = model["policies"]
    s, h = sp.symbols("s h", real=True)
    objective = model["WA"] + model["WB"] if coordinated else model["WA"]
    f1 = sp.diff(objective, sA).subs({sA: s, sB: s, hA: h, hB: h})
    f2 = sp.diff(objective, hA).subs({sA: s, sB: s, hA: h, hB: h})
    A, rhs = sp.linear_eq_to_matrix([f1, f2], [s, h])
    return tuple(sp.factor(z) for z in A.LUsolve(rhs))


def eval_state(model, theta_value, solution):
    theta = model["theta"]
    sA, hA, sB, hB = model["policies"]
    kx, kg, mu, nu, kappa, d, e, beta, xi, m = model["params"]
    s_star = sp.factor(solution[0].subs(theta, theta_value))
    h_star = sp.factor(solution[1].subs(theta, theta_value))
    subs = {theta: theta_value, sA: s_star, sB: s_star, hA: h_star, hB: h_star}
    q = sp.factor(model["qA"].subs(subs))
    x = sp.factor(model["xA"].subs(subs))
    g = sp.factor(model["gA"].subs(subs))
    E = sp.factor(model["EA"].subs(subs))
    Wtot = sp.factor((model["WA"] + model["WB"]).subs(subs))
    subsidy_outlay = sp.factor(s_star * g)
    infra_outlay = sp.factor(kappa * h_star**2 / 2)
    fiscal_share = sp.factor(infra_outlay / (subsidy_outlay + infra_outlay))
    return {
        "s": s_star,
        "h": h_star,
        "q": q,
        "x": x,
        "g": g,
        "E": E,
        "Wtot": Wtot,
        "phi": fiscal_share,
    }


def main():
    model = build_model()
    theta = model["theta"]
    sA, hA, sB, hB = model["policies"]
    kx, kg, mu, nu, kappa, d, e, beta, xi, m = model["params"]

    ne = symmetric_solution(model, coordinated=False)
    coord = symmetric_solution(model, coordinated=True)

    t09 = sp.Rational(9, 10)
    ne09 = eval_state(model, t09, ne)
    co09 = eval_state(model, t09, coord)

    assert abs(float(ne09["Wtot"]) - 2.1869518245534194) < 1e-10
    assert abs(float(co09["Wtot"]) - 3.7203060911922945) < 1e-10
    assert abs(float(ne09["phi"]) - 0.3631749282583924) < 1e-10
    assert abs(float(co09["phi"]) - 0.6924942965779163) < 1e-10
    assert co09["Wtot"] > ne09["Wtot"]
    assert co09["E"] > ne09["E"]
    assert co09["q"] > ne09["q"]

    # Direct cross-effect decomposition at the canonical theta=.9 global-SPNE point.
    subs09 = {
        theta: t09,
        sA: ne09["s"],
        sB: ne09["s"],
        hA: ne09["h"],
        hB: ne09["h"],
    }
    comp_cs = sp.factor(sp.diff(model["CS"] / 2, hA, sB).subs(subs09))
    comp_ps = sp.factor(sp.diff(model["PSA"], hA, sB).subs(subs09))
    comp_target = sp.factor(sp.diff(-d * model["EA"] ** 2 / 2, hA, sB).subs(subs09))
    total_direct = sp.factor(comp_cs + comp_ps + comp_target)

    expected = [0.00163810596163441, -0.0396291007557247, 0.0460775303425797, 0.00808653554848939]
    actual = [float(comp_cs), float(comp_ps), float(comp_target), float(total_direct)]
    for a, bval in zip(actual, expected):
        assert abs(a - bval) < 1e-10

    EA_h = sp.factor(sp.diff(model["EA"], hA).subs(subs09))
    EA_sB = sp.factor(sp.diff(model["EA"], sB).subs(subs09))
    assert abs(float(EA_h) - 0.951986079533832) < 1e-10
    assert abs(float(EA_sB) + 0.0242007374546605) < 1e-10

    # Full IFT response and its non-monotonicity below the switching threshold.
    H = sp.hessian(model["WA"], (sA, hA))
    cross_s = sp.Matrix([sp.diff(model["WA"], sA, sB), sp.diff(model["WA"], hA, sB)])
    cross_h = sp.Matrix([sp.diff(model["WA"], sA, hB), sp.diff(model["WA"], hA, hB)])
    response_s = sp.simplify(-H.inv() * cross_s)

    # Rival instruments enter A's interior problem through y_B only.
    factor = sp.factor(nu * kg / mu)
    for i in range(2):
        assert sp.simplify(cross_h[i] - factor * cross_s[i]) == 0
    assert factor == 24

    checkpoints = {
        sp.Rational(1, 10): -0.0012312138411530414,
        sp.Rational(3, 10): -0.0034418551759057914,
        sp.Rational(1, 2): -0.00455221890862445,
        sp.Rational(7, 10): -0.002414890272554068,
        sp.Rational(4, 5): 0.0011500303027101037,
        sp.Rational(9, 10): 0.007112572287111896,
    }
    for tv, expected_h in checkpoints.items():
        state = eval_state(model, tv, ne)
        subs = {theta: tv, sA: state["s"], sB: state["s"], hA: state["h"], hB: state["h"]}
        got = float(sp.N(response_s[1].subs(subs), 16))
        assert abs(got - expected_h) < 1e-10

    print("theta=.9 welfare:", float(ne09["Wtot"]), "->", float(co09["Wtot"]))
    print("theta=.9 emissions:", float(ne09["E"]), "->", float(co09["E"]))
    print("theta=.9 fiscal infrastructure share:", float(ne09["phi"]), "->", float(co09["phi"]))
    print("W_hAsB decomposition:", actual)
    print("rival-policy proportionality factor:", int(factor))
    print("STAGE7 POST-REPAIR VALIDATION PASS")


if __name__ == "__main__":
    main()
