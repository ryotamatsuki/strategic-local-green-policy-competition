# Stage 4 Reopened — N1 Global Symmetry-Selection and Nested-Model Theorem
Date: 2026-10-12 JST
Branch: `research/stage3-green-policy-local-consent-2026-10-12`
Original mathematical source: `research/STAGE4_GLOBAL_CONSENT_THEOREM_2026-10-12.md`
Stage-6 blocker: `audits/STAGE6_LOCAL_CONSENT_HOSTILE_NOVELTY_2026-10-12.md`, N1.
**Verdict: GO TO NEW STAGE 4A MATH RED-TEAM (NOT STAGE 6/7/8), conditional on external independent re-execution.**
Method: independent exact-rational reconstructions in SymPy; no constraints or new policy/investment instruments added. Current code: `research/stage4_n1_global_symmetry_exact.py`; local equivalent `/tmp/n1_exact.py` was executed and passed. GitHub hosted CI not yet run.

## Research question and exact qualified theorem
Consider original three-stage two-region differentiated Cournot game with subsidy `s_i>=0`, public productive infrastructure `h_i>=0`, endogenous conventional and green firm cost-reducing investments and nonnegative firm outputs. The new Stage-3 institution is only a hypothetically enforceable no-transfer joint policy agreement subject to **each region's modeled welfare exceeding its selected exhibited symmetric Stage-1 SPNE outside option**. Jointly maximize `W_A+W_B` over all four nonnegative government policies subject to two regional participation inequalities, with the **complete five-regime** private investment and Cournot continuation. Locations are fixed: one-firm operation means **zero output**, not plant relocation.

Fix baseline rational primitives
`(kx,kg,mu,nu,kappa,d,e,beta,xi,m,Ebar)=(4,18,9/10,6/5,4/5,2,11/10,17/10,1/10,2,0)`.
At each of the following rational product-substitutability parameters:
- `theta=1/10`: unique GLOBAL participant-feasible joint-welfare maximizing policy is **symmetric**, with total W `14.284251882667755`.
- `theta=3/10`: at least one GLOBAL participant-feasible optimizer exists and **every** global optimizer is **asymmetric**; symmetric-coordinator upper welfare `8.719747818398718` is **strictly dominated** by a positive-policy, dual-output, both-IR-feasible asymmetric deviation (strict exact gain `22617173/4841870418000`).
- `theta=1/2`: same global-existence + **every global optimizer asymmetric**; symmetric coordinator W `6.162294126447622`, exact gain `172856/8002000125`.
- `theta=7/10`: unique GLOBAL participant-feasible joint-welfare maximizing policy is **symmetric**, W `4.695337607723726`.
- `theta=9/10`: unique GLOBAL participant-feasible joint-welfare maximizing policy is **symmetric**, W `674272009120/181241003453≈3.7203060912`, as previously Stage-4A certified.

Every assertion at these **five** rational points is strict where needed. Continuity of the corresponding local comparison and coercivity certificates gives nonempty open `theta` intervals around **each point** with the same symmetric vs necessarily-asymmetric classification (the selected outside option continues as an exhibited SPNE under the previously certified baseline). **No claim of a unique global threshold, exact transition positions, unique asymmetric optimizer, or same symmetry across all theta**.

Exchange symmetry entails reflection-equivalent distinct global maximizers wherever all maximizers are asymmetric, but their total number and policies are not characterized; **multiplicity of the IR-coordinated optimum cannot be misreported as uniqueness**.

## Stage-4 newly proved existence lemma for theta=.3/.5 (formerly missing)
At each rational theta, under the complete branch-specific government policy continuation, aggregate welfare is piecewise quadratic over the nonnegative policy orthant with five regimes: dual-active `D`, A/B kink, A/B monopoly.

- Kink and monopoly branches have **exact negative-definite 4x4 Hessians**, so their objective functions are coercive on the unbounded nonnegative policy domain (and have finite quadratic upper bounds).
- Duopoly `D` at .3/.5 has one POSITIVE Hessian eigenvalue in the unrestricted signed policy space, **so the previously attempted global concavity approach is invalid there**. To prove coercivity on the economically admissible **nonnegative** orthant, let `H=∇²F_D` and define `H^+` by keeping diagonal entries unchanged and replacing each **negative off-diagonal** entry with zero (retaining positive offdiagonals). For any nonnegative `z=(s_A,h_A,s_B,h_B)`, `z'H z <= z'H^+z`. Despite the indefiniteness of H, the exact Sylvester leading principal minors of `-H^+` are strictly positive at both rational theta values. Therefore `F_D(z)->-infinity` as `||z||->infinity`, z>=0.
- Because all five continuation branches are uniformly coercive, their continuous piecewise aggregate objective `F` is coercive globally and attains its maximum over any nonempty closed feasible set. The **regional IR feasible set is closed** and includes at least the exhibited pre-agreement SPNE, so a GLOBAL no-transfer cooperative maximum exists.
- Under symmetric policies `s_A=s_B=s, h_A=h_B=h`, both firms must be active; the two-policy restricted objective has a **strictly negative-definite Hessian**, so its unique positive maximizer bounds ALL symmetric feasible cooperation policies.
- The explicitly displayed feasible asymmetric perturbation `(s_C+.1,h_C+.05,s_C-.1,h_C-.05)` strictly exceeds this ALL-symmetric upper bound, with strictly positive IR gaps and both output quantities positive. Thus no globally optimal no-transfer cooperative policy can be symmetric.

**Exact anti-copositivity-guard minors** of `-H^+`, theta=3/10:
`18291540597451097/284194370988452925`,
`1321139394472162259/295562145827991042000`,
`24165674868879515364297937601548123/83997098121583310109787832338697850000`,
`1745409299626271557672799290823983081/87356982046446642514179345632245764000000`.
At theta=1/2:
`11015043407975/171967527822321`,
`17418658927855/2751480445157136`,
`191867284199034098856643625/473165290005131955464733232656`,
`1349485024077001417399022567525425542268733664573025/34123668901941872640070340888815641787832224126641643776`.
All positive. These rational certificates are preserved in the SymPy reproducer; NO arbitrary finite numerical policy cap is used.

## Distinct nested-model counterfactual: BOTH firm-investment margins matter here
Use **exact same remaining primitives, original two policy instruments, same regional W and selected-outside-option definition**, while one at a time removing:
- `mu=0`: green investment still reduces territorial emissions but DOES NOT improve firm marginal costs; conventional R&D remains, `1/kx=1/4`.
- `1/kx=0`: conventional private R&D is absent (the regular limiting economy `kx->infinity`), green investment remains productivity-enhancing with `mu=9/10`, `kg=18`.

At **both theta=3/10 and 1/2**, each corresponding reduced model has a **UNIQUE GLOBAL PARTICIPATION-FEASIBLE SYMMETRIC** cooperative maximizer, unlike the full model where every global optimum is asymmetric.

This stronger comparison has full-game, not just local-Hessian evidence:
1. In either reduced model the **entire 4D active-duopoly joint-welfare quadratic Hessian is negative definite** (strict exact Sylvester inequalities), and its unconstrained maximum is positive-policy, active-duopoly, symmetric and gives both regions strictly more than their separate selected outside option.
2. All one-firm-output policies, including the limit-pricing kink, are excluded by the same exact hosting-region upper-envelope approach as the baseline. For `mu=0`, `sup W_host=175320/284107≈0.617091448`, below regional NE W `1.419451752` (theta .3) / `1.252640236` (.5), with positive exact KKT multiplier `408080/284107`. For no conventional R&D, the host quadratic is **negative semidefinite** (one flat direction), yet the exact first-order stationary point and nonpositive Hessian certify global host upper bound `1361200/1330943≈1.022733505`; below selected NE regional W `1.913312477` (.3) and `1.682048520` (.5). **Do not copy strict 3D host concavity into the no-x case.**
3. At both theta values, the symmetric matched own-government policy profile is verified to be a **GLOBAL best response** in these reduced models, not just a local-duopoly FOC: with nonnegative own policies, the rival monopoly/kink regions are inaccessible; within D own government's 2D quadratic is strictly concave and is maximized at the symmetric policy; A-monopoly own-policy unrestricted quadratic upper bound is strictly below the candidate NE welfare; A-kink own-policy unrestricted quadratic upper bound is likewise lower. In no-x A-kink the own quadratic is singular because it is independent of own subsidy; maximizing over h alone gives a strict upper bound. Therefore each nested outside option is a legitimate exhibited policy NE.
4. Since host veto excludes all firm-exit outcomes and the active-duopoly aggregate quadratic is globally strictly concave, the exhibited **symmetric** active-duopoly coordinator is the UNIQUE IR-feasible global maximizer.

Numerical welfare diagnostics (the underlying inequalities were checked as exact rational values):
| Model | theta | Selected regional outside option | Host welfare ceiling | Unique global IR cooperative welfare / form |
|---|---:|---:|---:|---|
| full | .3 | 1.941477 | 0.846465 | W>=8.719748, **necessarily asymmetric** |
| full | .5 | 1.644562 | 0.846465 | W>=6.162294, **necessarily asymmetric** |
| mu=0 | .3 | 1.419452 | 0.617091 | W=4.747943, **symmetric** |
| mu=0 | .5 | 1.252640 | 0.617091 | W=3.915842, **symmetric** |
| no-x | .3 | 1.913312 | 1.022734 | W=5.877045, **symmetric** |
| no-x | .5 | 1.682049 | 1.022734 | W=4.612396, **symmetric** |

The baseline rows' displayed lower bound is the **symmetric restricted value**, so the strict feasible asymmetric witness actually gives slightly more. These models have different maximum values and welfare normalizations *because different physical investment opportunities are removed*. Do **not** compare welfare LEVELS across models as a policy welfare ranking; the meaningful comparison is the **optimal-policy symmetry class** at the same surviving original parameters.

## Economic interpretation, genuine scope and threats
At the selected canonical primitives, dual cost-reduction channels make specialization of green subsidy and productive public input across otherwise identical jurisdictions jointly welfare-improving in an intermediate rivalry range while preserving both regions' voluntary consent and both firms' operation. With either conventional R&D or green-investment productivity removed, welfare-optimal consensual policies remain symmetric in this range. At lower theta=.1 and higher theta=.7/.9, the full economy also prefers a symmetric package. Thus this is an exact **reentrant symmetric → asymmetric → symmetric voluntary-coordination pattern** (for finite rational points and open neighborhoods), not just the previous generic 2x2 antisymmetric-Hessian story.

**Novelty risk remains serious.** The full proof uses classic exchange-invariant quadratic and active-set logic, and published fiscal competition, strategic R&D, regional consensus and tax harmonization papers already show many nonmonotone/asymmetric policy patterns. Merely showing that two margins matter in one matched parameter vector does not prove a full-paper field contribution or universal necessity. The economic welfare gain of the displayed asymmetric perturbation is very small: `4.67e-6` at .3, `2.16e-5` at .5 model units. The globally optimal asymmetric welfare gain is not independently characterized exactly. The selected noncooperative outside equilibrium is certified for baseline by prior Stage-4A; no all-government-policy-equilibrium-selection theorem is proved.

**No claim** of unique symmetry switching threshold; more than one transition possible and local Hessian roots `.283235`, `.553536` are not automatically the global policy regime boundaries. No implementation, fiscal-cost calibration, incentive-compatible proposal/acceptance, national vs prefectural legal authority, real climate damage or physical plant relocation theorem is established. Consent is the inequality constraint of an assumed enforceable contract, not an endogenous treaty Nash equilibrium.

## Formal Stage-4 result classification
- `T2-N1a`: at theta=.1,.7,.9 unique symmetric GLOBAL regional-IR cooperative optimum — **exact rational theorem**, preagreement selected policy SPNE qualification.
- `T2-N1b`: at theta=.3,.5 global regional-IR cooperative maximizer **exists**, all such maximizers are necessarily asymmetric; at least two reflection-distinct optimizers — **exact rational coercivity + feasible strictly improving policy theorem**; their exact levels and complete policy correspondence unproved.
- `T2-N1c`: two nested limiting economies mu=0, no-x have **unique symmetric GLOBAL regional-IR cooperative optimum** at theta=.3,.5 with certified respective global noncooperative outside options — **exact rational full-game comparison**.
- `T2-N1d`: disjoint nonempty theta-open neighborhoods around these five fixed rational points inherit the corresponding qualitative symmetry types by continuity and strictness, with exact original selected outside SPNE — **local existence argument**, no explicit neighborhood endpoints.
- `T2-N1e`: strong point-to-point **nonmonotonic policy symmetry** and matched full-game nested-model separation — **candidate economic theorem**, novelty not certified.

## Stage 4 decision / next contract
**Stage 4 GO → Stage 4A INDEPENDENT MATH RED-TEAM, then repeat Stage 6 HOSTILE NOVELTY RE-KILL.** Stage 5 may log the new theorem's frozen economic limits but must not add new ingredients. Stage-4A priority:
- independently verify the **copositive majorant** and strict-coercivity passage from 5 branch quadratics to the unbounded nonnegative union, including correct signs of all cross coefficients;
- re-derive both nested `mu=0` and no-x full policy NE, host-veto bounds including limit-pricing, and strict D concavity;
- test whether a **hidden one-firm output regime** survives in no-x when `kx->infinity` and the reduced private-investment constraints are used;
- reproduce symmetric-to-asymmetric-to-symmetric intervals and all IR gaps without copying selected producer results;
- rigorously separate 'symmetric policy is globally dominated' and 'the actual asymmetric optimal policy is characterized'; no unique theta threshold theorem.
- assess policy significance versus Markusen 1995 / Fenge 2009 / Leahy–Neary 2009 / Baldwin–Krugman 2004 / Suga–Yanase–Tawada 2026. The results warrant reexamination but **do not** override prior Stage-6 CONDITIONAL GO or Stage-7.5 editorial full-paper NO-GO without independent novelty/value gates.

Only this research branch has changed. Do not merge or rewrite historical theory freeze from these Stage-4 calculations.
