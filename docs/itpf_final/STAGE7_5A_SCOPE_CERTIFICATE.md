# Stage 7 / 7.5A — Scope and independent-proof admission (2026-11-19)

**Verdict: BOUNDED PASS for the fixed-θ two-point theorem; publication value NOT certified.**

## Previously frozen vs newly demonstrated

- **Frozen baseline:** the original $\theta$-indexed quartic root and the d=2 canonical full-nonnegative-game SPNE for $\theta\in[0,1]$; earlier technical Lean formalization concerns this provenance and auxiliary structure, not the new two-point parameter comparison.
- **New proposition in the final rewrite:** fix $\theta=31/40$, all other primitives at the stated rational baseline, and compare *two* separate values $d\in\{39/20,41/20\}$. Each gives a positive symmetric SPNE of the entire action game, a strict global best government response, and distinct signs of the conditional partial derivative $\partial h_A^{BR}/\partial s_B$, with $h_B$ fixed and own $s_A,h_A$ jointly reoptimized. Direct $W_{h_As_B}$ is positive at both specified points.
- **Open set quantifier:** for **each point separately**, there exists a nonempty open neighborhood in primitive space, with its own positive strict gaps and regular Jacobian, where the same existence and sign conclusion survives. No explicit radius is asserted.
- **Not demonstrated:** the *entire* interval $1.95\le d\le2.05$ as a global-SPNE branch; the entire analytic zero curve $d^*(\theta)$ as a globally implementable frontier; monotonicity in $d$ or $\theta$ for arbitrary primitives; uniqueness of **all** governments' equilibria; causal subsidies distinct from an equal rival index shock; global welfare/emissions ranking.

## Mathematical proof gate

The new result does not follow from the old Lean file, and must not be attributed to its axiom audit. Instead, (i) independently construct all five firm continuation regions and exact government quadratics, (ii) enumerate rational stationary/edge/vertex candidate maxima subject to axes and index inequalities, (iii) prove coercivity in the unbounded own-monopoly branch, (iv) show positive symmetric government policies, output, negative-definite own Hessian, nonzero symmetric and antisymmetric policy-FOC Jacobian blocks, (v) establish strict global welfare gaps $\Delta W_{39/20}>0$ and $\Delta W_{41/20}>0$, (vi) verify direct and profiled slopes with common total Hessian, and (vii) use continuity/IFT only for the separate local neighborhoods. Details and exact rational fractions: [STAGE4A_TWO_POINT_CERTIFICATE.md](STAGE4A_TWO_POINT_CERTIFICATE.md).

Counterexamples at $(\theta=1,d=d^*(1))$, $(\theta=.9,d=1.5)$, and $(\theta=.9,d=3)$ remain integral boundary evidence, not decorations.

## Scientific regression and reproduction

- Independent copied PR34 symbolic comparator: `docs/itpf_final/exact_policy_slice.py`; fixed-slice regression: `docs/itpf_final/verify_fixed_theta_result.py`; original independent inverse-Hessian/target analysis: `docs/stage11_v3/recompute_stage6_target_boundary.py`.
- `make verify` and `.github/workflows/verify.yml` include the new exact fixed-slice check. Existing frozen scripts, quantitative welfare/counterexample checks and Lean build retained.
- The source and PDF hashes, explicit passing CI runs and the actual figure/font visual checks belong to the final validation report **after** the manuscript head is frozen. A drafted claim is not successful-execution evidence.

## Editorial boundary

Stage 7/7.5A establishes **what is proved**, not whether the narrow result earns an ITPF editor's attention. The existing Stage11 desk-reject-equivalent and B02 novelty concern remain historical evidence; new editorial judgment must weigh the exact two-point result against HMR, Morita–Okoshi, Strandholm and Bayindir-Upmann source gaps.

**Stage 7/7.5A GO (narrow theorem only). Stage 11/ITPF verdict not automatically upgraded.**
