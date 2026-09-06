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

The generator also creates `figures/figure1_threshold_response.png` as a preview during regeneration. CI regenerates Figure 1 before symbolic verification and before the LaTeX build. The Stage-14 checker requires the generator, nonempty PDF, label, and Introduction/Main-Results references. The source ZIP includes the regenerated figure directory and generator script.

Pull request: **#16 — `Stage 13R: bounded figure integration`**.

Substantive implementation head checked by CI: `59dec8cb7dd4c0aa22675bfbee23cebd37052a71`.

GitHub Actions run: `34007273858` (`verify-theory`, run #71).

Result: **SUCCESS** for both `symbolic-verification` and `manuscript-build`.

The run regenerated Figure 1 before verification and build, passed the complete Stage 9R/10R/freeze/global-SPNE/no-`x`/Stage-7/Stage-10/Stage-11R checks, passed the figure-aware Stage-14 machine checker, and reported **9 pytest tests passed**.

## 7. Build and visual QA

Local bounded QA and PR-artifact QA both pass.

The PR-generated artifact is `stage14-itpf-manuscript`:

- artifact ID: `9981369722`;
- artifact digest: `sha256:550ee4803ff88b2790f5326df1b9c80ca36c6f352bccb890680a0daf28dc3cf5`;
- generated `main.pdf` SHA-256: `4fe4c00cc3fd1e926d4705dcdfd66d9063560323919c94d11efa728a27dddaea`;
- generated `itpf-source.zip` SHA-256: `05169e62bc88e0cdd1d69758dbe3227598c62a6de1882b9dae131e05017646ad`;
- regenerated Figure 1 PDF SHA-256 inside the source ZIP: `1f07e10bdd01af9b351f9fbe512d8cafdf62d661cda6451814c55e01e2bedd7e`;
- regenerated PNG preview SHA-256: `abf3af527fc578e17ac228340360de95612ad0b23f7ccc8edc793a3a778d5e11`.

The manuscript is **24 pages**, openable and unencrypted. The actual PR-generated PDF was rendered and Figure 1 on page 10 inspected. Axes, legend, zero line, threshold marker, solid/dashed curves, caption, Table 1 transition, and grayscale distinction are readable; no clipping, overlap, broken glyph, or float-placement blocker was found.

The initial local float placement produced excessive whitespace on a figure-only page. The final integration uses a smaller `0.72\textwidth` top float and a shorter self-contained caption; Figure 1 now appears with the associated interpretation and Table 1 on the same page.

## 8. Hostile self-audit

- Universal switching claim: absent.
- Global monotonicity claim: absent; the figure explicitly displays non-monotonicity before the crossing.
- Conventional-investment necessity claim: absent.
- Claim that no-`x` switching is impossible for all primitives: absent; the text retains the verified counterexample qualification.
- Global-SPNE claim outside the certified canonical neighborhood: absent.
- Arbitrary polynomial normalization presented as a derivative: absent.
- Proposition/proof/table-value changes: absent.

## 9. Remaining blocker and next stage

Stage 13R has no remaining substantive or presentation blocker. The next required step is **Stage 14 re-QA** on the new 24-page package. Stage 15 remains blocked until Stage 14 re-QA is complete and the live ITPF portal fee gate is cleared.

## 10. Verdict

**`BOUNDED FIGURE INTEGRATION COMPLETE — READY FOR STAGE 14 RE-QA`.**
