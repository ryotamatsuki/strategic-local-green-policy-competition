# Reproducibility Protocol

## Authoritative theory object

`docs/THEORY_FREEZE.md` is the canonical theory object for `SLGPC-THEORY-FREEZE-2026-09-05-v1`.

## Symbolic verification

Run:

```bash
python scripts/verify_freeze.py
python scripts/verify_stage10.py
```

`verify_freeze.py` checks the frozen firm-investment closed forms, the Stage-4R canonical switching polynomial, endpoint signs, derivative Bernstein conditions, the unique threshold near `0.7738043861`, and the no-conventional-investment benchmark.

`verify_stage10.py` independently reconstructs the Stage-10 cross-instrument Hessian and general quartic factorization from model primitives, checks the canonical threshold polynomial, and verifies sign reversals under differentiated Bertrand competition and partial local capture of firm surplus.

## Tests

Run:

```bash
python -m pytest -q
```

## Manuscript build

With `latexmk` and a standard TeX Live installation:

```bash
make paper
```

The pull-request CI also compiles `main.tex` with BibTeX and requires a non-empty `main.pdf`.

## Change control

If an equation in the manuscript changes a frozen primitive, timing, policy instrument, objective function, or headline theorem, record it first in `docs/DECISIONS.md` as a THEORY CHANGE and rerun the affected canonical workflow gates before merging.
