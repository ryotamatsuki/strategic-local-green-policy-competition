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


## 2026-10-12 — Stage 6 hostile novelty re-kill for one-institution voluntary-consent extension (RESEARCH BRANCH)

Decision: **CONDITIONAL GO — Novelty blocker N1; return to Stage 4.** Based on `audits/STAGE6_LOCAL_CONSENT_HOSTILE_NOVELTY_2026-10-12.md`. This is NOT Stage-7/Stage-8 approval, release, or claim of publication-ready full-paper significance.

Markusen, Morey & Olewiler (1995) already demonstrate efficient plant configurations versus regional hosting incentives, including when regional side payments are necessary; Fenge, von Ehrlich & Wrede (2009) already compare efficient centralized concentrated public inputs against decentralized dispersion. Leahy & Neary (2009) link product rivalry, multilateral investment subsidy coordination and welfare; Suga, Yanase & Tawada (online 2025, journal issue 2026) establish symmetry-breaking productive-public-good choices under a **noncooperative** equilibrium, not our **consent-constrained joint optimum**. No reviewed prior theorem was found to give the current *exact* combined model/parameter formula immediately, but formula-level difference is insufficient for full-paper novelty.

The Stage-4 T1 national planner exit vs voluntary-coalition retention result is **economically mechanism-absorbed** despite its exact canonical rational five-regime mathematical certification. The currently proved T2 finite-rivalry symmetry tests reduce to an application of the ordinary antisymmetric Hessian block in a symmetric linear-quadratic welfare function. Two roots of that Hessian are **not** a theorem of a unique transition in the global consent optimum. Stage 5's mu=0 counterexample also refutes T1's alleged dependence on green productivity.

Single authorized early-stage test N1: produce an interpretable, rigorous **GLOBAL IR-constrained cooperative-policy symmetry-selection theorem** on nonempty rivalry/primitive regions, demonstrate substantive content unavailable in mu=0 and no-x parent benchmarks, and explain the distinct economic consequence. No additional policy instruments, fiscal budget, bargaining stage, firm location mechanism or other features are authorized. A valid theorem must pass Stage 4A and a repeated hostile Stage 6. Stop full-paper extension if only a generic quadratic eigenvalue switch or a calibrated example survives. Historical Stage-4A mathematics stays certified only within its prior exact scope; `main` / legacy theory freeze unchanged. Author approval of eventual contribution remains pending.


## 2026-10-12 — N1 Stage 4 rollback: global reentrant symmetry and matched investment separation (RESEARCH BRANCH)

Status: **Stage 4 GO → Stage 4A independent red-team**. Source: `research/STAGE4_N1_REENTRANT_GLOBAL_SYMMETRY_2026-10-12.md`, exact rational regression `research/stage4_n1_global_symmetry_exact.py`. Original Stage-6 conditional novelty verdict and old Stage-7.5 full-paper editorial NO-GO remain historical and **are not automatically overturned**.

Without introducing any new model primitive, an exact noncompact-policy-domain proof gives a more substantive global symmetry-selection result for the original no-transfer voluntary regional welfare coordinator: unique symmetric GLOBAL optima at theta=1/10, 7/10, 9/10; existence of GLOBAL optima with **every** global optimum asymmetric at theta=3/10, 1/2. A *copositivity majorant* of the indefinite duopoly Hessian establishes welfare coercivity on the nonnegative 4-policy orthant at theta .3/.5, while kink/monopoly branches are negative definite. A strictly feasible asymmetric perturbation dominates **all** symmetric policies, and closedness of the IR feasible set guarantees an asymmetric global optimum. Local strict inequalities imply small nonempty theta neighborhoods; no unique global switch threshold or exact globally optimal asymmetric profile is claimed.

At theta=.3/.5 two rigorous *matched nested-model* contrasts sharpen the economics: when **mu=0** (green investment has no production-cost effect) or **1/kx=0** (no conventional R&D), each IR constrained joint-welfare problem has a unique symmetric global optimum, with its own selected symmetric noncooperative policy equilibrium verified as a GLOBAL best response using kink/monopoly policy deviation bounds. In the no-x case the kink government quadratic/host envelope may be singular/negative semidefinite and is treated accordingly; no false strict-Hessian claim is imported. This establishes dual investment feedback is relevant at these rational parameters, **not** that both investments are universally necessary for symmetry breaking.

The exact asymmetric welfare-gain witnesses are very small, and existing parent symmetric-LQ and integration theory may still absorb the economic result. Thus new **Stage 4A / Stage 6 re-kill / Stage 7.5 editorial value** are mandatory before a new theory freeze. Main stays untouched. Verification script is wired into PR CI and Makefile on the research branch, but hosted CI has not yet passed on that branch.


## 2026-10-12 — Stage 4A independent recertification of N1 global policy symmetry (RESEARCH BRANCH)

**Verdict: GO — MATHEMATICAL ADVERSARIAL CERTIFICATION PASS, strictly at five rational theta points and their sufficiently small parameter-theta neighborhoods.** Exact evidence: `audits/STAGE4A_N1_GLOBAL_SYMMETRY_REDTEAM_2026-10-12.md`; standalone clean-room primitive reconstruction: `audits/STAGE4A_N1_INDEPENDENT_PRIMITIVES_2026-10-12.py`.

Independent re-derivation of public consumer surplus, x/g investment expenses and environmental target penalties reproduces the baseline regional-consent coordinator: **unique symmetric global IR optimum at theta=.1,.7,.9**, but **all global IR optima asymmetric at theta=.3,.5**. A nonnegative-policy quadratic majorant permits exact coercivity/global existence at .3/.5 even though the full four-policy duopoly Hessian is indefinite on signed vectors. Full original-model government NE outside options were independently challenged by all D/kink/monopoly one-sided policy deviation upper bounds at all 5 points; no profitable deviation found and strict inequalities certified.

In both nested models `mu=0` and `1/kx=0`, at theta=.3,.5 the exhibited symmetric noncooperative outside policy is independently certified globally optimal against one-government D, kink and monopoly deviations. Relaxed host welfare KKT bounds exclude all one-firm-output IR agreements; the participant-feasible cooperative global optimum is **unique symmetric**, in contrast to the necessarily asymmetric baseline full game. The no-x host Hessian can be semidefinite and its KKT multiplier zero; its global bound remains valid and strict relative to outside W. The audited result is mathematical finite-point and open-neighborhood classification, **not** a unique global rivalry threshold, a numerical characterization of asymmetric optima, government-NE uniqueness, formal Lean proof or journal novelty.

Original Stage-6 conditional novelty gate remains OPEN; this math PASS mandates a renewed Stage-6 independent predecessor/parent theorem absorption check. Old ITPF editorial-value NO-GO and original theory freeze are NOT overwritten. The new independent audit file and Stage-4 exact script are included in PR-triggered GitHub Actions and research-branch `make verify`; hosted CI not yet reported as passing. `main` unchanged.


## 2026-10-12 — Stage 6 N1 FINAL hostile novelty re-kill (RESEARCH BRANCH)

**Verdict: NO-GO for the proposed full-length voluntary green industrial policy coordination extension.** Definitive *research-workflow* stop decision after the previously authorized single N1 Stage-4 rollback and Stage-4A independent mathematics GO. Audit: `audits/STAGE6_N1_FINAL_HOSTILE_NOVELTY_2026-10-12.md`.

**Previously omitted extremely close predecessor:** Haaland & Kind (2008), *Journal of International Economics*, already study symmetric-country government R&D subsidy competition/cooperation, endogenous process R&D, differentiated goods, possible one-firm survival and **asymmetric socially optimal coordinated R&D subsidies as preferable to symmetric harmonization**. Salant & Shaffer (1998 IJIO; 1999 AER) establish private/social benefits of asymmetrically investing/cost-reducing ex ante identical firms and discuss side payments. Leahy & Neary (2005 IJIO) provide general cooperative symmetry SOC conditions, precisely the generic antisymmetric Hessian mechanism; Markusen et al. (1995 JPubE) establish efficiency/host-veto compensation economics. Earlier Stage-6 novelty searches were incomplete because these high-proximity industrial-organization/R&D papers had not been directly compared.

**Preserved technical contributions:** Stage-4A-certified exact noncompact full-game GLOBAL symmetric at theta=.1,.7,.9 and necessarily asymmetric global IR coordinator at .3,.5; exact matched mu=0/no-conventional-x GLOBAL symmetric comparators; complete Cournot/kink/monopoly and consent exclusion proof. **No predecessor was shown to literally contain or algebraically imply the entire candidate four-policy, two-investment and two-IR theorem.** A parameter-specific, technically valid interaction therefore remains, but its general economics is strongly anticipated and its standalone welfare/policy importance is not established. The finite-theta matched technology deletion is not a general necessary condition, and the original primitive-level economic WHY remains generic cost variance/antisymmetric LQ curvature. Do not classify formula uniqueness as a sufficient new full-paper economics theorem.

**Quantitative diagnostic**, NOT globally certified maximum: independent constrained SLSQP candidates at theta=.3, .5 yielded a welfare improvement above the maximum symmetric feasible cooperation of about 0.00825% / 0.03349%. At each candidate one region's IR inequality is approximately binding. Such figures are numerical explorations, not exact global optimum claims or upper bounds.

**Consequence**: stop the full-paper N1 extension. No more feature addition, complexity or rolling Stage-4 rescue on this branch; do not promote to Stage 7, Stage 7.5 or Stage 8 as if Stage 6 were GO. Preserve mathematical source for a possible **research note** explicitly credited against Haaland–Kind/Salant–Shaffer/Leahy–Neary; or open a **genuinely different future Stage-0 research problem** with a fresh frontier search. This is a provisional scholarly appraisal, **not** an actual journal editorial decision or a claim that the mathematical result is necessarily unpublishable. Prior Stage-4A mathematical GO and historical frozen main stay unchanged.
