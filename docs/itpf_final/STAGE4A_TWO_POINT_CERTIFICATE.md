# Stage 4 / 4A — Independent rational certification of the fixed-rivalry target-discipline comparison

**Date:** 2026-11-19 JST. **Decision:** **PASS for the two specified parameter points and separate nonempty local neighborhoods; FAIL for universal d/θ claims.** This is a source-level theoretical certificate, **not** a proof of journal novelty, all-equilibrium uniqueness, or final author verification.

**Source control:** input draft PR #33 `9c10788f4c75cabc977a13754f3e9d02730f9830` (manuscript SHA `1bb47db597339d4f15305e3284ddf320b675a2cb`), referee evidence PR #34 `62c2ab9078ffca6461fe7a53e292a69ff7bbb931`. Current output branch `revision/v3-itpf-final-fixed-theta-target-discipline-20261119`; certified model primitives unchanged.

## 1. Exact action and continuation map

Fix `θ=31/40`, `d∈{39/20,41/20}`, `(kx,kg,μ,ν,κ,e,β,ξ,m,Ebar)=(4,18,9/10,6/5,4/5,11/10,17/10,1/10,2,0)`. Let `b=μ/kg`, `R=1/kx+μ²/kg=59/200`, `L=2−4R/(4−θ²)`, `M=2−R`, `w_A=m+b s_A+ν h_A`, `w_B=m+b s_B+ν h_B`, and `s_A,h_A≥0`.

The full firm continuation has precisely five adjacent pieces classified by `w_A`:
- rival monopoly: `w_A≤θ w_B/M`;
- rival kink: `θ w_B/M≤w_A≤θ w_B/L`;
- duopoly: `θ w_B/L≤w_A≤L w_B/θ`;
- own kink: `L w_B/θ≤w_A≤M w_B/θ`;
- own monopoly: `w_A≥M w_B/θ`.

The unique downstream investment continuation and Cournot quantity follow the frozen model. Each government's payoff is a quadratic `W(s_A,h_A|w_B)` on each piece. Policy feasibility imposes the two axes and at most two linear index bounds. For each piece, enumerate (i) unconstrained interior stationary candidates, (ii) stationary points on each feasible boundary face, and (iii) every pairwise vertex (axes included). Exact rational arithmetic is used for every bound, candidate and welfare value. The only unbounded own-monopoly region has an **exact strictly negative-definite Hessian**, so no maximum escapes to infinity. A singular stationary system is not to be ignored; the independent verifier raises an error if such a system arises. Neither certified pair has a singular candidate that changes the maximum. Empty rival-side regions are explicitly recorded.

The published Source-independent verification is `docs/itpf_final/exact_policy_slice.py` (brought from PR #34), called by `docs/itpf_final/verify_fixed_theta_result.py`. The authoring audit also independently reconstructed the five branch quadratics and enumerated interior/face/vertex candidates without importing project scripts; the second computation reproduced both slopes and exact rational outside gaps. Avoid claiming the two tests are external human audits.

## 2. Positive equilibrium and exact FOC checks

| Rational point | d=39/20 | d=41/20 |
|---|---:|---:|
| Symmetric s | 2.473667338867865 | 2.410735915937671 |
| Symmetric h | 1.032255472915709 | 0.852322550426969 |
| q_A=q_B | 1.384909295633460 | 1.294679829723916 |
| H_ss | strictly negative | strictly negative |
| det H_ss,sh,hh | 0.0247354143148558 | 0.0283396608320903 |
| symmetric FOC-Jacobian determinant | 0.0264750882847591 | 0.0282627858500666 |
| antisymmetric FOC-Jacobian determinant | 0.0229957403449524 | 0.0284165358141140 |
| own-kink normal derivative | +1.77609919719262 | +1.74783910412421 |
| own-monopoly normal derivative | −0.569942124117200 | −0.591875597870716 |
| rival-kink/monopoly | infeasible from w_A≥m | infeasible from w_A≥m |
| best non-duopoly regime | shared own kink/monopoly boundary | shared own kink/monopoly boundary |
| global duopoly advantage ΔW | +1.22504186325935 | +1.25098446650982 |

All rows come from exact rational formulas; decimals are displays. The symmetric policy FOC Jacobian has both symmetric and antisymmetric blocks nonsingular. Strict policy positivity, active-firm quantity positivity and positive duopoly regime slack rule out an infinitesimally immediate active-set switch. The own-policy Hessian is strictly negative definite. The global optimality conclusion is not inferred from that alone: the rival kink and monopoly cannot be reached by any own nonnegative policy; within the remaining own-kink and own-monopoly regions, strict concavity and the tangential/normal signs make the common boundary candidate the best non-duopoly deviation; the strictly positive ΔW rules it out.

### Exact fractions (an independent certificate rather than rounded grid searches)

For d=39/20:
- s = `121580876413931367960/49150051222965116819`, h = `50735409368993152500/49150051222965116819`.
- `Hdet=141457819720783615721999/5718837692394178848540000>0`.
- `ΔW=148989349783148556217990867003253066339283904/121619802760655671470687698110873893192222545>0`.
- `∂h_BR/∂s_B=-850047589668964769775/565831278883134462887996<0`.
- `W_{h_As_B}=28126243004892153219/10590440171100331201000>0`.

For d=41/20:
- s = `379465606083707217720/157406542780158347383`, h = `134161145996276422500/157406542780158347383`.
- `Hdet=486209761668675604027843/17156513077182536545620000>0`.
- `ΔW=4733774998207837781350448359892008581617262272/3784039790210027952876714776301248782838527525>0`.
- `∂h_BR/∂s_B=84580318176289963179075/60290010446915774899452532>0`.
- `W_{h_As_B}=44118071857733202861/10590440171100331201000>0`.

The joint-optimization contributions to the derivative (each evaluated using the **same full-government Hessian** rather than reoptimizing individual welfare terms) are:
- d=1.95: CS `+0.000376095`, PS `−0.069230869`, territorial target `+0.067352475`, total `−0.001502299`.
- d=2.05: CS `+0.000330702`, PS `−0.060729074`, territorial target `+0.061801263`, total `+0.001402891`.
The direct mixed effects are positive at **these two points**, not at all positive θ.

## 3. Stage 4A — local global best-response sensitivity

Under each rational witness the government interior best response is strict and its policy Hessian invertible. A local marginal change in rival subsidy with rival infrastructure held fixed changes the one-dimensional index `y_B` smoothly. The finite branch maxima, policy constraints, active-regime slack, and strict outside-gap vary continuously in the underlying primitives. An arbitrarily small rival shock therefore preserves the strict duopoly-vs-nonduopoly ordering at each witness; the unique interior BR coincides locally with the global BR. The symmetric government FOC Jacobian is nonsingular, so an implicit symmetric (indeed locally regular) equilibrium persists for sufficiently small perturbations of primitives. Thus **there exists a nonempty open neighborhood of each of the two parameter points** over which the signed global BR slope remains strictly negative/positive respectively. We have **not** certified a numerical radius, a common interval connecting both d points, or uniqueness of other governments' equilibria.

This does not prove that a fixed numerical change in the rival subsidy keeps the game on the same branch: only a local derivative in a nonempty sufficiently small neighborhood is certified. The opponent's other instrument is held fixed during that derivative.

## 4. Negative falsification and nonadmissible boundaries

- `θ=1,d=d*(1)=89308800/54845239≈1.62837835386222`: a feasible own-monopoly deviation `(s,h)≈(6.4369930810,3.5256630653)` increases welfare by **0.2814095664** over the interior zero-slope stationary candidate. **Failure of that candidate's globality**, not proof of absence of any equilibrium.
- `θ=0.9,d=1.5`: own-monopoly deviation improves welfare by **0.2956411290**.
- `θ=0.9,d=3`: symmetric interior first-order-condition candidate gives **h≈−0.3256201095**, so violates the nonnegative policy action set.

These cases demonstrate why a full algebraic `d*(θ)` zero locus is not a global-SPNE frontier.

## 5. Scope control

**PASS:** the two-point exact fixed-θ symmetric SPNE existence, opposite marginal global BR slopes, strict branch gaps, firm continuation uniqueness from existing frozen proof, and nonempty **separate** local neighborhoods. **NOT CERTIFIED:** interval `d∈[1.95,2.05]`, globality of the whole interior `d*(θ)` curve, uniqueness of every government equilibrium, general θ-varying target theorem, subsidies as uniquely identified rival shocks, welfare or emissions ranking across target weights.

The existing pinned Lean theorem/axiom audit remains evidence for the earlier formalized statements. **No new Lean theorem formalizing this two-point global comparison was created.** Exact rational SymPy checks, enumeration, and hand-auditable regime inequalities support the new claim; do not misattribute their scope to Lean.

**Stage 4/4A decision: GO only for the bounded fixed-θ two-point existence statement.**
