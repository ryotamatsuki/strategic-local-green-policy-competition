"""Independent exact slice checks, with no imports from the project solver.

All restrictions and stationary candidates use rational arithmetic. Results are
per parameter vector, not an interval certification.
"""
import itertools

import sympy as sp


Q = sp.Rational
s, h, y = sp.symbols("s h y")
z = sp.Matrix([s, h])
m, kx, kg, mu, nu, kappa, e, beta, xi = (
    Q(2), Q(4), Q(18), Q("0.9"), Q("1.2"), Q("0.8"), Q("1.1"), Q("1.7"), Q("0.1")
)
b = mu / kg
R = 1 / kx + mu**2 / kg
y_a = b * s + nu * h
w_a, w_b = m + y_a, m + y


def policy_model(theta, d, emissions_intensity=e):
    D = 4 - theta**2
    lam = 4 * R / D
    L = 2 - lam
    M = 2 - R
    q_a = (L * w_a - theta * w_b) / (L**2 - theta**2)
    q_b = (L * w_b - theta * w_a) / (L**2 - theta**2)
    quantities = {
        "duopoly": (q_a, q_b, lam * q_a, theta * w_b / L, L * w_b / theta),
        "own kink": (w_b / theta, 0, 2 * w_b / theta - w_a, L * w_b / theta, M * w_b / theta),
        "own monopoly": (w_a / M, 0, R * w_a / M, M * w_b / theta, None),
        "rival kink": (0, w_a / theta, 0, theta * w_b / M, theta * w_b / L),
        "rival monopoly": (0, w_b / M, 0, None, theta * w_b / M),
    }
    result = {}
    for regime, (qa, qb, u, low, high) in quantities.items():
        x_a = u / (kx * R)
        g_a = s / kg + mu * u / (kg * R)
        E = emissions_intensity * qa - beta * g_a - xi * h
        parts = [
            (qa**2 + qb**2 + 2 * theta * qa * qb) / 4,
            qa**2 - kx * x_a**2 / 2 - kg * g_a**2 / 2,
            -d * E**2 / 2,
            -kappa * h**2 / 2,
        ]
        result[regime] = (list(map(sp.expand, parts)), low, high)
    return result


def derivatives(parts):
    W = sum(parts)
    own = sp.hessian(W, (s, h))
    cross = sp.Matrix([sp.diff(W, v, y) for v in z])
    gradient = sp.Matrix([sp.diff(W, v) for v in z])
    return own, cross, gradient


def feasible_maxima(W, lower, upper):
    # Allowed half-spaces have the form normal . z <= limit.
    constraints = [([-1, 0], Q(0)), ([0, -1], Q(0))]
    if lower is not None:
        constraints.append(([-b, -nu], m - lower))
    if upper is not None:
        constraints.append(([b, nu], upper - m))
    hess, _, grad = derivatives([W])
    c = grad.subs({s: 0, h: 0})
    if upper is None and not (hess[0, 0] < 0 and hess.det() > 0):
        raise ValueError("unbounded region requires a coercivity check")
    for n in range(3):
        for active in itertools.combinations(constraints, n):
            if not active:
                M, rhs = hess, -c
            else:
                a = sp.Matrix([x[0] for x in active])
                if a.rank() < n:
                    continue
                top = hess.row_join(a.T)
                M = top.col_join(a.row_join(sp.zeros(n)))
                rhs = (-c).col_join(sp.Matrix([x[1] for x in active]))
            if not M.det():
                raise ValueError("singular stationary system needs separate coverage")
            policy = M.inv()[:2, :] * rhs
            if all(sp.Matrix([normal]).dot(policy) <= limit for normal, limit in constraints):
                value = W.subs(dict(zip(z, policy)))
                yield value, tuple(policy)


def inspect(theta, d, emissions_intensity=e):
    model = policy_model(theta, d, emissions_intensity)
    parts = model["duopoly"][0]
    H, C, G = derivatives(parts)
    F = G.subs(y, y_a)
    jac = F.jacobian(z)
    policy = -jac.inv() * F.subs({s: 0, h: 0})
    rhs = dict(zip(z, policy))
    rival = y_a.subs(rhs)
    Schur = H[1, 1] - H[1, 0] ** 2 / H[0, 0]
    mix = H[1, 0] / H[0, 0]
    channels = [
        -b * (sp.diff(part, h, y) - mix * sp.diff(part, s, y)) / Schur
        for part in parts
    ]
    direct = b * C[1]
    slope = (-H.inv() * C)[1] * b
    assert sum(channels) == slope
    baseline = sum(parts).subs(y, rival).subs(rhs)
    lo, hi = model["duopoly"][1:]
    at_duopoly = lo.subs(y, rival) < (m + rival) < hi.subs(y, rival)
    if min(policy) < 0 or not at_duopoly:
        return ("infeasible", policy, direct, slope, channels, None, None)
    alternatives = []
    for regime, (p, lower, upper) in model.items():
        W = sum(p).subs(y, rival)
        for value, candidate in feasible_maxima(
            W, lower.subs(y, rival) if lower is not None else None,
            upper.subs(y, rival) if upper is not None else None
        ):
            if regime != "duopoly":
                alternatives.append((value, regime, candidate))
            elif H[0, 0] < 0 and H.det() > 0:
                assert value <= baseline
            else:
                raise ValueError("duopoly concavity needed")
    val, regime, best = max(alternatives, default=(baseline, "none", ()))
    return ("strict against exclusion" if val < baseline else "failed or tied",
            policy, direct, slope, channels, baseline - val, (regime, best))


def diagnostic_root(theta, emissions_intensity=e):
    def numerator(d):
        H, C, _ = derivatives(policy_model(theta, d, emissions_intensity)["duopoly"][0])
        return H[0, 1] * C[0] - H[0, 0] * C[1]
    n0 = numerator(Q(0))
    n1 = numerator(Q(1)) - n0
    assert numerator(Q(2)) == n0 + 2 * n1
    return -n0 / n1, n1


def show(theta, d):
    status, policy, direct, slope, channels, margin, alternative = inspect(theta, d)
    print(f"theta={float(theta):.5f} d={float(d):.8f} {status}; "
          f"(s,h)={list(map(float, policy))}; direct={float(direct):+.9f}; "
          f"profile={float(slope):+.9f}; parts={list(map(float, channels))}; "
          f"gap={None if margin is None else float(margin)}; "
          f"challenger={None if alternative is None else (alternative[0], tuple(map(float, alternative[1])))}")


if __name__ == "__main__":
    for th, d in [("0.5", "2"), ("0.9", "2"), ("0.9", "1.5"), ("0.9", "3"),
                  ("0.775", "1.95"), ("0.775", "2.05"), ("0.05", "2"), ("0.15", "2")]:
        show(Q(th), Q(d))
    for th in map(Q, ("0.5", "0.775", "0.9", "1")):
        d, n1 = diagnostic_root(th)
        assert n1 > 0
        show(th, d)
    for new_e in map(Q, ("0.4", "0.8", "1.1", "1.4", "2")):
        roots = [diagnostic_root(Q(th), new_e) for th in ("0.5", "0.9")]
        print(f"e={float(new_e)}: (interior d*, slope of N in d)",
              [(float(root), float(n1)) for root, n1 in roots])
