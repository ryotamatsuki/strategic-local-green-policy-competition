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

## Phase 3 — active firm-stage regularity and reduction

The modules

- `StrategicLocalGreenPolicyCompetition/FirmStage.lean`, and
- `StrategicLocalGreenPolicyCompetition/FirmHessian.lean`

formalize the algebraic and regularity backbone of the active-duopoly firm stage.

`FirmStage.lean` proves:

1. with `D = 4 - theta^2`, `D >= 3` and hence `D > 0` for every `theta in [0,1]`;
2. with `R = 1/kx + mu^2/kg`, the maintained condition `R < 3/4` implies
   `lambda = 4R/D < 1`;
3. therefore `L = 2 - lambda > theta` throughout `theta in [0,1]`;
4. consequently `L > 0` and `L^2 - theta^2 > 0`;
5. the active Stage-3 Cournot equations
   `2 qA + theta qB = vA` and `theta qA + 2 qB = vB`
   have the manuscript's closed-form solution with denominator `D`, and that solution is unique;
6. the manuscript's interior Stage-2 investment formulas
   `x_i = 4 q_i/(D kx)` and `g_i = (4 mu q_i/D + s_i)/kg`
   imply the exact private-cost-reduction identity `x_i + mu g_i + nu h_i = lambda q_i + y_i`;
7. combining that identity with the active Cournot equation yields the reduced system
   `L q_i + theta q_j = w_i`;
8. this reduced two-firm system has a unique closed-form solution whenever its determinant is nonzero, and the maintained regularity condition supplies strict positivity of that determinant;
9. the closed form is algebraically identical to the manuscript representation
   `q_i = q0 + t0 y_i + t1 y_j`;
10. under the maintained regularity condition, `t0 > 0`, `t1 <= 0`, and `t1 < 0` when `theta > 0`.

`FirmHessian.lean` proves, for `kx>0`, `kg>0`, `theta in [0,1]`, and `R<3/4`:

1. the first leading principal Hessian entry is strictly negative;
2. the exact determinant factorization
   `det(H_F) = kx kg (1 - 8 R / D^2)`;
3. the determinant is strictly positive;
4. the two scalar Sylvester inequalities hold;
5. more strongly, the Hessian quadratic form is strictly negative in every nonzero investment direction.

Accordingly, Phase 3 machine-checks the manuscript's stated sufficient regularity chain linking `R<3/4` to active-branch firm-stage concavity, invertibility, uniqueness of the reduced quantity system, and the signs of its comparative-static coefficients.

## What is not yet proved in Lean

The formalization still deliberately stops short of claiming that the entire economic model or the global-SPNE theorem is machine checked. In particular, the following remain outside Lean and continue to rely on the existing symbolic/numerical verification stack:

- calculus-level derivation of the Stage-2 investment first-order conditions from the primitive profit function and derivation of the displayed Hessian from those primitives;
- the complete Stage-2 nonnegative piecewise investment continuation, including corner regimes, admissibility inequalities, and boundary continuity;
- derivation from primitives of the full four-policy government Hessian;
- derivation from primitives of the generic quartic coefficients `A0,...,A4` and the positive factor `Omega(theta)`;
- proof that government strict concavity plus the firm-stage objects imply the full Proposition 2 reduced-form response expression;
- kink/monopoly regime comparisons;
- the claim in the final sentence of Proposition 2 that the local interior derivative is also the derivative of the true global best response on an open neighborhood;
- the canonical global-policy Nash / SPNE welfare-gap certificate over the full `theta in [0,1]` range;
- open-neighborhood persistence around the canonical primitive vector;
- welfare and robustness extensions.

Thus the repository may describe the active-duopoly firm-stage **regularity, reduced linear system, and Hessian negative-definiteness certificates** as formally verified. It should not yet describe the full piecewise firm continuation, government-stage derivation, or global SPNE as formally verified.

## Commands

With Lean installed through `elan`:

```bash
lake update
lake build
```

CI runs the same project automatically on pull requests. The Lean job kernel-checks the project with warnings treated as failures and runs an axiom audit over the Lean library; proofs depending on `sorryAx` or unapproved axioms fail CI.

## Next formalization targets

The highest-value next steps are:

1. formalize the Stage-2 regime partition, nonnegativity/admissibility conditions, and boundary continuity for the piecewise firm continuation;
2. formalize the calculus bridge from the primitive profit function to the active Stage-2 FOCs/Hessian where useful for an end-to-end primitive certificate;
3. connect the active firm-stage equilibrium objects to the government reduced objective and four-policy Hessian;
4. derive the Proposition 2 quartic coefficients and positive factor `Omega(theta)` from primitives and connect them to the generic Phase-2 theorem;
5. formalize the canonical global-policy Nash / SPNE certificate and neighborhood persistence;
6. only after those bridges are closed, formalize welfare and robustness extensions.

No manuscript theorem or theory-freeze statement should be strengthened beyond the exact scope certified above.
