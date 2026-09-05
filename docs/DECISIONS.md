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
