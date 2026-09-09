# Lean formalization layer

This repository includes a Lean 4 / mathlib verification layer for selected mathematical claims in the frozen theory paper.

## Purpose

The Lean code provides machine-checked proofs for audit-sensitive parts of the paper. It complements, rather than replaces, the existing SymPy reconstruction, regression tests, numerical global-equilibrium checks, and manuscript verification.

Pinned environment:

- Lean: `v4.33.0`
- mathlib: `v4.33.0`
- CI: `leanprover/lean-action@v1`
- proof-integrity audit: `axiom-audit` over the `StrategicLocalGreenPolicyCompetition` Lean library, with only `propext`, `Classical.choice`, and `Quot.sound` permitted; `sorryAx` is not permitted

## Phase 1 — canonical threshold witness

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

## Phase 2 — generic Proposition 2 theorem

The modules

- `StrategicLocalGreenPolicyCompetition/Proposition2.lean`,
- `StrategicLocalGreenPolicyCompetition/Proposition2Sign.lean`, and
- `StrategicLocalGreenPolicyCompetition/Proposition2Theta.lean`

formalize the reduced-form mathematical content of Proposition 2 for arbitrary quartic coefficients.

They prove:

1. the generic quartic
   `P(u) = A4 u^4 + A3 u^3 + A2 u^2 + A1 u + A0`;
2. the manuscript's Bernstein coefficients of `P'`,
   `B0 = A1`,
   `B1 = A1 + (2/3) A2`,
   `B2 = A1 + (4/3) A2 + A3`, and
   `B3 = A1 + 2 A2 + 3 A3 + 4 A4`;
3. the exact algebraic identity between `P'` and its cubic Bernstein representation on `[0,1]`;
4. `B0,B1,B2,B3 < 0` implies `P'(u) < 0` on `[0,1]`;
5. hence `P` is strictly decreasing on `[0,1]`;
6. together with `P(0) > 0 > P(1)`, there is exactly one root `u* in (0,1)`;
7. that root separates the signs of `P`: positive below `u*` and negative above it;
8. under the change of variables `u = theta^2`, there is exactly one `theta* in (0,1)` satisfying `P(theta*^2)=0`;
9. for any positive reduced-form factor `Omega(theta)` on `(0,1]`, the response
   `-Omega(theta) P(theta^2)` is negative for `0 < theta < theta*` and positive for `theta* < theta <= 1`.

Thus the Bernstein/root/sign-switch argument stated in Proposition 2 is machine checked once the manuscript's reduced-form representation
`d h_A^BR / d s_B = -Omega(theta) P(theta^2)` and `Omega(theta)>0` are supplied.

## What Phase 2 does not yet prove

Phase 2 deliberately does **not** claim that the entire economic model or the global-SPNE theorem is machine checked. In particular, the following remain outside Lean and continue to rely on the existing symbolic/numerical verification stack:

- derivation from primitives of the full four-policy government Hessian;
- derivation from primitives of the generic quartic coefficients `A0,...,A4` and the positive factor `Omega(theta)`;
- proof that the maintained firm-stage regularity and government strict-concavity assumptions imply the required reduced-form representation on the relevant branch;
- the complete Stage-2 piecewise investment continuation;
- kink/monopoly regime comparisons and boundary continuity;
- the claim in the final sentence of Proposition 2 that the local interior derivative is also the derivative of the true global best response on an open neighborhood;
- the canonical global-policy Nash / SPNE welfare-gap certificate over the full `theta in [0,1]` range;
- open-neighborhood persistence around the canonical primitive vector;
- welfare and robustness extensions.

Accordingly, after Phase 2 the repository may describe Proposition 2's **reduced-form quartic threshold theorem** as formally verified. It should not describe the full economic derivation or global-SPNE bridge as formally verified.

## Commands

With Lean installed through `elan`:

```bash
lake update
lake build
```

CI runs the same project automatically on pull requests. The Lean job kernel-checks the project with warnings treated as failures and runs an axiom audit over the Lean library; proofs depending on `sorryAx` or unapproved axioms fail CI.

## Next formalization targets

The highest-value next steps are:

1. formalize the reduced two-firm linear system from primitives and the `R < 3/4` sufficient regularity chain;
2. derive the relevant interior equilibrium objects needed to connect primitives to the government reduced form;
3. encode the Stage-2 regime partition, admissibility conditions, and boundary continuity;
4. formalize the canonical global-SPNE certificate using exact rational inequalities and interval-polynomial positivity certificates;
5. only after those bridges are closed, formalize welfare and robustness extensions.

No manuscript theorem or theory-freeze statement should be strengthened beyond the exact scope certified above.
