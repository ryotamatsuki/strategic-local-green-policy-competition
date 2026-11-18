# Stage 10B v3.0 Gate Report — Green Subsidies rewritten manuscript

**Date:** 2026-11-19 JST  
**Verdict:** **FULL DRAFT READY FOR REFEREE GATE** — Stage 10B GO to Stage 11, **NOT** Stage 11 PASS or Stage 14 final submission certificate.  
**Project:** *Green Subsidies, Public Infrastructure, and Product-Market Rivalry: When Cross-Instrument Responses Reverse*  
**Target:** *International Tax and Public Finance*, regular theoretical public-finance paper.  
**Workflow:** \`ryotamatsuki/research-paper-workflow@v3.0\`, Stage10A → Stage10B.  
**Frozen theory:** \`SLGPC-THEORY-FREEZE-2026-09-05-v2\`.

## Stage entry, production branch, and exact reproducibility

- Stage10A GO: \`docs/stage10a_v3/STAGE10A_GATE_REPORT.md\`, Draft PR #30, complete exemplars + role map + blueprint. The earlier v1.1 draft was created **before** v3.0; this is a documented *prospective rewrite*, not fabricated retroactive compliance.
- Stage10B manuscript rewrite branch: \`editorial/v3-stage10b-green-subsidies-rewrite-20261119\`, stacked Draft PR #31 with parent \`editorial/v3-stage10a-green-subsidies-20261119\`. Original \`main\` and its original publication package remain unchanged.
- **Exact manuscript-source verification commit:** \`f6996432c463482355cef653e9ad77b236132e0d\`.
- **GitHub Actions:** [run #44406847110](https://github.com/ryotamatsuki/strategic-local-green-policy-competition/actions/runs/44406847110), head \`f6996432c463482355cef653e9ad77b236132e0d\`, **conclusion SUCCESS**:
  - \`symbolic-verification\` — SUCCESS (Stage9R/10R, exact theory/witness, global SPNE, no-x, target d, package and pytest checks).
  - \`lean-verification\` — SUCCESS (pinned Lean kernel build and axiom audit).
  - \`manuscript-build\` — SUCCESS (regenerated Figure1, font audit, latexmk, references, archive and artifact upload).
- After the successful run, comparison of the source-verified commit to this Stage10B branch showed changes **only** in the supporting markdown files \`docs/stage10b_v3/EXPOSITION_ARCHITECTURE.md\` and \`docs/stage10b_v3/EDITORIAL_ADOPTION_LOG.md\` (no manuscript or executable edits). This report is likewise documentation-only; any future manuscript change requires fresh tests.
- Artifact: \`stage14-itpf-manuscript\`, GitHub artifact ID \`14476750122\`, archive digest \`sha256:32990f6dffde9f8e4b7c94333e25821520350443e171bb300fd4b4934bba69e8\`. Here "stage14" is the historical build-artifact name, **not** a new current Stage14 scientific verdict.

## Actual PDF / formatting audit

The generated draft \`main.pdf\` from that run was retrieved and visually inspected:
- **24 letter-size pages**, no blank pages, no missing Introduction/References/Appendix, and no unrenderable or page-clipped text blocks on the PDF page boundaries.
- A contact sheet reviewed all 24 pages; the title page, revised Introduction, Main Results/Figure1, Related Literature, Discussion, Conclusion and proof appendix were sampled in higher resolution.
- All fonts in the compiled PDF are embedded; Figure1 passed the workflow's embedded-font check. Core mathematical proofs, figure, tables and citations render visibly.
- **Minor nonblocking warning:** the TeX log reports one overfull hbox of approximately **1.7 pt** at line 102 (not an unresolved citation, missing figure or output clipping). Keep as a typesetting-polish item for the later final package; do not disguise it as a mathematical failure.
- The rebuilt PDF's SHA-256 is \`414582425c9e239e90a9f97984519f9ed8ea8be85d186eb9b04cf1ae61cfd881\`; size is 351,569 bytes. This PDF is a **Stage10B referee draft**, not a frozen submission object.

## Source-file change and evidence ledger

| File | Actual authoring work | Frozen-theory guard |
|---|---|---|
| \`main.tex\` | Abstract rewritten around question, conditional sign finding, global continuation and main limits; 173 words. | Title/author/JEL/keyword/section inputs and declarations unchanged; old machine-verification phrase "true SPNE of the full nonnegative-action game" preserved in its correct restricted sense. |
| \`sections/introduction.tex\` | Complete puzzle-first rewrite, contending channels, exact scoped result, closest prior theorem and major limitations; Figure1 sign preview restored. | No new empirical fact or global-primitives theorem; Japan used as illustration. |
| \`sections/main_results.tex\` | Directly adjacent plain-language interpretation of sign change and a target-intensity qualifier. | Labels, proposition/corollary environments, displayed equations, numerical witness, existing figure and tables unchanged. |
| \`sections/related_literature.tex\` | Full theorem-level confrontation with Hauptmeier/Morita–Okoshi/Strandholm; rejects ingredient-count novelty and leaves genuine editorial novelty risk. | No unsupported theorem claim imported from writing exemplars; all source keys verified. |
| \`sections/discussion.tex\` | Substantive rewrite emphasizing target \`d\` dependence, no-x exceptions, subsidy/infrastructure proportionality, globality scope, welfare/emissions and institutional/causal limits. | All negative evidence preserved; no universal climate claim. |
| \`sections/conclusion.tex\` | Two-paragraph conditional result and precise limit. | No expanded proposition or policy prescription. |

No change to \`model.tex\`, \`equilibrium.tex\`, \`welfare.tex\`, \`robustness.tex\`, \`institutional_bridge.tex\`, mathematical appendices, figures, bibliography, scripts, formal checks or any submitted manuscript.

## Mandatory architecture and exhibits

- Reader-arrival budget, section roles, main-text/appendix bridge, five-exhibit scarcity thought experiment and figure/table source map documented in \`EXPOSITION_ARCHITECTURE.md\`.
- Role-by-role use of three fully inspected writing exemplars, actual revised locations and justified omissions documented in \`EDITORIAL_ADOPTION_LOG.md\`.
- The one economic question is visible in Introduction paragraph 1, the opposing forces in paragraph 2, and the theorem's scope in paragraph 3. The explicit derivative condition and direct/indirect policy channels appear beside the certified theorem, not just in Discussion.
- Existing generated Figure1 and \`d\`-scope/welfare/response tables continue to serve their original interpretive roles. No artificial extra exhibit, made-up numerical result or change to figure generator.
- References: all 13 \`references.bib\` entries are cited in the manuscript, all manuscript citation keys resolve in that file; no stale TODO placeholders.
- Submissions: **not submitted** to ITPF. The mandatory live submission-fee gate remains unresolved and is **not** a reason to reopen the mathematical theory in a prose rewrite.

## Initial reading-order evaluation, clearly not independent Stage 11

A normal first-pass reading now reaches (i) the jurisdiction's own infrastructure response to a rival subsidy, (ii) why competition and territorial targets can produce opposite effects, (iii) a unique but conditional sign crossing, and (iv) a direct closest-paper confrontation before the formal model. The theorem discussion labels the global-equilibrium claim separately, and the Discussion makes major negative evidence explicit. This is an **authoring-stage structural check**, not an independent uninformed referee and not a finding that editorial significance is sufficient.

## Known risks and required Stage 11 attack

1. Field-journal editor may still consider the conditional sign-reversal theorem a narrow combination of known fiscal and environmental-IO components; the new prose cannot prove novelty or journal importance.
2. An independent reader must check whether "cross-instrument response" is understandable without private explanations and whether the main economic mechanism remains overly composite.
3. Verify whether the accessible close prior work contains a theorem absorbing the apparent cross-derivative result; if so, return to Stage6 rather than polishing further.
4. Hostile mathematical referee must independently reproduce FOC → sign polynomial → root conditions and the separate global off-branch policy checks without silently extending globality.
5. Guard the real limitations: \`d\`-dependence, non-necessity of conventional investment, relative subsidy/infrastructure shock index, restricted coordinated welfare, potentially increased emissions, fixed plants and lack of policy-identifying data.
6. Recheck ITPF-specific prose and formatting at Stage12/13 after editorial revisions; rerun exact PDF at Stage14. The existing 24-page preview and full green CI are **Stage10B build evidence only**.
7. No direct journal submission, live portal declarations, fee payment, archival version tag or dashboard auto-sync is authorized by this draft.

## Final certified Stage 10B disposition

**FULL DRAFT READY FOR REFEREE GATE.** Stage10A GO was satisfied; a coherent manuscript rewrite was actually committed; native CI symbolic, Lean and LaTeX jobs all passed at the manuscript head; PDF was inspected; the source bibliography and scope guardrails remain intact. The next substantive stage is **Stage 11 independent hostile referee/editorial cold-read**, which may still reject the manuscript's contribution or require further rewriting.

The Stage10B PR remains **Draft and unmerged** pending independent Stage11 and author-controlled gates. Portfolio automatic synchronization remains disabled.
