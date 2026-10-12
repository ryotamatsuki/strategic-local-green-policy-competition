# Decision Log

## 2026-09-05 — Stage 8 theory freeze

Decision: freeze theory as `SLGPC-THEORY-FREEZE-2026-09-05-v1`.

Headline mechanism: competition-induced cross-instrument sign reversal through firms' dual investment.

Rejected as novelty claims:

- multi-instrument local fiscal/environmental competition;
- cross-instrument government response per se;
- subsidy and public-infrastructure interaction per se;
- decentralized policy-composition distortion per se;
- simultaneous conventional and green R&D per se.

Closest-paper boundary retained from Stage 6: the paper must distinguish itself through the sign reversal in `d h_A^BR / d s_B` and the disappearance of that reversal when conventional competitive investment is removed.

## 2026-09-05 — Stage 9 repository initialization

Decision: create production repository only after theory freeze, following canonical workflow v1.1. Symbolic verification is authoritative for algebraic identities; manuscript equations must be checked against scripts before integration.

## 2026-09-05 — Stage 11 hostile audit rollback

Decision: stop Stage 11 and roll back to the earliest affected stage, Stage 4.

A hostile independent audit of production commit `98612b15ac34c3cb050ea8485a0ee1171c86bbc4` found a valid policy deviation that induces rival-firm inactivity. The previous interior Hessian/IFT conditions therefore did not establish a global policy Nash equilibrium of the original nonnegative-quantity game.

The quartic cross-response factorization, all five polynomial coefficients, the Bernstein single-crossing proof, and the canonical threshold `theta*=0.773804386083461...` were independently verified. The failure is the missing connection from the interior branch to global SPNE, not the local algebra itself.

The same audit also found that a universal interpretation of “dual-investment necessity” is false: with no conventional investment and `beta=1.3`, the cross response reverses near `theta=0.9394850556`.

Status of freeze `SLGPC-THEORY-FREEZE-2026-09-05-v1`: retained for provenance but no longer submission-valid.

## 2026-09-05 — Stage 4R-G global equilibrium repair

Decision: complete the original action sets and continuation game rather than add a policy bound or a new primitive.

The repaired action sets impose nonnegativity on policy, investment, and quantity choices. The Stage-2 investment game is reduced to effective private cost reduction and solved globally across five continuation regions: duopoly, A/B limit-pricing kinks, and A/B monopoly.

For the canonical rational witness, exact symbolic root-count certificates establish that the symmetric duopoly policy candidate is a true global policy Nash equilibrium for every `theta in [0,1]`, including all monopoly-inducing deviations. The strict branch gap implies a nonempty open neighborhood of primitives with the same property.

Contribution correction: replace any universal “dual-investment necessity” claim with a same-primitives benchmark-separation claim. Conventional competitive investment can generate a reversal absent in the corresponding no-x benchmark on a nonempty primitive region, but it is not necessary for every possible reversal.

Stage 4R-G verdict: `GO`.

Routing: Stage 6 Novelty Re-Kill, then Stage 7, repeat Stage 7.5, and issue a new Stage-8 theory freeze before manuscript reconstruction.

## 2026-09-05 — Stage 6 post-repair novelty re-kill

Decision: `GO`, classification `DISTINCT BUT NARROW`.

The surviving theorem-level contribution is the product-substitutability-driven unique sign reversal in the local infrastructure response on a true global-SPNE region. Cross-instrument reactions, subsidy/public-input interaction, subsidy/infrastructure thresholds, and dual conventional/green investment are all treated as prior art at the component level.

Universal dual-investment necessity is permanently withdrawn. The no-x result survives only as matched same-primitives benchmark separation.

## 2026-09-05 — Stage 7 post-repair validation

Decision: `GO`.

Welfare, mechanism, robustness, institutional interpretation, and empirical predictions were narrowed to match the repaired mathematics. The invalid `h/(s+h)` statistic was removed; coordination is interpreted as second-best regional welfare and may raise territorial emissions; rival subsidy is recognized as a normalization of the composite rival productive-policy index; empirical predictions are nonlinear/threshold rather than globally monotone.

## 2026-09-05 — Stage 7.5 repeat

Decision: `GO`.

The repaired result remains a sufficiently general strategic mechanism to justify a new canonical freeze. The paper must be built around the global-SPNE-validated product-substitutability sign reversal, not around universal dual-investment necessity or a subsidy-specific transmission story.

## 2026-09-05 — Stage 8 post-repair theory freeze v2

Decision: issue new canonical freeze `SLGPC-THEORY-FREEZE-2026-09-05-v2`.

Status: `GO — THEORY FROZEN`.

Working title: **Strategic Local Green Policy Competition: Product-Market Rivalry and Instrument Switching**.

The v2 freeze incorporates:

- explicit nonnegative action sets;
- full duopoly / limit-pricing-kink / monopoly continuations;
- exact canonical global-SPNE/open-neighborhood validation;
- unique product-substitutability threshold as the headline proposition;
- matched no-x benchmark separation only;
- rival-policy proportionality through `y_B`;
- second-best territorial/regional welfare interpretation;
- local Bertrand and partial-ownership robustness;
- nonlinear/threshold empirical predictions;
- Stage-6 closest-paper boundary `DISTINCT BUT NARROW`.

The v1 freeze is historical only and must not be restored verbatim.

Next step: `Stage 9R — Repository / Reproducibility Alignment`. The repository already exists, so Stage 9R must align all scripts, status files, manuscript entry points, and CI references to v2 before Stage 10 reconstruction.


## 2026-10-12 — Stage 7 post-freeze welfare-benchmark scope correction (AUDIT BRANCH)

Audit source: `audits/STAGE7_WELFARE_GENERALITY_INSTITUTIONAL_AUDIT_2026-10-12.md`. Pre-existing freeze: `SLGPC-THEORY-FREEZE-2026-09-05-v2`. This entry records a post-freeze welfare-scope correction; do not retroactively rewrite the historical September 5 certification.

**Trigger W1:** Equation `eq:planner` asserted unrestricted four-instrument maximization of `W_A+W_B`; the existing coordinated values were only a maximum along `s_A=s_B=s, h_A=h_B=h` with both firms active. At `theta=9/10`, the feasible asymmetric monopoly policy `(30,18,0,0)` yields exact aggregate welfare `53153998/5232645 ≈ 10.158151`, strictly exceeding the symmetric candidate's `674272009120/181241003453 ≈ 3.720306`. **Therefore the printed unrestricted-planner claim was false.**

**Authorized narrow change on this audit branch:** define and label the displayed welfare comparison as a **symmetric-policy restricted coordination benchmark**, with actual feasible set `s_A=s_B=s>=0`, `h_A=h_B=h>=0`, downstream continuation re-solved. This does not add an instrument, policy budget, plant relocation, or new strategic game; the Stage-4A equilibrium and switching theorem are unchanged. State that the unrestricted planner problem has NOT been solved and that non-symmetric welfare-improving policies need not be Pareto-improving. Amend Stage-10R manuscript guard; retain the exact counterexample as a regression in pytest, Makefile, and CI.

**Change-control classification:** `WELFARE-BENCHMARK STATEMENT CORRECTION`, affecting the frozen welfare-scope text in `docs/THEORY_FREEZE.md` §17. Treat the September 5 v2 freeze as historical/provisionally stale **for its broad planner description**. A new Stage-8 freeze may be issued only after current-workflow Stage 7, Stage 7.5, and Stage 7.5A recertification; do not claim this audit branch has already refrozen theory. The previous frozen Stage-4A mathematics remains a separately supported result.

Earliest analytic rollback: **Stage 7**; Stage 4A and Stage 6 remain unchanged. Stage 7 fixes the wording, certifies the restricted objective and reruns regressions. Stage 7.5 must independently assess economic significance and question completeness without relying on the historical September 5 GO.


## 2026-10-12 — Stage 7.5 independent editorial-value reassessment (AUDIT BRANCH)

Assessment source: `audits/STAGE7P5_EDITORIAL_VALUE_REASSESSMENT_2026-10-12.md`; evaluation actor GPT-6, **not** an external editor, peer reviewer or the author's own sign-off. Compare with corrected Stage-7 report `audits/STAGE7_W1_REPAIR_CLOSEOUT_2026-10-12.md`.

**Provisional editorial verdict: `NO-GO / RESEARCH NOTE / PIVOT` for the current full-length International Tax and Public Finance route.** The canonical main theorem remains mathematically valid and distinct in its narrow primitive-specific form. But an inverse-Hessian-based *conditional government best-response* sign flip, with an equivalent rival productive-policy index, no comparable welfare-sign or implementable-coordination theorem, and strong dependence on target intensity, does not currently justify the claimed full-paper economic significance under the v2.9-candidate contribution-completeness test. The strict Stage-7 benchmark correction further prevents portraying symmetric coordination as global planner welfare.

This is **not** a desk-rejection forecast or a claim of zero publishability. Preferred use of existing results: a tightly scoped positive-theory research note, with venue reassessment if separately selected. Alternative: **Stage-3 bounded exploration** of whether the unrestricted coordinated four-policy game generates a genuinely new, globally certifiable economic result involving asymmetric concentration and welfare distribution; do not modify the frozen model or add policy instruments at Stage 7.5. The previous 2026-09-05 Stage-7.5 GO remains a historical record and is not rewritten. **No new Stage-8 theory freeze issued.** Human-author decision/sign-off pending.


## 2026-10-12 — Stage 4 research extension exact conditional proof (RESEARCH BRANCH ONLY)

Authorization: one minimal extension after v2.9 candidate Stage-7.5 full-paper NO-GO, namely a hypothetical *voluntary, no-interregional-side-payment* cooperation agreement with each regional modeled welfare no lower than at the exhibited noncooperative SPNE. No new government/firm game primitive or policy instrument; no replacement of the historical `main` freeze.

**Stage 4 result: GO → independent Stage 4A red-team, NOT novelty certified.** At rational canonical parameters and `theta=9/10`, five regime-by-regime strictly concave quadratic welfare objectives have exact maximizers/upper bounds. Full unrestricted four-policy aggregate-W coordinator induces A/B regional firm inactivity (maximum `3691600/362551≈10.18229`). No-transfer consent prohibits all zero-rival-output continuations, **including limit-pricing kinks**, because hosting region welfare has exact global bound `1753200/2071201≈0.846465`, below pre-agreement `≈1.093476`. Consequently the **unique** consent-constrained global coordinator has both firms active and symmetric policy `s≈4.524766,h≈3.198740`, joint W `≈3.720306`. Alternative theta 3/10 and 1/2 admit EXACT duopoly/IR-feasible asymmetric policy perturbations strictly improving over the symmetry-constrained coordinator, while theta=.9 global consent optimum is uniquely symmetric; unique global transition threshold unproved.

Evidence: `research/STAGE4_GLOBAL_CONSENT_THEOREM_2026-10-12.md`, `research/stage4_global_consent_exact_certificate.py`, `research/stage4_asymmetric_duopoly_rivalry_witness.py`. The same exact models and inequalities were independently reconstructed with local SymPy execution for Stage-4 algebraic self-check, not yet subjected to Stage-4A. GitHub CI and manuscript compilation not verified on this new research branch.

**Crucial predecessor:** Markusen, Morey & Olewiler (1995), *Journal of Public Economics*, expressly analyze cooperative vs decentralized plant count and payments needed to sustain regional welfare gains; Fenge, von Ehrlich & Wrede (2009) establish central infrastructure concentration with symmetric regions. The broad economic insight 'nationally preferred concentration blocked by consent without transfers' is **pre-existing**. Stage 4 GO alone does not overturn the earlier Stage-7.5 editorial NO-GO; Stage 6 may kill the new extension. The exact local within-duopoly rivalry symmetry-breaking is a candidate to investigate, not a claimed novel theorem.

Next: Stage 4A adversarial audit, Stage 5 hardening, Stage 6 theorem absorption on the newly derived full-game results; only if they survive can Stage 7+ Stage 7.5+ Stage 7.5A and Stage 8 new freeze be considered.
