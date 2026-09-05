from __future__ import annotations

import sympy as sp


def exact_point(theta: sp.Rational):
    sA, hA, sB, hB, s, h = sp.symbols("sA hA sB hB s h", real=True)

    kg = sp.Rational(18)
    mu = sp.Rational(9, 10)
    nu = sp.Rational(6, 5)
    kappa = sp.Rational(4, 5)
    d = sp.Rational(2)
    e = sp.Rational(11, 10)
    beta = sp.Rational(13, 10)
    xi = sp.Rational(1, 10)
    m = sp.Rational(2)

    # No conventional investment: R=mu^2/k_g.
    R = mu**2 / kg
    D = 4 - theta**2
    lam = 4 * R / D
    L = 2 - lam
    det = L**2 - theta**2
    b = mu / kg

    wA = m + b * sA + nu * hA
    wB = m + b * sB + nu * hB
    qA = (L * wA - theta * wB) / det
    qB = (L * wB - theta * wA) / det
    ellA = 4 * qA / D
    gA = (sA + mu * ellA) / kg
    CS = sp.Rational(1, 2) * (qA**2 + qB**2) + theta * qA * qB
    PS = qA**2 - kg * gA**2 / 2
    EA = e * qA - beta * gA - xi * hA
    W_D = sp.factor(CS / 2 + PS - kappa * hA**2 / 2 - d * EA**2 / 2)

    f1 = sp.diff(W_D, sA).subs({sA: s, sB: s, hA: h, hB: h})
    f2 = sp.diff(W_D, hA).subs({sA: s, sB: s, hA: h, hB: h})
    A, rhs = sp.linear_eq_to_matrix([f1, f2], [s, h])
    s_star, h_star = [sp.factor(x) for x in A.LUsolve(rhs)]
    assert s_star > 0 and h_star > 0

    H_D = sp.hessian(W_D, (sA, hA))
    assert H_D[0, 0] < 0 and sp.factor(H_D.det()) > 0

    wB_star = sp.factor(wB.subs({sB: s_star, hB: h_star}))
    # Rival-monopoly and rival-kink regions cannot be reached with nonnegative own policies.
    assert sp.factor(m * L - theta * wB_star) > 0

    WB = sp.symbols("WB", positive=True)
    wA_own = m + b * sA + nu * hA

    # Own limit-pricing kink branch.
    qK = WB / theta
    ellK = (2 * WB / theta - wA_own) / R
    gK = (sA + mu * ellK) / kg
    W_K = sp.factor(
        sp.Rational(1, 4) * qK**2 + qK**2 - kg * gK**2 / 2
        - kappa * hA**2 / 2 - d * (e * qK - beta * gK - xi * hA) ** 2 / 2
    )

    # Own monopoly branch.
    qM = wA_own / (2 - R)
    ellM = qM
    gM = (sA + mu * ellM) / kg
    W_M = sp.factor(
        sp.Rational(1, 4) * qM**2 + qM**2 - kg * gM**2 / 2
        - kappa * hA**2 / 2 - d * (e * qM - beta * gM - xi * hA) ** 2 / 2
    )

    # In the no-x kink branch, subsidy changes are exactly offset by green-investment
    # changes needed to hold the rival at q_B=0.  Hence W_K is flat in s_A and
    # strictly concave only in h_A; negative definiteness would be the wrong test.
    HK = sp.hessian(W_K, (sA, hA))
    HM = sp.hessian(W_M, (sA, hA))
    assert sp.simplify(sp.diff(W_K, sA)) == 0
    assert HK[0, 0] == 0 and HK[0, 1] == 0 and HK[1, 0] == 0 and HK[1, 1] < 0
    assert HM[0, 0] < 0 and sp.factor(HM.det()) > 0

    # Common kink/monopoly boundary and its best policy composition.
    boundary_w = sp.factor((2 - R) * wB_star / theta)
    z = sp.symbols("z", real=True)
    h_boundary = sp.factor((boundary_w - m - b * z) / nu)
    W_boundary = sp.factor(W_M.subs({sA: z, hA: h_boundary}))
    Az, bz = sp.linear_eq_to_matrix([sp.diff(W_boundary, z)], [z])
    s_boundary = sp.factor(Az.LUsolve(bz)[0])
    h_boundary_star = sp.factor(h_boundary.subs(z, s_boundary))
    assert s_boundary > 0 and h_boundary_star > 0

    # The kink objective has a unique optimal h_A but a flat subsidy direction.
    # Verify that this optimal h_A is feasible throughout the kink strip and that
    # the selected boundary point is one of its (continuum of) global kink maxima.
    Ah, bh = sp.linear_eq_to_matrix([sp.diff(W_K, hA).subs(WB, wB_star)], [hA])
    h_kink_star = sp.factor(Ah.LUsolve(bh)[0])
    lower_w = sp.factor(L * wB_star / theta)
    s_at_lower = sp.factor((lower_w - m - nu * h_kink_star) / b)
    s_at_upper = sp.factor((boundary_w - m - nu * h_kink_star) / b)
    assert h_kink_star > 0
    assert s_at_lower >= 0 and s_at_upper > s_at_lower
    assert sp.simplify(h_boundary_star - h_kink_star) == 0
    assert sp.simplify(s_boundary - s_at_upper) == 0

    gradK = [sp.factor(sp.diff(W_K, v).subs({WB: wB_star, sA: s_boundary, hA: h_boundary_star})) for v in (sA, hA)]
    gradM = [sp.factor(sp.diff(W_M, v).subs({sA: s_boundary, hA: h_boundary_star})) for v in (sA, hA)]
    assert sp.simplify(nu * gradK[0] - b * gradK[1]) == 0
    assert sp.simplify(nu * gradM[0] - b * gradM[1]) == 0
    lambdaK = sp.factor(gradK[1] / nu)
    lambdaM = sp.factor(gradM[1] / nu)
    assert lambdaK == 0
    assert lambdaM < 0

    W_eq = sp.factor(W_D.subs({sA: s_star, sB: s_star, hA: h_star, hB: h_star}))
    W_alt = sp.factor(W_boundary.subs(z, s_boundary))
    gap = sp.factor(W_eq - W_alt)
    assert gap > 0

    psi = sp.factor(
        sp.diff(W_D, sA, hA) * sp.diff(W_D, sA, sB)
        - sp.diff(W_D, sA, 2) * sp.diff(W_D, hA, sB)
    )
    psi_star = sp.factor(psi.subs({sA: s_star, sB: s_star, hA: h_star, hB: h_star}))

    return {
        "s": s_star,
        "h": h_star,
        "gap": gap,
        "psi": psi_star,
    }


def main():
    low = exact_point(sp.Rational(9, 10))
    high = exact_point(sp.Rational(1))
    assert low["psi"] < 0
    assert high["psi"] > 0
    print("no-x beta=1.3 global-SPNE point theta=.9:", {k: float(v) for k, v in low.items()})
    print("no-x beta=1.3 global-SPNE point theta=1:", {k: float(v) for k, v in high.items()})
    print("NO-X GLOBAL COUNTEREXAMPLE PASS")


if __name__ == "__main__":
    main()
