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


## 2026-10-12 — Stage 2 v2.9 frontier reboot (RESEARCH BRANCH ONLY)

**Verdict: CONDITIONAL GO FOR SOURCE-THEOREM FRONTIER VALIDATION; NOT Stage-3 model authorization or a new full-paper GO.**
Evidence: `research/STAGE2_V29_INDUSTRIAL_POLICY_FRONTIER_2026-10-12.md` and `research/STAGE2_V29_FRONTIER_OPPORTUNITY_REGISTER_2026-10-12.md`.
Literature cutoff 2026-10-12, workflow `ryotamatsuki/research-paper-workflow@v2.9`.

The broad national-vs-local industrial policy hierarchy problem is already mature (Caillaud–Jullien–Picard 1996, Morasch 2003, Klibanoff–Poitevin 2022, Hevia–Loayza–Meza-Cuadra 2023). Its relabeled fiscal-federalism threshold is NO-GO. Q1, a narrower cross-paper question on *government-level assignment of targeted subsidies versus general public infrastructure under private information and interregional input-output spillovers*, is **LITERATURE-SCREENED / UNRESOLVED**, not proved novel; the decisive N2 blocker is full formal-theorem reading/mapping of Caillaud 1996, Morasch 2003 and relevant generic delegation theory, plus Hevia and Klibanoff–Poitevin. No new model, parameter or policy tool authorized. Q2 is an empirical Morita–Okoshi (2025) author-stated future-work lead, subject to separate identification/data feasibility. Q3 concerns author-stated Klibanoff–Poitevin bargaining-protocol limits but is **DEFERRED** pending strong parent-theorem screening.

Keep **author-stated** source limits and **auditor-inferred / cross-paper** conjectures separate; none is certified open by negative search. The original fixed-location green-policy paper stays NO-GO for a full-length ITPF paper by the October Stage-7.5 audit, and regional-consent N1 full-paper extension stays Stage-6 NO-GO. These independent decisions are not reversed. `main` and `SLGPC-THEORY-FREEZE-2026-09-05-v2` remain unchanged.


## 2026-10-12 — Stage 2 v2.9 N2 full predecessor-theorem audit (RESEARCH BRANCH ONLY)

**Verdict: NO-GO FOR THE PRESENT Q1 RESEARCH QUESTION, before Stage-3 model search.** Source `research/STAGE2_N2_CLOSEST_THEOREM_ABSORPTION_2026-10-12.md`. Replaces the earlier *conditional source-inspection-only* opportunity disposition; no revision to prior original-manuscript or N1 stopping verdicts.

Caillaud–Jullien–Picard (1994 preliminary full text of EER 1996) already prove under own assumptions information-sensitive hierarchical central/local firm incentive policies, regional externalities, intergovernmental compensation and mixed-level policy complementarity (Theorems 1–5). Morasch (2003 original abstract plus distinct 2008 follow-on **FULL** paper) covers oligopolistic fiscal choice, private policy information, delegation vs bargaining, signal disclosure and side-payment variants. Klibanoff–Poitevin (2022 journal Theorems 5.1/5.2) supplies conditional necessary-and-sufficient centralization/bargaining rights rules. Hevia–Loayza–Meza-Cuadra (2023 full §3/4) analyzes targeted firm aid versus broad public goods, private firm productivity, tax/revelation mechanisms, government capability and expenditure budgets. A 2004 JPubE paper already combines local public works, multivariate private information and optimal incentive-compatible central grants; IMF 2024 considers sector-specific vs horizontal innovation support in knowledge networks.

Thus merely juxtaposing `national vs local + private information + industry-network spillovers + subsidy versus infrastructure` is not a specified new important economic question. There is **NO evidence of a new irreducible mechanism or welfare/implementability prediction**, while individual ingredients are heavily pre-solved. This is **not** a claim of a single literally isomorphic parent theorem; final journal Caillaud 1996 full text and original Morasch 2003 full text were not accessible in this session. Record later-work/open-frontier uncertainty rather than claiming novelty-negative proof.

Author-stated future research now verified exactly: Caillaud 1994 §6 interregional transfer restrictions / endogenous agency charter / horizontal renegotiation; Bartholomae–Morasch 2008 §5 information-transfer bargaining **with** side payments; Hevia 2023 §4 production complementarity / costly type verification / imperfect monitoring; Klibanoff–Poitevin 2022 §6 alternative enforceable bargaining protocols. None is an automatically novel 2026 project.

Preserve **PROPOSED-only** R1 (verifiable information, financing and monitoring rights; high absorption), R2 (causal test of induced infrastructure-related national/host/nonhost net welfare), R3 (information revelation + side-payment bargaining). The next research question requires deliberate author selection, fresh Stage-0/2 evidence, and a falsifiable non-parent economic theorem; **do not proceed to Stage 3** on Q1. No old manuscript, theory freeze or main-branch changes.


## 2026-10-12 — Stage 2 v2.9 fresh cross-paper frontier reselection, after N2 (RESEARCH BRANCH ONLY)

New evidence report: `research/STAGE2_V29_FRESH_FRONTIER_RESELECTION_2026-10-12.md`; opportunity register §F. Latest literature cutoff 2026-10-12. **Verdict: CONDITIONAL QUESTION-LEVEL CONTINUATION ONLY, no new theory/full-paper GO, no Stage-3 model permission.** Original Q1 hierarchy/info/sector subsidy/public input/network mash-up and older R1 are NOT presumed best next direction.

Decisive new source development: the OECD 2025 author's proposed 'national targeting of places' companion **was published 2026-10-09** (DOI `10.1787/284fcc80-en`); Fajgelbaum–Gaubert (2025) already supplies six place-based optimal-subsidy/infra limits; Roper et al. (2025) already empirically studies national/sectoral/regional R&D-policy complementarity. Regional industrial experimentation/learning also extensively published (Klimenko 2004; Callander–Harstad 2015 QJE; Cheng–Li 2019 AEJ; Wang–Yang 2025 JPE). Generic subsidy auction, local spillover or rules/discretion welfare already studied (Slattery 2025 JPE; Siegloch et al. 2025 AEJ:EP; Cingano et al. 2025 Econometrica).

Source-stated gaps worth preserving: Mazzucato–Rodrik (2026) §2 explicitly distinguishes additionality from aggregate *public value* and states its conditionality taxonomy does NOT estimate either; Heinrich–Knill–Steinebach (2025) explicitly disclaim causal portfolio effects; Morita–Okoshi (2025) §5 requests empirical testing of infrastructure-mediated fiscal competition; Rodríguez-Pose (2026) §7 recommends monitoring/termination (policy proposal, NOT asserted unproved theorem). These do not prove a frontier is open.

**Preferred one-shot N3 THEOREM-PRIOR-ART test:** F1 — when industrial subsidy clawback/continuation conditions only observe local firm outcomes, can a specified additional cross-jurisdiction verifiable outcome or monitoring structure nontrivially implement aggregate-welfare project selection under geographic displacement? **DO NOT** run a new model unless parent spatial public-economics/contracting informativeness theorems fail to absorb a precisely stated economic result. F2 — genuine infrastructure mediation and net host/nonhost welfare, possible empirical track requiring causal data. F3 — policy portfolio regulatory/monitoring conditions, deferred. All `HYPOTHESIS / UNRESOLVED / NOT AUTHORIZED`, no fresh theorem/certified model.

Historic original Stage-7.5 full-paper NO-GO, regional-consent N1 Stage-6 NO-GO and Stage-2 old Q1 NO-GO retained. Nothing changed in main or prior Theory Freeze.


## 2026-10-12 — Stage 2 v2.9 N3 final cross-paper reselection / NO theory certificate (RESEARCH BRANCH)

Source `research/STAGE2_V29_N3_METRIC_PARENT_KILL_AND_RESELECTION_2026-10-12.md`. The earlier `research/STAGE2_V29_FRESH_FRONTIER_RESELECTION_2026-10-12.md` ranked F1 as a provisional theory-question prior-art check, **not a Stage-3 GO**. Actual N3 uncovered Holmström (1979), Holmström–Milgrom (1991), Baker (1992), Aggarwal–Samwick (1999) and 2025 network relative-performance results, already covering informativeness, local/proxy metric distortions, rival outcome contract incentives and multi-task allocation. **F1 NO-GO as presently articulated for a NEW theory full paper**; no claim exact application-level identity but no specified new conclusion beyond parent theory.

**Preferred prospective question changes to F2, empirical:** causal additional productive infrastructure induced by firm-attraction subsidy **contests**, and net host/nonhost/national welfare after displacement and public funding. Morita–Okoshi 2025 §5 is author-stated original motivation; distinct from simple subsidy job or spillover estimation already treated in Slattery 2025, Siegloch 2025, Cingano 2025, Ehrlich–Seidel 2018. `HYPOTHESIS / UNRESOLVED`; future project's data feasibility and identification NOT certified. F3 portfolio-regulation causal question deferred.

**No defensible new THEORY GO-to-model candidate in this bounded search.** Existing original-paper Stage-7.5 NO-GO, N1 Stage-6 NO-GO, broad Stage-2 Q1 NO-GO unchanged, `main` untouched. v2.9 preserves future knowledge without promising novelty or turning a negative result into feature accumulation.
