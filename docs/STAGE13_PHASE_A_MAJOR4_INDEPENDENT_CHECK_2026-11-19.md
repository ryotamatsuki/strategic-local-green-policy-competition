# Stage 13 Phase A — MAJOR A01–A04 Independent Equation Audit (2026-11-19)

Source: user-provided FINAL_PROSE_REFEREE_REPORT.md; audited original PDF SHA-256 5dfe22de37cb10e047527e56bd60532b8767a7c2aea1fdb128ee54d3cb65f62f, base source faad1f05cb20088734e43215c19e5b9fda79d1c4.

Independent means fresh symbolic/numeric reconstruction of claims; the present editing agent is NOT a second independent blind full-PDF referee.

## A01: partial best-response definition
Main Results equation (2x2 IFT) optimizes both own policy components while holding rival infrastructure fixed during the rival-subsidy partial derivative. It is not a total response along all four policy equilibrium values. Introduction, results, empirical bridge and exhibit captions now specify this object. The observed own-subsidy sign is attributed only to the reported theta=.9 example.

## A02: direct and indirect components
Independent rational SymPy reconstruction of the canonical welfare Hessian verifies:
| theta | raw W_hA,sB | scaled direct slope | own subsidy indirect slope | total hA slope | target contribution to raw W_hA,sB |
|---|---:|---:|---:|---:|---:|
| .5 | +.0002368389153 | +.0006773782840 | -.0052295971926 | -.0045522189086 | +.0134046243585 |
| .9 | +.0080865355485 | +.0153549842276 | -.0082424119405 | +.0071125722871 | +.0460775303426 |

The actual contributions to the best-response slope equal (-W_ss W_hsB / detH) and (W_sh W_ssB / detH); do not compare an unscaled welfare derivative to a policy derivative. Affine emissions give the target direct component -d E_h E_sB > 0 at these *canonical* points. The prose now puts this contrast adjacent to the theorem.

## A03: target-loss weight
Original verified table and script verify interior sign patterns at fixed remaining primitives: d=1.5 gives negative response throughout theta>0; d=2 changes negative to positive once; d=3 positive throughout. This does NOT prove a necessary bound for d or global SPNE at d=1.5/3. Both Robustness and Discussion now limit language to the table.

## A04: full five-continuation region check
Independent exact-rational SymPy reconstruction of the canonical symmetric government FOCs yields R=59/200 and F(theta)=m L(theta)-theta*wB_star(theta). Its rational-function numerator degree 12 and denominator degree 11 have **zero roots on [0,1]**, and F(1/2)=1.54285661206 > 0. Therefore F>0 for all theta in [0,1]. For any nonnegative own policy, wA>=m, so theta*wB_star < Lm <= LwA <= (2-R)wA. Both **B limit-pricing kink** (requires theta*wB_star >= LwA) and **B monopoly** (requires theta*wB_star >= (2-R)wA) are impossible. That fills the A.6 exposition gap.

The remaining own-kink and own-monopoly government objectives have negative-definite Hessians and attain their constrained maxima at the same boundary by strict KKT multiplier signs; positivity of the symmetric-candidate versus boundary welfare gap on all theta>0 is established by the existing exact root-count verifier scripts/verify_stage4rg_global.py. A separate independent branch welfare reconstruction at theta=.5/.9/1 gives W gaps 7.64865760646 / 0.427751100367 / 0.073412375139, exactly matching earlier checkpoints. This second reconstruction does not independently certify the outside gap over the entire theta continuum; the existing root-count script does.

## Audit limitations
No theory, payoff, equilibrium conditions or parameter values are altered. These results justify bounded presentation repairs. 12 original MINORs remain independently unclosed. A new rebuilt PDF must pass complete critical reading by a truly separate reader; this is not Stage13 GO.
