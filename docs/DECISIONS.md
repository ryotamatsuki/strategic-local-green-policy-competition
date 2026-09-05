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

Astra hostile audit found a fatal global-equilibrium counterexample to the Stage-10 manuscript. The smooth two-active-firm government candidate can satisfy the existing Hessian and threshold conditions while admitting a profitable policy deviation that drives the rival firm inactive. The counterexample was independently reproduced.

Decision:

- stop Stage 11;
- invalidate the inference from the smooth branch to global SPNE under `SLGPC-THEORY-FREEZE-2026-09-05-v1`;
- return to `Stage 4R-G — Global Equilibrium / Boundary Repair`;
- do not change primitives, timing, or instruments unless the original game cannot be repaired.

The quartic factorization, Bernstein proof, and canonical threshold remain mathematically valid conditional on the smooth branch being the true best-response branch.

## 2026-09-05 — Stage 4R-G repair decision

The original game is repairable without a model redesign. Exact active-set analysis establishes a certified global-SPNE interval for the canonical primitives,

`theta in [0.72,0.84]`,

which contains the canonical switching threshold `theta*=0.773804386083461`.

The repaired contribution language is **benchmark separation**, not universal dual-investment necessity. The same-primitives no-conventional-investment benchmark has no reversal on the certified interval, while the full model does. Universal necessity is prohibited because a no-`x` counterexample exists at other primitives.

Because the old freeze contains an invalid global-SPNE implication and overstrong necessity language, it must be replaced after downstream re-audits. Routing after Stage 4R-G: Stage 6 Novelty Re-Kill, Stage 7, Stage 7.5, then a new Stage 8 freeze.
