# 2026-11-08 ITPF hostile-review response and submission gate

## Authority and baseline
- Reviewed canonical baseline: main at a318195c75a0d0ce30a69f61ae810918aacd7552.
- Frozen theory: SLGPC-THEORY-FREEZE-2026-09-05-v2. This draft PR proposes a *new conditional analysis* and does not silently replace the validated v2 freeze.
- Prior hostile-audit decisions remain binding: nonnegative five-regime continuation; no universal conventional-investment necessity; rival policy enters through a composite productivity index; environmental-target intensity matters; coordination can raise emissions; IFT is only globally meaningful in the certified equilibrium region.

## Reviewer recommendations: disposition
| Item | Prior status | New work / rationale |
| --- | --- | --- |
| P1, Schur direct-vs-joint mechanism | Existing 2x2 IFT and composite-welfare decomposition | Added exact direct-vs-joint canonical rivalry thresholds, retained as policy-adjustment interpretation rather than new algebra |
| P2, investment-feedback role | R aggregation, kx local sensitivity, no-x beta=1.3 global counterexample, d=1.5/2/3 signs already documented | New interval theorem on the fixed-environmental-primitives slice: critical R, complete interior response classification, strictly declining switching threshold |
| P3, welfare linkage | Regional coordination wedge and limited active-duopoly planner comparison settled in Stage 7 | No invented welfare theorem; policy reaction sign does not rank social welfare |
| P4, near literature | Hauptmeier/Morita–Okoshi/Strandholm already compared | Added and checked Billon 2023 and Zimmermann 2024 |
| P5, no-x benchmark global meaning | Canonical no-x had interior sign certificate; different beta=1.3 counterexample was globally checked at two thetas | Added separate exact full-rivalry global policy-deviation certificate for matched beta=1.7 no-x system |
| P6, interior/global distinction | Resolved in v2 | Preserved: new R-interval result is interior, canonical upper endpoint has the existing global-SPNE/open-neighborhood bridge |
| P7, Introduction/abstract/conclusion | Original controlled claims | Revision foregrounds economics of portfolio adjustment and conditional investment feedback |
| P8, institutional scope | Limits already documented | No unmotivated budget, emissions, location, or climate-welfare model change |

## New result 1: direct vs joint threshold
For canonical remaining primitives:
- Direct own-infrastructure effect W_{h_A s_B} has a unique zero at theta_D about 0.425736775528.
- Simultaneous two-policy response dh_A^BR/ds_B has a unique zero at theta_star about 0.773804386083.
- The two response experiments have opposite signs throughout (theta_D, theta_star).
- Schur complement is an algebraic reformulation of the previously verified 2x2 IFT, **not** an independent novelty claim.
- This is a within-model counterfactual: holding s_A fixed is not a separately globally solved jurisdictional game.

## New result 2: investment-feedback boundary
Hold all other canonical primitives fixed and r=R=1/k_x+9/200 in [9/200,59/200].
- On the active-duopoly branch, the own-government Hessian is negative definite throughout the (r,theta) rectangle.
- A rational polynomial Q(r,u) with u=theta^2 controls the cross-infrastructure response.
- Exact tensor-product Bernstein certificates prove Q_u>0 and Q_r>0 across the rectangle.
- Q(r,0)<0 throughout; Q(r,1) changes sign exactly once at
  r_c=132483/137425 - 3 sqrt(22808771461)/549700 = 0.1398122733006...
- For r<r_c no positive-rivalry switching; at r=r_c zero only at theta=1; for r>r_c a unique negative-to-positive switching theta_star(r) with d theta_star/dr<0.
- The no-conventional-investment limit is r=0.045; full canonical has r=0.295.
- This is **not** a general condition for arbitrary environmental primitives nor a global-SPNE theorem for the entire interval.

## New result 3: matched no-x global validation
The canonical no-x benchmark with beta=1.7 is now checked against the nonnegative active, kink, and monopoly continuations for every theta in (0,1]. Firm and policy feasibility, kink subsidy plateau, boundary KKT, strictly concave monopoly objective, and strictly positive welfare gap are checked using exact rational polynomial root counts. At theta=0 exclusion is impossible.

Do not confuse this matched benchmark with the preexisting no-x beta=1.3 counterexample, which shows conventional investment is not universally necessary for switching.

## Verification and trust boundary
- New symbolic verifiers:
  - scripts/verify_itpf_mechanism.py
  - scripts/verify_nox_canonical_global.py
- Added pytest regression checks.
- Existing sympy and Lean formalization are not rewritten.
- Phase 8/9 complete global-SPNE Lean proof remains outstanding in Draft PR #25; do not advertise a complete formal proof.
- Initial CI failure after edits originated in a hard-coded prior abstract string guard; the equivalent true-SPNE wording has been restored. Check latest head CI before merging.
- Visually inspect the rebuilt PDF and source archive after final CI.

## Adversarial editorial judgment
A genuinely new one-parameter interior classification and globally validated matched comparison address two core criticisms more directly than prose alone. They strengthen the case for submitting to ITPF, but do not guarantee acceptance: the mechanism remains a linear-quadratic, fixed-location model and the theorem's global-SPNE bridge remains certified only around the canonical vector. The welfare effect of switching remains unresolved and is not asserted. The editor could still find the contribution too narrow.

## Remaining gates
1. All symbolic, manuscript, and Lean CI jobs must PASS on the exact final PR head; no stale-success substitution.
2. Inspect the rebuilt PDF (pages, layout, equations, bibliography), and confirm the manuscript and proofs describe the same parameter domain.
3. Perform one final closest-theorem editorial comparison. Do not require an unmotivated new model or welfare theorem.
4. Record a new verified theory/manuscript freeze if the new proposition is accepted.
5. Confirm the zero-submission-fee constraint in the live ITPF portal and obtain explicit author approval before final submission. Subscription no-APC does not establish a zero submission fee.

No journal submission is made by this PR.
