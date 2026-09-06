# Stage 14 — ITPF Submission QA

Date: 2026-09-06.

Canonical workflow: `ryotamatsuki/research-paper-workflow` v1.1, `templates/STAGE_14_SUBMISSION_QA.md` and `checklists/SUBMISSION_CHECKLIST.md` at release SHA `488e5ab06c207909296a7564eaf9066f7f94319c`.

Theory freeze: `SLGPC-THEORY-FREEZE-2026-09-05-v2`.

Primary target: **International Tax and Public Finance (ITPF)**.

Stage 14 branch: `stage14-itpf-submission-qa`.

## 1. Executive verdict

**`CONDITIONAL PASS`**.

No substantive, mathematical, novelty, reproducibility, citation, source-package, or PDF-layout defect was found. The manuscript is technically ready for submission once four factual/external gates are closed:

1. official author/affiliation/corresponding-author metadata;
2. Funding statement;
3. Competing Interests statement, including any applicable non-financial interest;
4. live ITPF submission-portal confirmation that no mandatory submission fee is requested.

These are non-substantive submission facts. They do not justify reopening the theory. Stage 15 is nevertheless blocked until they are resolved because they are required for an accurate submission record.

## 2. Current ITPF requirement audit

The current official pages checked for this QA are:

- `https://link.springer.com/journal/10797/submission-guidelines`
- `https://link.springer.com/journal/10797/how-to-publish-with-us`

The package satisfies the requirements that can be verified without author-specific factual declarations:

- regular-article route selected;
- editable LaTeX source retained together with compiled PDF;
- abstract: **157 words**, within the current 150--250-word requirement;
- keywords: **5**, within the current 4--6 requirement;
- JEL codes: **6** and present;
- title present and stable;
- Data Availability statement present;
- Code Availability statement present;
- substantive generative-AI use disclosed transparently;
- bibliography and DOI metadata checked;
- all bibliography entries cited;
- no ITPF-specific double-blind requirement was identified in the current instructions; the journal instead requests author/title-page metadata.

The official publishing page states that the subscription publishing model has no APC. The repository's stricter zero-fee rule remains in force because a live submission charge cannot be ruled out solely from the publishing page.

## 3. Machine and mathematical verification

Pull request #15 runs the complete existing verification suite plus a Stage-14 package checker.

Final verified manuscript commit before this audit record: `e13e68597af93ad50bcc27524d8bafb3f1b0d79b`.

GitHub Actions run: `34003198125` (`verify-theory`, run #55).

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

The Stage-14 checker reports:

- `abstract_words=157`;
- `keywords=5`;
- `jel_codes=6`;
- `bibliography_entries=13`;
- `citations_resolved=13`;
- `author_metadata_ready=False`.

The last item is a deliberate factual gate, not a technical failure.

The frozen numerical invariants continue to reproduce, including `theta_star=0.7738043861`, the Stage-4R-G global-SPNE gaps, the no-conventional-investment counterexample, welfare calculations, robustness values, and Stage-11R target-scope signs.

## 4. Citation and bibliography QA

PASS.

All 13 entries in `references.bib` are cited in the manuscript, and the machine checker rejects unknown or uncited keys. The bibliographic metadata of the principal theoretical and institutional references were cross-checked against publisher/official sources during Stage 14.

Because the manuscript uses `apalike`, which does not reliably print the `doi` field by itself, Stage 14 adds full `https://doi.org/...` links in the printable note field for entries with verified DOIs. No DOI was invented for the Bayindir-Upmann emissions article where a DOI was not independently confirmed.

## 5. Source-package QA

PASS.

The build job produces `stage14-itpf-manuscript`, containing:

- `main.pdf`;
- `main.log`;
- `itpf-source.zip` containing `main.tex`, `references.bib`, and the complete `sections/` tree.

For the final inspected artifact from run #55:

- GitHub artifact ID: `9980120378`;
- artifact digest: `sha256:85546ab3269e87a44b81b61c2e5b3640b86a208ccb63db6deca6e61bad6633d4`;
- inspected `main.pdf` SHA-256: `ff7d92d7d15a35c8e89a66a47083370f3bc62be5be4e6eb2edc6bb99c5fdfa7e`;
- inspected `itpf-source.zip` SHA-256: `aa00f524e83ee2e26e92abefbcf2f6073cd9610e0b275434434fff4871180440`.

## 6. PDF visual QA

PASS, subject only to the intentionally blank author metadata.

The actual CI-generated PDF was downloaded, rendered at 160 dpi, and all **23 pages** were inspected. The review found:

- no clipped prose or equations;
- no overlapping text;
- no broken glyphs or black squares;
- no missing table content;
- no unresolved `??` references;
- no stale `TODO`, `TBD`, `FIXME`, or placeholder tokens in manuscript sources;
- tables remain inside the text area;
- appendix equations remain legible;
- reference URLs remain readable;
- hyperlink border boxes were removed with `hidelinks` for a cleaner submission PDF;
- paragraph overfull warnings were eliminated with `\emergencystretch`.

The final log retains one negligible 1.71451pt display-math overfull warning in the long appendix polynomial and three underfull warnings. Visual inspection confirms that the equation is not clipped and remains within usable page space. This is not a submission blocker.

## 7. Manuscript metadata and declarations

### Verified and ready

- Title: ready.
- Abstract: ready.
- Keywords: ready.
- JEL: ready.
- Data Availability: ready.
- Code Availability: ready.
- Generative-AI disclosure: ready, provided it accurately describes the author's actual review and verification.

### Factual human gates

The repository does not contain authoritative values for the following fields, and Stage 14 does not infer them from GitHub ownership or prior context:

- official author name;
- affiliation and postal affiliation details;
- active corresponding-author email;
- ORCID, if any;
- Funding statement;
- Competing Interests statement.

These must be provided by the author before Stage 15. Once supplied, the same values must be inserted consistently in `main.tex`, `sections/declarations.tex`, the cover-letter signature block, and the live submission form.

## 8. Cover letter and submission-system metadata

A target-specific cover-letter body and copy-ready metadata record are prepared under `submission/itpf/`.

The cover letter deliberately avoids certifying factual matters that have not yet been supplied. The final signatory block must be inserted before Stage 15.

Suggested reviewers are not treated as a mandatory Stage-14 file because current ITPF guidance welcomes suggestions but does not make a repository reviewer list a prerequisite for manuscript readiness.

## 9. Zero-fee gate

Official current Springer information confirms that ITPF's subscription publishing route carries no APC. This satisfies the mandatory-publication-charge side of the project's constraint.

The live portal remains authoritative for any submission charge. The gate is therefore:

> If the ITPF submission workflow displays any mandatory submission fee or payment requirement, STOP before payment and return to Stage 12 journal positioning.

Stage 14 cannot certify this portal-only condition from the repository or public journal pages.

## 10. Change-scope audit

Stage 14 made no theory changes and added no robustness result. Changes are limited to:

- submission QA automation;
- DOI-link rendering;
- submission metadata/cover-letter preparation;
- PDF artifact generation;
- `hidelinks` and emergency paragraph stretching for clean rendering;
- this QA record.

The theory freeze remains valid.

## 11. Stage 15 entry condition

**Stage 15 must not begin yet.**

Entry requires all of the following:

1. factual author/title-page metadata supplied and inserted;
2. Funding supplied and inserted;
3. Competing Interests supplied and inserted;
4. final cover-letter signatory block completed;
5. live ITPF portal checked and no mandatory submission fee requested;
6. portal-generated submission PDF compared against the verified source/PDF before the final submit action.

Once items 1--5 are satisfied, Stage 14 can be converted from `CONDITIONAL PASS` to `SUBMISSION QA PASS` without reopening any earlier research stage, provided the resulting PDF remains mechanically identical in substantive content.
