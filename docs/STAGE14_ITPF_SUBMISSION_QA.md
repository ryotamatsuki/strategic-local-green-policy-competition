# Stage 14 — ITPF Submission QA

Date: 2026-09-06.

Canonical workflow: `ryotamatsuki/research-paper-workflow` v1.1, `templates/STAGE_14_SUBMISSION_QA.md` and `checklists/SUBMISSION_CHECKLIST.md` at release SHA `488e5ab06c207909296a7564eaf9066f7f94319c`.

Theory freeze: `SLGPC-THEORY-FREEZE-2026-09-05-v2`.

Primary target: **International Tax and Public Finance (ITPF)**.

## 1. Executive verdict

**`CONDITIONAL PASS — LIVE PORTAL FEE GATE ONLY`**.

No substantive, mathematical, novelty, reproducibility, citation, source-package, metadata, declaration, or PDF-layout defect remains.

Previously open factual metadata gates have now been resolved from author information already confirmed in prior journal-submission records and inserted consistently in the ITPF package:

- author: Ryota Matsuki;
- affiliation: Independent Researcher;
- location: Matsuyama, Ehime, Japan;
- corresponding-author email: ryota.matsuki@gmail.com;
- ORCID: 0009-0005-2329-531X;
- Funding: No external funding supported this work.;
- Competing interests: The author declares that he has no competing interests.;
- single-author CRediT metadata prepared for the submission interface.

The only remaining condition is the project's external zero-submission-fee hard gate: the live ITPF portal must not request a mandatory submission fee or payment.

## 2. Current ITPF requirement audit

The current official pages checked on 2026-09-06 are:

- `https://link.springer.com/journal/10797/submission-guidelines`
- `https://link.springer.com/journal/10797/how-to-publish-with-us`

The package now satisfies the publicly verifiable requirements for a regular article:

- editable LaTeX source retained together with compiled PDF;
- abstract: **157 words**, within the current 150--250-word requirement;
- keywords: **5**, within the current 4--6 requirement;
- JEL codes: **6** and present;
- title present and stable;
- author name, affiliation/location, active corresponding-author email, and ORCID present;
- Data Availability statement present;
- Code Availability statement present;
- Funding statement present;
- Competing Interests statement present;
- Author Contributions/CRediT metadata prepared for the submission interface;
- substantive generative-AI use disclosed transparently;
- bibliography and DOI metadata checked;
- all bibliography entries cited;
- no ITPF-specific double-blind requirement identified in the current instructions.

The official publishing page states that the subscription publishing model has **no APC charges**. Optional open access carries an APC and is not the project route.

## 3. Machine and mathematical verification

Final post-metadata verification commit before removal of the non-required postal code: `67147c20c871538a334b6559bc7a4ab6af8bf925`.

GitHub Actions run: `34005056160` (`verify-theory`, run #65).

Result: **SUCCESS**.

Successful checks include:

- `verify_stage9r_alignment.py`;
- `verify_stage10r_manuscript.py`;
- `verify_freeze.py`;
- `verify_stage4rg_global.py`;
- `verify_nox_global_counterexample.py`;
- `verify_stage7_postrepair.py`;
- `verify_stage10.py`;
- `verify_stage11r_target_scope.py`;
- `verify_stage14_submission_package.py`;
- `pytest`: **9 passed**;
- LaTeX build;
- nonempty PDF check;
- unresolved citation/cross-reference rejection check;
- source-ZIP construction and artifact upload.

The Stage-14 checker enforces the finalized metadata/declarations rather than treating them as optional human gates. It reports author metadata, Funding, and Competing Interests as ready.

The frozen numerical invariants continue to reproduce, including `theta_star=0.7738043861`, the Stage-4R-G global-SPNE gaps, the no-conventional-investment counterexample, welfare calculations, robustness values, and Stage-11R target-scope signs.

## 4. Citation and bibliography QA

PASS.

All 13 entries in `references.bib` are cited in the manuscript, and the machine checker rejects unknown or uncited keys. Full DOI links are exposed in the rendered `apalike` reference list where verified. No unverifiable DOI was inserted.

## 5. Source-package QA

PASS as of run #65; a fresh build is required after the postal-code-only metadata cleanup before Stage 15 freeze.

The Stage-14 build artifact `stage14-itpf-manuscript` contains:

- `main.pdf`;
- `main.log`;
- `itpf-source.zip` containing `main.tex`, `references.bib`, and the complete `sections/` tree.

The run #65 hashes are retained only as the immediately preceding verified state. They must not be used as the Stage-15 freeze hashes after the postal-code cleanup.

## 6. PDF visual QA

PASS for the immediately preceding post-metadata build; the postal-code deletion is a title-page-only metadata cleanup and requires a fresh final build before freeze.

The run #65 PDF contained 23 pages and had no clipping, overlap, broken glyph, unresolved reference, or table-layout blocker.

## 7. Manuscript metadata and declarations

READY.

- Title: ready.
- Author: Ryota Matsuki.
- Affiliation: Independent Researcher.
- Location: Matsuyama, Ehime, Japan.
- Corresponding-author email: ryota.matsuki@gmail.com.
- ORCID: 0009-0005-2329-531X.
- Abstract: ready.
- Keywords: ready.
- JEL: ready.
- Funding: ready.
- Competing Interests: ready.
- Data Availability: ready.
- Code Availability: ready.
- Generative-AI disclosure: ready.
- Author Contributions/CRediT metadata: ready for the submission interface.

Postal code and phone details are deliberately omitted from the public manuscript/package because the public title-page guidance does not require them; they should be entered only if the private submission form explicitly requires such fields.

## 8. Cover letter and submission-system metadata

READY.

`submission/itpf/cover_letter_body.md` contains the final signatory block without a postal code.

`submission/itpf/metadata.md` contains copy-ready:

- author/affiliation/corresponding-author metadata;
- ORCID;
- title;
- abstract;
- keywords;
- JEL codes;
- single-author CRediT statement;
- Funding;
- Competing Interests;
- Data Availability;
- Code Availability;
- generative-AI disclosure;
- zero-fee portal instruction.

Suggested reviewers are not treated as a mandatory Stage-14 file because current ITPF guidance does not make a repository reviewer list a prerequisite for readiness.

## 9. Zero-fee gate

Official current Springer information confirms that ITPF's subscription publishing route carries no APC. This satisfies the mandatory-publication-charge side of the project constraint.

The live portal remains authoritative for any submission charge. The hard gate is:

> If the ITPF submission workflow displays any mandatory submission fee or payment requirement, STOP before payment and return to Stage 12 journal positioning.

This portal-only condition cannot be certified from the repository or the public publishing page.

## 10. Change-scope audit

No theory change, new proposition, new robustness result, or contribution expansion was made in closing the Stage-14 metadata gates or removing the non-required postal code.

Changes are limited to:

- author/title-page metadata;
- Funding and Competing Interests declarations;
- final cover-letter signature block;
- copy-ready Author Contributions/CRediT metadata;
- QA automation that requires these finalized fields;
- removal of the non-required postal code from public submission materials;
- updated QA/provenance records.

The theory freeze remains valid.

## 11. Stage 15 entry condition

**Stage 15 remains blocked only by a fresh post-cleanup build and the live portal fee gate.**

Before creating the immutable submission freeze:

1. confirm the post-cleanup verification/build passes;
2. enter the ITPF live submission workflow;
3. confirm that no mandatory submission fee or payment requirement is presented;
4. if any mandatory fee appears, STOP before payment and return to Stage 12;
5. once the fee gate is clear, create the Stage-15 freeze from the validated package;
6. before the final submit action, compare any portal-generated manuscript PDF against the frozen source/PDF.

No earlier theory or manuscript-construction stage needs to be reopened.
