# Stage 10R — Post-Repair Section-by-Section Paper Reconstruction

Status: `GO — EXTERNAL CI RUNNER BLOCKED BY ACTIONS QUOTA`.

Date: 2026-09-05.

Canonical freeze: `SLGPC-THEORY-FREEZE-2026-09-05-v2`.

## Objective

Reconstruct the production manuscript section by section against the post-Astra v2 freeze. The superseded Stage-10 draft was treated only as source text; no section was presumed submission-valid merely because it previously compiled.

No theory change is made in Stage 10R.

## Section audit

- [x] Abstract/title: post-repair title retained; abstract now states that the canonical witness is an SPNE of the full nonnegative-action game.
- [x] Introduction: narrow contribution, global-SPNE qualification, matched benchmark, composite mechanism, and second-best welfare scope agree with v2.
- [x] Model: nonnegative action sets, global producer-surplus definition, territorial-target interpretation, fixed-location scope, and `R<3/4` regularity are explicit.
- [x] Equilibrium: duopoly, limit-pricing-kink, and monopoly continuations are all present; active-firm identities are not used globally.
- [x] Global equilibrium: the canonical full-game certificate is elevated to a formal `Canonical global-SPNE bridge` proposition; the hostile counterexample remains an explicit limitation.
- [x] Main results: unique quartic/Bernstein switching threshold, canonical `theta*=0.773804386083461...`, rival-policy proportionality, matched no-`x` benchmark, `mu=0` benchmark, and local threshold comparative statics agree with v2.
- [x] Mechanism: no pure-competitiveness story; CS, PS/business stealing, territorial target, investment adjustment, and own-policy interaction are all disclosed.
- [x] Welfare: coordinated policies are explicitly nonnegative; the coordinated numerical solution is labeled an active-duopoly benchmark rather than a separate global planner theorem; the invalid `h/(s+h)` measure is rejected and `phi_h` uses common fiscal units.
- [x] Robustness: differentiated Bertrand and partial local ownership remain local open-set checks only; no global robustness theorem is implied.
- [x] Institutional/empirical bridge: nonlinear/threshold prediction and non-literal Japanese institutional mapping are retained.
- [x] Related literature: cross-instrument fiscal competition, subsidy/infrastructure/Cournot thresholds, and dual investment are treated as prior art; contribution remains `DISTINCT BUT NARROW`.
- [x] Discussion/conclusion: universal dual-investment necessity, universal green-coordination benefits, and globally monotone interaction claims are absent.
- [x] Appendix: the compact reduced-output matrix is stated with eigenvalues `L-theta` and `L+theta`; the equivalent pre-transformation regularity system is distinguished explicitly.

## Manuscript verification added

A dedicated `scripts/verify_stage10r_manuscript.py` checks:

1. canonical title and full-game SPNE language in the abstract;
2. presence of every production section;
3. formal global-SPNE, threshold, and matched-benchmark propositions;
4. no universal necessity claim;
5. rival-policy proportionality disclosure;
6. correct fiscal-composition metric and coordinated-benchmark limitation;
7. Bertrand/ownership scope limitations;
8. Appendix reduced-system consistency;
9. absence of unresolved `TODO`, `TBD`, `FIXME`, or `XXX` markers.

The Stage-9R hygiene verifier was also repaired so that mentioning `h/(s+h)` solely to explain why the statistic is invalid does not generate a false failure. It now directly requires the correct `phi_h` definition.

The new Stage-10R verifier is wired into both the Makefile and GitHub Actions, and pytest imports its checks.

## Mathematical verification status

Stage 10R changes presentation and formalization only. It does not change primitives, timing, equilibrium formulas, the quartic, the global-SPNE certificate, or robustness parameter values.

The immediately preceding Stage-8 v2 head passed:

- canonical threshold / Bernstein verification;
- Stage-4R-G global-SPNE certificate;
- hostile counterexample regression;
- no-`x` counterexample regression;
- Stage-7 welfare/mechanism verification;
- independent quartic/Bertrand/ownership verification;
- pytest;
- LaTeX/BibTeX PDF build.

The Stage-10R Python manuscript verifier was independently syntax-checked and its required strings/structures were checked against the branch files through the GitHub connector.

## CI execution note

GitHub Actions cannot currently allocate a runner because the account exhausted 100% of its included Actions minutes on 2026-09-05. Jobs therefore fail before executing repository steps and generate no meaningful test logs. This external quota condition is not a research-gate failure.

The workflow remains configured to rerun the full verification and PDF-build stack when Actions runner access resumes.

## Verdict

`GO`.

The v2 production manuscript is reconstructed and ready for a new hostile referee gate.

Routing:

`Stage 11R — Post-Repair Robustness / Referee Attack Gate`.

The next stage must treat the current manuscript as the attack target and must explicitly retest the repaired global-SPNE bridge, narrow novelty claim, mechanism decomposition, welfare scope, and robustness boundaries. No new theory should be added unless a Stage-11R attack forces rollback.
