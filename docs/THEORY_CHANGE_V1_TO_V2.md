# Theory Change Record — v1 to v2

Date: 2026-09-05

Superseded freeze: `SLGPC-THEORY-FREEZE-2026-09-05-v1`

New freeze: `SLGPC-THEORY-FREEZE-2026-09-05-v2`

Workflow: `ryotamatsuki/research-paper-workflow` v1.1, release SHA `488e5ab06c207909296a7564eaf9066f7f94319c`.

## Trigger

A hostile Stage-11 audit found that the v1 paper had proved an interior-duopoly policy stationary point and its local comparative statics but had not ruled out government deviations that change the continuation market structure. A valid deviation to a rival-inactivity continuation raised government welfare in an admissible parameter vector. The same audit also showed that a universal interpretation of “dual-investment necessity” was false.

## What changed

The economic baseline did **not** add a player, instrument, timing stage, demand system, production technology, emissions technology, or government objective.

The theory object changed in the following substantive respects:

1. action sets are explicitly nonnegative for policies, investments, and quantities;
2. the full continuation game now includes duopoly, limit-pricing-kink, and monopoly regions;
3. global policy deviations across continuation regimes are part of the SPNE proof obligation;
4. the canonical rational witness now carries an exact global-SPNE/open-neighborhood certificate;
5. the old universal-sounding dual-investment necessity interpretation is withdrawn and replaced by matched same-primitives benchmark separation;
6. mechanism language is broadened from pure competitiveness preservation to the joint CS, producer-surplus/business-stealing, territorial-target, investment-adjustment, and within-government interaction channels;
7. rival subsidy is recognized as a headline normalization of the composite rival productive-policy index rather than a unique structural shock;
8. welfare interpretation is narrowed to second-best territorial/regional welfare; the invalid `h/(s+h)` statistic is removed;
9. empirical claims are narrowed to nonlinear/threshold policy reactions;
10. Bertrand and ownership robustness are explicitly local open-set results.

## Gates rerun

- Stage 4R-G — Global Equilibrium / Boundary Repair: `GO`.
- Stage 6 — Post-Repair Novelty Re-Kill: `GO`, `DISTINCT BUT NARROW`.
- Stage 7 — Post-Repair Welfare / Generality / Institutional Validation: `GO`.
- Stage 7.5 — Full-Theory Freeze Decision (repeat): `GO`.
- Stage 8 — Canonical Theory Freeze: this record accompanies v2.

## Permanent regression obligations

The repository must retain:

- the hostile global-deviation counterexample that invalidated v1;
- the no-`x`, `beta=1.3` reversal showing that universal necessity is false;
- exact canonical global-gap checks through `theta=1`;
- the quartic/Bernstein threshold verification;
- Stage-7 mechanism and welfare checks.

## Downstream consequence

The existing production repository may be reused, but every artifact created under v1 must be aligned to v2 before new manuscript construction is treated as canonical. The next step is Stage 9R — Repository / Reproducibility Alignment.
