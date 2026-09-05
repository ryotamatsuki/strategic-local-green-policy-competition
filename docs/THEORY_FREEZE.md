# SLGPC Canonical Theory Freeze

Freeze ID: `SLGPC-THEORY-FREEZE-2026-09-05-v2`

Status: `CANONICAL — THEORY FROZEN`.

Supersedes: `SLGPC-THEORY-FREEZE-2026-09-05-v1`.

Workflow: `ryotamatsuki/research-paper-workflow` v1.1, release SHA `488e5ab06c207909296a7564eaf9066f7f94319c`.

This freeze incorporates the Stage-11 hostile-audit rollback, Stage 4R-G global-equilibrium repair, Stage 6 post-repair novelty re-kill, Stage 7 post-repair welfare/generality/institutional validation, and repeated Stage 7.5 full-theory decision. The v1 freeze remains historical provenance only and must not be used as a submission-valid theory object.

## 1. Working title

**Strategic Local Green Policy Competition: Product-Market Rivalry and Instrument Switching**

The earlier subtitle “Instrument Switching through Dual Investment” is retired because it can be read as a universal necessity claim that the repaired theory does not establish.

## 2. Frozen research question

When competing local governments can use a targeted green-investment subsidy and productive green public infrastructure, can stronger product-market rivalry reverse the sign of a local government's infrastructure response to a rival productive green-policy shock when firms endogenously adjust conventional and green investment?

The headline derivative remains

`d h_A^BR / d s_B`.

However, on the interior reduced system the rival policy enters through

`y_B = (mu/k_g) s_B + nu h_B`.

Therefore the rival subsidy is the headline cross-instrument normalization, not a uniquely identified rival-policy channel.

## 3. Players, information, and action sets

- Two jurisdictions, `A` and `B`.
- One incumbent manufacturing firm in each jurisdiction.
- Plant locations are fixed.
- Complete information; all primitives are common knowledge.
- Government actions: `s_i >= 0`, `h_i >= 0`.
- Firm investment actions: `x_i >= 0`, `g_i >= 0`.
- Product-market actions: `q_i >= 0`.

No entry, endogenous plant location, multi-plant capital allocation, or foreign-location bidding is part of the baseline.

## 4. Frozen timing and equilibrium concept

Stage 1: governments simultaneously choose `(s_i,h_i)`.

Stage 2: firms simultaneously choose `(x_i,g_i)`.

Stage 3: firms compete in nonnegative differentiated-Cournot quantities.

Equilibrium concept: subgame-perfect Nash equilibrium of the full nonnegative-action game.

The theory must not identify an interior stationary policy profile with SPNE unless all relevant continuation regimes and global policy deviations are checked.

## 5. Frozen demand and consumer surplus

Representative-consumer gross utility:

`V(q_A,q_B) = a(q_A+q_B) - 1/2(q_A^2+q_B^2) - theta q_A q_B`,

with `0 <= theta <= 1`.

Inverse demand:

`p_i = a - q_i - theta q_j`.

Consumer surplus:

`CS = 1/2(q_A^2+q_B^2) + theta q_A q_B`.

`theta` is product substitutability / product-market rivalry.

## 6. Frozen technology, investment, and emissions

Marginal cost:

`c_i = c - x_i - mu g_i - nu h_i`.

Investment cost:

`(k_x/2)x_i^2 + (k_g/2)g_i^2`, with `k_x,k_g>0`.

Firm profit:

`pi_i = (p_i-c_i)q_i - (k_x/2)x_i^2 - (k_g/2)g_i^2 + s_i g_i`.

Territorial emissions:

`E_i = e q_i - beta g_i - xi h_i`, with `e,beta>0` and `xi>=0`.

`mu>0` is a scope condition for competitiveness-relevant green investment, such as energy-efficiency or process-modernization investment. The paper must not imply that all environmental investment is cost reducing.

There is no hard firm investment budget `x_i+g_i=Kbar`, no hard government budget linking `s_i` and `h_i`, and no nonseparable investment cost in the baseline.

## 7. Frozen local-government objective

Regional welfare is

`W_i = 1/2 CS + PS_i - (kappa/2)h_i^2 - (d/2)(E_i-Ebar_i)^2`,

with `kappa,d>0`.

Global producer surplus is defined from real operating surplus net of investment costs:

`PS_i = (p_i-c_i)q_i - (k_x/2)x_i^2 - (k_g/2)g_i^2`.

On an active interior Cournot branch, `(p_i-c_i)=q_i`, so this reduces to

`PS_i = q_i^2 - (k_x/2)x_i^2 - (k_g/2)g_i^2`.

The subsidy payment `s_i g_i` is an intrajurisdictional transfer in the full-local-capture baseline.

The final term is a territorial/delegated emissions-target loss. It is not literal local physical climate damage and is not a global carbon-damage function.

## 8. Frozen regularity

Define

`R = 1/k_x + mu^2/k_g`.

The maintained convenient sufficient regularity restriction is

`R < 3/4`.

It guarantees the relevant firm-stage regularity and nonsingularity conditions over `theta in [0,1]`. Government strict concavity is imposed on the interior branch where local IFT comparative statics are evaluated.

## 9. Frozen full continuation game

Let

`D = 4-theta^2`,

`b = mu/k_g`,

`w_i = m + b s_i + nu h_i`, where `m=a-c`,

`lambda = 4R/D`,

`L = 2-lambda`.

Under `R<3/4`, `L>theta` on `[0,1]`.

### Stage 3

Writing `v_i=m+x_i+mu g_i+nu h_i`, the nonnegative Cournot continuation is piecewise:

- both firms active if `2v_i>theta v_j` for both firms, with `q_i=(2v_i-theta v_j)/D`;
- A monopoly if `v_B <= theta v_A/2`, with `q_A=v_A/2`, `q_B=0`;
- B monopoly symmetrically.

The identity `p_i-c_i=q_i` is an active-firm identity only.

### Stage 2

After reducing private investment to effective cost reduction, the unique continuation is classified into five regions:

1. A monopoly if `theta w_A >= (2-R)w_B`;
2. A limit-pricing kink if `L w_B <= theta w_A <= (2-R)w_B`;
3. duopoly if `theta w_A < L w_B` and `theta w_B < L w_A`;
4. B limit-pricing kink symmetrically;
5. B monopoly symmetrically.

All regime boundaries match continuously. The kink regions are part of the canonical theory and may not be omitted from future equilibrium proofs.

## 10. Frozen canonical witness and global-SPNE bridge

Canonical rational primitives:

`k_x=4`, `k_g=18`, `mu=9/10`, `nu=6/5`, `kappa=4/5`, `d=2`, `e=11/10`, `beta=17/10`, `xi=1/10`, `m=2`, `Ebar=0`.

Thus `R=59/200`.

Exact symbolic root-count and KKT certificates establish for every `theta in [0,1]` that:

- the symmetric policy candidate is positive;
- the own-policy Hessian on the duopoly branch is negative definite;
- the symmetric continuation lies strictly in the duopoly region;
- all feasible kink/monopoly-inducing policy deviations are globally dominated;
- the symmetric policy candidate is a true global policy Nash equilibrium.

The exact welfare gap against the best exclusionary challenger is strictly positive for `theta in (0,1]`, with checkpoints approximately `.4277511` at `theta=.9` and `.0734124` at `theta=1`.

Because the relevant inequalities and gap are strict, a nonempty open neighborhood of primitives inherits the same global-SPNE property.

The hostile-audit counterexample that invalidated v1 remains a permanent regression test and proves that the local interior conditions alone are not global sufficient conditions.

## 11. Frozen headline proposition — unique switching threshold

On a true global-equilibrium neighborhood that remains locally on the interior duopoly continuation, differentiate government A's two policy first-order conditions. Let

`H_A = W_(s_A,h_A)(s_A,h_A)`.

Then

`d h_A^BR/d s_B = [W_sAhA W_sAsB - W_sAsA W_hAsB] / det(H_A)`.

Define the switching index

`Psi(theta) = W_sAhA W_sAsB - W_sAsA W_hAsB`.

Symbolic reduction yields a positive denominator and a quartic

`P(u)=A_4u^4+A_3u^3+A_2u^2+A_1u+A_0`, `u=theta^2`,

such that for `theta in (0,1]`

`sign(d h_A^BR/d s_B) = -sign(P(theta^2))`.

If

`P(0)>0`, `P(1)<0`,

and the derivative Bernstein coefficients

`B_0=A_1`,

`B_1=A_1+(2/3)A_2`,

`B_2=A_1+(4/3)A_2+A_3`,

`B_3=A_1+2A_2+3A_3+4A_4`

are all strictly negative, then `P` is strictly decreasing on `[0,1]`, has a unique root, and there exists a unique

`theta* in (0,1)`

such that

- `d h_A^BR/ds_B < 0` for `0<theta<theta*`;
- `d h_A^BR/ds_B > 0` for `theta*<theta<=1`.

At the canonical witness:

`theta* = 0.773804386083461...`.

At `theta=0`, the cross-jurisdictional response is zero.

## 12. Frozen mechanism interpretation

The permitted mechanism is not a single-channel story. The sign reversal is generated by the joint movement of:

1. rival-policy transmission into product-market quantities;
2. endogenous conventional and green investment adjustment;
3. consumer-surplus effects;
4. producer-surplus / business-stealing effects;
5. territorial-target effects;
6. interaction between the local government's own subsidy and infrastructure instruments.

Product substitutability changes the relative weight of these channels until `Psi(theta)` changes sign.

At the canonical `theta=.9` point, the direct cross term decomposes approximately as

`W_hAsB = +.00163811 (CS) - .03962910 (PS) + .04607753 (territorial target) = +.00808654`.

Therefore the paper must not describe the positive high-rivalry response as pure competitiveness preservation.

## 13. Frozen rival-policy proportionality

On the interior reduced system, rival policy enters through

`y_B=(mu/k_g)s_B+nu h_B`.

For either own response component `z_A in {s_A,h_A}`,

`d z_A^BR/d h_B = (nu k_g/mu) d z_A^BR/d s_B`

on the same interior branch.

At the canonical witness the scale factor is `24`.

Thus the paper may use a rival subsidy as the headline cross-instrument shock but may not claim that the model identifies a subsidy-specific transmission mechanism distinct from rival infrastructure.

## 14. Frozen matched no-conventional-investment benchmark

Removing conventional competitive investment is the `1/k_x -> 0` nested benchmark.

At the same canonical remaining primitives, the positive-Bernstein benchmark condition implies

`d h_A^BR/ds_B < 0` for every `theta in (0,1]`.

Hence conventional investment **can generate** a reversal that is absent in the corresponding matched benchmark.

This is not a necessity theorem. A verified no-`x` case with `beta=1.3` has a true global policy equilibrium with a reversal near `theta=0.9394850556`.

Permanently prohibited language:

- “conventional investment is necessary for switching”;
- “dual investment is the minimal architecture for every reversal”;
- any universal no-`x` impossibility claim.

## 15. Frozen competitiveness-link benchmark

If `mu=0`, a rival green subsidy no longer changes rival product-market competitiveness through green investment. In that benchmark the corresponding cross-jurisdictional responses vanish.

This is mechanism validation, not a standalone novelty claim.

## 16. Frozen comparative-statics scope

Around the canonical open region only:

`d theta*/d nu < 0`,

`d theta*/d k_x > 0`.

These are local comparative statics, not global monotonicity theorems.

The cross-response itself is not globally monotone in `theta` below the threshold. Empirical predictions must therefore allow threshold/nonlinear responses rather than impose a globally positive linear interaction.

## 17. Frozen welfare scope

Coordinated policy maximizes `W_A+W_B`.

For `z_A in {s_A,h_A}`, the coordination wedge is

`Omega_zA = dW_B/dz_A = 1/2 CS_zA + PS_B,zA - d(E_B-Ebar_B)E_B,zA`.

This is a real cross-jurisdictional wedge, not transfer accounting.

No global ordering of decentralized and coordinated `s` or `h` is frozen.

At the canonical `theta=.9` illustration, the symmetric coordinated active-duopoly benchmark raises total model welfare relative to decentralized SPNE, but also raises output and territorial emissions. It is therefore a second-best regional-welfare illustration, not an emissions-reduction theorem.

The dimensionally invalid statistic `h/(s+h)` is permanently excluded.

If a descriptive fiscal-composition statistic is used, it is

`phi_h = (kappa h^2/2)/(s g + kappa h^2/2)`.

## 18. Frozen robustness scope

Mandatory robustness evidence retained:

- differentiated Bertrand: same primitives, local interior sign reversal with crossing near `theta_B*=.3972`; do not extrapolate the interior IFT past the infrastructure nonnegativity boundary near `.545`;
- partial local profit capture: at `omega=.9`, local interior reversal near `.5111`; no claim for arbitrary `omega`;
- sufficiently small primitive asymmetries preserve the strict local qualitative structure by continuity; no asymmetric closed-form theorem is required.

These are local open-set robustness results. They are not promoted to full-interval global-SPNE theorems.

## 19. Frozen institutional scope

Best interpretation: place-based green industrial policy for geographically anchored incumbent industrial production with broader product-market competition and productive regional green infrastructure.

Relevant examples include energy-intensive manufacturing and industrial clusters where clean-power access, grid capacity, hydrogen/steam networks, ports, utilities, or related shared inputs affect production conditions.

Current METI/OECD evidence supports coexistence of place-based infrastructure, firm-facing green investment support, competitiveness goals, and subnational implementation. It does not establish that Japanese local governments independently choose both instruments exactly as in the theoretical game. Japan is institutional motivation, not literal calibration.

## 20. Frozen empirical predictions

Permissible predictions:

1. cross-jurisdictional policy reactions can differ in sign across product-substitutability regimes;
2. in the canonical neighborhood, more productive shared infrastructure lowers the switching threshold;
3. in the canonical neighborhood, more flexible conventional investment lowers the switching threshold;
4. when `mu` is near zero, the product-market transmission of rival green subsidies weakens or vanishes;
5. empirical specifications should permit nonlinear / threshold responses;
6. instrument-specific shocks must be identified separately if the empirical goal is to distinguish rival subsidy from rival infrastructure, because the reduced theoretical continuation contains the composite `y_B`.

## 21. Frozen contribution claims

Allowed core claims:

1. **Competition-induced cross-instrument sign reversal:** over a nonempty global-SPNE region, product substitutability can uniquely reverse the sign of the local infrastructure response to a rival targeted green-policy shock.
2. **Global-equilibrium validation:** the result is not only an interior FOC phenomenon; the canonical witness is verified against kink and monopoly-inducing deviations, with strict open-neighborhood survival.
3. **Matched benchmark separation:** at the same canonical primitives, adding the conventional-investment margin generates a reversal absent from the corresponding no-`x` benchmark.
4. **Local formulation robustness:** the sign-reversal mechanism survives differentiated Bertrand competition and modest local-ownership leakage on interior open sets.

Do not claim novelty for:

- multi-instrument fiscal/environmental competition;
- cross-instrument best responses per se;
- subsidy/public-input interaction per se;
- threshold effects in subsidy/infrastructure competition per se;
- conventional plus green R&D per se;
- the duopoly/kink/monopoly repair itself;
- generic decentralization distortions.

## 22. Frozen closest-paper boundary

Stage-6 classification: `DISTINCT BUT NARROW`.

- Hauptmeier, Mittermaier, and Rincke (2012): `STRUCTURALLY VERY CLOSE` for simultaneous tax/public-input reaction architecture; cross-instrument reaction functions are prior art.
- Morita and Okoshi (2025): `STRUCTURALLY VERY CLOSE` for subsidy/infrastructure/Cournot/threshold language; their timing and theorem object differ.
- Strandholm, Espinola-Arredondo, and Muñoz-García (2025): `COMPONENT OVERLAP` for simultaneous conventional and green investment.
- Bayindir-Upmann and Markusen-Morey-Olewiler: material prior art for environmental federalism, imperfect competition, and market-structure/boundary discipline.

Surviving theorem-level distinction:

> Product-market substitutability uniquely reverses a local government's infrastructure best response to a rival productive green-policy shock on a nonempty true-global-SPNE region, with a matched same-primitives benchmark showing that conventional investment can alter the qualitative best-response network.

No exact prior-art or immediate-corollary absorption was found at Stage 6.

## 23. Frozen proof strategy

1. Solve the nonnegative Cournot continuation by active set.
2. Reduce Stage-2 investment to effective private cost reduction and classify the five continuation regions.
3. Prove the canonical global policy equilibrium by exact branch comparison, KKT conditions, and polynomial root counts.
4. On the interior duopoly neighborhood, derive firm investment and reduced quantities analytically.
5. Form the government Hessian and use the IFT for the cross-policy best-response derivative.
6. Factor the switching index into a positive denominator times `theta(theta^2-4)P(theta^2)`.
7. Use Bernstein-basis sufficient conditions and endpoints to prove a unique root.
8. Solve the matched no-`x` benchmark separately and retain the `beta=1.3` no-`x` reversal as a quantifier-regression test.
9. Verify all symbolic identities and global certificates independently in repository scripts and CI.

A giant closed-form expression for `theta*` is not part of the proof strategy.

## 24. Theory-change rule after v2

Any post-v2 change to a frozen item requires an explicit theory-change record and rerunning the earliest affected gates.

Changes that automatically count as substantive theory changes include:

- adding a third policy instrument or green public procurement to the baseline;
- endogenous plant location, entry, or multi-plant capital mobility;
- a hard government budget or firm investment budget;
- nonseparable `x/g` investment technology;
- changing the local-government objective materially;
- replacing the territorial-target loss with global carbon damages in the baseline;
- changing nonnegative action sets or omitting kink/monopoly continuations;
- changing the equilibrium concept;
- promoting the matched no-`x` result into a universal necessity claim;
- promoting local robustness results into global theorems without revalidation.

## 25. Stage-8 verdict and routing

`GO — THEORY FROZEN`.

Canonical freeze ID:

`SLGPC-THEORY-FREEZE-2026-09-05-v2`.

Because the production repository already exists from the superseded v1 cycle, the next workflow step is a **Stage 9R — Repository / Reproducibility Alignment** rather than repository creation from scratch. Stage 9R must ensure every status document, verification script, manuscript entry point, and CI gate points to v2 and contains no surviving v1 claim before Stage 10 reconstruction proceeds.
