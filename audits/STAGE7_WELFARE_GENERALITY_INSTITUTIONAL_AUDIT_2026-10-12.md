# Stage 7 — Hostile Welfare, Generality, and Institutional Audit
Date: 2026-10-12 (Asia/Tokyo)
Base manuscript: `main` SHA `a318195c75a0d0ce30a69f61ae810918aacd7552` (unchanged).
Workflow: `research-paper-workflow` v2.8 Stage-7 template, with v2.9-candidate question-completeness checks.
Inputs: this branch's Stage-4A and Stage-6 adversarial audits.
Audit tools: new independent symbolic primitive evaluation, four-policy direct-payoff solver and derivative-free global numeric exploration, independent Bertrand/ownership algebra, official METI/OECD/Japanese Ministry of Environment sources.
**CANONICAL VERDICT: CONDITIONAL GO — ONE BENCHMARK-DEFINITION BLOCKER.**
Blocker W1, earliest affected stage **Stage 7**. Do **not** route to Stage 7.5 until addressed.

## 0. Executive result
The firm's physical quantities, conventional/green investments, emissions, exact consumer surplus, and within-region subsidy-transfer cancellations are consistent with the revised model. The restricted symmetric active-duopoly coordination example and its environmental warning reproduce numerically, and the true cross-regional welfare wedge is positive at the canonical NE.

**Newly uncovered material defect:** `sections/welfare.tex`, equation `eq:planner`, explicitly prints `max_{s_A,h_A,s_B,h_B>=0}(W_A+W_B)` (unrestricted four-instrument planner), but the reported `C` welfare table solves the **symmetric interior two-active-firm** first-order conditions only. The full feasible game admits asymmetric policies inducing monopoly, and one **explicit exact-rational feasible policy** produces welfare `10.15815099247` at `theta=.9`, compared to the reported `3.72030609119`. Therefore the equality between the displayed planner problem and the reported coordinated solution is mathematically **false**, even though the restricted benchmark's numbers are correct. The source text elsewhere calls the numerical benchmark restricted; this does not repair the mismatch in the equation defining the problem.

This is a welfare-scope/calibration issue, not a failure of the central Stage-4A product-market response theorem. The audit identifies no reason to reopen Stage 4 at present. The single required repair is to make the planner's *actual constrained choice set* agree with the displayed mathematical benchmark and carry the restriction consistently into abstract/introduction/discussion/conclusion.

## 1. Exact welfare accounting
Primitive consumer utility: `V=a(q_A+q_B)-.5(q_A^2+q_B^2)-theta*q_A*q_B`.
Inverse demand yields **exact** `CS=.5(q_A^2+q_B^2)+theta*q_A*q_B`, not an approximation.
Real operating profit at the Cournot equilibrium is `q_i^2` for active firms, zero when inactive.
Real producer surplus: `PS_i=(p_i-c_i)q_i-kx*x_i^2/2-kg*g_i^2/2`.
Government welfare: `W_i=.5 CS+PS_i-kappa*h_i^2/2-d*(e*q_i-beta*g_i-xi*h_i-Ebar_i)^2/2`.
The subsidy payment `s_i*g_i` cancels with firm receipts ONLY for full local profit capture and no tax financing distortion. It must be reported as a budget outlay, not a real resource loss in the baseline welfare functional. For local ownership `omega<1`, the residual `(omega-1)s_i*g_i` survives.
`d*(E_i-Ebar)^2/2` is a delegated territorial-target objective, **not calibrated global climate damages**. Output expansion can raise E despite increased green investment.

## 2. Exact rational mathematical counterexample (W1)
Canonical parameters `(kx,kg,mu,nu,kappa,d,e,beta,xi,m,Ebar)=(4,18,.9,1.2,.8,2,1.1,1.7,.1,2,0)`, `theta=9/10`.

Symmetric-coordinated candidate solves the **two-variable restriction** `max_{s,h>=0} W_A(s,h,s,h)+W_B(s,h,s,h)` in its duopoly continuation:
- `s_C = 820073054520/181241003453 = 4.52477428...`
- `h_C = 579742914900/181241003453 = 3.19874014...`
- `W_C = 674272009120/181241003453 = 3.7203060911922967...`
- symmetric restricted Hessian is negative definite, policies positive. This is a valid **restricted** maximum. At theta=.9 even the full 4-policy Hessian *inside the duopoly branch* is negative definite (numeric eigenvalues `-1.103982,-.316116,-.054330,-.032750`), indicating the oversight concerns the **switch to monopoly**, not an unstable symmetric duopoly point.

Set a feasible asymmetric `(s_A,h_A,s_B,h_B)=(30,18,0,0)`. The full Stage-2/3 A-monopoly condition is:
`theta*w_A-(2-R)*w_B=959/50>0`; hence **do not apply duopoly formulas**.
Then `q_A=5020/341`, `q_B=0`, `x_A=q_A/4`, `g_A=2458/1023`, `E_A=10546/1023`, `E_B=0`; `CS=q_A^2/2`.
The resulting exact welfare is:
- `W_A=-230350502/5232645=-44.02180962018253...`
- `W_B=6300100/116281=54.17996061265383...`
- `W_A+W_B=53153998/5232645=10.15815099247130...`.
The **strict exact gap** from the reported coordinated comparator is
`6105457877897032694/948369830513323185 = 6.437844901279...` > 0.
Therefore the printed 4-policy planner optimum CANNOT equal the reported symmetric-duopoly comparator. The counterexample remains valid even without proving the global planner optimum.

Independent bounded differential-evolution search over four nonnegative policy controls (both [0,100]^4 and [0,400]^4, multiple seeds) suggests an even higher **asymmetric monopoly** optimum of roughly `10.182291595`, near `(30.556,17.813,0,0)` or the mirrored policy at theta=.3,.6,.9,1; this is **numerical diagnostic only** (not an exact global/planner uniqueness theorem). At theta=.1 the numerical unrestricted optimum is symmetric; the change in optimizer topology must not be promoted to a proved 'new phase transition'.

**Economic distribution caveat:** the exact asymmetric policy decreases A's local welfare dramatically while benefiting B through half of integrated-market consumer surplus. It is **not Pareto-superior**, and no compensation, interregional contract, or fiscal participation constraint is modeled. The result is sensitive to the absence of a hard financing/budget constraint and to integrated CS allocation; not a policy recommendation to close the rival firm.

Reproducible exact-rational regression:
`audits/stage7_exact_planner_counterexample.py` (same branch).
The frozen main/welfare manuscript has NOT yet been altered.

## 3. Planner / feasible-set register
| Object | Objective | True feasible choice set | Status |
|---|---|---|---|
| Decentralized SPNE | `W_i` separately | each `s_i,h_i>=0`; other government's strategies endogenous; downstream nonnegative firms | canonical **existence**, not all-government-policy-equilibrium uniqueness |
| Published `C` at theta=.9 | `W_A+W_B` | `s_A=s_B=s>=0`, `h_A=h_B=h>=0`, consequently active duopoly under canonical conditions | **RESTRICTED-SYMMETRIC COORDINATION BENCHMARK**, no global planner interpretation |
| `eq:planner` as currently printed | `W_A+W_B` | all `s_A,h_A,s_B,h_B>=0` with complete continuation | **NOT SOLVED BY TABLE**; exact feasible asymmetric policy dominates reported values |
| Economic first-best | actual global environmental/social objective including relevant carbon damages, funding, private/consumer allocations and real institutional constraints | potentially more choices than government's four instruments | NOT MODELED; neither previous comparator is a climate 'first best' |

**Minimum permissible Stage-7 correction:**
Replace the displayed optimization formula defining the reported comparator by
`max_{s,h>=0} [W_A(s,h,s,h)+W_B(s,h,s,h)]` with the complete game continuation understood, title it 'symmetric-policy, active-duopoly restricted benchmark', and explicitly say it is not the maximum of unrestricted four-policy planner welfare. Make all text/table references agree. To offer genuine unconstrained coordination policy, separately solve and certify the full nonlinear piecewise 4D planner, including fairness/participation and admissible instruments as necessary — a larger new result, NOT required for keeping the narrow diagnostic model.
**Do not** infer anything about a feasible or Pareto-improving real-world policy from the unrestricted total-welfare counterexample.

## 4. Private/social wedge and outcome comparisons
For `z_A in {s_A,h_A}`, at decentralized NE, coordination's first-order wedge is
`Omega_zA = d W_B / d z_A = .5*CS_zA+PS_B,zA-d(E_B-Ebar_B)E_B,zA`.
Own NE derivative `dW_A/dz_A=0`. Independent primitive centered differences at theta=.9 yield:
- `dW_B/ds_A ≈ +0.02498421092`,
- `dW_B/dh_A ≈ +0.59962106214`.
Hence this is not an artifice of internal subsidy transfers. The sign/ranking of welfare wedges is parameter-specific, NOT a general under-provision theorem.

At theta=.9:
| Item | canonical symmetric global-SPNE | restricted symmetric coordinated |
|---|---:|---:|
| `(s,h)` | `(2.059411,.744258)` | `(4.524774,3.198740)` |
| total modeled welfare | `2.1869518` | `3.7203061` |
| regional welfare each | `1.093476` | `1.860153` |
| output per region | `1.184177` | `2.397036` |
| E per region | `.907456` | `1.634043` |
| fiscal infrastructure outlay share `(kappa*h^2/2)/(s*g+kappa*h^2/2)` | `.363175` | `.692494` |

The restrictive comparison is Pareto-improving **for the displayed symmetric canonical NE** if its policies can be coordinated, but it increases total territorial emissions. It is neither a guaranteed improvement for every other possible policy equilibrium nor a global emission-reduction or efficiency theorem. Its normalized numerical magnitudes cannot be read as monetary public spending levels.

## 5. Equilibrium-selection robustness
| Claim | Equilibrium-set status | Selection used | Defensible interpretation |
|---|---|---|---|
| Canonical decentralized baseline `W^{NE}` | **EXISTENCE ONLY** certified at Stage 4A, other policy equilibria not globally excluded | displayed symmetric SPNE | **SELECTED EQUILIBRIUM ONLY**; no all-equilibrium welfare ordering |
| Restricted coordination improvement | mathematical comparison to displayed symmetric SPNE | symmetric two-active-coordination | **SELECTED EQUILIBRIUM ONLY**; no all-selection Pareto assertion |
| Fully unrestricted planner optimum | **UNRESOLVED** due to omission of monopoly/asymmetry | none adequately specified | previous implied global-optimality interpretation **REJECTED** |
| Cross-region subgame selection combinations | unique firms' continuation for each policy history under regularity; single integrated differentiated-product market | no independent downstream selections | **NOT APPLICABLE** for downstream market multiplicity; government-policy multiplicity remains unexcluded |

## 6. Two genuinely distinct robustness settings
Independent fresh symbolic Hessian/IFT checks (see `audits/stage7_independent_local_robustness.py`) give:
| Setting | theta | dh_A^BR/ds_B | Own Hessian |
|---|---:|---:|---|
| differentiated Bertrand (price competition) | .3 | -.00169448445 | negative definite |
| differentiated Bertrand | .5 | +.00401263009 | negative definite |
| Cournot, 90% local producer-surplus capture | .5 | -.00009679841 | negative definite |
| Cournot, 90% local producer-surplus capture | .7 | +.00324624086 | negative definite |

These support a local sign change by continuity and valid local strict-concavity results, **not** a unique crossing across the entire interval or a global SPNE under the alternative settings. The Bertrand policy constraint binds by approximately theta=.545. Local-ownership leakage must account for residual subsidy incidence `(omega-1)s_i*g_i`. Existing target-discipline checks at d=1.5,2,3 show negative throughout / one switch / positive throughout: the switch is **not generic** across environmental preferences. Small asymmetry portability is a local continuity proposition, not a global asymmetric characterization.

**Evidence classification:**
- Baseline threshold uniqueness: `SUFFICIENT-CONDITION THEOREM` for interior, plus `GLOBAL-SPNE CANONICAL WITNESS`.
- Global canonical equilibrium validity: analytic rational witness and local-open-set certification, not full-general-form theorem.
- Bertrand switch: `NUMERICAL / LOCAL SYMBOLIC ROBUSTNESS ONLY`.
- 90% local surplus ownership: `LOCAL SYMBOLIC ROBUSTNESS ONLY`.
- General functional-form invariance, congestion/financing/plant relocation: `NOT PROVED`.
- d-variation: `PARAMETER DEPENDENCE / LOCAL ANALYTIC CERTIFICATES`.
- Asymmetric neighboring primitives: `LOCAL OPEN-NEIGHBORHOOD CONTINUITY`, formal scope still Stage-7.5A challenge.

## 7. Official institutional evidence (2026-10-12 verification)
| Bridge claim | Primary source | Classification |
|---|---|---|
| Japanese GX policy combines place-based regional industrial-cluster/grid/utility measures and firm-facing grant channel at national-program level | METI GX strategy area: https://www.meti.go.jp/policy/energy_environment/global_warming/gx_strategy_area.html | **ESTABLISHED, nationally** |
| GX regional contribution subsidy aids large electricity-consuming private capex on decarbonized-electricity and local contribution conditions | METI https://www.meti.go.jp/policy/energy_environment/global_warming/gx_strategy_area/subsidy/subsidy.html | **ESTABLISHED, program terms** |
| Japan's subnational governments have environmental implementation roles and many local net-zero targets | OECD Environmental Performance Reviews: Japan 2025 https://www.oecd.org/en/publications/oecd-environmental-performance-reviews-japan-2025_583cab4c-en/full-report/executive-summary_5fca8a9e.html ; MOE local-plan manual https://policies.env.go.jp/policy/roadmap/local_keikaku/kuiki/ | **ESTABLISHED, broad administrative role** |
| Prefectures autonomously choose BOTH green firm-specific subsidy s_i and productive h_i in one unconstrained fiscal budget like the game | no source establishes this; METI program is national support | **UNVERIFIED / NOT LITERALLY MAPPED** |
| Both `mu>0` and target weight `d` plausibly represent all subsidized abatement investments | no direct estimate; selective process efficiency can reduce production cost | **SUGGESTIVE ONLY / heterogeneity important** |
| Regional model target-loss function measures actual global carbon damage | not part of source or model | **CONTRADICTED AS INTERPRETATION**; delegated target is a reduced-form constraint |

No assertion that the list of 2026 GX *first-stage candidate areas* necessarily equals final approved GX strategy area selections without a current official final release.

## 8. Empirical implications, identifiability, and limits
1. `d h_A^BR / d s_B` may change sign over product-substitutability theta regimes **conditionally on target discipline and investment primitives**. It is a **conditional BR**, not the simultaneous equilibrium policy response to an exogenous public funding reform.
2. Best-response slopes need non-linear/threshold tests; ordinary spatial correlation between neighbors' spending or a linear spatial lag of subsidies cannot identify this model.
3. Rival subsidy and infrastructure shocks enter through the *same composite index* `y_B=(mu/kg)s_B+nu*h_B`. At canonical parameters the ratio of derivatives to an `h_B` vs `s_B` shock is `nu*kg/mu=24`, but monetary/units scaling and endogeneity prevent reading this numerical ratio as an empirical estimate.
4. Relevant discriminators: firm green-investment competitiveness parameter `mu`, normal R&D responsiveness `1/kx`, infrastructure productivity `nu`, territorial-target intensity `d`, local profit capture `omega`, differentiation theta and regime (duopoly vs monopoly). None calibrated to real Japanese industry here.
5. No claim that a particular real jurisdiction should increase infrastructure from an observed subsidy spillover, no effect size in yen, no local climate marginal-damage coefficient, no full-equilibrium policy impact.

## 9. Exposition triage / stage-10 routing
| Surviving result | Best vehicle | Reason / Stage-10 restriction |
|---|---|---|
| Canonical unique BR switching threshold | one proposition + plot | exhibit local conditional reaction, NOT ultimate welfare/optimal policy |
| Global-SPNE bridge | proposition + essential proof/case chart in appendix | state existence, not all equilibria uniqueness |
| Matched no-x separation | overlay line on same plot + terse proposition | no universal investment-necessity claim |
| Fiscal/target/producer-surplus decomposition | concise table or prose at theta=.9 | do not claim one channel always dominates |
| Restricted-coordination comparison | table explicitly labelled **symmetric-policy, active-duopoly restricted** | MUST replace unrestricted planner optimization equation and avoid global planner labels |
| Asymmetric feasible planner counterexample | appendix technical warning or Stage-7 audit regression; decide exposition at Stage 7.5 | exact counterexample disqualifies an unrestricted optimum claim; no need to add 'asymmetric monopoly welfare theorem' as new contribution |
| Bertrand/ownership portability | concise robustness paragraph/table | explicitly local, do not mislabel as global SPNE |
| Institutional mapping | succinct paragraph with METI/OECD sources | national vs prefectural instrument control distinction |

## 10. WHY / SHOULD / COULD and v2.9 complete-question handoff
- **WHY** (`MODELED`): externality `dW_B/dz_A`, partial BR sign switch via firms, territorial target. Not a theorem that decentralized infrastructure is always too low.
- **SHOULD** (`RESTRICTED ONLY`): correct limited symmetric coordination comparison; full unrestricted planner may prefer extreme asymmetric industrial concentration, reducing one jurisdiction's welfare massively. Under modeled `W_A+W_B` there is no fixed social welfare/emissions ranking without benchmark conditions.
- **COULD** (`OUT OF SCOPE` for positive diagnostic theory): region participation, interregional compensation, fiscal authority/implementation, public budget, national carbon policy and actual instruments. Explicitly justify why a purely positive reaction theorem warrants a full paper or narrow research note at Stage 7.5.
- Existing introduction uses the normative word "Should a local government match that support, retreat, or respond through a different instrument?" That question is **not answered as welfare-optimal policy** by a conditional best response. It should be rewritten as a positive-strategic question unless normative theory is actually supplied. This is an editorial completeness warning, NOT a separate Stage-7 mathematical blocker beyond W1.
- **Baseline-only**: fix benchmark definition, limit prescriptions; lowest repair cost.
- **One minimal extension**: full four-policy planner with asymmetric/monopoly possibilities plus regional participation, or well-defined exogenous reform-to-simultaneous policy NE comparative statics. Might be economic novelty, but requires rollback and independent novelty test; DO NOT add by default.
- **Note**: present unique-crossing positive theorem with sharp limitations, omit unsolved broad normative policy design.

## 11. Evidence ledger
| Claim | Independent attack | Evidence path | Result and remaining scope |
|---|---|---|---|
| Exact CS and local W | primitive utility/CS derivation and model reconstruction | `sections/model.tex`; `audits/stage7_exact_planner_counterexample.py` | baseline verified, no global carbon cost |
| Selected cooperative welfare | independent 2-variable exact rational FOC and concavity | `audits/stage7_exact_planner_counterexample.py` | **valid restricted** optimum |
| Unrestricted planner characterization | exact asymmetric monopoly admissible policy under true continuation | same script; `sections/equilibrium.tex` | **FAIL**: 10.158 > 3.720 |
| NE–coordination welfare wedge | independent primitive direct-payoff finite differences at theta=.9 | stage7 audit numeric log here + source file `sections/welfare.tex` | non-transfer cross externality, selected NE only |
| Bertrand/local ownership portability | fresh independent symbolic stage2 + gov Hessian | `audits/stage7_independent_local_robustness.py` | sign change local, no global robustness |
| Local policy institutional bridge | original METI, OECD, Japanese MOE sources | URLs above | national program/local aims established; prefectural autonomous instrument-pair unverified |

## 12. Formal verdict / earliest rollback / stop contract
**CONDITIONAL GO — W1 ONLY: ERRONEOUS UNRESTRICTED PLANNER BENCHMARK CLAIM.**
- Earliest affected stage: **Stage 7**. Core Stage 4A and Stage 6 mathematical claims remain frozen and unaffected as of this audit.
- Minimum required action: make `eq:planner` and related language explicitly constrain `s_A=s_B`, `h_A=h_B` (and correctly label two-active symmetric benchmark); preserve W1 as permanent regression and ensure manuscript states no global social optimum proof.
- Required check: run `audits/stage7_exact_planner_counterexample.py` and main existing `scripts/verify_stage7_postrepair.py` after manuscript-only benchmark correction; scrutinize references elsewhere to unrestricted planner maximization.
- If authors instead assert a fully unrestricted planner solution, they must actually certify its entire piecewise global optimum and welfare-selection implications; that is NOT currently authorized by the narrow Stage-7 repair.
- Stage 7 cannot GO TO STAGE 7.5 until W1 is resolved and logged. After repair, Stage 7.5 must make an **independent editorial-value decision** without importing earlier automatic GO judgments. Its main concern is whether a narrow conditional policy-BR derivative offers consequential economic understanding beyond known LQ models and whether the introduction's implied prescription is adequately answered by positive theory.
