# Lean formalization layer

This repository includes a Lean 4 / mathlib verification layer for selected algebraic claims in the frozen theory paper.

## Purpose

The Lean code is an independent formal check of the most audit-sensitive polynomial argument. It complements, rather than replaces, the existing SymPy reconstruction, regression tests, numerical global-equilibrium checks, and manuscript verification.

Pinned environment:

- Lean: `v4.33.0`
- mathlib: `v4.33.0`
- CI: `leanprover/lean-action@v1`
- proof-integrity audit: `axiom-audit` over the `StrategicLocalGreenPolicyCompetition` Lean library, with only `propext`, `Classical.choice`, and `Quot.sound` permitted; `sorryAx` is not permitted

## Formally verified in v1

The module `StrategicLocalGreenPolicyCompetition/Threshold.lean` proves:

1. the exact canonical switching polynomial
   `602500 u^4 - 8101550 u^3 + 39588109 u^2 - 74143042 u + 31863144`;
2. the algebraic equality between its ordinary derivative and the cubic Bernstein representation used in the manuscript;
3. strict negativity of that derivative for every `u in [0,1]`;
4. strict decrease of the canonical polynomial on `[0,1]`;
5. exact endpoint signs `P(0) > 0` and `P(1) < 0`;
6. existence and uniqueness of the switching root in `(0,1)` by the intermediate value theorem plus strict antitonicity;
7. an exact rational root bracket `0.5987 < u* < 0.5988`;
8. strict positivity on `[0,1]` of the matched no-conventional-investment quadratic factor
   `602500 u^2 - 3281550 u + 3486659`, and hence of the full factorized benchmark `(4-u)^2 Q(u)`;
9. exact verification that the canonical primitives satisfy the maintained regularity inequality `R < 3/4`.

These results formalize the core mathematical content behind the manuscript's unique switching-threshold and matched no-`x` benchmark claims at the canonical witness.

## Not yet formalized

The v1 Lean layer does **not** claim a machine-checked proof of the entire paper. In particular, the following remain outside Lean and continue to rely on the existing symbolic/numerical verification stack:

- derivation of the full four-policy government Hessian from primitives;
- the general symbolic factorization of the cross-instrument numerator for arbitrary primitives;
- the complete Stage-2 piecewise investment continuation;
- kink/monopoly regime comparisons;
- the canonical global-policy Nash / SPNE welfare-gap certificate over the full `theta in [0,1]` range;
- the open-neighborhood persistence argument around the canonical primitive vector;
- welfare and robustness extensions.

Accordingly, the Lean layer should be described as a **formal verification of the canonical threshold and benchmark algebra**, not as a full formalization of the global SPNE theorem.

## Commands

With Lean installed through `elan`:

```bash
lake update
lake build
```

CI runs the same project automatically on pull requests. The Lean job kernel-checks the project with warnings treated as failures and runs an axiom audit over the Lean library; proofs depending on `sorryAx` or unapproved axioms fail CI.

## Next formalization targets

The highest-value next steps are:

1. abstract the Bernstein argument from the canonical coefficients to a generic quartic theorem matching Proposition 2's assumptions;
2. formalize the reduced two-firm linear system and the `R < 3/4` sufficient regularity chain;
3. encode the Stage-2 regime partition and boundary continuity;
4. formalize the canonical global-SPNE certificate using exact rational inequalities and interval-polynomial positivity certificates.

No manuscript theorem or theory-freeze statement should be strengthened merely because this v1 formal layer is present.
