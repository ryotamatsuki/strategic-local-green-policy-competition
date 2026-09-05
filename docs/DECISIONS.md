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

A hostile independent audit of production commit `98612b15ac34c3cb050ea8485a0ee1171c86bbc4` found a valid policy deviation that induces rival-firm inactivity.  The previous interior Hessian/IFT conditions therefore did not establish a global policy Nash equilibrium of the original nonnegative-quantity game.

The quartic cross-response factorization, all five polynomial coefficients, the Bernstein single-crossing proof, and the canonical threshold `theta*=0.773804386083461...` were independently verified.  The failure is the missing connection from the interior branch to global SPNE, not the local algebra itself.

The same audit also found that a universal interpretation of “dual-investment necessity” is false: with no conventional investment and `beta=1.3`, the interior cross response reverses at `theta approximately 0.9394850556`.

Status of freeze `SLGPC-THEORY-FREEZE-2026-09-05-v1`: retained for provenance but no longer submission-valid.  A new freeze may be issued only after the affected downstream gates are rerun.

## 2026-09-05 — Stage 4R-G global equilibrium repair

Decision: complete the original action sets and continuation game rather than add a policy bound or a new primitive.

The repaired action sets impose nonnegativity on policy, investment, and quantity choices.  The Stage-2 investment game is reduced to effective private cost reduction and solved globally across five continuation regions: duopoly, A/B limit-pricing kinks, and A/B monopoly.

For the canonical rational witness, exact symbolic root-count certificates establish that the symmetric duopoly policy candidate is a true global policy Nash equilibrium for every `theta in [0,1]`, including all monopoly-inducing deviations.  The strict branch gap implies a nonempty open neighborhood of primitives with the same property.

Contribution correction: replace any universal “dual-investment necessity” claim with a same-primitives benchmark-separation claim.  Conventional competitive investment can generate a reversal absent in the corresponding no-x benchmark on a nonempty primitive region, but it is not necessary for every possible reversal.

Stage 4R-G verdict: `GO`, conditional only on repository CI passing the exact repair certificate.

Routing: Stage 6 Novelty Re-Kill, then Stage 7, repeat Stage 7.5, and issue a new Stage-8 theory freeze before manuscript reconstruction.
