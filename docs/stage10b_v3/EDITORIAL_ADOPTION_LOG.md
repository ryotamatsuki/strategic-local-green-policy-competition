# Stage 10B v3.0 — Exemplar Adoption and Rewrite Audit

Date: **2026-11-19 JST**. Source benchmark: \`docs/stage10a_v3/EXEMPLARY_PAPER_REGISTER.md\` and \`EDITORIAL_EXEMPLAR_MAP.md\`. Manuscript design: \`docs/stage10a_v3/MANUSCRIPT_BLUEPRINT.md\`. Frozen theory: \`SLGPC-THEORY-FREEZE-2026-09-05-v2\`. Current editorial branch is stacked on Draft Stage10A PR #30.

The cited papers were studied for their **writing construction**, not as an external verification of this manuscript's novelty, equilibrium theorem or acceptance chances. No passage was copied, and the existing economics/math source was not silently rewritten.

## Original draft → actual Stage10B prose changes

| Editorial role / role-selected source evidence | Old manuscript problem | Actual revised file/passage | Justified application and critical guard |
|---|---|---|---|
| **Problem-first Introduction** — Morita–Okoshi (2025), Introduction §1, policy-competition paradox; Lai (2026), Introduction §1, opposing directional expectations | Introduction started with a broad catalogue of place-based green policies and Japan's GX setting. Core sign question appeared only after context. | \`sections/introduction.tex\`, paragraphs 1–2: B subsidizes green investment; A could reduce or increase its infrastructure. Immediately states the cross-best-response sign question and rival economic forces. | Uses the observed *problem → competing intuitions → conditional inference* move, **not** M&O's FDI relocation claim or Lai's environmental-policy assumptions. Japan retained later as motivation. |
| **Theorem-specific contribution** — Matsumoto (2022) Introduction §1; M&O Introduction and results | The old Introduction listed many non-novel ingredients, risking an impression that novelty was only a new model cocktail. | Introduction paragraph 5 and \`sections/related_literature.tex\`, paragraphs 1–6, distinguish existing cross-instrument reactions (Hauptmeier), subsidy/infrastructure/Cournot threshold (M&O), and dual green/conventional investment (Strandholm) from our **exact signed derivative and quantified global-SPNE bridge**. | Keeps \`DISTINCT BUT NARROW\`; no first-ever fiscal-instrument or dual-investment claim. The literature objection remains a real publication risk. |
| **Abstract coherence** — Matsumoto concise theorem statement and Lai conditional competing channels | The historical abstract emphasized game architecture before the economic inference and omitted the environmental-target and emissions limits. | \`main.tex\` abstract now follows policy puzzle → game → sign threshold → necessary off-path check → exact restricted witness → no-x qualification → target intensity and emissions qualification. | Preserves true SPNE of full nonnegative-action game phrase for pre-existing independent machine contract, but explicitly limits it to canonical neighborhood, not all primitives. |
| **Proof-adjacent intuition** — Matsumoto main theorem/Appendix A.1–A.8; Lai model/results discussion of opposing forces | A symbolic derivative/strict Bernstein condition immediately followed the theorem, before unambiguous economic scope for an outside reader. | \`sections/main_results.tex\` inserts a prose paragraph after \`prop:threshold\`: derivative sign vs rivalry, *not* a discrete switch, global continuation check separate. The exact Bernstein proof and equations remain unchanged. | No omitted KKT/off-path regime checks, theorem label or quantifier changes. Keep heavy algebra in original appendices. |
| **Mechanism and target $d$** — Lai discussion and policy outcome mechanisms; M&O policy-regime explanation | A single competitiveness story risked masking the territorial-target part of the cross derivative and target dependence. | Introduction paragraphs 2/6, \`main_results.tex\` after direct CS/PS/target decomposition, Discussion paragraphs 1–2; existing \`robustness.tex\` exact $d=1.5,2,3$ table retained. | Target term is materially important at witness but not universally dominant; the target sensitivity is an *interior* diagnostic, not three new global-SPNE cases. |
| **Matched counterfactual / negative evidence** — Matsumoto precise instrument contrast | No-x result could be oversold as universal necessity of two firm investment margins. | Introduction paragraph 6, Related Literature conclusion, Discussion paragraph 3, Conclusion paragraph 2; existing \`prop:no-x\` and $\beta=1.3$ counterexample remain verbatim. | Only same-primitives benchmark separation, no statement that conventional investment is universally necessary. |
| **Welfare versus emissions** — Lai, Discussion §8 and Conclusion, explicitly separates environmental accounting | Welfare improvement under coordinated benchmark could be misread as an emissions benefit. | Abstract final sentence, Introduction paragraph 7, Discussion paragraph 5, Conclusion paragraph 2 distinguish regionally modeled welfare from emissions. Welfare section and its exact values **unchanged**. | No global first-best, climate optimality, identified CO2 reduction or policy prescription. |
| **Scope / location / empirical test** — Lai limitations and Matsumoto short conclusion | Long caveats existed but were scattered, allowing causal or national institutional overread. | Discussion paragraphs 4–7 synthesize global-equilibrium scope, local Bertrand/ownership variants, non-substitutable subsidy path, fixed location, fiscal budget/authority restrictions and nonlinearity; Conclusion retains short conditional answer. | Japanese policy discussion only illustrates functional instruments; no actual prefectural policy authority or causal estimation asserted. |
| **Exhibits and coherence** — M&O policy-regime plots, Lai comparative-static figures | Figure1 was not previewed early enough after rewriting the Introduction. | Introduction paragraph 3 adds \`Figure~\ref{fig:threshold-response}\`; existing Main Results figure, $\theta^*$, dashed no-x benchmark, exact numerical examples and captions stay unchanged. | No hand-tuned data, diagram imitation, unsupported global derivative, or new figure that changes meaning. |

## Exact changed-file inventory (compared with Stage10A branch)

Only the following manuscript files were changed:
1. \`main.tex\`: abstract prose only; title, author metadata, inputs, declarations and TeX setup unchanged.
2. \`sections/introduction.tex\`: complete prose reconstruction and explicit Figure1 preview.
3. \`sections/main_results.tex\`: adjacent commentary inserted next to \`prop:threshold\`, plus a bounded qualification beside target accounting; equations, proposition bodies, labels, tables, figure and numerical values unchanged.
4. \`sections/related_literature.tex\`: complete literature narrative rewritten around theorem object rather than ingredient novelty; uses only existing cited bibliography.
5. \`sections/discussion.tex\`: complete interpretation/limitation narrative rewritten.
6. \`sections/conclusion.tex\`: concise conditional contribution + limit reconstruction.

The Stage10A files and the new Stage10B audit-only markdown documents are additional supporting files. **The scientific source files \`sections/model.tex\`, \`sections/equilibrium.tex\`, \`sections/welfare.tex\`, \`sections/robustness.tex\`, \`sections/institutional_bridge.tex\`, the mathematical appendices, \`references.bib\`, figure generator, formal proofs and all executable verification scripts were not modified.** The historical full manuscript and submission candidate remain on protected \`main\`.

## Scientific regression anchors preserved

- $\theta^*=0.7738043861\ldots$ from the canonical rational witness; conditional one-time sign reversal of $\partial h_A^{BR}/\partial s_B$.
- The fully nonnegative policy/investment/output continuation, including potential rival-firm inactivity, must certify the canonical SPNE; the referee's formerly fatal off-branch deviation is not ruled out by mere first-order conditions.
- Direct derivative decomposition of CS, PS, territorial target and endogenous local instrument coupling.
- The exact $d=1.5,2,3$ **interior** scope tests; no independent global equilibrium claims for the other values.
- Same-primitives no-conventional-investment benchmark lacks a reversal, but the independent no-$x$, altered-$\beta$ example can reverse.
- Rival subsidy and rival infrastructure share an interior transmission index; subsidy-only causal mechanism not identified.
- Symmetric coordinated active-duopoly benchmark is second best and can raise output and territorial emissions.
- No claim of a general arbitrary-parameter global equilibrium theorem, a universal public climate recommendation or a realized policy experiment.

## Review of potential editorial regressions

**Structural improvement (preliminary editor pass):** An unbriefed specialist can now find the decision-maker and sign question in the first paragraph, competing channels in the second, a qualified claim in the third, and closest theory in the fifth. The reader can find the theorem's sign interpretation directly next to it and the strongest limitations in Discussion. This is an **authoring-stage assessment only**, not an independent Stage11 cold read; the final proof and exposition must be attacked without this note.

**Remaining publication risks:** The novelty may still be judged incremental by a field editor despite correct wording; the exact globality domain is narrow; target dependence limits external validity; the stylized fixed-location and environmental objective may be unrealistic in applications; no causal evidence. A serious Stage11 referee must be allowed to recommend rejection or rollback.

## Validation and downstream handoff

Source-level checks after this manuscript rewrite:
- Bibliography cross-check: each of the 13 bibliography entries occurs in a manuscript cite, each cited key is present, and no stale source placeholder was found.
- Abstract: **173 words**, computed by the repository's \`verify_stage14_submission_package.py\` regex equivalence; within the manuscript's ITPF 150–250-word gate.
- Main Results changes do not modify any named theorem, mathematical display, labeled equation, chart file, or numerical checkpoint; this must remain true after later edits.
- Pre-existing \`verify_stage10r_manuscript.py\` identity string and Stage14 Figure1 reference were preserved/restored following authoring-stage checks.
- Executable tests, clean PDF build, PDF page count, font inspection and CI are recorded only if/when jobs actually finish; an authoring claim is not a substitute for passing CI.

Next action: complete build/reproducibility gate on the **exact PR head**, inspect generated PDF and run independent Stage11 editor/referee test. If pending/failing, the Stage10B verdict remains conditional.

**Status: manuscript and adoption ledger rewritten and stored; Stage10B final unconditional verdict depends on actual build evidence.**
