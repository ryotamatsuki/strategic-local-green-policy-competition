# Stage 4A — Independent Adversarial Re-certification (2026-10-12)

## Authority and frozen inputs
- Audit base: `main` commit `a318195c75a0d0ce30a69f61ae810918aacd7552` (2026-09-18).
- Governing standard: `research-paper-workflow` v2.8, `templates/STAGE_04A_MATH_RED_TEAM.md`, theorem/continuation/formal-verification checklists; v2.9 candidate does not alter Stage-4A mathematical criteria.
- Frozen model: two local governments choosing nonnegative `(s_i,h_i)`; firms choosing nonnegative `(x_i,g_i)`; differentiated Cournot quantity choices `q_i>=0`; complete information; three sequential stages; SPNE.
- Parameters of canonical witness: `(kx,kg,mu,nu,kappa,d,e,beta,xi,m,Ebar)=(4,18,.9,1.2,.8,2,1.1,1.7,.1,2,0)`, `theta in [0,1]`, `R=59/200<3/4`.
- Input exposure: the auditor inspected `sections/model.tex`, `sections/equilibrium.tex`, `sections/main_results.tex`, Stage-4R-G historical proof, and the producer verification source. Therefore this is **not a blinded review**. Independence consists of reconstruction of government payoff and policy Hessian from primitives, a separately implemented Cournot/investment evaluator, derivative-free global policy search, and independent exact-rational checkpoint calculations. A different model name or a green production CI alone is not counted as an independent attack.
- No model, theorem, manuscript, or frozen mathematical content was changed.

## Executive verdict
**GO — MATHEMATICAL ADVERSARIAL CERTIFICATION PASS (existence-only/global-SPNE claim; no general equilibrium uniqueness claimed).**

No new mathematical counterexample was identified. The result relies on BOTH (i) the existing exact all-theta rational root-count / KKT proof for the canonical witness and (ii) an independent attack using primitive direct-payoff solvers and off-path government global searches. This audit does **not** assert an independent machine-checked proof of every Global SPNE implication, nor does it certify a unique policy equilibrium for all admissible primitives. Stage 7.5A must continue to delimit theorem quantifiers and formalization boundaries. GO here does not imply Stage-6 novelty or Stage-7.5 editorial-value PASS.

## 1. Independent primitive reconstruction
- Stage-3 Cournot response is obtained directly from `max_{q_i>=0} (m+x_i+mu*g_i+nu*h_i-q_i-theta*q_j)q_i`, re-solving after changes in investments.
- Stage-2 primitive `(x_i,g_i)` best responses were recomputed numerically with nonnegativity bounds and alternating best-response iterations; this does not invoke the production Stage-4R-G verifier.
- A second independent Stage-2 scalarized best-response solver (direct `scipy.optimize.minimize_scalar` over each firm's scalar investment, using the primitive Cournot response) was used around kink/monopoly boundaries to avoid false smooth-gradient classifications.
- Government `W_A=CS/2+PS_A-kappa*h_A^2/2-d*(E_A-Ebar)^2/2` was reconstructed from quantities and real investment costs without adding subsidy transfers to total local welfare.
- The independent quadratic-policy Hessian/IFT evaluation reproduces the canonical best-response slopes.

## 2. Headline theorem certificates
| ID | Claim / quantifiers | Independent attack | Status and limitation |
|---|---|---|---|
| C1 | Stage-3/2 nonnegative continuation exists and is unique for the canonical regularity class | 45 random off-path policy histories including inactive firms; 18 targeted kink/monopoly neighborhoods; direct primitive and scalar best responses | PASS within tested cases, backed by original analytic five-regime proof; direct smooth L-BFGS-B is numerically unreliable exactly near a kink |
| C2 | Canonical symmetric candidate is a **global** policy Nash for each `theta in [0,1]`, inducing one pure SPNE | Independent differential evolution over `s_A in [0,200]`, `h_A in [0,100]` at 7 theta checkpoints; large unilateral deviations; exact rational checks of outer-boundary surplus gap at theta=1/2,9/10,1 | PASS as **existence** claim using producer exact all-theta certificate plus independent deviation attack; not a proof that the global policy equilibrium is unique |
| C3 | Unique sign-change of the **interior / locally global** infrastructure best-response slope under Bernstein sufficient conditions | Reconstructed government-policy Hessian, cross-derivative and exact canonical `P(u)` root/sign check | PASS; generic proposition requires its stated interior/strict-concavity assumptions |
| C4 | At matched canonical primitives, no-conventional-investment benchmark has no reversal | Exact rational `Q(u)=602500u^2-3281550u+3486659` checked to have no roots on [0,1] and positive sample sign; producer benchmark verifier inspected | PASS for **matched** benchmark only; conventional investment is not a universal necessity |
| C5 | Coordinated welfare illustration is a symmetric, active-duopoly, constrained benchmark | Compared planner label to `sections/welfare.tex` and objective definitions | PASS as a restricted benchmark, **not** global planner optimum or first-best claim |

## 3. Candidate-deviation evidence
Independent global-search optimization against the fixed symmetric rival converged to the same own-policy profile for:
| theta | s_A | h_A | profitable finite deviation found? |
|---:|---:|---:|---|
| 0 | 5.06183 | 1.75507 | no |
| .05 | 4.83638 | 1.70111 | no |
| .3 | 3.86671 | 1.44197 | no |
| .5 | 3.23184 | 1.24502 | no |
| .773804386 | 2.44466 | .94095 | no |
| .9 | 2.05941 | .74426 | no |
| 1 | 1.70863 | .52359 | no |

Search: differential evolution over [0,200] x [0,100] plus very large policies, including `(300,200)`, `(1000,0)`, `(0,1000)`, and `(2500,500)`. This finite computational search alone would not establish a global theorem; the all-interval exact producer proof is retained as the mathematical certificate.

## 4. Full continuation and boundary-region attack
- 45 random off-path policy histories at theta=.2,.7,1: direct primitive investment Nash and separately coded piecewise continuation matched region classifications and welfare within `5.3e-5`; solver tolerance was the dominant discrepancy.
- 18 deliberately chosen histories, near both duopoly/kink and kink/monopoly boundaries at theta=.4,.9,1: independent scalar best-response solver and piecewise evaluator matched welfare within `1.1e-7`. Near the exact boundary the numeric regime label can differ at tiny output levels, but this did not produce a material payoff contradiction.
- Along the kink/monopoly common frontier `theta*w_A=(2-R)*w_B`, separate one-dimensional government optimization returned exact-rational welfare gaps:
  - theta=1/2: `7.648657606459858`;
  - theta=9/10: `0.4277511003668914`;
  - theta=1: `0.07341237513919008`.
- Exact-rational independent 2D calculations at these three points confirmed `s>0`, `h>0`, own-policy Hessian `H_ss<0`, `det(H)>0`, and positive separation from the best exclusionary challenger. At the common boundary the one-sided welfare derivatives have signs required for a frontier maximum.
- Producer `scripts/verify_stage4rg_global.py` additionally establishes the positive gap and KKT signs for the entire interval through exact polynomial root counting. The producer code was reviewed as external evidence; we did **not** duplicate the full interval symbolic factorization in a wholly new implementation.

## 5. Alternative-equilibrium, indifference and selection attacks
- Government-policy best-response dynamics from five widely separated asymmetric initial profiles at each theta=.5,.9,1 converged numerically to the reported symmetric profile (15 start cases). **This is not a theorem of globally unique government equilibrium.**
- Equilibrium-set label for government: **EXISTENCE ONLY** (other policy equilibria have not been globally excluded; the manuscript does not claim uniqueness of all equilibrium profiles).
- At a fixed canonical rival, strict own-branch concavity, positive gap to the exclusionary frontier, and the absence of a reachable rival-monopoly branch imply that the proposed own best response is not a tie with the outside challenger.
- Inactive downstream firms, zero outputs, kink boundaries, and theta=0/1 were explicitly investigated. Nonnegative investment and firm quadratic penalties preclude treating zero-output firms as having arbitrary costless investment responses. No material payoff-equivalent action changing the exhibited candidate's continuation was found.
- The model does not invoke ad hoc selection refinements, weak dominance or a government equilibrium-uniqueness assumption to obtain the **existence** claim.

## 6. Canonical sign-switch recheck
Using independently reconstructed policy Hessians, the infrastructure response agrees with the manuscript at:
| theta | d h_A^BR / d s_B |
|---:|---:|
| .1 | -.00123121 |
| .3 | -.00344186 |
| .5 | -.00455222 |
| .7 | -.00241489 |
| .773804386 | approximately zero |
| .9 | +.00711257 |
| 1 | +.01534844 |

Exact polynomial: `P(u)=602500u^4-8101550u^3+39588109u^2-74143042u+31863144`.
Its endpoint signs are `P(0)=31863144>0`, `P(1)=-10190839<0`. Independently calculated derivative Bernstein coefficients are `(-74143042,-143252908/3,-88381340/3,-16861474)`, all strictly negative. SymPy exact root counting gives one root in [0,1]. This supports the canonical unique-crossing certificate, not a universal theorem for arbitrary primitives.

## 7. Formal verification applicability
**FORMALIZATION APPLICABLE.** Existing Lean 4 verification formally proves the polynomial threshold, major Stage-2 reductions, the active government Hessian and canonical quartic bridge. As the project's own `docs/LEAN_FORMALIZATION.md` explicitly notes, the full primitive global government Nash/SPNE theorem, the all-parameter-boundary deviation proof and open-neighborhood continuation are **not fully encoded in Lean**. Existing symbolic root-count proofs and independent adversarial audit provide distinct layers. High-value subsequent formal targets: (a) actual-best-response IFT bridge, (b) government kink/monopoly global deviation, (c) global-SPNE/open-neighborhood bridge; confirm formal proof fidelity at Stage 7.5A.

## 8. Evidence and regression ledger
| Claim | Attack / evidence | Result | Limitation |
|---|---|---|---|
| On-path investment/quantity identity | Fresh primal optimizer, Hessian reconstruction | matches existing values | finite numeric check |
| Off-path continuation | 45 random histories and 18 targeted boundary histories | no substantive mismatch | floating-point tolerance at ties |
| Canonical global policy best response | independent differential evolution, very large finite deviations, separate rational benchmark checks | no new counterexample | general theta interval relies on existing exact certificate |
| Alternative policy equilibria | 15 distinct asymmetric best-response initializations | no alternative found | no global uniqueness proof or claim |
| Unique threshold | exact rational polynomial/Bernstein/root calculations | verified canonical math | generic theorem conditional |
| Prior known counterexample | `docs/STAGE4RG_GLOBAL_REPAIR.md` and producer regression | retained, not deleted | shows interior certificate alone is inadequate |
| no-x necessity counterexample | `scripts/verify_nox_global_counterexample.py` / literature boundary | recorded as permanent limitation | matched benchmark cannot be universalized |

No new economic counterexample was found; therefore no new counterexample regression test is required. A numerical-method warning is retained: do not use smooth optimization alone to classify a limit-pricing kink.

## 9. Scope limitations and handoff
- Certified surviving claim is **one global-SPNE witness family with a locally well-defined sign-crossing** and one matched no-x separation, not a global characterization or uniqueness result for every primitive.
- Do not promote the Bertrand, partial-ownership, emission-target intensity, welfare/coordination, or alternative-equilibrium diagnostics to unproved global SPNE theorems.
- Full independent symbolic factorization of the global welfare gap across all theta was attempted but did not complete within the available compute budget; this is disclosed, not misreported as an independent exact proof.
- The earliest affected stage if future counterexamples arise is **Stage 4**, followed by re-certification at Stage 4A and downstream rollback. No present model or theorem repair is identified.
- **Routing: Stage 6 — Novelty Re-Kill** under v2.8/v2.9-candidate, followed by distinct economic-significance/complete-question scrutiny at Stage 7.5. Stage 4A PASS is not evidence of novelty or editorial value.
