# Post-Stage 11 revision execution and verification record — 2026-11-19 JST

## Overall disposition

**Revision work performed; Stage 6 novelty/editorial gate remains CONDITIONAL / HOLD.** The November 19 hostile referee's **ITPF Desk Reject equivalent / REOPEN Stage 6** remains the previous completed independent editorial decision and is not silently overwritten. This report documents revision implementation, not a new Stage 11 independent pass, Stage 12 acceptance, scientific theory-freeze change, ITPF submission or author attestation.

Previous referee instruction: [REVISION_PLAN.md](REVISION_PLAN.md). Branch `revision/v3-stage6-diagnostic-and-referee-repairs-20261119` (stacked on PR #32). Draft PR #33 is held unmerged.

## Gate-by-gate implementation

| Issue | Implementation | Assessment |
|---|---|---|
| B01 — closest result | `STAGE6_TARGETED_REASSESSMENT.md`, Introduction and Related Literature compare HMR ECB WP equations (7), (10)–(11), M&O Proposition1/footnote20/§4.3/official App E, Strandholm author version. Distinguish derivative directions, policy stage, regime-level comparisons, and publication versions. | Explicit comparison **completed**, independent VOR formula equality for HMR/Strandholm and Bayindir-Upmann proof not fully verified. |
| B02 — contribution value | Exact interior target–rivalry boundary `d*(θ)`, own subsidy reoptimized, common rival index and empirical falsification conditions; strict canonical global-equilibrium certificate and counterexamples recorded separately. | **Conditional/HOLD**: derivation can be an informative model-specific diagnostic, but novelty beyond generic two-policy IFT and sufficiently important journal-level welfare/policy insight remain unresolved. A new theorem and wider global feasible domain are NOT declared. |
| C01 | In `main_results.tex` added `eq:profiled-infrastructure` (Schur complement) and `tab:profiled-channels`: direct `W_hb>0` at both θ=.5 and .9, but fully profiled responses negative/positive, with same total Hessian for CS/PS/target. | Exposition repaired and values traced to independent SymPy code. |
| C02 | `robustness.tex` `tab:d-sensitivity` now separates interior root/sign counts from **d=1.5 profitable global exclusion (+.29564 at θ=.9)** and **d=3 infeasible interior h≈−.3256**. Corrected high-rivalry-first offset. | Original canonical global SPNE unaffected; no unjustified sensitivity-plane global claim. |
| A01/A02 | `model.tex` μ≥0 assumption; `equilibrium.tex` scalar firm investment and derivative/concavity/regime proof; `global_equilibrium_appendix.tex` all-branch reachability, boundary tangent and normals, exact welfare gap and theta-zero scaling/certificate table. | Based on existing certified scientific claims, no new equilibrium universality/uniqueness asserted. |
| C03/C04 | `welfare.tex` labels the feasible coordinated active-duopoly benchmark only, with increased emissions; `institutional_bridge.tex` defines normalized common y_B rival shocks, independent empirical variation and falsifiability. | No numerical welfare change or causality claim. |
| D02/D03/D04 | Reorganized Discussion/Conclusion; Figure1 caption specifies globally certified full-model vs no-x interior diagnostic; code-provenance SHA in Declarations; distinguished AI/computation/formal checking from pending **author independent verification/signoff**. | Final declarations require author approval; not represented as completed. |
| V01 | Canonical paper and code remain preserved on `main`; review/revision branch does not overwrite submission data or portfolio. Verification run SHA and PDF files tracked below. | No Stage14/new submission freeze declared. |

## Exact calculation/reproducibility evidence

- `docs/stage11_v3/recompute_stage6_target_boundary.py`: independent SymPy re-derivation of the canonical interior profiled response, exact rational `d*(θ)`, Sturm root counts/monotonicity, comparison at θ=.5 and θ=.9 for CS/PS/target, direct cross effect and Schur-complement-normalized slope.
- It is now called by both `make verify` and the repository `verify-theory` GitHub Actions symbolic-verification job.
- GitHub CI [run #44416036138](https://github.com/ryotamatsuki/strategic-local-green-policy-competition/actions/runs/44416036138), manuscript/code head `b7e28440ed954ba9ba17684bb32861cd1a079591`: **SUCCESS** in symbolic-verification (including independent target-weight script), Lean formal verification and manuscript LaTeX build.
- Later purely presentational edit to `sections/declarations.tex` shortens the unbreakable Git SHA and uses `\path{}` for the script pathname after the 27-page PDF inspection identified ~95pt and ~127pt line overflows in declarations. The final manuscript/presentation edit is SHA `1bb47db597339d4f15305e3284ddf320b675a2cb`; [GitHub Actions run #44416397841](https://github.com/ryotamatsuki/strategic-local-green-policy-competition/actions/runs/44416397841) completed **SUCCESS** for symbolic-verification (including `recompute_stage6_target_boundary.py`), Lean formal verification and manuscript-build. This certifies the PDF generated at that exact manuscript SHA, but **does not** resolve the separate scientific originality or ITPF editorial gates.

## PDF visual audit and provisional output

- The initial CI artifact at commit `fe28945d092e3e04563721c8a162a9a0f1a1767f`, GitHub run [#44415762411](https://github.com/ryotamatsuki/strategic-local-green-policy-competition/actions/runs/44415762411) compiled successfully to **27 pages**, SHA256 `d32c0c049b6d8906e79e2e1274039546695ae00c9675ca1a095262f93412077a`.
- Manuscript, Figure1, mathematical appendix and source reference tables rendered. Critically, two 95pt/127pt overfull boxes were traced to long monospace references in the **Declarations** section and fixed in the latest branch. The remaining old 1.7pt overfull warning in Appendix is minor.
- The local secondary attempt to compile the latest short-path version lacked the `bibtex` executable and could not resolve citations; its 26-page incomplete output was **rejected**, not accepted or frozen. Only a complete successful CI PDF with resolved bibliography is deliverable as a validated output.
- **Final regenerated CI PDF:** 27 US-letter pages, original CI-generated `main.pdf` SHA256 `3f288734b262e1314f2f3f997840d653fa830388e145e79ffbf550dfe482d3d3`; artifact ID `14478919088`, [run #44416397841](https://github.com/ryotamatsuki/strategic-local-green-policy-competition/actions/runs/44416397841). All 3 jobs SUCCESS. The PDF was extracted and checked by `pdfinfo`, `pdftotext`, `pdffonts`, and high-resolution rendering of the corrected declarations/references and representative formula/table pages. Long 95pt/127pt overfull warnings are gone; the only retained minor warning is 1.71451pt in the technical appendix. No missing citations, missing Figure 1, omitted pages, or obvious text clipping detected. **Stage14 final submission freeze remains unperformed**. The PDF provided to the user is a referee-ready revision draft and subject to author signoff.

## Prior-art and economic-value open risks (must not silently close)

1. HMR published-VOR mathematical identity vs ECB WP and Strandholm published-VOR vs lawful author preprint remain incompletely checked. Bayindir-Upmann theorem coverage is incomplete. Do not infer novelty from an inaccessible source.
2. The algebraic `d*(θ)` curve is mathematically verified as an **interior** sign boundary for canonical other primitives. Global SPNE is certified only at canonical `d=2` and an unquantified open primitive neighborhood; not across full d-extremes or the plotted plane.
3. The economic import of the diagnostic beyond existing multi-instrument strategic substitution models is still challenged by Stage11 reviewer. **ITPF submission path must stay ON HOLD** unless fresh Stage6 economic and novelty evidence passes after full cross-article inspection and an independent re-referee.
4. No fresh blind Stage11 editor/referee assessment of this revised text was run here. Author signoff of declarations and later fee-gate handling also remain.
5. Prior notebook / exact Python calculations / CI are **AI/computation/Lean** verification; they are not independent external human referee or author verification.

## Handoff decision

**REVISE EVIDENCE READY; PUBLICATION GATE HOLD.** The existing model was retained; all issue-specific textual, mechanism and exposition corrections requested in the plan have been implemented on a Draft branch. The unresolved next research judgment is whether the target–substitutability boundary offers a defensible policy discrimination beyond HMR/M&O and generic LQ IFT, and, if advanced as a new theorem, whether Stage4/4A and Stage7/7.5A can rigorously certify the required nonempty globally feasible region and exact quantifier scope.

**No `main` merge, ITPF portal submission, automatic paper-dashboard sync or external background monitoring was performed.**
