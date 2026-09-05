# Reproducibility Protocol

## Authoritative theory object

`docs/THEORY_FREEZE.md` is the canonical theory object for `SLGPC-THEORY-FREEZE-2026-09-05-v2`.

The superseded v1 freeze is provenance only. Any submission-valid calculation, proposition, manuscript statement, or robustness claim must agree with v2.

## Verification stack

Run the full deterministic verification stack with:

```bash
make verify
```

This executes, in order:

1. `scripts/verify_stage9r_alignment.py` — checks repository-wide v2 identity, title, required provenance/verification files, manuscript claim hygiene, presence of the full nonnegative continuation, the corrected fiscal-composition definition, and CI wiring.
2. `scripts/verify_stage10r_manuscript.py` — checks the post-repair production manuscript: section structure, explicit global-SPNE proposition, headline threshold proposition, matched no-`x` benchmark, rival-policy scope, welfare constraints, robustness boundaries, appendix consistency, and absence of unresolved drafting markers.
3. `scripts/verify_freeze.py` — checks the canonical firm-investment closed forms, switching polynomial, endpoint signs, derivative Bernstein conditions, unique threshold near `0.7738043861`, and the matched canonical no-conventional-investment benchmark.
4. `scripts/verify_stage4rg_global.py` — verifies the repaired duopoly/kink/monopoly continuation, canonical global-SPNE certificate, exact global-deviation gap, and retained hostile-audit counterexample regression.
5. `scripts/verify_nox_global_counterexample.py` — verifies the no-`x` counterexample showing that universal conventional-investment necessity is false.
6. `scripts/verify_stage7_postrepair.py` — verifies corrected welfare accounting, fiscal-composition statistic, mechanism decomposition, and related post-repair calculations.
7. `scripts/verify_stage10.py` — independently reconstructs the cross-response Hessian/quartic factorization and local Bertrand/partial-ownership robustness calculations.

The hostile-audit counterexample and the no-`x` counterexample are permanent regression guards. They must not be removed merely because the canonical v2 witness survives them.

## Tests

Run:

```bash
make test
```

or

```bash
python -m pytest -q
```

Tests include the canonical threshold, Stage-9R repository-alignment checks, and Stage-10R manuscript guards.

## Manuscript build

With `latexmk` and a standard TeX Live installation:

```bash
make paper
```

For the complete local gate:

```bash
make ci
```

The pull-request CI independently runs the verification/test stack and compiles `main.tex` with BibTeX, requiring a non-empty `main.pdf`.

## Current CI quota condition

As of 2026-09-05, the linked GitHub account has exhausted its included Actions minutes, so new hosted-runner jobs fail before runner allocation. This is an external execution constraint, not a repository verification failure. The complete v2 symbolic stack and PDF build passed immediately before the quota exhaustion at Stage 8; Stage 9R and Stage 10R keep the CI wiring in place so the expanded stack will execute automatically when runner access resumes.

## Change control

Any change to a frozen primitive, action set, timing, continuation regime, policy instrument, objective, equilibrium concept, headline theorem, welfare proposition, robustness scope, or contribution boundary is a THEORY CHANGE. Record it first in `docs/DECISIONS.md`, identify the earliest affected workflow gate, rerun that gate and all affected downstream gates, and issue a new freeze if required.

Ordinary manuscript clarification is permitted only when it preserves `SLGPC-THEORY-FREEZE-2026-09-05-v2` exactly.
