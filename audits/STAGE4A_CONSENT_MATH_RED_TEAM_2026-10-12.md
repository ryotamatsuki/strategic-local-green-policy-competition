# Stage 4A — Independent Mathematical Adversarial Certification of Voluntary Local Consent
Audit date: 2026-10-12 (JST).
Research branch: `research/stage3-green-policy-local-consent-2026-10-12`.
Producer Stage 4: `research/STAGE4_GLOBAL_CONSENT_THEOREM_2026-10-12.md`.
Workflow authority: `research-paper-workflow` v2.8 `templates/STAGE_04A_MATH_RED_TEAM.md`, `checklists/THEOREM_CERTIFICATION_CHECKLIST.md`, `checklists/EQUILIBRIUM_CONTINUATION_CHECKLIST.md`.
Evaluator: GPT-6 clean-room-reconstruction attempt, **same AI service**, not a distinct human referee. Explicit input exposure: complete original primitive game plus existing Stage-4 proposed mathematical conclusions, and ultimately the producer source code. Full blinding was impossible. Independence in the evidence means independently reconstructed equations and quadratic matrices, transformed symmetry/antisymmetry coordinates, and a **separate scalar-firm unilateral best-response solver**. Do not count mere rereading producer asserts as an independent test.

## Canonical verdict
**GO — MATHEMATICAL ADVERSARIAL CERTIFICATION PASS**, for a carefully limited theorem:
- one **global** unrestricted aggregate-welfare coordinator result at **canonical rational primitives, theta=9/10**;
- one **global** no-interregional-transfer voluntary agreement maximizing the same aggregate objective **subject to two explicitly defined participation constraints** relative to the **exhibited** symmetric policy SPNE;
- exclusion of both one-firm-active monopoly and kink continuations by exact host-welfare bound;
- two **finite-theta asymmetric-improvement witnesses** at theta=3/10 and 1/2; unique global symmetric voluntary optimum at 9/10;
- local qualitative open-parameter robustness by continuity and strict gaps, NOT a global theta-dependent unique phase-transition theorem and NOT all-equilibrium-selection invariance.

No new mathematical counterexample or profitable deviation was found. This is **not** a Stage-6 novelty certification or Stage-7.5 editorial-value GO. The producer has to keep the exact quantifiers below.

## 1. Frozen primitives and domains
Two jurisdictions A,B; complete-information 3-stage government s,h >=0, firms x,g>=0, Cournot q>=0; original technologies `c_i=c-x_i-mu*g_i-nu*h_i`, cost `kx*x²/2+kg*g²/2`, emissions `e*q-beta*g-xi*h`, local welfare `CS/2+PS_i-kappa*h_i²/2-d(E_i-Ebar_i)²/2`. Demand inverse `p_i=a-q_i-theta*q_j`. Scalar private innovation coefficient `R=1/kx+mu²/kg`, `w_i=m+(mu/kg)s_i+nu*h_i`.
All primitives fixed to exact rational canonical `(kx,kg,mu,nu,kappa,d,e,beta,xi,m,Ebar,theta)=(4,18,9/10,6/5,4/5,2,11/10,17/10,1/10,2,0,9/10)`. The set of local-government policy actions is `R_+^4` with no artificial upper policy bound. The national agreement is an **imposed enforceable objective** with two local IR constraints, not a new voluntary-policy-formation strategic Nash equilibrium. Preagreement payoffs use the existing selected symmetric SPNE; government policy-equilibrium uniqueness generally **NOT claimed**.

## 2. Independent continuation and large deviation attack
Reconstructed firm scalar effective investment `u_i=x_i+mu*g_i-(mu/kg)s_i>=0`. For fixed rival investment u_j, the firm globally maximizes `q_i²-u_i²/(2R)` over `u_i>=0`, plus a constant independent of u_i. Direct nonnegative Cournot response evaluated by:
- zero production if `2(w_i+u_i)<=theta(w_j+u_j)`;
- two-active Cournot quantity `[2(w_i+u_i)-theta(w_j+u_j)]/(4-theta²)` if interior;
- sole-active monopoly output `(w_i+u_i)/2` if `2(w_j+u_j)<=theta(w_i+u_i)`.
An independently written segmentwise scalar maximization found no profitable unilateral investment deviation on **300 random nonnegative government-policy histories** over theta .1,.3,.5,.9,1; all five regimes appeared. The maximum numeric payoff improvement was `3.41e-13`. Additional **18 targeted histories** at the exact and ±1e-8 sides of duopoly/kink and kink/monopoly A-frontiers at theta .3,.9,1 likewise yielded none. B-frontiers covered by random histories and symmetry. No unresolved continuation or numeric failure in these tested histories.
Permanent reproducibility path: `audits/STAGE4A_CONSENT_CLEANROOM_INVESTMENT_CHECK_2026-10-12.py` (Python stdlib, separately coded segmentwise global best responses); output above came from independently executed Python equivalent in auditor environment, but the committed file itself has **not** been exercised in a hosted CI run. Existing full analytic firm continuation is also grounded in original `sections/equilibrium.tex`; do not substitute finite tests for this analytic game certificate.
At regime boundaries the K/D and M/K expressions coincide for output and effective investment, so a change in branch label is not a new choice of product-market allocation or producer welfare. With positive quadratic investment costs, off-path zero-output firm has unique `u=0` for given positive subsidy and chooses `g=s/kg`; its investment expense and induced emissions target cost remain counted in W.

## 3. Independent full planner quadratic reconstruction
Derived each region's affine output/investments from primitives and substituted directly into the two government's welfare functions. Each of the 5 region-specific total-W Hessians is **strictly negative definite** at theta=.9; independent double-precision eigenvalues of the three distinct matrices:
- D: `[-1.10398208,-.31611554,-.05433015,-.03274984]`;
- A kink: `[-26.05877666,-.36979136,-.07307781,-.03546853]`;
- A monopoly: `[-.82047758,-.264975,-.07291748,-.01452682]`.
More importantly, `audits/STAGE4A_CONSENT_INDEPENDENT_CERTIFICATE_2026-10-12.py` verifies this via exact rational Sylvester principal minors, so eigenvalues are not the sole certificate.

All-zone *unconstrained quadratic suprema*, which are valid upper bounds even when the stationary point is not inside the actual polygonal regime:
| region | upper bound exact | numeric |
|---|---|---:|
| both-active D | `674272009120/181241003453` | 3.720306091 |
| kink A/B | `75653929312/18482408001` | 4.093293975 |
| monopoly A/B | `3691600/362551` | 10.182291595 |

The globally largest **monopoly** free quadratic maximizer `(s_A,h_A,s_B,h_B)=(11078064/362551,6458100/362551,0,0)` is nonnegative and satisfies monopoly inequality with exact **strict positive** margin `688955377/36255100`; hence attains its unconstrained upper bound and dominates *all* policies in the other four regimes, including boundaries and arbitrarily high positive s/h. The reflected B-monopoly policy is equally optimal. Because each region's quadratic is strictly concave and remaining upper bounds are strictly smaller, these are the **only two** unrestricted coordinator global maximizers **at the symmetric canonical witness**.

**Nonfatal scope nuance found by adversarial audit:** at the monopoly optimum `s_B=h_B=0` the marginal derivatives of joint welfare with respect to these two inactive-jurisdiction policy controls are **zero**, not strictly negative. Strict complementarity of their lower-bound KKT multipliers therefore does NOT hold. Thus a claimed *strict KKT boundary margin* would be false. This is NOT a counterexample to global welfare maximum/uniqueness **at the fixed witness** (full quadratic is strictly negative definite). The open-neighborhood qualitative **market-regime** claim needs continuity and uniform strong concavity/gap arguments, not an assertion that the optimal excluded-region policies remain identically zero for every nearby primitive vector. E.g. asymmetric target perturbations can affect these boundary instruments. Keep the precise qualification in Stage 7.5A.

## 4. Independent host consent envelope, including limit-pricing kink
For any one-active-firm outcome with A producing and B inactive, define own reduced private cost investment `u_A` and `q_A=(w_A+u_A)/2`. The A-monopoly region satisfies `u_A=R*q_A`; in the **A limit-pricing kink** region `u_A>=R*q_A`.
Relax to the superset `s_A,h_A,u_A>=0`, `u_A-R*q_A>=0`. The exact primitive host objective, including **1/2 of integrated consumer surplus**, real investment and public-input expenses and local territorial target, is a strictly concave quadratic in 3 variables. Independently computed Hessian eigenvalues are `[-2.99186773,-.4631255,-.03713938]`; exact Sylvester minors are positive in the auditor artifact.

Its global constrained maximizer has `s_A=10484064/2071201`, `h_A=3635100/2071201`, `u_A=7810774/10356005`, with value `W_A^host,max=1753200/2071201 ≈0.8464654082`. The exact KKT multiplier of the inequality `u_A-R*q_A>=0` is `177112000/122200859>0`, and the FULL 3-dimensional gradient-plus-multiplier is identically zero. Thus no kink, boundary, or monopoly policy with B inactive achieves a higher *hosting-region* welfare, even after allowing rival-region arbitrary policies consistent with inactivity.

Selected canonical incumbent-SPNE outside-option welfare (exact rational):
`W_i^NE=2129482118801677362193413324880/1947443098557072400775535945289≈1.0934759123`, so **strict IR veto gap ≈0.2470105040**. By A/B symmetry all outcomes with only B active are likewise vetoed. Both inactive is impossible with m>0 and nonnegative policies and firm best responses.

## 5. Voluntary planner globality and multiplicity
Every policy meeting both regions' no-transfer IR must be in D (both firms active), by exact host veto above. D total welfare quadratic is globally strictly concave in the full 4D policy vector, and its R^4 maximizer is positive, D-feasible, symmetric, and makes both regions strictly better off than the exhibited SPNE. Thus it is **the unique GLOBAL welfare-maximizing policy among all IR-feasible coordinated policies** at this exact witness. The *underlying full strategy game* has not had its entire Stage-1 government equilibrium set proved unique; the reference outside option is **selected-SPNE conditional**. No unannounced equilibrium refinement was used.

Separate alternative-equilibrium / tie checks:
- Unrestricted coordinator at symmetric canonical primitives: **TWO** reflected global maximizers (A or B monopoly); result appropriately describes a two-element selection set, not uniqueness.
- Voluntary no-transfer coordinator: **UNIQUE** optimum over the specified modeled cooperative feasible set, proved via strict D convexity and complete exclusion of non-D regimes.
- Downstream investment/Cournot: uniqueness under original R<3/4; off-path q=0 firm's u=0 is unique; subsidy-driven `g=s/kg` is included.
- Regime-frontier tie labels do not create distinct investments/payoffs; source pieces coincide continuously.
- At cooperative optimum both IR inequalities are STRICT, so no acceptance-indifference tie is determining selection. At U monopoly the host strictly rejects the agreement absent compensation.
- The model does NOT analyze an endogenous contract proposal/acceptance game; no coalition-formation Nash equilibrium theorem was claimed, nor can one be inferred from the planner optimality conditions.

## 6. Rivalry/antisymmetry test, distinct from full global threshold
Independently diagonalized region-D welfare in **symmetric and antisymmetric policy coordinates**:
`s_A=S+du, s_B=S-du, h_A=H+dv, h_B=H-dv`.
Recomputed the 2x2 antisymmetric Hessian
`H_minus = partial²(W_A+W_B)/partial(du,dv)²`, not by reading producer's coefficient list.
Its exact determinant matches
`[484600*t^6 - 711835*t^5 -3638491*t^4 +4725480*t^3 +7413288*t² -7512560*t +1450204] / [810*(50*t³-100*t²-200*t+341)²]`.
Its upper-left numerator has **zero** roots on (0,1) and remains negative in the sign convention; the determinant numerator has exactly **TWO** roots on (0,1), `t≈.283235449022760` and `.553536076351933`. The symmetric-duopoly welfare stationary policy is therefore locally unstable along an antisymmetric direction in the open region between roots whenever the policy and IR inequalities are slack.
Independent direct-welfare perturbation by `(+.1,+.05,-.1,-.05)` around symmetric cooperative policies reproduced:
- t=.3: **positive** total welfare gain `22617173/4841870418000`; both local IR and the two-active firm inequalities strictly hold;
- t=.5: **positive** gain `172856/8002000125`; both local IR and D inequalities strictly hold;
- t=.9: that perturbation **reduces** total welfare (numerically by .0016549291); here the separate full 5-regime theorem establishes globally unique symmetric voluntary optimum.

These **finite-point** claims are PASS. Their generalization to a unique GLOBAL symmetry-breaking/restoration threshold for the IR-feasible planner is **NOT PROVED**, and must not appear as an established theorem. The two Hessian roots alone are not that global threshold. Existence of an asymmetric global IR optimum at .3/.5 was not proved through the perturbation; what was proved is that **a symmetric policy cannot be globally optimal** if a global maximizer exists (and the welfare of the symmetric restricted candidate is well-defined).

## 7. Open-neighborhood, indifference and quantifier restrictions
At the canonical witness there are strict total-welfare upper-bound gaps (U: monopoly vs other regimes), strict host-veto IR gap, strict D feasibility and both regional IR slacks at the voluntary coordinator, and negative definite Hessians. These continuous strict inequalities allow a sufficiently small neighborhood of primitives/theta in which **U still induces market exit and C stays in D** when paired with a continuously varying selected preagreement SPNE, provided uniform quadratic coercivity is maintained. Symmetric equality of the C's two jurisdictions is only guaranteed at symmetric primitive vectors; under asymmetric primitive changes policies generally become asymmetric. Similarly U's two mirrored maxima need not remain equal if symmetry is perturbed. No claim of globally unique government NE or all-selection independent feasibility is allowed. No full neighborhood radius is computed; sufficient continuity/proof arguments, not an explicit robust interval or general necessary/sufficient theorem.

The original environmental metric can become negative for an inactive subsidized firm (`E=-beta*s/kg-xi*h`). This is algebraically permitted by the reduced-form model; a physical nonnegative-emissions constraint would change the theory and requires fresh Stages 3/4/4A. The sign of the benchmark territorial welfare under aggressive unilateral concentration does not establish real-world climate policy feasibility.

## 8. Claims and certificate ledger
| ID | Exact status | Attacks and proof evidence | Valid limitation |
|---|---|---|---|
| T1-U canonical unrestricted total-welfare coordinator | **PASS, GLOBAL and exactly TWO symmetry-reflected optima** at theta=.9 | 5 Hessian exact Sylvester minors; regime-wise quadratic upper bounds; strict A-monopoly feasibility and nonnegativity; `audits/STAGE4A_CONSENT_INDEPENDENT_CERTIFICATE_2026-10-12.py` | only exact witness + qualitative local regime preservation; no unrestricted planner theorem for all theta/primitives |
| T1-C canonical voluntary no-transfer agreement | **PASS, globally UNIQUE optimum** of specified IR-constrained joint maximization | independent 3D host-envelope strict KKT incl kink; exact IR veto gap; D four-control Hessian and admissible maximizer; same independent script | conditional on **exhibited** noncooperative SPNE outside option, enforceable coordinator, no transfers |
| T1-exit elimination | **PASS all q_j=0 continuations** at theta=.9 | relaxed 3D KKT with positive bound multiplier and C host veto gap; off-path 300 +18 best-response checks | no necessity/general all-parameter theorem |
| T2-finite rivalry asymmetry | **PASS at t=.3,.5 (symmetry dominated) and t=.9 (unique symmetric C)** | independent substitution & exact welfare/IR inequalities; antisymmetric-Hessian factorization | **unique global transition threshold NOT CERTIFIED** |
| T3 dual investment necessary | **NOT CLAIMED / NOT APPLICABLE**; no nested benchmark yet | warning from earlier no-x result | any such claim must be separately Stage-4/6 checked |
| T4 all-government policy NE unique | **NOT CLAIMED / EXISTENCE ONLY** | existing Stage-4A math certificate for original symmetric SPNE; cooperative objective conditioned on it | alternative NE not globally excluded |
| Institutional implementability as coalition Nash | **NOT CLAIMED** | neither bargaining nor commitment is modeled | explicit contract enforceability premise, no side payments |

## 9. Preliminary formal verification applicability
**FORMALIZATION APPLICABLE**. Recommended high-value targets:
1. Exact rational five 4x4 negative-definite Hessians via finite principal-minor checks and region suprema (straightforward arithmetic).
2. 3D host quadratic + **kink/monopoly** inequality `u-Rq>=0`, KKT multiplier/dual upper bound and IR strict rational inequality (proof-critical).
3. Global five-regime coverage and boundary-continuity bridge, plus noncompact policy-domain uniform coercivity for perturbative open-neighborhood theorem (harder).
4. Two-node optimal-solution multiplicity under exchange symmetry and unique no-transfer welfare optimizer; selected outside equilibrium qualification.
5. Antisymmetric determinant polynomial and its two root counts (helpful but NOT global threshold).
Existing Lean formalization of the original sign-flip theorem cannot be advertised as formal verification of these newly introduced cooperative results.

## 10. Audit outcome, regression and routing
Evidence created in **research branch**:
- `audits/STAGE4A_CONSENT_INDEPENDENT_CERTIFICATE_2026-10-12.py`: clean-room algebraic 5-region/host KKT certificate and boundary multiplier degeneracy assertion.
- `audits/STAGE4A_CONSENT_CLEANROOM_INVESTMENT_CHECK_2026-10-12.py`: 300 random + 18 targeted boundary independent scalar firm best responses, Python stdlib.
- `research/stage4_global_consent_exact_certificate.py`: producer derivation, not counted alone as independent verification.
- `research/stage4_asymmetric_duopoly_rivalry_witness.py`: producer's distinct finite rivalry witnesses, independently reproduced in symbolic coordinate analysis.

The auditor's independent SymPy reconstruction and 318 off-path scalar checks were executed within this interaction. **Repository's newly committed scripts were not re-executed via CI on GitHub after upload**, nor was a LaTeX/Lean build performed for this research branch. Those are future Stage-5/7.5A reproducibility/formalization tasks. NO new model artifact is merged to `main`.

**Stage 4A verdict: GO — MATHEMATICAL ADVERSARIAL CERTIFICATION PASS.** Route onward through Stage 5 hardening and **Stage 6 hostile theorem-level novelty re-kill**; this user workflow may treat Stage 5 as next mechanical gate before Stage 6, not as permission for model feature growth.

**Fatal economic novelty risk remains**: Fenge–von Ehrlich–Wrede (2009) on efficient central infrastructure concentration, Markusen–Morey–Olewiler (1995) on decentralization vs cooperative plant allocation and side-payment veto, and broader two-region LQ welfare theory may absorb most of the economic message. That must be assessed by independent Stage 6; Stage 4A GO does not overcome the preceding editorial NO-GO.
