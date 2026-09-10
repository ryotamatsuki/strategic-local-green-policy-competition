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

1. the generic quartic `P(u) = A4 u^4 + A3 u^3 + A2 u^2 + A1 u + A0`;
2. the manuscript's Bernstein coefficients of `P'`;
3. the exact algebraic identity between `P'` and its cubic Bernstein representation on `[0,1]`;
4. `B0,B1,B2,B3 < 0` implies `P'(u) < 0` on `[0,1]`;
5. hence `P` is strictly decreasing on `[0,1]`;
6. together with `P(0) > 0 > P(1)`, there is exactly one root `u* in (0,1)`;
7. that root separates the signs of `P`;
8. under `u = theta^2`, there is exactly one `theta* in (0,1)` satisfying `P(theta*^2)=0`;
9. for any positive reduced-form factor `Omega(theta)` on `(0,1]`, the response `-Omega(theta) P(theta^2)` switches sign exactly once at `theta*`.

Thus the Bernstein/root/sign-switch argument in Proposition 2 is machine checked once the manuscript's reduced-form representation `d h_A^BR / d s_B = -Omega(theta) P(theta^2)` and `Omega(theta)>0` are supplied.

## Phase 3 — active firm-stage regularity and reduction

The modules

- `StrategicLocalGreenPolicyCompetition/FirmStage.lean`, and
- `StrategicLocalGreenPolicyCompetition/FirmHessian.lean`

formalize the algebraic and regularity backbone of the active-duopoly firm stage.

`FirmStage.lean` proves:

1. with `D = 4 - theta^2`, `D >= 3` and hence `D > 0` for every `theta in [0,1]`;
2. with `R = 1/kx + mu^2/kg`, `R < 3/4` implies `lambda = 4R/D < 1`;
3. therefore `L = 2-lambda > theta` throughout `theta in [0,1]`;
4. consequently `L > 0` and `L^2-theta^2 > 0`;
5. the active Stage-3 Cournot equations have the manuscript's unique closed-form solution;
6. the manuscript's interior Stage-2 investment formulas imply the exact private-cost-reduction identity `x_i + mu g_i + nu h_i = lambda q_i + y_i`;
7. combining that identity with the active Cournot equation yields `L q_i + theta q_j = w_i`;
8. the reduced two-firm system has a unique closed-form solution under maintained regularity;
9. that closed form equals the manuscript representation `q_i = q0 + t0 y_i + t1 y_j`;
10. under maintained regularity, `t0 > 0`, `t1 <= 0`, and `t1 < 0` when `theta > 0`.

`FirmHessian.lean` proves, for `kx>0`, `kg>0`, `theta in [0,1]`, and `R<3/4`:

1. the first leading principal Hessian entry is strictly negative;
2. `det(H_F) = kx kg (1 - 8 R / D^2)`;
3. the determinant is strictly positive;
4. the two scalar Sylvester inequalities hold;
5. the Hessian quadratic form is strictly negative in every nonzero investment direction.

Accordingly, Phase 3 machine-checks the maintained regularity chain linking `R<3/4` to active-branch firm-stage concavity, invertibility, uniqueness of the reduced quantity system, and the signs of its comparative-static coefficients.

## Phase 4 — Stage-2 piecewise regime formalization

The modules

- `StrategicLocalGreenPolicyCompetition/Stage2Scalarization.lean`,
- `StrategicLocalGreenPolicyCompetition/Stage2Regimes.lean`,
- `StrategicLocalGreenPolicyCompetition/Stage2Admissibility.lean`,
- `StrategicLocalGreenPolicyCompetition/Stage2Partition.lean`,
- `StrategicLocalGreenPolicyCompetition/Stage2Certificate.lean`, and
- `StrategicLocalGreenPolicyCompetition/Stage2Endpoint.lean`

formalize the reduced Stage-2 continuation across the interior and corner regimes.

The Phase-4 layer proves:

1. the five tie-broken regimes for positive rivalry: A monopoly, A kink, active duopoly, B kink, and B monopoly;
2. algebraic exhaustiveness of those five region predicates;
3. under `kx>0`, `kg>0`, `theta in [0,1]`, `theta>0`, `R<3/4`, and positive reduced intercepts, `theta < L < M`, where `M = 2-R`;
4. pairwise disjointness of all five tie-broken regimes under the same maintained conditions;
5. the closed-form continuation record `(qA,qB,uA,uB)` in every regime;
6. exact solution of the reduced active-duopoly linear system and positivity of both active outputs there;
7. branch-specific admissibility certificates for monopoly, kink, and duopoly regimes;
8. Stage-3 consistency identities for monopoly, kink, and active-duopoly continuations;
9. exact equality of the full continuation record across every adjacent regime boundary;
10. at `theta=0`, positive reduced intercepts imply the active-duopoly region and rule out the four exclusion/kink predicates;
11. the scalarization bridge `u = x + mu (g-s/kg)`: the displayed composition delivers `u`, minimizes centered quadratic investment cost and original investment cost net of subsidy conditional on `u`, and is nonnegative under the stated nonnegativity conditions.

Accordingly, the reduced Stage-2 piecewise continuation — regime partition, branch admissibility, scalar composition, and adjacent-boundary matching — is machine checked in Lean.

## Phase 5 — primitive Stage-2 optimization bridge

The modules

- `StrategicLocalGreenPolicyCompetition/Stage2PrimitiveBridge.lean`, and
- `StrategicLocalGreenPolicyCompetition/Stage2OptimizationBridge.lean`

bridge the primitive firm-profit problem to the Phase-4 scalar continuation without changing the frozen manuscript or strengthening its stated theorems.

`Stage2PrimitiveBridge.lean` proves:

1. the primitive inverse-demand, marginal-cost, and firm-profit expressions used by the manuscript;
2. the centered scalar `u` plus the reduced policy intercept `w` exactly reconstruct the primitive post-investment net-demand intercept;
3. the active Cournot equation implies the markup identity `p_i-c_i=q_i`;
4. therefore primitive active-branch profit reduces exactly to `q_i^2` minus investment cost net of subsidy;
5. the Phase-4 cost-minimizing scalar composition has centered cost exactly `u^2/(2R)`;
6. after restoring the subsidy shift, its primitive net investment cost is `u^2/(2R)-s^2/(2kg)`;
7. primitive profit evaluated at that scalar composition equals the scalar reduced-profit expression plus the policy-only constant `s^2/(2kg)`;
8. the scalar candidate exactly reconstructs the required primitive intercept `w+u`.

`Stage2OptimizationBridge.lean` proves:

1. exact scalar profit functions for the active-duopoly, monopoly, and inactive branches;
2. exact active-duopoly and monopoly first-order expressions and their equality to the algebraic derivatives of explicit quadratic expansions;
3. generic global-maximization certificates for strictly concave quadratics from a zero FOC and for one-sided endpoint conditions;
4. under `kx>0`, `kg>0`, `theta in [0,1]`, and `R<3/4`, strict concavity of both the active-duopoly and monopoly scalar objectives;
5. hence a zero scalar FOC gives the branch-global maximum on the active-duopoly or monopoly branch;
6. the Phase-4 A-monopoly and B-monopoly continuations satisfy their scalar monopoly FOCs;
7. both components of the Phase-4 active-duopoly continuation satisfy their scalar FOCs;
8. at the A-kink and B-kink candidates, the Phase-4 regime inequalities are exactly sufficient for the required one-sided KKT signs: the duopoly-side derivative is nonnegative and the monopoly-side derivative is nonpositive;
9. those one-sided KKT signs plus strict concavity make each kink candidate a global maximum on the corresponding left duopoly-side branch and right monopoly-side branch;
10. for positive `R`, the inactive scalar branch is maximized at zero over nonnegative scalar choices;
11. conditional on a fixed scalar reduction `u` and a common active Stage-3 quantity, the Phase-4 cost-minimizing `(x,g)` composition weakly dominates every primitive investment composition implementing the same `u`.

Accordingly, Phase 5 closes the **primitive-to-scalar Stage-2 optimization bridge at the branchwise/KKT level**. Primitive active profit, the cost-minimizing investment composition, scalar FOCs, strict branch concavity, monopoly and duopoly candidate optimality, and kink one-sided KKT/branch-optimality are all machine checked.

This Phase-5 closure is intentionally narrower than a claim that the entire primitive Stage-2 game has been formalized as one global constrained optimization theorem. In particular, it does not silently promote branchwise certificates into a stronger cross-regime global theorem.

## What is not yet proved in Lean

The formalization still deliberately stops short of claiming that the entire economic model or the global-SPNE theorem is machine checked. The principal remaining bridges are:

- a single end-to-end primitive constrained Stage-2 best-response theorem that quantifies over all feasible primitive `(x,g)` deviations and all induced downstream regime switches simultaneously, rather than using the branchwise/KKT certificates now proved in Phase 5;
- derivation from primitives of the full four-policy government Hessian;
- derivation from primitives of the generic quartic coefficients `A0,...,A4` and the positive factor `Omega(theta)`;
- proof that government strict concavity plus the firm-stage objects imply the full Proposition 2 reduced-form response expression;
- primitive government-objective comparisons across kink/monopoly regimes;
- the final Proposition 2 neighborhood claim identifying the local interior derivative with the derivative of the true global best response on an open neighborhood;
- the canonical global-policy Nash / SPNE welfare-gap certificate over the full `theta in [0,1]` range;
- open-neighborhood persistence around the canonical primitive vector;
- welfare and robustness extensions.

Thus the repository may state that the **primitive Stage-2 profit/scalarization bridge and branchwise FOC/KKT optimality certificates are formally verified**, together with the Phase-4 regime partition and continuation. It should not state that a single global primitive Stage-2 best-response theorem, the government stage, or the full global SPNE is already machine checked.

## Commands

With Lean installed through `elan`:

```bash
lake update
lake build
```

CI runs the same project automatically on pull requests. The Lean job kernel-checks the project with warnings treated as failures and runs an axiom audit over the Lean library; proofs depending on `sorryAx` or unapproved axioms fail CI.

## Next formalization targets

The highest-value next steps are:

1. connect the firm-stage equilibrium objects to the government reduced objective and four-policy Hessian;
2. derive the Proposition 2 quartic coefficients and positive factor `Omega(theta)` from primitives and connect them to the generic Phase-2 theorem;
3. formalize the canonical global-policy Nash / SPNE certificate and neighborhood persistence;
4. optionally strengthen Phase 5 further with a single cross-regime primitive Stage-2 best-response theorem if that stronger certificate is needed for an audit target;
5. only after those bridges are closed, formalize welfare and robustness extensions.

No manuscript theorem or theory-freeze statement is strengthened by Phase 5 beyond the exact primitive/scalar and branchwise optimization scope certified above.
