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

