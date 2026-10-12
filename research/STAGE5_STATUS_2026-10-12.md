# Stage 5 — Mechanism Hardening (2026-10-12)

Verdict: **GO TO NOVELTY RE-KILL**, with no change to model primitives. The incoming Stage-4A has no unresolved mathematical failure. Stage 5 consequently tests mechanism specificity rather than inventing an additional parameter or policy instrument. This verdict does not certify economic originality.

## Nested benchmark tests

Independent exact-rational calculations at theta=0.9 establish a stringent adverse comparison. Setting mu=0 (green investment still reduces emissions but cannot reduce production costs) preserves the same qualitative welfare/participation contrast: regionwise unrestricted coordinator bounds are 2.776085724 (both firms), 2.735791782 (limit-pricing boundary), and 3.270056958 (single operating firm). The firm-exit-host's exact upper welfare bound is 175320/284107 = 0.617091448, lower than the selected non-cooperative regional welfare 0.900407403. The relaxed one-operating-firm host problem's exact KKT multiplier is 408080/284107 > 0. The duopoly coordinator is participation-compatible and improves each region's welfare. Thus the headline consent veto DOES NOT require the cost-reducing green investment channel.

Setting mu=0 lies on the boundary of the main hypothesis mu>0; strict inequalities permit qualitatively analogous small positive mu under continuity, but the calculation is not a general mu>0 theorem.

At theta 0.3, 0.5 and 0.9, compute the exact change in joint welfare from (+0.1,+0.05,-0.1,-0.05) relative to the symmetric coordinated optimum, retaining both firms active and both participation inequalities slack:

| Model | theta=.3 | theta=.5 | theta=.9 |
|---|---:|---:|---:|
| Original (conventional and green investment) | +0.00000467116446 | +0.00002160159926 | -0.001654929058 |
| mu=0 (green investment does not affect production cost) | -0.00030079044523 | -0.00036480444408 | -0.002274207204 |
| no conventional R&D (1/kx=0) | -0.00014735033757 | -0.00001550862157 | +0.00003648139241 |

Every displayed sign was evaluated exactly with SymPy rational expressions, then rounded for this table. The findings establish sign sensitivity to the underlying investment feedback, but **do not** establish that either R&D choice is universally necessary, or that these points identify a unique change in the true global participation-optimal policy. In the no-conventional-R&D benchmark, the full kink-region four-policy Hessian can be singular; no original five-regime global uniqueness proof is transferred to that case.

## Hardening decision: no new assumption added

1. **Previous failure:** the Stage-7.5 editorial rejection of the *original* paper was economic importance, not a Stage-4 equilibrium error. The revised consent model's Stage 4 and 4A passed their narrowly stated mathematical gates. There is therefore no new derivation failure to 'fix' using another instrument.
2. **Single previously selected addition:** a hypothetical enforceable no-side-payment unanimous agreement with regional individual rationality relative to the exhibited local-government SPNE. It was introduced explicitly at Stage 3/4, not silently added at Stage 5. Demand, firms, local welfare, original equilibrium, and nonnegative action sets are unchanged.
3. **Stage-4 vs hardened result:** the same canonical full five-regime welfare and conditional consent theorem survives. The key novelty refinement is **negative**: its broad mechanism is present even when the green-productivity link is removed, so the result must NOT be advertised as specific to cost-reducing green investment or dual R&D. The small asymmetric-perturbation sign patterns DO depend on firm investment structure at sampled rivalry levels, but the necessity of any particular input or a unique global symmetry regime change remains unproved.
4. **Not baked in by definition:** the consent constraints mechanically prevent a coalition member from accepting modeled welfare below their outside option. They do not mechanically force a particular market configuration. The exact host-welfare upper bound compared with the decentralized outside option is the actual derived inequality. However, no endogenous bargaining/acceptance/contracting equilibrium has been solved; an enforceable agreement is an assumption.
5. **Live literature threats:** Markusen, Morey and Olewiler (1995, JPubE 56:55–77) expressly discuss host compensation and pollution-driven regional conflict in cooperative vs noncooperative market-structure choices; their 1993 JEEM article already links environmental policy to plant closure and output allocation. Fenge, von Ehrlich and Wrede (2009, RSUE) show a centralized concentration-versus-decentralized dispersion result. Sharma and Pal, *Nash equilibrium in tax and public investment competition*, identify endogenous asymmetric/sequential equilibria even for initially symmetric governments. These results present serious broad economic/theorem-overlap threats; a different environmental investment label does not establish novelty.
6. **Welfare and institutional scope:** the government payoff includes an equally allocated integrated-market consumer surplus and quadratic deviations from delegated territorial emission targets; it is not a global climate damage measure. The contract assumes legally feasible interlocal joint policy and enforceability without monetary side payments. No real Japan-specific policy authority is established for this exact unrestricted instrument set. No compensation mechanism or budget cap is added.

## Surviving claims to pass to Stage 6

- T1: Exact canonical rational witness (theta=.9) with global unrestricted aggregate coordinator choosing one firm's inactivity; no-transfer consent eliminates **all** one-firm operating outcomes including the pricing kink and yields the unique symmetric active-duopoly coordinator, **conditional on the exhibited pre-agreement SPNE**.
- T2: Exact finite theta=.3,.5 witnesses refute optimality of any symmetric voluntary agreement in the baseline model; theta=.9 has a globally optimal symmetric voluntary agreement. The antisymmetric Hessian has two internal roots, but no globally certified unique policy-symmetry threshold is established.
- T1 does not require mu>0: mu=0 benchmark possesses the same strict global contrast. No claim that conventional investment is necessary for T1 or T2.
- Sensitivity: the no-x benchmark changes the signs of the tested antisymmetric perturbations; copying a strict kink Hessian criterion from the baseline is invalid in the no-x nested model.
- The exact admissible set is all nonnegative subsidies/infrastructure, without finite numerical boxes. At the canonical witness overall quadratics are strictly concave on every correctly extended market regime; generic unrestricted planner objectives may be unbounded when environmental target weight d is too small.
- Not proved: global theta-switch threshold for the voluntary optimum; welfare rankings independent of government-policy equilibrium selection; bargaining game equilibrium; general necessary/sufficient primitive conditions; genuine journal-level novelty.

**No second modification is authorized.** The bounded branch goes directly to a hostile Stage 6 prior-theorem absorption check. If T1 is treated as already known and T2 cannot produce economics beyond generic symmetric LQ policy curvature, stop the full-paper extension rather than adding instruments or increasing model complexity.

## Reproducibility and workflow

Exact-rational nested mu=0 proof code: `research/stage5_no_green_productivity_exact.py`.
The Stage 5 benchmark calculations were independently executed with local SymPy, but the newly pushed standalone GitHub file and the full repo CI are not yet verified by a hosted runner. No main-branch code/manuscript/previous theory freeze was changed. Stage 5 GO is NOT Stage 6 novelty GO or publication recommendation.

**Canonical Stage 5 verdict: GO TO NOVELTY RE-KILL (bounded).**
