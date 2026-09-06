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


def _pdf_escape(text: str) -> str:
    return text.replace('\\', '\\\\').replace('(', '\\(').replace(')', '\\)')


def _write_vector_pdf(grid, baseline_values, no_x_values):
    """Write a small deterministic ASCII-only vector PDF."""
    width, height = 460.0, 300.0
    left, right, bottom, top = 64.0, 446.0, 48.0, 282.0
    ymin = float(min(np.min(baseline_values), np.min(no_x_values)))
    ymax = float(max(np.max(baseline_values), np.max(no_x_values)))
    pad = 0.08 * (ymax - ymin)
    ymin -= pad
    ymax += pad

    def X(t):
        return left + (right - left) * float(t)

    def Y(v):
        return bottom + (top - bottom) * (float(v) - ymin) / (ymax - ymin)

    def text(x, y, value, size=8, font='F1'):
        return f'BT /{font} {size} Tf {x:.2f} {y:.2f} Td ({_pdf_escape(value)}) Tj ET'

    cmds = ['0 G', '0 g', '0.8 w']
    cmds.append(f'{left:.2f} {bottom:.2f} m {right:.2f} {bottom:.2f} l S')
    cmds.append(f'{left:.2f} {bottom:.2f} m {left:.2f} {top:.2f} l S')

    for t in np.linspace(0, 1, 6):
        x = X(t)
        cmds.append(f'{x:.2f} {bottom:.2f} m {x:.2f} {bottom-3:.2f} l S')
        cmds.append(text(x-6.0, bottom-14.0, f'{t:.1f}', 7))

    for v in np.linspace(ymin, ymax, 6):
        y = Y(v)
        cmds.append(f'{left:.2f} {y:.2f} m {left-3:.2f} {y:.2f} l S')
        cmds.append(text(8.0, y-2.5, f'{v:.3f}', 7))

    y0 = Y(0.0)
    cmds += ['0.45 G', '0.6 w', '[1.5 2] 0 d']
    cmds.append(f'{left:.2f} {y0:.2f} m {right:.2f} {y0:.2f} l S')
    xs = X(THETA_STAR)
    cmds += ['[5 2 1 2] 0 d']
    cmds.append(f'{xs:.2f} {bottom:.2f} m {xs:.2f} {top:.2f} l S')

    def path(values, dash, linewidth):
        parts = [f'{X(grid[0]):.2f} {Y(values[0]):.2f} m']
        parts.extend(f'{X(t):.2f} {Y(v):.2f} l' for t, v in zip(grid[1:], values[1:]))
        return [f'{dash} 0 d', f'{linewidth} w', '0 G', ' '.join(parts) + ' S']

    cmds += path(baseline_values, '[]', 1.5)
    cmds += path(no_x_values, '[6 3]', 1.25)

    cmds.append(text(178.0, 12.0, 'Product substitutability theta', 9))
    cmds.append('q 0 1 -1 0 38 170 cm')
    cmds.append(text(0.0, 0.0, 'd h_A^BR / d s_B', 9))
    cmds.append('Q')

    lx, ly = left + 12, top - 13
    cmds += ['[] 0 d', '1.5 w', '0 G', f'{lx:.2f} {ly:.2f} m {lx+24:.2f} {ly:.2f} l S']
    cmds.append(text(lx+30, ly-3, 'Full model', 8))
    cmds += ['[6 3] 0 d', '1.25 w', f'{lx:.2f} {ly-14:.2f} m {lx+24:.2f} {ly-14:.2f} l S']
    cmds.append(text(lx+30, ly-17, 'Matched no-x benchmark', 8))
    cmds += ['[5 2 1 2] 0 d', '0.6 w', '0.45 G', f'{lx:.2f} {ly-28:.2f} m {lx+24:.2f} {ly-28:.2f} l S']
    cmds.append(text(lx+30, ly-31, 'theta* = 0.7738', 8))

    stream = ('\n'.join(cmds) + '\n').encode('ascii')
    objects = [
        b'<< /Type /Catalog /Pages 2 0 R >>',
        b'<< /Type /Pages /Kids [3 0 R] /Count 1 >>',
        (f'<< /Type /Page /Parent 2 0 R /MediaBox [0 0 {width:.0f} {height:.0f}] '
         f'/Resources << /Font << /F1 4 0 R >> >> /Contents 5 0 R >>').encode('ascii'),
        b'<< /Type /Font /Subtype /Type1 /BaseFont /Helvetica >>',
        b'<< /Length ' + str(len(stream)).encode('ascii') + b' >>\nstream\n' + stream + b'endstream',
        (b'<< /Title (Canonical cross-instrument infrastructure response) '
         b'/Author (Ryota Matsuki) /Creator (scripts/make_figure1_threshold_response.py) >>'),
    ]
    pdf = bytearray(b'%PDF-1.4\n%ASCII\n')
    offsets = [0]
    for i, obj in enumerate(objects, start=1):
        offsets.append(len(pdf))
        pdf.extend(f'{i} 0 obj\n'.encode('ascii'))
        pdf.extend(obj)
        pdf.extend(b'\nendobj\n')
    xref = len(pdf)
    pdf.extend(f'xref\n0 {len(objects)+1}\n'.encode('ascii'))
    pdf.extend(b'0000000000 65535 f \n')
    for off in offsets[1:]:
        pdf.extend(f'{off:010d} 00000 n \n'.encode('ascii'))
    pdf.extend((f'trailer\n<< /Size {len(objects)+1} /Root 1 0 R /Info 6 0 R >>\n'
                f'startxref\n{xref}\n%%EOF\n').encode('ascii'))
    PDF_PATH.write_bytes(bytes(pdf))


def make_figure():
    baseline_fn, no_x_fn = verify_response_expressions()
    FIG_DIR.mkdir(parents=True, exist_ok=True)

    grid = np.linspace(0.0, 1.0, 401)
    baseline_values = np.asarray(baseline_fn(grid), dtype=float)
    no_x_values = np.asarray(no_x_fn(grid), dtype=float)

    _write_vector_pdf(grid[::4], baseline_values[::4], no_x_values[::4])

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
