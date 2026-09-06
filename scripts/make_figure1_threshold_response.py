from __future__ import annotations

from pathlib import Path

import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import numpy as np
import sympy as sp

ROOT = Path(__file__).resolve().parents[1]
FIG_DIR = ROOT / 'figures'
PDF_PATH = FIG_DIR / 'figure1_threshold_response.pdf'
PNG_PATH = FIG_DIR / 'figure1_threshold_response.png'

THETA_STAR = 0.773804386083461
BASELINE_CHECKS = {
    0.1: -0.0012312138411530414,
    0.3: -0.0034418551759057914,
    0.5: -0.00455221890862445,
    0.7: -0.002414890272554068,
    0.8: 0.0011500303027101037,
    0.9: 0.007112572287111896,
}


def _canonical_response(include_conventional: bool):
    """Return the exact canonical interior response dh_A^BR/ds_B.

    This reconstructs the same reduced welfare/Hessian system used by the
    manuscript verification scripts. The no-x case is the nested benchmark
    obtained by setting the conventional-investment feedback 1/k_x to zero.
    """
    theta = sp.symbols('theta', real=True)
    sA, hA, sB, hB = sp.symbols('sA hA sB hB', real=True)

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
    R = (1 / kx if include_conventional else 0) + mu**2 / kg
    lam = 4 * R / D
    L = 2 - lam
    b = mu / kg
    det = L**2 - theta**2

    wA = m + b * sA + nu * hA
    wB = m + b * sB + nu * hB
    qA = sp.factor((L * wA - theta * wB) / det)
    qB = sp.factor((L * wB - theta * wA) / det)

    gA = sp.factor((4 * mu * qA / D + sA) / kg)
    CS = sp.factor(sp.Rational(1, 2) * (qA**2 + qB**2) + theta * qA * qB)
    PSA = sp.factor(qA**2 - kg * gA**2 / 2)
    if include_conventional:
        xA = sp.factor(4 * qA / (D * kx))
        PSA = sp.factor(PSA - kx * xA**2 / 2)
    EA = sp.factor(e * qA - beta * gA - xi * hA)
    WA = sp.factor(CS / 2 + PSA - kappa * hA**2 / 2 - d * EA**2 / 2)

    H = sp.hessian(WA, (sA, hA))
    cross = sp.Matrix([sp.diff(WA, sA, sB), sp.diff(WA, hA, sB)])
    response = sp.simplify(-H.inv() * cross)
    return theta, sp.factor(response[1])


def verify_response_expressions():
    theta, baseline = _canonical_response(include_conventional=True)
    _, no_x = _canonical_response(include_conventional=False)

    baseline_num = sp.factor(sp.fraction(baseline)[0])
    no_x_num = sp.factor(sp.fraction(no_x)[0])

    full_poly = (
        602500 * theta**8
        - 8101550 * theta**6
        + 39588109 * theta**4
        - 74143042 * theta**2
        + 31863144
    )
    no_x_poly = 602500 * theta**4 - 3281550 * theta**2 + 3486659

    baseline_ratio = sp.factor(baseline_num / full_poly)
    no_x_ratio = sp.factor(no_x_num / no_x_poly)
    expected_common = 375 * theta * (theta - 2) * (theta + 2)
    assert sp.simplify(baseline_ratio - expected_common) == 0
    assert sp.simplify(no_x_ratio - expected_common) == 0

    baseline_fn = sp.lambdify(theta, baseline, 'numpy')
    no_x_fn = sp.lambdify(theta, no_x, 'numpy')

    for t, expected in BASELINE_CHECKS.items():
        got = float(baseline_fn(t))
        assert abs(got - expected) < 1e-12, (t, got, expected)

    assert abs(float(baseline_fn(THETA_STAR))) < 2e-12

    check_grid = np.linspace(0.001, 1.0, 1000)
    no_x_values = np.asarray(no_x_fn(check_grid), dtype=float)
    assert np.all(no_x_values < 0)

    return baseline_fn, no_x_fn


def _plot_response(grid, baseline_values, no_x_values):
    """Build the publication figure once so PDF and PNG share the same geometry."""
    matplotlib.rcParams['pdf.fonttype'] = 42
    matplotlib.rcParams['ps.fonttype'] = 42

    fig, ax = plt.subplots(figsize=(6.4, 4.1))
    ax.plot(grid, baseline_values, color='black', linewidth=1.8, linestyle='-', label='Full model')
    ax.plot(grid, no_x_values, color='black', linewidth=1.6, linestyle='--', label='Matched no-$x$ benchmark')
    ax.axhline(0.0, color='0.45', linewidth=0.9, linestyle=':')
    ax.axvline(THETA_STAR, color='0.45', linewidth=1.0, linestyle='-.', label=r'$\theta^*=0.7738$')
    ax.set_xlim(0.0, 1.0)
    ax.set_xlabel(r'Product substitutability $\theta$')
    ax.set_ylabel(r'$\partial h_A^{BR}/\partial s_B$')
    ax.legend(frameon=False, loc='upper left')
    ax.margins(x=0)
    fig.tight_layout()
    return fig


def make_figure():
    baseline_fn, no_x_fn = verify_response_expressions()
    FIG_DIR.mkdir(parents=True, exist_ok=True)

    grid = np.linspace(0.0, 1.0, 401)
    baseline_values = np.asarray(baseline_fn(grid), dtype=float)
    no_x_values = np.asarray(no_x_fn(grid), dtype=float)

    fig = _plot_response(grid, baseline_values, no_x_values)
    pdf_metadata = {
        'Title': 'Canonical cross-instrument infrastructure response',
        'Author': 'Ryota Matsuki',
        'Creator': 'scripts/make_figure1_threshold_response.py',
        'CreationDate': None,
        'ModDate': None,
    }
    fig.savefig(PDF_PATH, bbox_inches='tight', metadata=pdf_metadata)
    fig.savefig(PNG_PATH, dpi=220, bbox_inches='tight', metadata={'Software': 'matplotlib'})
    plt.close(fig)

    print(f'baseline_theta_0.5={float(baseline_fn(0.5)):.12f}')
    print(f'baseline_theta_0.9={float(baseline_fn(0.9)):.12f}')
    print(f'baseline_theta_star={THETA_STAR:.15f}')
    print(f'no_x_min={float(np.min(no_x_values[1:])):.12f}')
    print(f'no_x_max_on_positive_grid={float(np.max(no_x_values[1:])):.12f}')
    print(f'WROTE {PDF_PATH.relative_to(ROOT)}')
    print(f'WROTE {PNG_PATH.relative_to(ROOT)}')


if __name__ == '__main__':
    make_figure()
