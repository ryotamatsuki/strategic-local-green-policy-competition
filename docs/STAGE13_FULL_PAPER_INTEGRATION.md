# Stage 13 — Full-Paper Integration for International Tax and Public Finance

Date: 2026-09-05.

Canonical workflow: `ryotamatsuki/research-paper-workflow` v1.1, `templates/STAGE_13_FULL_PAPER_INTEGRATION.md`.

Theory freeze: `SLGPC-THEORY-FREEZE-2026-09-05-v2`.

Primary target: **International Tax and Public Finance (ITPF)**.

Fee constraint input: `docs/STAGE12_FEE_CONSTRAINT_AMENDMENT.md`.

## 1. Executive integration verdict

**Substantive verdict: PASS.** No theory-stage inconsistency was uncovered during full-paper integration. The manuscript retains the repaired global-SPNE qualification, the unique switching-threshold theorem, the matched no-conventional-investment benchmark, and the explicit non-universality limits established in the post-repair referee gate.

The integration changes are presentation-only and target-specific. The abstract and Introduction now foreground the public-finance object for ITPF: the direction of a cross-instrument interjurisdictional best response as product-market rivalry changes. Known ingredients are conceded before the model machinery, with Hauptmeier--Mittermaier--Rincke and Morita--Okoshi visible early rather than being used as late defensive citations.

## 2. Section-role audit

### Abstract

PASS. The revised abstract asks the cross-instrument policy question directly, states the three-stage mechanism, reports the unique threshold result, qualifies the global-SPNE result to a canonical rational witness/open neighborhood, and states the matched benchmark without claiming universal necessity. Word count: **156**, within ITPF's current 150--250-word requirement.

### Introduction

PASS after integration. The sequence is now:

1. place-based green-policy motivation;
2. cross-instrument public-finance question;
3. known-literature boundary and exact theorem-level contribution;
4. model architecture;
5. switching theorem and global-equilibrium qualification;
6. mechanism;
7. matched benchmark and non-necessity caveat;
8. welfare scope;
9. institutional scope;
10. roadmap.

The Introduction does not claim first use of multiple instruments, first infrastructure competition, first dual investment, universal necessity of conventional investment, or a global primitive characterization of SPNE.

### Model / Equilibrium

PASS. Action sets remain nonnegative; plant locations remain fixed; the territorial objective remains reduced form; the subsidy transfer treatment is unchanged; and the regularity condition remains `R<3/4`. The equilibrium section continues to distinguish the interior duopoly branch from kink and monopoly continuations and explicitly states that branch-specific concavity is insufficient for global SPNE.

### Main Results

PASS. Proposition 1 remains conditional on firm regularity, government strict concavity, the quartic endpoint signs, and negative Bernstein coefficients. The global-best-response interpretation is added only when the interior branch is the true global policy best response on an open neighborhood. The canonical threshold remains `theta*=0.7738043861...`.

The no-conventional-investment result remains a matched-primitives separation, not a necessity theorem. The retained beta=1.3 counterexample prevents contribution inflation.

### Welfare

PASS. Welfare is explicitly secondary. The coordinated solution is described as an active-duopoly benchmark rather than a separate global planner theorem. Coordination is not characterized as necessarily lowering emissions.

### Robustness

PASS. Bertrand and partial-local-capture exercises are correctly labeled local/interior robustness exercises rather than global-SPNE theorems. Target-intensity sensitivity is also kept as an interior diagnostic.

### Institutional / Empirical Bridge

PASS. Japan is used as functional institutional motivation, not as a literal claim that Japanese local governments possess the exact modeled instruments. Empirical implications are threshold/nonlinear predictions and do not claim existing causal evidence.

### Discussion / Conclusion

PASS. The Discussion interprets mechanism, scope, limits, and empirical implications without introducing a new theorem. The Conclusion is short, answers the research question, and preserves the limitation that the model is about second-best local green industrial policy rather than complete global climate policy.

## 3. Contribution-claim audit

The canonical contribution sentence is:

> Over a certified nonempty global-SPNE region, product substitutability can uniquely reverse the sign of a local government's infrastructure response to a rival green-investment subsidy through the endogenous firm-investment and territorial-policy feedback network; at the canonical remaining primitives, the matched benchmark without conventional investment lacks the reversal.

This maps directly to the threshold theorem, the global-SPNE bridge, and the matched benchmark. No stronger claim is required for ITPF positioning.

Killed or prohibited claims remain absent:

- no claim that cross-instrument fiscal reactions are new;
- no claim that subsidy-plus-infrastructure competition is new;
- no claim that dual investment is universally necessary;
- no global characterization for arbitrary primitives;
- no claim that rivalry monotonically raises infrastructure responses;
- no claim that coordination necessarily reduces emissions.

## 4. Related-literature structure audit

PASS. The section is organized conceptually into environmental federalism, fiscal competition/public inputs, place-based incentives, and environmental IO/dual investment. It explicitly treats Hauptmeier--Mittermaier--Rincke and Morita--Okoshi as close comparators and explains the narrower result-level distinction. The prose does not rely on novelty-by-ingredient.

## 5. Results / Discussion separation audit

PASS. Results contain derivations, propositions, witness values, and local comparative statics. Discussion interprets the composite mechanism, territorial-objective scope, fixed-location limitation, and empirical identification implications. No result is introduced for the first time in Discussion.

## 6. Abstract / Introduction / Conclusion alignment

PASS. All three documents make the same claim hierarchy:

1. object: cross-instrument local policy response;
2. driver: product substitutability / product-market rivalry;
3. main theorem: unique negative-to-positive infrastructure-response switch under stated conditions;
4. equilibrium qualification: certified global-SPNE region, not arbitrary primitives;
5. benchmark: conventional investment matters at matched canonical primitives but is not universally necessary;
6. scope: second-best local green industrial policy, not a universal emissions theorem.

## 7. Notation / citation / cross-reference audit

PASS on manuscript integration.

- `theta` is used consistently for product substitutability.
- `s_i` and `h_i` remain the government instruments.
- `x_i` and `g_i` remain conventional and green investment.
- `R`, `D`, `lambda`, `L`, `P(u)`, and the threshold notation are consistent across text and appendix.
- Main propositions are cross-referenced to the corresponding appendix logic.
- The global-equilibrium appendix preserves the five-region continuation map and the exact scope of the open-neighborhood certificate.
- The principal closest-paper references used for positioning are present in `references.bib`.

No equation, proposition, parameter value, or verification script was changed in Stage 13.

## 8. Changes made

1. Created branch `stage13-itpf-integration` from `stage12-journal-positioning`.
2. Added `docs/STAGE12_FEE_CONSTRAINT_AMENDMENT.md` to make the zero-fee ladder authoritative downstream.
3. Revised the abstract to lead with the ITPF-relevant cross-instrument question while preserving all theorem qualifications.
4. Reordered/reframed the Introduction so the public-finance contribution and closest-literature distinctions appear before model machinery.
5. Added a `Statements and Declarations` hook before the bibliography.
6. Added Data Availability, Code Availability, and generative-AI-use statements consistent with current Springer Nature requirements and actual project use.
7. Did **not** alter the model, proofs, numerical witness, robustness results, welfare calculations, or institutional claims.

Current official ITPF requirements checked at:

- https://link.springer.com/journal/10797/submission-guidelines
- https://link.springer.com/journal/10797/how-to-publish-with-us

## 9. Remaining blockers

There is **no substantive manuscript blocker** for Stage 14.

The following author/package-specific items are intentionally left to Submission QA because they do not affect the theory or contribution:

- final author/affiliation/corresponding-author/ORCID title-page metadata;
- final Funding statement;
- final Competing Interests statement, including any disclosure required by Springer's non-financial-interest rules;
- cover letter and submission-system metadata;
- live portal confirmation that no mandatory submission fee is requested;
- final source/PDF package and portal-generated proof inspection.

These are bounded submission-package tasks. Any mathematical or novelty objection discovered during Stage 14 would instead reopen the earliest affected research stage.

## 10. Verdict and Stage 14 contract

**Final Stage 13 verdict:** `INTEGRATED MANUSCRIPT READY FOR SUBMISSION QA`.

Stage 14 must verify the ITPF submission package rather than rewrite the theory. It must:

1. complete journal-required author and declaration metadata;
2. verify abstract, keywords, JEL codes, title page, editable LaTeX source, bibliography, and compiled PDF;
3. verify the Data Availability and AI-use wording against the live journal policy;
4. prepare/check the cover letter and submission metadata;
5. enforce the zero-fee hard gate at the live submission portal;
6. run the repository verification suite and manuscript build;
7. block submission if any theorem, number, citation, source file, or portal-generated PDF is inconsistent.

Stage 14 may make bounded formatting and declaration corrections. It may not change the frozen theory, add a new robustness result, or inflate the contribution.
