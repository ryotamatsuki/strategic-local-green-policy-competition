# Stage 4A N1 — Independent Adversarial Recertification: Global Reentrant Voluntary Coordination
Audit: 2026-10-12, Japan time.
Target branch: `research/stage3-green-policy-local-consent-2026-10-12`.
Incoming candidate: `research/STAGE4_N1_REENTRANT_GLOBAL_SYMMETRY_2026-10-12.md`.
Workflow standard: `research-paper-workflow/templates/STAGE_04A_MATH_RED_TEAM.md`.
Auditor: GPT-6, using a **separate primitive-payoff SymPy reconstruction** and new unilateral-offpath comparisons; this is NOT external human peer review or proof-assistant formalization. Original Stage-4 theorem was seen before the reconstruction, so do not claim blind independence.

## Verdict and exact scope
**GO — MATHEMATICAL ADVERSARIAL CERTIFICATION PASS**, **for the finite rational points and local-open-neighborhood statements only**. The next active gate is **Stage 6 hostile novelty re-kill** (with a bounded Stage-5 updated mechanism ledger); the old Stage-6 CONDITIONAL GO is not automatically canceled by a math PASS. Neither main, frozen previous theory, nor a journal submission is modified.

At canonical unchanged primitives `(kx,kg,mu,nu,kappa,d,e,beta,xi,m,Ebar)=(4,18,9/10,6/5,4/5,2,11/10,17/10,1/10,2,0)`, and for a joint agreement choosing all `(s_A,h_A,s_B,h_B)>=0` subject to `W_i>=W_i^{NE}` with no regional side payments:
- `theta=1/10, 7/10, 9/10`: **unique, globally maximizing policy symmetric**, with both incumbent firms producing;
- `theta=3/10, 1/2`: **a global maximizer exists, and EVERY global maximizer is asymmetric**; by jurisdictional reflection there are at least two globally maximizing policies, not necessarily only two; policies themselves not characterized;
- `theta=3/10,1/2` in both matched nested models `mu=0` and `1/kx=0`: **unique globally maximizing participant-compatible policy symmetric** and dual-firm operation, with the respective reduced model's selected global government-policy NE as outside option.

**No unique symmetry switching threshold, asymmetric optimum formula, universal dual-R&D-necessity condition, complete government-NE set, or treaty/bargaining-game SPNE has been proved.** In the no-conventional-R&D model, `1/kx=0` means a well-defined limit/new reduced investment action set, not a finite strictly positive `kx`.

## Frozen primitives, continuation and independent method
Two firms/regions, `w_i=m+(mu/kg)s_i+nu*h_i`, `R=1/kx+mu²/kg`. Private investment cost-minimizing portfolio at a given `u_i` is `x_i=u_i/(R*kx)`, `g_i=s_i/kg+mu u_i/(R kg)`, with proper limiting formulas for no conventional x. Output and u are affine in the four nonnegative policy controls separately within **five** complete downstream regimes: both firms producing, A/B limit pricing (q_j=0), A/B monopoly (q_j=0). At boundaries the continuation coincides continuously; m>0 excludes both firms inactive.

Independent evaluator `audits/STAGE4A_N1_INDEPENDENT_PRIMITIVES_2026-10-12.py` reconstructs `PS_i=q_i² - (kx/2)x_i² - (kg/2)g_i²` by directly computing investment expenses from separate x and g expressions, rather than copying the producer's expanded `u,s` welfare polynomial. It also rebuilds `CS/2`, infrastructure cost, `-d(E_i-Ebar)^2/2` and every government policy derivative. A separate local SymPy execution of this method gave the output below; the just-committed GitHub script is **not yet shown passing GitHub CI**.

## 1. Five-point baseline test — actual values
| theta | Global regional-IR coordinator symmetry class | Maximum symmetric cooperation welfare (unconstrained in s=h across regions) | IR slack at symmetric cooperation per region |
|---|---|---:|---:|
| .1 | unique symmetric | 14.284251882668 | 4.853423232355 |
| .3 | **all global optima asymmetric** | 8.719747818399 (strictly dominated) | 2.418396797528 |
| .5 | **all global optima asymmetric** | 6.162294126448 (strictly dominated) | 1.436585401015 |
| .7 | unique symmetric | 4.695337607724 | 0.970653660554 |
| .9 | unique symmetric | 3.720306091192 | 0.766677133319 |

For .3 and .5, the **explicit asymmetric** policy with `(delta s_A, delta h_A, delta s_B, delta h_B)=(1/10,1/20,-1/10,-1/20)` around the best symmetric policy has exact total-welfare gain respectively `22617173/4841870418000>0` and `172856/8002000125>0`. Both have strictly positive government controls, positive Cournot outputs and strictly positive **both** local IR slacks. This witness does **not** identify a global optimum; it rules out **every symmetric global optimizer** because the symmetric restricted problem is strictly concave.

For .1/.7/.9 the **complete** active-duopoly aggregate policy Hessian is exactly negative definite (all leading Sylvester principal minors strictly positive for `-H`). The globally unconstrained 4-policy stationary point is symmetric, lies in the positive active-duopoly region, and has strictly slack regional participation. All zero-output policies are independently excluded by the host-veto lemma (below), so it is uniquely optimal among ALL consent-feasible policies.

## 2. Global optimum existence at theta=.3/.5 — key false-proof attack
The four-policy **D (dual-active)** aggregate Hessian at these parameters has one **positive** eigenvalue on signed real policy vectors (approx `+.0005719078704` at theta=.3; `+.0018877012681` at theta=.5). Thus claiming full D global strict concavity would be mathematically FALSE.

Producer proof instead uses nonnegative-policy cone `z>=0`: build symmetric matrix `H^+` from the exact D Hessian `H`, preserve diagonals and positive off-diagonals, replace negative off-diagonals with zero. Then for all `z>=0`, `z'H z<=z'H^+z`. Independent recomputation of ALL four Sylvester minors of `-H^+` (decimal displays of underlying positive rationals):
- `theta=.3`: `(0.0643627828863, 0.00446992083770, 0.000287696544396, 0.0000199801922953)`;
- `theta=.5`: `(0.0640530427312, 0.00633064972659, 0.000405497377453, 0.0000395468912782)`.

All are strictly positive exactly. Both K and M branch four-policy total-W Hessians are also exactly negative definite; K leading minors at .3: approximately `(.0598930,.345961,.0263047,.0592097)`, and M: `(.0645286,.00384924,.000282515,.000230290)`; same signs at .5.

Consequently the five-region piecewise total-W function is **coercive** on the entire nonnegative four-policy orthant: as any feasible policy sequence's norm tends to infinity, aggregate W tends to minus infinity. The participation-feasible set is nonempty (contains selected NE policy) and closed, since continuation and W are continuous across the kink boundaries. Hence the constrained maximum is attained. Strict feasible asymmetric gains above the maximal symmetric-coordinator welfare then show that **all** such attained maxima are asymmetric. This is a global EXISTENCE + symmetry-type certificate, not a global enumeration of optimum policies.

## 3. Off-path NE and alternative-equilibrium audits
A new independent government unilateral-policy branch audit was performed for the full baseline at **all 5 theta points**, holding rival policy at the exhibited candidate and re-solving producer/investment Cournot continuation:
- D own-policy quadratic stationary value equals proposed outside-region payoff.
- A-kink and A-monopoly own-policy quadratic GLOBAL upper bounds are strictly below that welfare; rival-only-output continuations are mathematically unreachable with own nonnegative policy at these fixed rival profiles.
- Exact selected NE welfare per region: `theta=.1:2.288702709; .3:1.941477112; .5:1.644561662; .7:1.377015143; .9:1.093475912`.
- Most challenging omitted branch among the five points: at `theta=.9`, A-kink best quadratic upper bound `1.054366256` versus incumbent payoff `1.093475912`; strictly negative profitable-deviation gap. No other profitable unilateral policy deviation exists from this selected symmetric profile.
- This verifies **an exhibited symmetric government-policy NE**, not uniqueness of the full simultaneous-government game.

For **nested cases** at theta=.3/.5, the own-government D 2x2 quadratic maximum equals the selected symmetric outside payoff exactly, while A-kink and A-monopoly own-policy suprema are STRICTLY BELOW it. A rival-only-output deviation is impossible because `theta w_B^NE<2L`, with `w_A>=m=2`. For no-x, kink Hessian is singular in the subsidy direction, but that instrument does not affect the candidate's A-kink welfare at fixed B policy: the exact remaining 1D infrastructure quadratic supremum gives the bound, avoiding a false inverse-Hessian claim.

Numeric independent reduced-model government deviation envelopes:
| theta | model | chosen NE W_i | A-kink unrestricted bound | A-monopoly unrestricted bound |
|---|---|---:|---:|---:|
| .3 | mu=0 | 1.419451752 | -33.376480638 | 0.617091448 |
| .3 | no-x | 1.913312477 | -52.086101952 | 1.022733505 |
| .5 | mu=0 | 1.252640236 | -6.763335318 | 0.617091448 |
| .5 | no-x | 1.682048520 | -11.707487316 | 1.022733505 |

The strict inequalities provide exact-rational global best-response witnesses; multiple government-policy equilibria elsewhere are NOT excluded. The coalition outside-payoff selection is specified explicitly.

## 4. Host consent veto, kink and degenerate no-x envelope
If B produces zero and A remains active, define its reduced firm investment u and market output `q_A=(w_A+u)/2`. On monopoly `u=R q_A`, and on the adjoining limit-pricing kink `u>=R q_A`. Relax to `u-R q_A>=0` (also `s_A,h_A>=0`) and maximize A's government welfare over this **SUPERSET**. The regional payoff includes CS allocation, investment costs, public input costs and delegated local target loss; B's subsidized inactive green investment does not enter A host's own payoff.

Independent exact KKT equations, all principal minors of `-H_{host}`, and nonnegative multiplier give GLOBAL bounds on host W across **both** zero-rival-output regions:
- Full baseline: `1753200/2071201≈.8464654082`;
- mu=0: `175320/284107≈.6170914479`;
- no-x: `1361200/1330943≈1.0227335055`, Hessian **negative semidefinite**, has one flat direction and KKT multiplier **zero**. Use convex-concave global sufficiency; no strict inequality required for the multiplier.

Every value is STRICTLY less than the applicable selected noncooperative regional welfare at every tested theta. This excludes all one-firm-output outcomes, including the limit-pricing kink, from the voluntarily IR-feasible cooperative program. Both firms inactive cannot occur under `m>0` and nonnegative policies. No artificial upper policy cap or transfer instrument is imposed.

## 5. Nested model cooperation: global, not chosen perturbation
At theta=.3/.5 in BOTH reduced models, independent 4-policy D joint-W Hessians are strictly negative definite. Their **unconstrained R^4** maximizers are symmetric, have positive controls, dual production and strict individual participation. Because the host bound eliminates all non-D participant-feasible policies, these maxima are indeed UNIQUE **global** voluntary coordination optima, regardless of the specific +0.1/+0.05 perturbation direction. Thus the full-versus-nested difference holds at the *whole-game global policy symmetry class* level.

| theta | full game optimal policy | mu=0 optimal policy | no-x optimal policy |
|---|---|---|---|
| 0.3 | all optimizers asymmetric | unique symmetric | unique symmetric |
| 0.5 | all optimizers asymmetric | unique symmetric | unique symmetric |

This **matched-primitive** contrast does not show that BOTH investments are necessary in all parameter vectors. It does not compare model welfare LEVELS across economies with different feasible private investment sets. It establishes a real full-game interaction at these tested witness points.

## 6. Other Stage 4A requirements and honest exclusions
- Complete regime set: D, A/B kink, A/B monopoly; regime boundaries are continuous, and output/production status is not confused with plant relocation. The inactive firm's subsidy-induced g=s/kg is explicitly counted in its own W, and absent conventional investment corresponds to `1/kx=0` limiting model.
- Candidate/alternative audit: U unrestricted cooperative benchmark may have A/B reflected two optimal profiles; the new N1 concerns **IR-constrained** coordination. At theta=.3/.5 reflection creates at least two asymmetrically chosen optimal policies, but their exact count/levels unknown. At .1/.7/.9 IR coordinator has exactly one symmetric optimum. Original noncooperative government equilibria: **EXISTENCE ONLY**, not all-equilibrium invariance.
- Indifference: no-x host envelope has flat marginal direction and zero dual multiplier; this does not generate an extra participant-feasible q_j=0 outcome due to strict host/NE welfare gap. At the globally symmetric C optimum both IR constraints have strict slack. At asymmetric candidate IR is strict, but true global asymmetric optimum may or may not have an IR constraint binding.
- Open-theta-neighborhood classification: all needed host veto gaps, relevant strict negative-definiteness or coercivity majorant inequalities, symmetric candidate feasibility/IR slacks and (where needed) strict feasible asymmetric welfare gains are continuous in theta, so **some positive-radius interval** around each listed theta inherits the stated type. Exact endpoints and uniqueness or ordering of all regime transitions are NOT computed. Symmetry under nearby changes of asymmetric region-specific parameters is NOT claimed.
- Formalization: **APPLICABLE**. Priority proof assistant targets: finite-rational Hessian/majorant Sylvester inequalities and the noncompact-domain coercivity implication; original two nested globally valid outside-option deviation bounds; the semidefinite no-x host KKT global upper certificate; the five-branch continuous IR-domain global maximum theorem and symmetry comparison. No Lean proof for N1 exists yet; this is independent symbolic verification, not machine-checked formal logic.
- The environmental quadratic is **territorial target deviation**, not real climate damages; mathematical inactivity can permit an inactive subsidized firm's negative model E_i. No endogenous treaty-enforcement or contribution/expenditure institutional feasibility theorem.
- **Novelty risk not resolved:** symmetric LQ welfare curvature and nonmonotone trade/integration policies are generic; the newly demonstrated strong whole-game nested contrast strengthens the contribution but its welfare magnitude at selected perturbations is tiny. Actual global asymmetric-policy welfare improvement still lacks an exact value. Source theorem absorption and field-journal contribution must be re-evaluated independently at a repeated **Stage 6**.

## 7. Evidence ledger and execution honesty
| Mathematical claim | Hostile attack | Independently reconstructed evidence | Residual restriction |
|---|---|---|---|
| Positive-cone coercivity at theta=.3/.5 | D Hessian indefinite, search for unbounded policy escape | `audits/STAGE4A_N1_INDEPENDENT_PRIMITIVES_2026-10-12.py`: H+ and exact 4 Sylvester minors, independent local SymPy computation | not all theta; no arbitrary shocks |
| No symmetric global C optimizer .3/.5 | attack symmetric restricted optimum and policy/IR boundaries | independent direct-surplus asymmetric perturbation + actual coercivity/attainment | asymmetric optimum values/uniqueness unknown |
| Unique symmetric C .1/.7/.9 | search monopoly/kink participation loophole | 3D host-concave bound + strict 4D D Hessian and admissible stationary optimum | outside-option selection fixed |
| Nested unique symmetric C .3/.5 | global off-path govt deviations and singular Hessian | D/K/M independently derived policy upper envelopes; exact 3D (semi)definite host KKT | limits mu=0 and 1/kx=0, not universal necessity |
| Full game private continuation | omitted output regime and subsidy green investment | complete five-case analytic continuation already recertified in previous Stage 4A; fresh direct-payoff reconstruction here | no wholesale new global mixed-government-equilibrium search |
| Open neighborhoods | irrational parameter boundary counterexample | continuity of strict rational gaps, Hessian signs, coercivity inequalities | interval endpoints absent |
| Economic importance | generic parent-class absorption | novelty issue deferred Stage 6 | not a mathematical error |

**Audit execution:** Independent equivalent standalone SymPy reconstruction was executed locally; 5 baseline and 4 nested combinations reproduced source signs and welfare. New GitHub audit code and producer script were wired to research-branch PR verification, but **hosted GitHub Actions, LaTeX build and Lean kernel checks were not run in this audit session**. Do not describe a CI green check until a real check run is observed.

**Final Stage 4A verdict:** `GO — MATHEMATICAL ADVERSARIAL CERTIFICATION PASS` with exactly delimited points/nearby intervals and nested comparator models. **Next action: repeat Stage 6 hostile theorem-level novelty re-kill**, not theory freeze or journal submission. No changes made to `main`.
