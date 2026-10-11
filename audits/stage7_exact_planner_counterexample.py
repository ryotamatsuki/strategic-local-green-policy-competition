"""Stage 7 exact-rational counterexample to unrestricted coordinated welfare.

Independently reconstructs the canonical primitive game and proves that the
reported symmetric active-duopoly cooperative benchmark is NOT the maximum of
the unrestricted 4-instrument planner problem. This is a welfare-scope
regression test, not a claim to have solved the global planner exactly.

Usage: python audits/stage7_exact_planner_counterexample.py
Requires: sympy (already in repository requirements).
"""
import sympy as sp

t = sp.Rational(9, 10)
kx, kg = sp.Integer(4), sp.Integer(18)
mu, nu = sp.Rational(9, 10), sp.Rational(6, 5)
kappa, d = sp.Rational(4, 5), sp.Integer(2)
e, beta, xi, m = sp.Rational(11, 10), sp.Rational(17, 10), sp.Rational(1, 10), sp.Integer(2)
R = 1 / kx + mu**2 / kg
D = 4 - t**2
L = 2 - 4 * R / D

# Symmetric policy-constrained, two-active-firm objective.
s, h = sp.symbols("s h", real=True)
q = (m + (mu / kg) * s + nu * h) / (L + t)
x = 4 * q / (D * kx)
g = (s + 4 * mu * q / D) / kg
E = e * q - beta * g - xi * h
CS = (1 + t) * q**2
PS = q**2 - kx * x**2 / 2 - kg * g**2 / 2
W_sym = sp.expand(CS + 2 * PS - kappa * h**2 - d * E**2)
candidate = sp.solve((sp.diff(W_sym, s), sp.diff(W_sym, h)), (s, h), rational=True)
assert candidate[s] > 0 and candidate[h] > 0
W_sym_val = sp.factor(W_sym.subs(candidate))
# Check symmetry-restricted optimum, not full planner globality.
Hsym = sp.hessian(W_sym, (s, h))
assert Hsym[0, 0] < 0 and sp.factor(Hsym.det()) > 0

# Feasible 4-dimensional policy: (s_A,h_A,s_B,h_B)=(30,18,0,0).
sA, hA, sB, hB = sp.Integer(30), sp.Integer(18), sp.Integer(0), sp.Integer(0)
wA = m + (mu / kg) * sA + nu * hA
wB = m + (mu / kg) * sB + nu * hB
# The stage-2/3 A-monopoly inequality, not an extrapolated duopoly formula.
assert t * wA - (2 - R) * wB == sp.Rational(959, 50) > 0
qA = wA / (2 - R)
qB = sp.Integer(0)
xA, xB = qA / kx, sp.Integer(0)
gA, gB = (sA + mu * qA) / kg, sp.Integer(0)
EA, EB = e * qA - beta * gA - xi * hA, sp.Integer(0)
cs_mono = (qA**2 + qB**2) / 2 + t * qA * qB
psA = qA**2 - kx * xA**2 / 2 - kg * gA**2 / 2
psB = sp.Integer(0)
WA = sp.factor(cs_mono / 2 + psA - kappa * hA**2 / 2 - d * EA**2 / 2)
WB = sp.factor(cs_mono / 2 + psB - kappa * hB**2 / 2 - d * EB**2 / 2)
W_alt = sp.factor(WA + WB)
assert W_alt == sp.Rational(53153998, 5232645)
assert sp.factor(W_alt - W_sym_val) > 0
assert WA < 0 and WB > 0

print("theta:", t)
print("symmetric duopoly policies:", candidate)
print("symmetric duopoly welfare:", W_sym_val, float(W_sym_val))
print("feasible asymmetric monopoly policy:", (sA, hA, sB, hB))
print("A monopoly condition margin:", sp.factor(t * wA - (2 - R) * wB))
print("asymmetric welfare A, B, total:", WA, WB, W_alt)
print("asymmetric welfare total numeric:", float(W_alt))
print("strict welfare improvement over restricted comparator:", sp.factor(W_alt - W_sym_val), float(W_alt - W_sym_val))
print("PASS: unrestricted planner != reported symmetric active-duopoly solution")
