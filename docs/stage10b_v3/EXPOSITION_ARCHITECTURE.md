# Stage 10B v3.0 — Exposition and Figure/Table Architecture

Prepared: **2026-11-19 JST**, on editorial rewrite branch. Parent: Stage10A [blueprint](../stage10a_v3/MANUSCRIPT_BLUEPRINT.md), [role map](../stage10a_v3/EDITORIAL_EXEMPLAR_MAP.md). Provisional venue: *International Tax and Public Finance* (regular theoretical article). Frozen model: **SLGPC-THEORY-FREEZE-2026-09-05-v2**. Reader-facing rewrite only.

## The paper's single economic question

If jurisdiction B raises the firm-facing green-investment subsidy, when does jurisdiction A's optimal productive green infrastructure response change from contraction to expansion as product substitutability rises?

The **dependent object is a signed local infrastructure best-response derivative**, not a discrete policy switch, a level comparison of own infrastructure with/without fiscal competition, or a global climate-policy prescription. The result is conditional on the stated firm-stage regularity, government strict concavity and polynomial threshold inequalities. The global-policy-equilibrium bridge is proven on a rational canonical configuration and nonempty open neighborhood, **not all primitives**.

## Reader-arrival budget and actual revised source locations

| Reader should learn | Source location / passage in revised text | Diagnostic target |
|---|---|---|
| Puzzle and relevant decision maker | \`sections/introduction.tex\`, paragraph 1, opening rival subsidy vs own infrastructure. | First 1–2 paragraphs; no notation needed. |
| Opposing forces and the role of territorial target | Introduction paragraph 2, then \`main_results.tex\` immediately after Eq. \`eq:cross-instrument-general\`. | Before full formal model; revisited immediately beside result. |
| Surviving conditional inference and global equilibrium limitation | Introduction paragraph 3; \`main.tex\` abstract; proposition \`prop:threshold\`; \`prop:global-spne\` in Equilibrium. | No later than opening page for scoped statement; exact page checked after PDF build. |
| Prior work's closest theorem-level distinctions | Introduction prior-literature paragraph; Related Literature paragraphs 2–4. | Before or at first result interpretation, not buried in conclusion. |
| Frozen model/action set | Model section and Equilibrium section. | Before mathematical theorem, with kink/monopoly out-of-branch warning. |
| Signed derivative and certification argument | Main Results \`eq:br-ift\`, \`eq:cross-instrument-general\`, \`eq:P-sign\`, \`prop:threshold\`, canonical witness. | Main paper, not only appendix/code. |
| Mechanism immediately after theorem | New text in Main Results between \`prop:threshold\` and proof paragraph; Economic mechanism subsection with exact CS/PS/target decomposition. | Directly next to theorem, not Discussion only. |
| Graph and non-necessity | Generated Fig. \`fig:threshold-response\`; \`prop:no-x\`, counterexample paragraph. | Figure shown in results with caveat in Introduction and Discussion. |
| Distinct welfare/emissions comparison | \`sections/welfare.tex\`, first interpretation; Discussion paragraph 5. | Before climate-policy inference. |
| Empirical/institutional scope | \`sections/institutional_bridge.tex\`, Related Literature and Discussion last paragraphs. | Before concluding recommendation; causal test not claimed as performed. |
| Binding limitations | Introduction paragraphs 3, 6–7; Main Results economic interpretation; Robustness table \`tab:d-sensitivity\`; Discussion paragraphs 2–7. | Each limitation attached to the associated claim and synthesized non-repetitively. |

## One-job-per-section map

| Source | Dominant role | Core / helpful / appendix / delete rule |
|---|---|---|
| Abstract | A complete conditional claim and one substantial limit. | **CORE**: problem, result, globally certified scope, no-x and emissions. Eliminate speculative policy prescriptions. |
| Introduction | Economic puzzle → opposing forces → precisely bounded theorem → closest prior art → limits. | **CORE**: signed reaction. **HELPFUL**: brief Japanese GX context at end. **DELETE** repetitive negatives and motivation catalog. |
| Model | Players, timing, nonnegative feasible actions, payoffs and objective. | **CORE**: no hard budget, fixed plant locations, $\mu>0$ where needed; no new primitives. |
| Equilibrium | Why interior-only arguments fail; full five regimes; global bridge. | **CORE**: duopoly/kink/monopoly and global-policy deviation. **APPENDIX** exhaustive algebra without dropping proof bridge. |
| Main Results | Derivative/sign theorem, immediate intuition, canonical verification, Figure1, matched no-x. | **CORE**: Eq. \`eq:br-ift\` → \`eq:P-sign\` → \`prop:threshold\`; no claim inflation. |
| Welfare | Second-best restricted benchmark and local emissions tradeoff. | **HELPFUL**: welfare consequence (not a separate global climate theorem). |
| Robustness | Identify surviving local mechanism and conditions that eliminate switch. | **HELPFUL**: d table, Bertrand/local capture. **DELETE** universal inference from local checks. |
| Institutional Bridge | Functional policy interpretation + falsifiable nonlinear prediction. | **HELPFUL**: Japan only motivation, empirical tests hypothetical. |
| Related Literature | Direct closest-theorem and structural-overlap comparison. | **CORE**: Hauptmeier, Morita–Okoshi and Strandholm contrasts. **DELETE** novelty-by-ingredient lists. |
| Discussion | What the result changes economically, what it cannot support, how to test it. | **CORE**: interpretation and material limits, not a summary of numerical tables. |
| Conclusion | One conditional new inference with one decisive boundary. | **CORE**: short, claim-accurate, no new proposition. |
| Appendices | Preserve all regime, polynomial, KKT and source-code verification steps. | **APPENDIX** unchanged; main text must still expose essential bridges. |

## Headline-result exhibit map

| Result | Object | Main vehicle | Verified source | Scope guard |
|---|---|---|---|---|
| Unique signed response threshold | $\partial h_A^{BR}/\partial s_B$ as $\theta$ changes. | Proposition \`prop:threshold\` + immediate mechanism; Figure1. | Existing frozen symbolic proof, Bernstein tests and \`scripts/make_figure1_threshold_response.py\`. | Conditional interior theorem; global bridge separate. |
| Global equilibrium validity | Whether the candidate survives off-path policy deviations leading to rival inactivity. | Proposition \`prop:global-spne\`, text/appendix regime bridge. | Stage4R-G global counterexample repair and exact gap certificate. | Canonical witness and open neighborhood only. |
| Matched no-$x$ comparison | Cross-response without conventional investment. | Proposition \`prop:no-x\`, dashed Figure1 curve, no-x negative evidence paragraph. | Frozen \`verify_nox_global_counterexample.py\`, prior exact roots. | No claim that $x$ is universally necessary. |
| Territorial target sensitivity | Interior cross-response signs at $d=1.5,2,3$. | Existing table \`tab:d-sensitivity\` in Robustness. | \`verify_stage11r_target_scope.py\` exact root count. | Interior comparative static only; not global SPNE for each $d$. |
| Modeled welfare and emissions | Restricted coordinated vs decentralized outcomes. | Existing welfare table + concise discussion. | \`verify_stage7_postrepair.py\`. | Welfare can rise with emissions; not world first best. |
| Product-market/ownership robustness | Bertrand and $\omega=.9$ local response. | Existing robust result prose. | Frozen verifiers. | Local only; boundary around $\theta=.545$ in Bertrand. |

## Five-exhibit scarcity thought experiment

If only five scientific exhibits were permitted, preference order would be: (1) **essential** verified Figure1 sign/benchmark graph; (2) target-weight $d$ sensitivity table clarifying a binding mechanism condition; (3) existing restricted welfare and emissions table to prevent environmental overclaim; (4) existing signed response table for transparent canonical numerical checkpoints (could be omitted if Figure1 carries the contrast); (5) a prose-only equilibrium-regime map rather than another decorative chart. Existing figures/tables are retained, not duplicated. No new graphic created merely to meet a figure quota.

## Consistency and manuscript limits

- **Mathematics:** keep proposition statements, equation numbers/labels, parameter values and figure generator frozen. A new insight cannot enter as an asserted theorem without scientific rollback.
- **Reference sources:** 13 recorded bibliography items are presently cited and all citation keys resolve; check this again in CI and final LaTeX PDF.
- **Exemplar technique selection:** Morita–Okoshi for problem-first paradox/policy setting, Matsumoto for compact theorem–appendix economy, Lai for explicit opposing forces and environmental outcome distinctions. Source techniques are synthesized into original prose; model assumptions/proofs are NOT imported.
- **Page budget:** no artificial minimum/maximum. Current known source baseline was a 24-page manuscript; new PDF page count is **pending build** and must not be claimed unchanged.
- **Post-stage testing:** existing verify-theory symbolic, Lean and latexmk GitHub Actions workflow; exact final PDF visual QA and a source-uninformed Stage11 editorial attack are separate obligations.

**Status:** architecture pass as a writing plan, conditional on the rebuilt manuscript's executable and PDF-level checks. The branch is NOT a certified submitted PDF.
