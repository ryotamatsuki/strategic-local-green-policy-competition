# Stage 4 — Exact Minimal-Model Result: Local Consent versus Aggregate Green-Policy Coordination
Date: 2026-10-12 (JST)
Experimental branch: `research/stage3-green-policy-local-consent-2026-10-12`
Scientific evaluation: **GO → Stage 4A independent mathematical attack (conditional on the below tightly scoped theorem)**.
**NOT** a Stage-6 novelty PASS, a paper-length editorial GO, Stage-8 refreeze, or a submitted result.

## 1. One change, exact question
Original three-stage local green-policy game and all firm/investment/Cournot primitives are unchanged. Let `z=(s_A,h_A,s_B,h_B)>=0`; firm investment/quantity continuation includes five disjoint regimes D, A kink, B kink, A monopoly, B monopoly. Let `W_i(z)` denote the induced regional objective.

Two cooperative institutions are compared:

- **U (unrestricted aggregate coordinator)**: maximize `W_A(z)+W_B(z)` over all four nonnegative policies with original full continuation;
- **C (no-transfer voluntary regional coordinator)**: maximize same sum subject to **both** inequalities `W_i(z)>=W_i(z^{NE})`; `z^{NE}` is the *exhibited* canonical symmetric noncooperative SPNE, not an all-equilibria claim. No monetary side payment is allowed. If no agreement, outside option is `z^{NE}`.

Original fixed firm locations and exact W_i remain. **Firm exit here means output=0, not relocation**. Contract enforcement conditional on unanimous consent is *assumed*, not endogenized.

## 2. Theorem 1 — Exact canonical global contrast at theta=9/10
At rational primitives
`(kx,kg,mu,nu,kappa,d,e,beta,xi,m,Ebar)=(4,18,9/10,6/5,4/5,2,11/10,17/10,1/10,2,0)`, `theta=9/10`, `R=59/200`:

**(a) U** has **exactly two** global welfare-maximizing policy profiles (symmetry-equivalent): one in the A-monopoly region and the swap in the B-monopoly region. A-monopoly profile is
`(s_A,h_A,s_B,h_B)=(11078064/362551,6458100/362551,0,0)`, with
`W_A+W_B=3691600/362551≈10.182291594837691`.
The A-monopoly feasibility inequality `theta*w_A-(2-R)*w_B=688955377/36255100>0` is *strict*. The hosting region's welfare is approximately **-43.151922**, the no-plant region's welfare **+53.334214**. This is a Kaldor–Hicks aggregate ranking, **not** a Pareto improvement.

**(b) C** has a **unique** globally maximizing policy profile, which is symmetric and has both firms active:
`s_A=s_B=820073054520/181241003453≈4.5247655823`,
`h_A=h_B=579742914900/181241003453≈3.1987403725`,
`W_A+W_B=674272009120/181241003453≈3.720306091192297`.
At this selected agreement each region obtains `W_i=337136004560/181241003453≈1.8601530456`, strictly above the exhibited status-quo NE's `W_i^{NE}≈1.0934759123`.

**(c) Every cooperative policy under which either firm's equilibrium output is zero violates the hosting region's individual rationality inequality.** In particular this includes the **limit-pricing kink**, not merely the strictly monopolistic investment continuation. Thus only two-active-firm policies can be voluntarily agreed without side payments for this rational witness.

**(d) Strictness**: all critical welfare gaps, firm-regime inequalities, participant slack and positive-policy inequalities are strict. Thus the **same qualitative U monopoly / C duopoly contrast survives on a sufficiently small nonempty open neighborhood of theta=.9 and canonical structural primitives**, subject to continuous preservation of the selected symmetric SPNE outside option and local strict concavity. Do not claim full theta in [0,1] or all government equilibria.

## 3. Five-region global welfare proof
Within each of the five regions, the fully substituted `W_A+W_B` is a four-dimensional quadratic function. All five Hessians are **strictly negative definite** at canonical theta=9/10, certified by exact positive leading principal minors of `-H` (Sylvester criterion). Therefore each region's welfare is bounded ABOVE by the unconstrained R^4 stationary quadratic maximum, whether or not that point lies inside the regime's polyhedron.

| Downstream regime | Exact *unconstrained quadratic upper bound* on W_A+W_B | Decimal |
|---|---|---:|
| Both operate (D) | `674272009120/181241003453` | 3.720306091 |
| A/B limit-pricing kink (AK/BK) | `75653929312/18482408001` | 4.093293975 |
| A/B monopoly (AM/BM) | `3691600/362551` | 10.182291595 |

The A-monopoly stationary point is itself **nonnegative and strictly inside the relevant A-monopoly regime**; hence its upper bound is attained. Because `10.182291595>4.093293975>3.720306091`, it is the **true unrestricted GLOBAL optimizer**, even accounting for both kink boundaries, both monopoly regions and all nonnegative-policy corners. No finite numerical box is imposed. Each regional quadratic maximum is unique, and strict inequalities rule out other regimes; A/B swaps yield the only two unrestricted cooperative optima.

All five Sylvester exact minors, KKT solutions and rational inequalities appear as executable assertions in `research/stage4_global_consent_exact_certificate.py`.

## 4. Exact no-exit participation exclusion — including kinks
With q_B=0 and A active in the full original investment game,
`u_A=x_A+mu*g_A-(mu/k_g)s_A`, `q_A=(w_A+u_A)/2`.
- On **A monopoly**, `u_A=R*q_A`.
- On the distinct **A kink**, `u_A>=R*q_A` (and also has an upper bound not needed here).

We use a **larger** set containing both regimes: `s_A,h_A,u_A>=0`, `u_A-R*q_A>=0`, without applying all the downstream regime constraints.

Hosting-region welfare `W_A^{host}` is strictly concave as a quadratic in `(s_A,h_A,u_A)`. Exact Sylvester positive leading minors of `-H_{host}` are:
`101989/1620000`, `1330943/64800000`, `128977/2506320`.

Its global maximizer over the relaxed set is attained at
`s_A=10484064/2071201`,
`h_A=3635100/2071201`,
`u_A=R*q_A`,
with exact value `1753200/2071201≈0.8464654082341598`.
The lower-face KKT multiplier on `u_A-R*q_A>=0` is
`177112000/122200859>0`; all three exact KKT equalities hold.
Hence **all** A-active/B-inactive continuations (monopoly or kink) satisfy
`W_A<=1753200/2071201`, irrespective of B's nonnegative policy, and symmetrically for B hosting.

The preagreement selected canonical policy SPNE welfare is exactly
`W_i^{NE}=2129482118801677362193413324880/1947443098557072400775535945289≈1.09347591227671`.
Exact positive gap:
`W_i^{NE}-W_{host}^{max}=996328253553893621212690252624106080/4033546093174506913558690825418522089≈0.24701050404255`.

Thus host regional IR **necessarily fails** whenever the other firm's output is zero. For participant-feasible policies, the continuation **must remain inside the two-active-firm (D) region**. On D, the full joint-welfare quadratic Hessian is strictly negative definite, and its unconstrained R^4 stationary maximum is the displayed symmetric coordinator. It is admissible and **strictly satisfies both IR constraints**. Therefore this is also the **unique global C optimum**, with no numerical branch/selection gaps.

## 5. Rivalry-dependent symmetry-breaking: additional exact finite-point result
For theta=3/10 or theta=1/2, the symmetric restricted-duopoly cooperative stationary policy is **not** a global voluntary coordinator optimum, because a concrete asymmetric, nonnegative, two-firm-active policy *strictly* improves total welfare **and** satisfies both individual participation constraints.

Write symmetric candidate `(s_C,h_C,s_C,h_C)`. Perturb to
`(s_A,h_A,s_B,h_B)=(s_C+1/10,h_C+1/20,s_C-1/10,h_C-1/20)`.

- At theta=3/10, exact gain over the symmetric-coordinator welfare is
`22617173/4841870418000 > 0`.
- At theta=1/2, exact gain is
`172856/8002000125 > 0`.
- In BOTH cases, four policy controls remain positive, two-active inequalities are strictly satisfied, and both participant welfares are **strictly greater** than the exhibited policy SPNE outside option.

The symmetric-policy restricted coordination quadratic is strictly concave, so no OTHER symmetric policy can be better than `(s_C,h_C)`; hence **no symmetric global voluntary cooperative maximizer** exists at these two theta values (should one exist in the unrestricted consent-feasible domain). This is an exact *symmetry rejection certificate*, **not** a proof of the globally optimal asymmetric policy or a unique transition threshold.

### Curvature explanation
The symmetric/antisymmetric government-policy variation separates analytically. At the canonical other primitives, the antisymmetric-mode Hessian determinant has exact rational form

`det H_minus(theta)=[484600 theta^6 -711835 theta^5 -3638491 theta^4 +4725480 theta^3 +7413288 theta^2 -7512560 theta +1450204]/[810(50 theta^3 -100 theta^2 -200 theta +341)^2]`.

Exact polynomial root counting on `(0,1)` gives TWO roots `theta≈0.2832354490` and `0.5535360764`. The upper-left entry of `H_minus` is negative on the whole interval (its numerator has zero roots there). Between these roots the determinant is negative, so the symmetric cooperative stationary point is **unstable to an antisymmetric local policy direction**, when feasibility and consent inequalities are slack. At theta=.9 the D welfare Hessian is negative definite across all 4 policies.

**Do not equate this two-root LOCAL CURVATURE calculation with the true constrained planner's unique global switching threshold.** The consent feasible set and downstream kink/monopoly regions can change global optimum topology. Proof of a unique global coordination-regime threshold is deferred.

Proof/regression: `research/stage4_asymmetric_duopoly_rivalry_witness.py` (exact finite-point counterfactual).

## 6. Economic mechanism and nontrivial model content
This is no longer merely a conditional own-government BR slope:
- TOTAL aggregate-welfare coordination may choose intentional market-exit/production concentration for the sake of integrated consumer benefits, despite enormous concentrated regional target and fiscal burden.
- The host region vetoes such aggregate-surplus maximizing concentration under **individual participation** without interregional side payments.
- Feasible cooperation can be mutually welfare improving and retain both regional firms.
- Product rivalry changes which **within-duopoly cooperative policies** are locally preferable: at .3/.5 symmetry is dominated by feasible asymmetric policy, at .9 consent-constrained global optimum is uniquely symmetric.
- Strict inequalities establish nonempty local neighborhoods; **general primitive necessary/sufficient conditions and broad functional form robustness are NOT established**.
- Central/full model and nested benchmarks (no-x, mu=0, generic public input) have NOT yet been matched. No claim that dual private investments are necessary for the above.
- In the original game locations remain fixed. 'Market exit' is zero equilibrium output, not physical relocation. The model permits a subsidized inactive firm's green investment and negative reduced-form emissions under off-path policies; this is a real model interpretation limitation, not a measured fact.

## 7. Mandatory harsh predecessor absorption WARNING
The central no-transfer consent vs aggregate optimum logic is **not conceptually new**:

- **Markusen, Morey and Olewiler (1995)**, *Competition in regional environmental policies when plant locations are endogenous*, *Journal of Public Economics* 56:55–77, **Section 4 Cases I–III**, explicitly compare cooperative and noncooperative multi-region plant structures and discuss when **side payments are required** to sustain cooperative concentration. Case III explains that the no-plant region would pay the host to achieve a cooperative outcome. Accessible full-text evidence: https://www.researchgate.net/publication/223035523_Competition_in_Regional_Environmental_Policies_When_Plant_Locations_Are_Endogenous , notably text around pp.67–68, 71 and 73–75.
- **Fenge, von Ehrlich and Wrede (2009)**, *Public input competition and agglomeration*, *Regional Science and Urban Economics* 39:621–631, establish that central efficient infrastructure can concentrate production for symmetric regions, whereas decentralized public-input competition can support dispersion. https://doi.org/10.1016/j.regsciurbeco.2009.04.003
- **Martín-Herrán, Martínez-García and Morales (2026)**, *The Impacts of Environmental Policy on Industrial Allocation: A Transboundary Pollution Dynamic Game*, *Environmental and Resource Economics* 89 article 24, address environmental policy and industry allocation but in a dynamic footloose-capital model. https://doi.org/10.1007/s10640-026-01079-0

Thus **T1 alone has HIGH RISK of theorem-level or economic-message absorption** even though its algebra and exact kink-global proof are valid. Merely adding 'green' or dual R&D to a known consent/plant concentration result is inadequate. Candidate distinctness may lie in the **within-duopoly rivalry-dependent symmetry-breaking** in a no-transfer consent problem, but the exact finite cases and Hessian roots alone do not establish a genuinely new full-paper theorem; broader fiscal competition/general LQ theory may also absorb it. The **Stage-6 novelty kill must be adversarial and may return NO-GO**.

## 8. Correct role, next work and restrictions
- This Stage 4 result is **mathematical construction + exact internal certificate**, not independent scrutiny. **Stage 4A now mandatory**: independently rebuild both objective/regime formulas, verify monopolistic-host KKT envelope at kink including suppressed rival's firm investments, adversarially search for any missed 6th regime, prove open primitive neighborhood and exactly what is meant by outside-option NE selection.
- Then Stage 5 and Stage 6 must search parent games that allow abstract LQ welfare objectives, zero-output regimes and voluntary cooperation. Re-open and compare Markusen 1995 at **specific result/lemma** level. Do not confuse different microfoundations with theorem novelty.
- Stage 7 must revise welfare/distribution interpretation of old paper **only in the new research branch**. Frozen original result preserved.
- Stop if Stage 6 finds T1/T2 immediately absorbed or no additional economic understanding. Do **not** insert new fiscal instruments, transfer budgets, entry fees or arbitrary constraints to manufacture novelty.
- Existing `main` and earlier theory freeze remain unchanged. This research branch does **not** imply a new full-paper Stage-7.5 GO.

**CANONICAL STAGE-4 VERDICT:** `GO → STAGE 4A INDEPENDENT MATH RED-TEAM` for the one-institution, canonical-global consent contrast and the finite-point symmetry rejection. Subsequent novelty is **UNRESOLVED AND HIGH RISK**.
