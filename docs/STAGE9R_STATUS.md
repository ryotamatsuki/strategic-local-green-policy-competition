# Stage 9R — Repository / Reproducibility Alignment

Status: `GO PENDING GREEN CI`.

Date: 2026-09-05.

Canonical freeze: `SLGPC-THEORY-FREEZE-2026-09-05-v2`.

This stage reuses the existing production repository. It does not create a new repository and does not modify the frozen theory. Its purpose is to align repository metadata, verification, tests, CI, manuscript identity, and provenance with the post-repair v2 freeze before manuscript reconstruction.

## Alignment completed

- [x] `README.md` identifies v2 as canonical and v1 as superseded provenance.
- [x] `main.tex` uses the post-repair working title, **Strategic Local Green Policy Competition: Product-Market Rivalry and Instrument Switching**.
- [x] `docs/REPRODUCIBILITY.md` identifies v2 as authoritative and documents the complete verification stack.
- [x] `Makefile` runs the full v2 verification stack rather than only the legacy threshold script.
- [x] CI runs the v2 repository-alignment verifier before the mathematical regression stack.
- [x] A dedicated `scripts/verify_stage9r_alignment.py` checks canonical freeze identity, title, required provenance files, manuscript claim hygiene, full continuation presence, and CI wiring.
- [x] Automated tests include Stage-9R alignment guards.
- [x] The Stage-4R-G hostile counterexample remains a permanent regression test.
- [x] The no-`x`, `beta=1.3` counterexample remains a permanent regression test against universal necessity claims.
- [x] Stage-10 historical status remains superseded; routing is updated to post-v2 manuscript reconstruction.

## Required v2 verification stack

1. Stage-9R repository alignment.
2. Canonical threshold / Bernstein verification.
3. Global nonnegative duopoly-kink-monopoly continuation and canonical global-SPNE certificate.
4. Hostile counterexample regression.
5. No-`x` global counterexample regression.
6. Post-repair welfare/mechanism verification.
7. Independent quartic/Bertrand/ownership checks.
8. Pytest.
9. LaTeX/BibTeX PDF build.

## Theory-change audit

No primitive, player, timing, action set, demand system, cost technology, emissions technology, government objective, equilibrium concept, proposition, or robustness scope is changed in Stage 9R. This is repository/reproducibility alignment only.

## Verdict

`GO` once both symbolic-verification and manuscript-build jobs are green on the Stage-9R PR.

Routing after green CI and merge:

`Stage 10R — Post-Repair Section-by-Section Paper Reconstruction`.

The next manuscript stage must rebuild/check every section against v2. It may reuse text from the superseded Stage-10 draft only after explicit consistency checking against `docs/THEORY_FREEZE.md`.
