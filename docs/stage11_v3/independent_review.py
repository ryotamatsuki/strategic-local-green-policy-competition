"""Stage 11 referee reconstruction. SymPy, NumPy and SciPy only."""
from itertools import combinations
import numpy as np
import sympy as sp
from scipy.optimize import root

T = sp.Symbol("theta")
S, H, V = sp.symbols("s h rival_w")
W = sp.Symbol("own_w")
D_TARGET = sp.Symbol("d")
Q = sp.Rational
CANON = dict(inv_kx=Q(1, 4), kg=18, mu=Q(9, 10), nu=Q(6, 5),
             kappa=Q(4, 5), d=2, e=Q(11, 10), beta=Q(17, 10), xi=Q(1, 10), m=2, target=0)


def primitives(p):
    b = p["mu"] / p["kg"]
    r = p["inv_kx"] + p["mu"] * b
    return b, r


def firm_affines(t, p):
    """Output and centered cost reduction for each active set, ordered low to high own w."""
    b, r = primitives(p)
    own = p["m"] + b * S + p["nu"] * H
    ell = 2 - 4 * r / (4 - t**2)
    mono = 2 - r
    qa = (ell * own - t * V) / (ell**2 - t**2)
    qb = (ell * V - t * own) / (ell**2 - t**2)
    mapping = {"D": (qa, qb, (2 - ell) * qa)}
    if t == 0:
        return mapping
    return {
        "RM": (0, V / mono, 0),
        "RK": (0, own / t, 0),
        **mapping,
        "OK": (V / t, 0, 2 * V / t - own),
        "OM": (own / mono, 0, r * own / mono),
    }


def values(t, p, qa, qb, u):
    _, r = primitives(p)
    # From centered cost minimization and gross (transfer-free) investment cost.
    g = S / p["kg"] + p["mu"] * u / (r * p["kg"])
    emission = p["e"] * qa - p["beta"] * g - p["xi"] * H
    cs = (qa**2 + qb**2) / 2 + t * qa * qb
    ps = qa**2 - u**2 / (2 * r) - p["mu"] * u * S / (r * p["kg"]) - S**2 / (2 * p["kg"])
    infra = p["kappa"] * H**2 / 2
    target = -p["d"] * (emission - p["target"])**2 / 2
    return cs / 2, ps, -infra, target, emission, g


def quadratic(expr):
    coords = (S, H)
    return sp.hessian(expr, coords).applyfunc(sp.cancel)


def grad(expr):
    return sp.Matrix([sp.diff(expr, z) for z in (S, H)])


def reduce_all(t, p):
    return {k: values(t, p, *row) for k, row in firm_affines(t, p).items()}


def symmetric_policy(t, p, objective, coordinated=False):
    b, _ = primitives(p)
    f = grad(objective)
    if coordinated:
        f += sp.Matrix([b, p["nu"]]) * sp.diff(objective, V)
    f = f.subs(V, p["m"] + b * S + p["nu"] * H)
    jac, intercept = sp.linear_eq_to_matrix(f, [S, H])
    return (jac.inv() * intercept).applyfunc(sp.cancel)


def signed_interval(label, expr, want=1):
    """Exact univariate sign test with rational root counts, endpoints and pole checks."""
    num, den = sp.fraction(sp.cancel(expr))
    numer, denom = sp.Poly(num, T), sp.Poly(den, T)
    assert numer.count_roots(0, 1) == 0, (label, "zeros")
    assert denom.count_roots(0, 1) == 0, (label, "poles")
    left, right = [sp.cancel(expr).subs(T, edge) for edge in (0, 1)]
    assert want * left > 0 and want * right > 0, (label, left, right)
    print(label, "degrees", (numer.degree(), denom.degree()), "ends", float(left), float(right))


def exact_witness(p):
    b, r = primitives(p)
    objective_by_branch = {k: sum(row[:4]) for k, row in reduce_all(T, p).items()}
    obj = objective_by_branch["D"]
    hess = quadratic(obj)
    cross = grad(sp.diff(obj, V)).applyfunc(sp.cancel)
    symmetric = symmetric_policy(T, p, obj)
    rival = sp.cancel(p["m"] + b * symmetric[0] + p["nu"] * symmetric[1])
    ell, mono = 2 - 4 * r / (4 - T**2), 2 - r
    signed_interval("s positive", symmetric[0])
    signed_interval("h positive", symmetric[1])
    signed_interval("D own first minor", hess[0, 0], -1)
    signed_interval("D own determinant", hess.det())
    signed_interval("rival-kink entrance unreachable", ell * p["m"] - T * rival)
    signed_interval("policy symmetric block", (hess + cross * sp.Matrix([[b, p["nu"]]] )).det())
    signed_interval("policy antisymmetric block", (hess - cross * sp.Matrix([[b, p["nu"]]] )).det())

    # Slice the shared OK/OM boundary in coordinates (s, effective intercept).
    # At a feasible slice optimum both branch gradients in (s,w) have zero s component.
    slice_objectives = {}
    for name in ("OK", "OM"):
        original = objective_by_branch[name]
        slice_objectives[name] = original.subs(H, (W - p["m"] - b * S) / p["nu"])
    wall = mono * rival / T
    edge = slice_objectives["OM"]
    along = sp.diff(edge, S)
    s_wall = sp.cancel(-along.subs(S, 0).subs({W: wall, V: rival}, simultaneous=True) / sp.diff(along, S))
    h_wall = sp.cancel((wall - p["m"] - b * s_wall) / p["nu"])
    signed_interval("wall s positive", T * s_wall)
    signed_interval("wall h positive", T * h_wall)
    for name, direction in (("OK", 1), ("OM", -1)):
        form = objective_by_branch[name]
        hh = quadratic(form)
        # OK quantities are constant conditional on V, so both Hessians are regular at theta=0.
        signed_interval(name + " first minor", hh[0, 0], -1)
        signed_interval(name + " determinant", hh.det())
        expr = slice_objectives[name]
        along_wall = sp.cancel(sp.diff(expr, S).subs({S: s_wall, W: wall, V: rival}, simultaneous=True))
        assert along_wall == 0
        normal = sp.diff(expr, W).subs({S: s_wall, W: wall, V: rival}, simultaneous=True)
        signed_interval(name + " inward upper-bound gradient (scaled)", T * normal, direction)
    def value_at(mode, subsidy, infra):
        subs = {S: subsidy, H: infra, V: rival}
        state = [sp.cancel(sp.sympify(v).subs(subs, simultaneous=True)) for v in firm_affines(T, p)[mode]]
        parts = values(T, p, *state)[:4]
        return sum(sp.cancel(v.subs(subs, simultaneous=True)) for v in parts)

    duopoly_value = value_at("D", *symmetric)
    wall_value = value_at("OM", s_wall, h_wall)
    gap = sp.cancel(sp.cancel(T**2 * duopoly_value) - sp.cancel(T**2 * wall_value))
    signed_interval("scaled global welfare gap", gap)
    print("exact scaled-gap limit", gap.subs(T, 0))
    print("unscaled gaps", [float(gap.subs(T, a)/a**2) for a in (Q(1, 2), Q(9, 10), Q(1))])
    print("wall policies at .9", float(s_wall.subs(T, Q(9, 10))), float(h_wall.subs(T, Q(9, 10))))


def polynomial_and_channels():
    p = dict(CANON, d=D_TARGET)
    rows = reduce_all(T, p)["D"]
    matrices = [quadratic(part) for part in rows[:4]]
    vectors = [grad(sp.diff(part, V)).applyfunc(sp.cancel) for part in rows[:4]]
    hess = sum(matrices, sp.zeros(2))
    cross = sum(vectors, sp.zeros(2, 1))
    # Eliminate the government's subsidy via its first FOC, rather than expand the printed quartic.
    numerator = sp.cancel(hess[0,1]*cross[0] - hess[0,0]*cross[1])
    assert sp.diff(numerator, D_TARGET, 2) == 0
    dstar = sp.cancel(-numerator.subs(D_TARGET, 0) / sp.diff(numerator, D_TARGET))
    prefactor = sp.cancel(sp.diff(numerator, D_TARGET) / T)
    signed_interval("canonical N_d / theta", prefactor)
    signed_interval("canonical d*(theta) slope / theta", sp.cancel(sp.diff(dstar, T) / T), -1)
    print("d*(0), d*(.5), d*(.9), d*(1)", [float(dstar.subs(T, x)) for x in (0, Q(1,2), Q(9,10), 1)])
    u = sp.Symbol("u")
    for d in (Q(3,2), 2, 3):
        n, _ = sp.fraction(sp.cancel(numerator.subs(D_TARGET, d) / T))
        factors = sp.factor_list(n)[1]
        pol = next(f for f, _ in factors if sp.degree(f, T) == 8)
        poly = sp.Poly(pol.subs(T**2, u), u)
        print("d", d, "quartic", poly.as_expr(), "root count", poly.count_roots(0, 1))
        if d == 2:
            a, b, c, f, g = poly.all_coeffs()
            print("Bernstein for derivative", f, f+2*c/3, f+4*c/3+b, f+2*c+3*b+4*a)
            rr = next(z for z in sp.nroots(poly, n=24) if z.is_real and 0 < z < 1)
            print("u*, theta*", rr, sp.sqrt(rr))
    b, _ = primitives(p)
    for t in (Q(1, 2), Q(9, 10)):
        subs = {T:t, D_TARGET:2}
        hh = hess.subs(subs)
        psi = [b * (v[1] - hh[0,1]/hh[0,0]*v[0]).subs(subs) for v in vectors]
        denom = hh[1,1]-hh[0,1]**2/hh[0,0]
        print("theta", t, "profiled CS/PS/infra/target contributions to BR slope", [float(-v/denom) for v in psi])
        print("  direct and post-subsidy-relaxation mixed effects",
              float(b*cross[1].subs(subs)), float(sum(psi)))

    for label, beta in (("matched", Q(17,10)), ("modified", Q(13,10))):
        variant = dict(CANON, inv_kx=0, beta=beta)
        obj = sum(reduce_all(T, variant)["D"][:4])
        hh = quadratic(obj)
        g = grad(sp.diff(obj, V)).applyfunc(sp.cancel)
        n = sp.cancel((hh[0,1]*g[0] - hh[0,0]*g[1])/T)
        nf = sp.factor_list(sp.fraction(n)[0])[1]
        p_no_x = sp.Poly(next(f for f,_ in nf if sp.degree(f, T) == 4).subs(T**2,u),u)
        print("no-x", label, p_no_x.as_expr(), "root count", p_no_x.count_roots(0,1))
        if label == "modified":
            rr = next(z for z in sp.nroots(p_no_x, n=24) if z.is_real and 0 < z < 1)
            print("no-x alternative theta*", sp.sqrt(rr))


def numeric_game(t, p):
    t = sp.Rational(str(t))
    coords = (S, H, V)
    data = {}
    zero = dict.fromkeys(coords, 0)
    for label, row in reduce_all(t, p).items():
        expr = sum(row[:4])
        hess = np.array(sp.hessian(expr, coords), dtype=float)
        shift = np.array(grad(expr).col_join(sp.Matrix([sp.diff(expr, V)])).subs(zero), dtype=float).ravel()
        data[label] = hess, shift, float(expr.subs(zero))
    t = float(t)
    b, r = map(float, primitives(p))
    ell, mono = 2-4*r/(4-t*t), 2-r
    w0, policy_load = float(p["m"]), np.array([b, float(p["nu"])])
    dud = data["D"]

    def own_value(z, rival, mode="D"):
        hh, dd, dd0 = data[mode]
        vec = np.r_[z, rival]
        return float(vec @ hh @ vec / 2 + dd @ vec + dd0)

    def br(rival, count=False):
        intervals = dict(D=(-np.inf, np.inf)) if not t else {
            "RM":(-np.inf,t*rival/mono), "RK":(t*rival/mono,t*rival/ell),
            "D":(t*rival/ell,ell*rival/t), "OK":(ell*rival/t,mono*rival/t),
            "OM":(mono*rival/t,np.inf),
        }
        found = []
        for mode, (lo, hi) in intervals.items():
            if hi < w0:
                continue
            h_all, d_all, c = data[mode]
            hess = h_all[:2,:2]
            shift = d_all[:2] + h_all[:2,2]*rival
            if np.isinf(hi) and np.linalg.eigvalsh(hess).max() >= 0:
                raise ArithmeticError(f"Uncertified upper tail at {t}, {mode}")
            constraints = [(-np.eye(2)[idx],0.) for idx in range(2)]
            if lo > w0:
                constraints.append((-policy_load,w0-lo))
            if np.isfinite(hi):
                constraints.append((policy_load,hi-w0))
            a,bounds = np.array([a for a, _ in constraints]), np.array([b for _, b in constraints])
            for n in (0,1,2):
                for chosen in combinations(range(len(a)),n):
                    selected = list(chosen)
                    active = a[selected]
                    system = np.block([[hess,active.T],[active,np.zeros((n,n))]])
                    try:
                        z = np.linalg.solve(system,np.r_[-shift,bounds[selected]])[:2]
                    except np.linalg.LinAlgError as exc:
                        # Parallel bound faces cannot define a unique corner.
                        if n == 2 and np.linalg.matrix_rank(active) < 2:
                            continue
                        # On a compact face, a consistent singular stationary system
                        # is flat along a free direction and has a boundary maximizer.
                        # If inconsistent, there is no stationary point on the face.
                        if n < 2 and np.isfinite(hi):
                            continue
                        raise ArithmeticError((t, rival, mode, chosen, hess, system)) from exc
                    if np.max(a@z-bounds) <= 1e-8:
                        found.append((own_value(z,rival,mode),mode,z))
        if not found:
            raise ArithmeticError(f"No candidate at {t}, rival index {rival}")
        found.sort(key=lambda item:item[0], reverse=True)
        return found if count else found[0]

    reduced_load = dud[0][:2,2,None] * policy_load[None,:]
    sym = np.linalg.solve(dud[0][:2,:2]+reduced_load, -dud[1][:2]-dud[0][:2,2]*w0)
    return br, sym, policy_load, own_value, dud


def numeric_attacks():
    for name,p in [("canonical",CANON),("matched no-x",dict(CANON,inv_kx=0)),
                   ("no-x beta=1.3",dict(CANON,inv_kx=0,beta=Q(13,10)))]:
        for t in (.5,.9,1.):
            br,sym,load,value,mat = numeric_game(t,p)
            rival = float(p["m"]) + load @ sym
            best = br(rival, count=True)
            assert np.linalg.norm(best[0][2]-sym) < 1e-6
            slope = np.linalg.solve(-mat[0][:2,:2],mat[0][:2,2]*load[0])[1]
            tail = next((best[0][0]-v for v,mode,z in best if mode!="D"),None)
            print(name, t, "candidate", sym, "slope", slope, "best non-D loss", tail)
            if name == "canonical":
                # Distinct alternative-equilibrium search in the exact scalar rival-index game.
                m = float(p["m"])
                def f(x):
                    A,B=x
                    return np.array([A-m-load@br(max(B,m))[2],B-m-load@br(max(A,m))[2]])
                starts = [m,m+.25,m+1,m+3,m+12,m+80]
                outcomes = [root(f,(a,b)) for a in starts for b in starts]
                roots = {tuple(float(x) for x in np.round(res.x,7))
                         for res in outcomes if np.linalg.norm(f(res.x)) < 1e-6}
                failures = [float(np.linalg.norm(f(res.x))) for res in outcomes if np.linalg.norm(f(res.x)) >= 1e-6]
                print("  fixed-point search roots", sorted(roots), "unresolved solves", len(failures))
            if name == "matched no-x" and t == .9:
                _, r = map(float, primitives(p))
                ell, mono = 2-4*r/(4-t*t), 2-r
                for rival_index in (float(p["m"]), rival):
                    lower, upper = ell*rival_index/t, mono*rival_index/t
                    h = (lower - float(p["m"]))/load[1]
                    for fraction in (.25,.75):
                        point = np.array([(upper-lower)*fraction/load[0],h])
                        other_br = br(float(p["m"])+load@point)
                        print("no-x kink indifference", rival_index, point,
                              "own kink W", value(point,rival_index,"OK"),
                              "other government's global BR", other_br[1:])
    p = CANON
    t = Q(9,10)
    _, sym, _, _, _ = numeric_game(.9,p)
    rows = reduce_all(t,p)["D"]
    obj = sum(rows[:4])
    planner = symmetric_policy(t,p,obj,coordinated=True)
    b,_=primitives(p)
    for policy in (list(sym),list(planner)):
        s,h=policy
        subs={S:s,H:h,V:p["m"]+b*s+p["nu"]*h}
        print("welfare at .9", list(map(float,policy)), "2W,E,q",
              [float(x.subs(subs)) for x in (2*obj, rows[4], firm_affines(t,p)["D"][0])])
        print("welfare components per jurisdiction", [float(x.subs(subs)) for x in rows[:4]])
    for d in (Q(3,2),3):
        variant = dict(CANON,d=d)
        br, sym, load, val, _ = numeric_game(.9,variant)
        if np.min(sym) < 0:
            print("d scope stress .9", d, "infeasible interior FOC", sym)
            continue
        rival = variant["m"] + load @ sym
        best_w, mode, policy = br(rival)
        print("d scope stress .9", d, "interior FOC", sym, "global own BR to that rival vector",
              mode, policy, "gain over algebraic FOC payoff", best_w-val(sym,rival))
    historical = dict(CANON, inv_kx=Q(1,8), mu=Q(1), nu=Q(14,10), kappa=Q(42,100),
                      e=Q(14,10), beta=Q(28,10), xi=Q(8,100))
    br, candidate, load, value, _ = numeric_game(.9, historical)
    rival = historical["m"] + load @ candidate
    deviation = np.array([60.,22.])
    _, r = primitives(historical)
    assert .9 * (historical["m"] + load @ deviation) >= (2-r) * rival
    base_value, deviation_value = value(candidate,rival), value(deviation,rival,"OM")
    assert deviation_value > base_value
    print("historical out-of-scope deviation .9", base_value, deviation_value, br(rival)[:2])


if __name__ == "__main__":
    polynomial_and_channels()
    exact_witness(CANON)
    numeric_attacks()
