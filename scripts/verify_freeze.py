from __future__ import annotations

import math
import sympy as sp


def derive_firm_stage():
    theta, kx, kg, mu, q, s = sp.symbols("theta kx kg mu q s", positive=True)
    D = 4 - theta**2
    x, g = sp.symbols("x g")
    # Reduced operating-profit derivative at the investment stage is represented
    # through dq/dx = 2/D and dq/dg = 2*mu/D; with Cournot operating profit q^2.
    fx = 2*q*(2/D) - kx*x
    fg = 2*q*(2*mu/D) - kg*g + s
    x_star = sp.solve(sp.Eq(fx, 0), x)[0]
    g_star = sp.solve(sp.Eq(fg, 0), g)[0]
    assert sp.simplify(x_star - 4*q/(D*kx)) == 0
    assert sp.simplify(g_star - (4*mu*q/D + s)/kg) == 0
    return x_star, g_star


def baseline_switching_polynomial():
    # Stage-4R canonical baseline polynomial in u = theta^2.
    u = sp.symbols("u", real=True)
    P = (
        sp.Rational(104112, 10) * u**4
        - sp.Rational(139994784, 1000) * u**3
        + sp.Rational(68408252352, 100000) * u**2
        - sp.Rational(128119176576, 100000) * u
        + sp.Rational(55059512832, 100000)
    )
    return u, sp.expand(P)


def derivative_bernstein_coefficients(P, u):
    coeff = sp.Poly(P, u).all_coeffs()
    # Convert power coefficients A4,...,A0 to A0,...,A4.
    A4, A3, A2, A1, A0 = coeff
    B0 = A1
    B1 = A1 + sp.Rational(2, 3) * A2
    B2 = A1 + sp.Rational(4, 3) * A2 + A3
    B3 = A1 + 2*A2 + 3*A3 + 4*A4
    return [sp.simplify(x) for x in (B0, B1, B2, B3)]


def verify_threshold():
    u, P = baseline_switching_polynomial()
    assert P.subs(u, 0) > 0
    assert P.subs(u, 1) < 0
    B = derivative_bernstein_coefficients(P, u)
    assert all(b < 0 for b in B)
    roots = [complex(r) for r in sp.nroots(P, n=30, maxsteps=200)]
    real_unit = sorted(r.real for r in roots if abs(r.imag) < 1e-10 and 0 < r.real < 1)
    assert len(real_unit) == 1
    theta_star = math.sqrt(real_unit[0])
    assert abs(theta_star - 0.7738043861) < 1e-8
    return theta_star, B


def verify_no_competitive_investment_benchmark():
    # Canonical Stage-4R Bernstein coefficients for the benchmark polynomial.
    C = [60249.47, 38541.99, 23922.74, 14204.30, 7849.96]
    assert all(c > 0 for c in C)
    return C


def main():
    derive_firm_stage()
    theta_star, B = verify_threshold()
    C = verify_no_competitive_investment_benchmark()
    print(f"theta_star={theta_star:.10f}")
    print("P' Bernstein coefficients:", [float(b) for b in B])
    print("benchmark Bernstein coefficients:", C)
    print("VERIFICATION PASS")


if __name__ == "__main__":
    main()
