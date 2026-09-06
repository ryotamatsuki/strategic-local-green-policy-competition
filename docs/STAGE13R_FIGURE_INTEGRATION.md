# Stage 13R — Bounded Figure Integration and Text Revision

Date: 2026-09-06.

Canonical workflow: `ryotamatsuki/research-paper-workflow` v1.1 at release SHA `488e5ab06c207909296a7564eaf9066f7f94319c`.

Theory freeze: `SLGPC-THEORY-FREEZE-2026-09-05-v2`.

Target journal: **International Tax and Public Finance**.

## 1. Purpose and scope

This bounded Stage 13R adds one publication-standard figure that visualizes an already verified headline comparative static and integrates that figure into the Introduction and Main Results. It does not alter the model, propositions, proofs, canonical parameters, global-SPNE certificate, welfare analysis, robustness results, or contribution boundary.

**NO THEORY CHANGE.**

**NO NEW ROBUSTNESS RESULT.**

**NO CONTRIBUTION EXPANSION.**

## 2. Added figure

Figure 1 plots the actual canonical derivative `∂h_A^BR/∂s_B` over `theta in [0,1]` for:

- the full model; and
- the matched benchmark without conventional competitive investment.

The figure also shows the zero line and the verified switching threshold `theta*=0.773804386083461...`. Solid and dashed line styles make the comparison readable in grayscale.

## 3. Data and expression source

`scripts/make_figure1_threshold_response.py` reconstructs the exact reduced welfare/Hessian system from the canonical rational primitives and computes `-H_A^{-1} W_{z_A s_B}` directly. It does not plot an arbitrarily normalized switching polynomial.

For the full model, the generated derivative reproduces the existing Stage-7 post-repair checkpoint values. For the no-`x` benchmark, the conventional-investment feedback `1/k_x` is removed while the remaining canonical primitives are held fixed. The script symbolically checks that the derivative numerator contains the already reported no-`x` polynomial `602500 theta^4 - 3281550 theta^2 + 3486659` with the same common sign factor as the full-model expression.

## 4. Numerical checks

The generation script reproduces:

- full model at `theta=.5`: `-0.00455221890862445`;
- full model at `theta=.9`: `+0.007112572287111896`;
- switching threshold: `0.773804386083461`;
- full-model derivative zero at the threshold within numerical tolerance;
- matched no-`x` derivative strictly negative on a dense grid over `(0,1]`.

It additionally checks the existing baseline checkpoints at `theta=.1,.3,.5,.7,.8,.9`.

## 5. Manuscript changes

Modified manuscript files:

- `main.tex`: adds `graphicx` only.
- `sections/introduction.tex`: adds one sentence previewing Figure 1.
- `sections/main_results.tex`: adds Figure 1 after the canonical global-SPNE witness is stated; adds a bounded interpretation paragraph; connects Table `tab:br-slopes` to Figure 1; removes the now-redundant standalone non-monotonicity paragraph; and adds one sentence connecting the dashed curve to the matched no-`x` proposition.

No table values or existing proposition statements are changed. `tab:br-slopes`, `tab:d-sensitivity`, and `tab:welfare` are retained.

## 6. Figure reproducibility and CI

Added to the repository:

- `scripts/make_figure1_threshold_response.py`;
- `figures/figure1_threshold_response.pdf`.

The generator also creates `figures/figure1_threshold_response.png` as a preview during regeneration. CI is updated to regenerate Figure 1 before symbolic verification and before the LaTeX build. The Stage-14 checker now requires the generator, nonempty PDF, label, and Introduction/Main-Results references. The source ZIP includes the regenerated figure directory and generator script.

## 7. Build and visual QA

Local bounded QA before the pull request:

- figure generation: PASS;
- exact baseline regression checkpoints: PASS;
- no-`x` sign check: PASS;
- LaTeX build: PASS;
- unresolved Figure 1 reference after full build: none;
- resulting manuscript: 24 pages;
- PDF preflight: openable, unencrypted, non-scanned;
- Figure 1 page rendered and inspected: axes, legend, zero line, threshold marker, solid/dashed curves, caption, Table 1 transition, and grayscale distinction are readable; no clipping or overlap detected.

The initial float placement produced excessive whitespace on a figure-only page. The final integration uses a smaller `0.72\textwidth` top float and a shorter self-contained caption; Figure 1 now appears with the associated interpretation and Table 1 on the same page.

## 8. Hostile self-audit

- Universal switching claim: absent.
- Global monotonicity claim: absent; the figure explicitly displays non-monotonicity before the crossing.
- Conventional-investment necessity claim: absent.
- Claim that no-`x` switching is impossible for all primitives: absent; the text retains the verified counterexample qualification.
- Global-SPNE claim outside the certified canonical neighborhood: absent.
- Arbitrary polynomial normalization presented as a derivative: absent.

## 9. Remaining blocker and next stage

The only action after this bounded integration is to complete repository CI/PR verification and then rerun Stage 14 submission QA on the new 24-page package. Stage 15 remains blocked until Stage 14 re-QA is complete and the live ITPF portal fee gate is cleared.

## 10. Verdict

**`BOUNDED FIGURE INTEGRATION COMPLETE — READY FOR STAGE 14 RE-QA`**, conditional only on the pull-request CI reproducing the local checks above.
