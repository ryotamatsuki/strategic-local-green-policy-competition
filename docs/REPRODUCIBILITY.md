# Reproducibility Protocol

## Authoritative theory object

`docs/THEORY_FREEZE.md` is the canonical theory object for `SLGPC-THEORY-FREEZE-2026-09-05-v1`.

## Symbolic verification

Run:

```bash
python scripts/verify_freeze.py
```

The script verifies the frozen firm-investment closed forms, the Stage-4R baseline switching polynomial, endpoint signs, derivative Bernstein conditions, the unique threshold near `0.7738043861`, and the positive Bernstein coefficients of the no-conventional-investment benchmark.

## Tests

Run:

```bash
python -m pytest -q
```

## Manuscript build

With `latexmk` installed:

```bash
make paper
```

## Change control

If an equation in the manuscript changes a frozen primitive, timing, policy instrument, objective function, or headline theorem, record it first in `docs/DECISIONS.md` as a THEORY CHANGE and rerun the affected canonical workflow gates before merging.
