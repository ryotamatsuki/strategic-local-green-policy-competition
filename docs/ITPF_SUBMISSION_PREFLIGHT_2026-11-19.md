# ITPF Submission Rules and Outstanding Checks — 2026-11-19

**This is a preflight ledger; no submission and no Stage-14 PASS are claimed.**

Primary official instructions: https://link.springer.com/journal/10797/submission-guidelines (checked 2026-11-19); publisher AI policy: https://www.springernature.com/jp/policies/editorial-policies/ai-manuscript-preparation (checked 2026-11-19).

Verified public rules: regular article (the 6,000-word/five-display cap applies to Short Papers, not regular articles); abstract 150–250 words; four to six keywords; JEL codes; title-page author, institutional affiliation/location, contact email, ORCID; funding/conflict/data/code/AI declarations as applicable. **Editable LaTeX source AND compiled PDF** are expected, along with figure sources.

AI policy: disclose substantive AI-assisted research and manuscript generation without attributing authorship to AI. Distinguish machine verification from actual human author verification and document model/version or purpose when required. Author intellectual accountability must be confirmed rather than inferred from AI text.

Outstanding **blocking** checks: revised full PDF and genuine independent Stage-13 v3.1 full-paper prose closure; evidence of fully inspected exemplar sources; second independent complete cold reader; author approval of science, citations, disclosure and submission declarations; latest source/PDF/figure embedded-font build QA; exact portal-generated PDF parity and any required portal fields.

Zero-fee project constraint: publicly available no-APC subscription route is NOT evidence of zero mandatory submission fees. The authenticated live portal must be checked; do not pay or submit if a mandatory fee is requested. If an existing manuscript is under consideration elsewhere, the exclusivity declaration also must be true before submission.

Older September 2026 Stage-14 QA and Stage-15 freeze records refer to a **different manuscript source** and may not be used as current GO evidence.


## 2026-11-19 ITPF format corrections on revision/itpf-final-prose-v3-1-20261119

Verified against the **actual journal home-page AI-specific notice** (https://link.springer.com/journal/10797) and **official Instructions for Authors** (https://link.springer.com/journal/10797/submission-guidelines), accessed November 19, 2026.

- The journal home page specifically requires a **short title-page footnote** stating AI-use purposes including drafting, editing, data analysis and theoretical proof development/verification, plus a disclosure in the authenticated submission interface. A conventional Declarations paragraph alone did not meet that journal-specific instruction. Added an unnumbered footnote matching Declarations and submission metadata; full human validation remains to be performed.
- The abstract now spells out subgame-perfect Nash equilibrium before using **SPNE**; this addresses undefined abbreviations in abstracts.
- Official Springer Nature LaTeX class is **recommended**, not mandatory. Existing article class is retained; full source files and compiled PDF remain mandatory.
- ITPF requires bold **Fig. 1** without punctuation after the figure number and no terminal caption punctuation. Figure source now exports `Fig1.pdf` (exact plotting original), `Fig1.eps` (preferred vector artwork) and existing reproducibility PDF/PNG.
- Added `scripts/verify_itpf_submission_format.py` and archive manifest test to CI; passing checks do **not** certify post-rewrite independent Stage-13 full-PDF prose review, author intellectual confirmation, nor authenticated portal fee compliance.
- No mathematics, certified parameters, theorem text, proofs or calculations were rewritten for format compliance; source figure generator was extended to emit alternate artwork formats from the same scientific plot.
