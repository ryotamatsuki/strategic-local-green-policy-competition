# Stage 7 — Post-Repair Welfare / Generality / Institutional Validation

Status: `GO`.

Date: 2026-09-05.

Upstream state:

- Stage 4R-G: `GO`; the canonical rational witness is a true global policy SPNE on a nonempty open primitive region after completing the duopoly / limit-pricing-kink / monopoly continuation.
- Stage 6 post-repair novelty re-kill: `GO`, classification `DISTINCT BUT NARROW`.
- The old theory freeze `SLGPC-THEORY-FREEZE-2026-09-05-v1` remains superseded pending re-freeze.

This stage does not add a primitive, policy instrument, timing change, or new baseline institution. It validates the repaired mechanism, corrects welfare interpretation, and narrows empirical and robustness claims in response to the hostile audit.

## 1. Welfare accounting

The utility system remains

`V(q_A,q_B)=a(q_A+q_B)-1/2(q_A^2+q_B^2)-theta q_A q_B`,

so

`CS=1/2(q_A^2+q_B^2)+theta q_A q_B`.

Real local producer surplus is

`PS_i=q_i^2-(k_x/2)x_i^2-(k_g/2)g_i^2`.

The canonical local objective is

`W_i=1/2 CS + PS_i - (kappa/2)h_i^2 - (d/2)(E_i-Ebar_i)^2`.

The firm subsidy is an intrajurisdictional transfer in the full-local-capture baseline. The last term is a territorial/delegated emissions-target loss; it is not interpreted as physical local climate damage.

For any policy `z_A in {s_A,h_A}`, the coordinated-vs-decentralized first-order-condition wedge is

`Omega_zA = dW_B/dz_A`

`= 1/2 CS_zA + PS_B,zA - d(E_B-Ebar_B) E_B,zA`.

Thus the coordination wedge contains real consumer-surplus, producer-surplus/business-stealing, and emissions-target effects. It is not transfer accounting.

## 2. Corrected fiscal-composition statistic

The old manuscript statistic `h/(s+h)` is invalid because `s` is a subsidy rate while `h` is an infrastructure quantity. It is removed.

For descriptive fiscal composition only, define

`phi_h = (kappa h^2/2) / (s g + kappa h^2/2)`.

This compares actual subsidy outlay `s g` with the infrastructure resource/outlay term in common units. It is not a welfare share because the subsidy transfer cancels from baseline welfare.

At the canonical interior duopoly solutions:

| theta | s_NE | h_NE | phi_h_NE | s_C | h_C | phi_h_C |
|---:|---:|---:|---:|---:|---:|---:|
| .60 | 2.9411 | 1.1434 | .4172 | 7.0033 | 4.5966 | .6758 |
| .773804 | 2.4447 | .9409 | .4030 | 5.4073 | 3.6922 | .6855 |
| .90 | 2.0594 | .7443 | .3632 | 4.5248 | 3.1987 | .6925 |
| 1.00 | 1.7086 | .5236 | .2809 | 3.9230 | 2.8667 | .6983 |

Here `C` denotes the symmetric coordinated active-duopoly benchmark obtained by maximizing `W_A+W_B` on that branch. The table is an illustration, not a global policy-ordering theorem.

At `theta=.9`, total welfare rises from approximately `2.186952` in the decentralized global-SPNE equilibrium to `3.720306` at the symmetric coordinated active-duopoly benchmark. But output and territorial emissions also rise:

- `q`: `1.184177 -> 2.397036` per region;
- `E`: `.907456 -> 1.634043` per region.

Therefore coordination is not an “emissions-reduction” theorem. It is a second-best regional-welfare comparison in which stronger production can outweigh the larger territorial-target loss.

## 3. Mechanism decomposition after hostile audit

The general IFT formula remains

`d h_A^BR/d s_B = [W_sAhA W_sAsB - W_sAsA W_hAsB] / det(H_A)`.

At the canonical global-SPNE point `theta=.9`, the direct cross effect decomposes as

`W_hAsB = +.00163811 (consumer surplus) - .03962910 (own producer surplus) + .04607753 (territorial-target term) = +.00808654`.

Also,

`E_A,h_A = +.9519861`,

`E_A,s_B = -.02420074`.

Thus the positive high-rivalry infrastructure response cannot be described as a pure “competitiveness-preservation” force. At this point the direct target-loss contribution is quantitatively important: a rival subsidy lowers local output/emissions, which relaxes the target-loss consequence of an infrastructure expansion even though infrastructure's scale effect raises `E_A` on net.

The economically correct mechanism is the joint operation of:

1. rival-policy transmission into product-market quantities;
2. endogenous adjustment of both conventional and green firm investment;
3. consumer-surplus, producer-surplus/business-stealing, and territorial-target channels;
4. interaction between the local government's own subsidy and infrastructure instruments.

Product substitutability changes the relative strength of these terms. The switching index crosses zero once under the Stage-4R conditions.

The response is also non-monotone below the threshold in the canonical witness:

- `F(.1)=-.0012312`;
- `F(.3)=-.0034419`;
- `F(.5)=-.0045522`;
- `F(.7)=-.0024149`;
- `F(.8)=+.0011500`;
- `F(.9)=+.0071126`,

where `F(theta)=d h_A^BR/ds_B`.

Hence the model does not imply a globally positive linear “rival subsidy x competition” interaction. Its robust prediction is a sign difference across the threshold, with a positive local slope near and above the crossing in the canonical region.

## 4. Rival-instrument proportionality

On the interior reduced system, jurisdiction A receives jurisdiction B's policy through

`y_B=(mu/k_g)s_B+nu h_B`.

Consequently, for either own response component `z_A in {s_A,h_A}`,

`d z_A^BR/d h_B = (nu k_g/mu) d z_A^BR/d s_B`

whenever the same interior branch applies. At the canonical witness the proportionality factor is `24`.

This means the sign-reversal result is not economically unique to a rival subsidy shock. The subsidy shock is the paper's chosen cross-instrument normalization; a rival infrastructure shock moves the same product-market transmission margin with a different scale. The manuscript must not claim identification of a subsidy-specific causal channel that the model does not contain.

## 5. Matched no-x benchmark

The benchmark result is retained only in conditional/matched form.

At the canonical primitives, removing conventional investment eliminates the reversal over `theta in (0,1]` under the positive-Bernstein condition. However the verified `beta=1.3` no-x counterexample has global policy equilibria with a negative response at `theta=.9` and a positive response at `theta=1`.

Therefore:

- allowed: conventional investment can generate a reversal absent under the same canonical primitives in the matched no-x benchmark;
- prohibited: conventional investment is necessary for all reversals;
- prohibited: dual investment is the universally minimal architecture.

## 6. Robustness and scope

### Differentiated Bertrand

Using the same primitive vector, the interior differentiated-Bertrand formulation has a sign crossing at approximately `theta_B*=.3972`, with a negative response at `.3` and positive response at `.5`. The relevant policy candidates are positive and locally strictly concave on that interval.

The infrastructure policy reaches its nonnegativity boundary around `theta=.545`; therefore the interior Bertrand IFT must not be extrapolated beyond its valid active-policy region. This exercise establishes local formulation robustness, not a global-SPNE theorem for all `theta`.

### Partial local capture

With local profit-capture rate `omega=.9`, the interior Cournot formulation crosses near `theta*=.5111` with positive policy candidates over the reported neighborhood. The result establishes survival under modest ownership leakage, not robustness for arbitrary `omega`.

### Asymmetry

No new asymmetric baseline is required at this stage. Because the canonical global-SPNE gap, policy constraints, relevant Jacobians, and threshold root are strict, sufficiently small primitive asymmetries preserve the local qualitative structure by continuity. This is a local statement, not an asymmetric closed-form theorem.

## 7. Institutional validation

Current public evidence supports the primitives only at the level required by the model.

- METI's GX Strategic Area framework distinguishes place-based area selection/industrial-cluster development from a firm-facing “decarbonized-power regional contribution” investment-support channel. The framework explicitly links decarbonized power, industrial clusters, and integrated power/communications infrastructure.
- The 2026 GX regional investment-support program subsidizes large electricity-user investments conditional on use of decarbonized electricity and contribution to host power-source communities, and explicitly targets investment that strengthens industrial competitiveness.
- OECD's 2025 Japan Environmental Performance Review documents an increasing role for subnational governments in national environmental implementation and reports that about 60% of Japanese local governments have committed to net zero by 2050.

These sources support coexistence of place-based infrastructure, firm-facing green investment support, competitiveness goals, and subnational implementation. They do **not** establish that Japanese local governments independently choose both instruments exactly as in the theoretical game. The institutional section must present Japan as motivation and scope evidence, not as a literal institutional mapping.

The condition `mu>0` is likewise a scope restriction. It is defensible for energy-efficiency and process-modernization investments that lower operating costs or improve product-market position, but the paper must not imply that all environmental investment is cost reducing.

## 8. Empirical predictions after correction

Permissible predictions are:

1. cross-jurisdictional policy reactions can differ in sign across product-substitutability regimes;
2. in the canonical neighborhood, higher infrastructure productivity `nu` lowers the switching threshold;
3. in the canonical neighborhood, lower conventional-investment cost `k_x` lowers the threshold;
4. when `mu` is near zero, the product-market transmission of rival green subsidies weakens or vanishes;
5. empirical designs should allow nonlinear/threshold responses rather than impose a globally positive linear interaction between rival subsidy exposure and competition;
6. because rival `s_B` and `h_B` enter the interior continuation through the composite `y_B`, empirical identification should distinguish instrument-specific policy shocks rather than infer structural channels from a generic policy-reaction coefficient.

## 9. Kill tests

### Welfare is just transfer accounting

`PASS`. The coordination wedge contains real CS, rival PS/business-stealing, and territorial-target effects.

### Generality is only relabeling

`PASS`, with qualification. The sign reversal survives a differentiated-Bertrand interior formulation and modest ownership leakage, but these are local robustness results and are not promoted to global theorems.

### Crucial primitive lacks institutional/theoretical defense

`PASS`, within scope. `mu>0` is restricted to competitiveness-relevant green investment; `h` is interpreted as a productive shared local input. Current METI/OECD evidence supports the coexistence of these margins without being treated as a literal calibration.

### Policy implications require missing assumptions

`PASS` after narrowing. The paper does not claim global climate optimality, universal infrastructure under-provision, monotone emissions reduction from coordination, or a globally positive competition interaction.

## 10. Stage-7 verdict

`GO`.

The repaired mechanism has a coherent welfare wedge, an institutionally defensible scope, at least one alternative product-market formulation with a local sign reversal, and testable predictions that do not exceed the mathematics. The hostile-audit issues concerning the old policy-share statistic, emissions interpretation, mechanism prose, and global-linear empirical interaction are explicitly corrected.

Routing:

`Stage 7.5 — Full-Theory Freeze Decision (repeat)`.