"""Independent Stage 6 diagnostic: exact d*(theta) and profiled response decomposition.

This is an INTERIOR active-duopoly diagnostic, not a global-SPNE
certificate for arbitrary target weights. Use Python 3 + SymPy.
"""
import sympy as sp

T, u = sp.symbols("theta u")
Q = sp.Rational
kx, kg, mu, nu, kappa, e, beta, xi = (
    Q(4), Q(18), Q(9, 10), Q(6, 5), Q(4, 5),
    Q(11, 10), Q(17, 10), Q(1, 10)
)
b = mu / kg
R = 1 / kx + mu**2 / kg
L = 2 - 4 * R / (4 - T**2)
ell = 4 * R / (4 - T**2)
A = L / (L**2 - T**2)
B = -T / (L**2 - T**2)
es = sp.Matrix([1, 0, 0])
eh = sp.Matrix([0, 1, 0])
ev = sp.Matrix([0, 0, 1])
qa = A * (b * es + nu * eh) + B * ev
qb = B * (b * es + nu * eh) + A * ev
em = (e - beta * mu * ell / (R * kg)) * qa - beta / kg * es - xi * eh
outer = lambda x, y: x * y.T
Hcs = sp.Rational(1, 2) * (outer(qa, qa) + outer(qb, qb)) + T / 2 * (outer(qa, qb) + outer(qb, qa))
Hps = (2 - ell**2 / R) * outer(qa, qa) - mu * ell / (R * kg) * (outer(qa, es) + outer(es, qa)) - outer(es, es) / kg
Hinfra = -kappa * outer(eh, eh)
H0 = Hcs + Hps + Hinfra
Htarget0 = -outer(em, em)
M = H0
E = outer(em, em)

# N = H_sh H_sV - H_ss H_hV; H=H0 - d*E. The d^2 terms vanish
# because E is rank one.
N0 = sp.factor(M[0, 1] * M[0, 2] - M[0, 0] * M[1, 2])
N1 = sp.factor(-E[0, 1] * M[0, 2] - M[0, 1] * E[0, 2]
               + E[0, 0] * M[1, 2] + M[0, 0] * E[1, 2])
dstar = sp.factor(-N0 / N1)
Apoly = 50 * u**4 - 1000 * u**3 + 7073 * u**2 - 20525 * u + 20604
Bpoly = 242500 * u**4 - 901550 * u**3 - 11337491 * u**2 + 73636958 * u - 116485656
Cpoly = (5982500 * u**6 - 138307700 * u**5 + 1323988950 * u**4
         - 6895925900 * u**3 + 21009569023 * u**2
         - 35776083656 * u + 26474309296)
assert sp.cancel(dstar + 14400 * Apoly.subs(u, T**2) / Bpoly.subs(u, T**2)) == 0
assert sp.cancel(sp.diff(dstar, T) / T
                 + 950400 * Cpoly.subs(u, T**2) / Bpoly.subs(u, T**2)**2) == 0
for p, sign in [(Apoly, 1), (Bpoly, -1), (Cpoly, 1)]:
    obj = sp.Poly(p, u)
    assert obj.count_roots(0, 1) == 0
    assert sign * p.subs(u, 0) > 0
for factor in (50*T**3-100*T**2-200*T+341, 50*T**3+100*T**2-200*T-341):
    assert sp.Poly(factor, T).count_roots(0, 1) == 0
assert sp.cancel(N1/T).subs(T, sp.Rational(1,2)) > 0
for theta, expect in [(0, 2.5470741221562936), (Q(1,2), 2.317362364492486),
                      (Q(9,10), 1.806192969752593), (1, 1.628378353862220)]:
    actual = float(dstar.subs(T, theta))
    assert abs(actual - expect) < 1e-12
    print("theta",theta,"interior dstar",actual)

for t in (Q(1,2), Q(9,10)):
    H = (H0 + 2*Htarget0).subs(T, t)
    schur = H[1,1] - H[0,1]**2 / H[0,0]
    assert H[0,0] < 0 and schur < 0
    def component(X):
        XX = X.subs(T, t)
        return float(-b * (XX[1,2] - H[0,1] / H[0,0] * XX[0,2]) / schur)
    vals = [component(Hcs), component(Hps), component(2*Htarget0)]
    slope = sum(vals)
    direct = float(b * H[1,2])
    expected = {-1: None, Q(1,2): (-.00455221890862445, .0002368389153),
                Q(9,10): (.00711257228711189, .00808653554849)}[t]
    assert abs(slope-expected[0]) < 1e-11
    assert abs(direct-expected[1]) < 1e-11
    print("theta",t,"direct",direct,"profiled CS, PS, target",vals,"total",slope)
print("STAGE 6 exact interior boundary and channel decomposition PASS")
