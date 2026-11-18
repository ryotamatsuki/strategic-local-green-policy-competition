# ITPF submission preflight — official publisher instructions (2026-11-19 JST)

Target journal: *International Tax and Public Finance* (Springer Nature, hybrid). **No live publisher submission / portal account / upload / declaration or payment was performed.** Scientific gate and author accountability are separate.

## Verified official policies

| Topic | Publisher requirement and implication for this branch | Status |
|---|---|---|
| Scope | Theoretical/empirical original public economics; explicitly interjurisdictional/ international fiscal issues. Fixed-rivalry interregional subsidy/infrastructure reactions fit the subject area but a journal reader may still find a strict two-witness theorem too incremental. | SCOPE FIT, SIGNIFICANCE UNRESOLVED |
| Paper format | Regular research articles accepted. **Short Papers** explicitly available as a **collection** selected online; max **6,000 main-text words** excluding title/references, no more than **five main-text figures or tables**; word and exhibit counts on cover page, self-contained main paper, online appendix optional. Short Papers held to **same quality** standards with faster editorial pathway. The present long full paper and extra tables **have not been shown to satisfy the short track**; do not select that collection for this package automatically. | REGULAR PAPER working target; SHORT option requires reformatting and another decision |
| Abstract | **150–250 words**, avoid undefined terms and references. Current abstract is written to this range; verify with exact final source and Python script. | PENDING exact final static gate |
| Keywords | **4–6 keywords**, plus suitable **JEL** classifications. Manuscript currently has five keywords and six JEL items; check exact final source. | PRESENT |
| Manuscript source | Original editable **LaTeX** and all style/figure files **plus compiled PDF**, Springer Nature template encouraged, must produce clean BibTeX and cross references. | GitHub CI rebuilds main.pdf, Figure1 and source ZIP; FINAL QA pending |
| Exhibit accuracy | Figure 1 must be **regenerated** by `scripts/make_figure1_threshold_response.py` (stored repo original figure has been found corrupt for separate PDF extraction). Embed fonts and ensure the zero at theta=0 is distinguished from the unique positive sign-changing root. Main fixed-theta table and old theta=.5/.9 table are different comparisons. | CI regeneration integrated; image/page check pending |
| Declarations | Funding, conflicting interests, data, code and **AI assistance** declaration. Researcher/author is responsible for exact claim scope and must personally validate or amend AI disclosure before final submission. Do not assert author independently proved every step merely because AI/Python/Lean did. | TEXT PRESENT; **AUTHOR SIGNOFF NOT RECORDED** |
| Originality and concurrent submission | Work must be original, not published or simultaneously considered elsewhere; true co-author approvals/associated institute approvals if relevant. | AUTHOR DECLARATION / PORTAL REQUIRED |
| Source citation uncertainties | HMR WP vs published page mapping supported by PR34 available typesetting; M&O complete official article+appendix; Strandholm author manuscript checked but **final VOR supplement not fully checked**; Bayindir-Upmann original emissions-tax response theorems inaccessible. | **PRIOR ART INCOMPLETE** |
| Fees / access model | ITPF **hybrid**. Ordinary subscription publication has **no open-access APC**. Optional OA APC currently GBP 2,290 / USD 3,290 / EUR 2,590, determined by acceptance date, possible taxes; **NOT a submission fee**. No reliable zero-fee submission guarantee from the official online guide. A live authenticated portal fee/preflight gate must verify any **submission or handling fee** separately before submitting; do not assume. | PORTAL FEE **UNVERIFIED** |
| Portal | Official journal's "Submit your manuscript" links to Springer Nature submission system; actual article type/collection, files, generated merged preview, final disclosures, reviewer suggestions are portal-specific. | NOT PERFORMED |

## Exact official sources

- Aims: https://link.springer.com/journal/10797/aims-and-scope
- Submission: https://link.springer.com/journal/10797/submission-guidelines
- Publication options/APC: https://link.springer.com/journal/10797/how-to-publish-with-us

Publisher page consulted on **2026-11-19**. Versions and fees can change by the eventual submission/acceptance date.

## Author-controlled release blockers

1. Author must validate the revised main finding, source comparisons, citations, proof and generated PDF, and personally approve funding, competing interests, AI assistance, corresponding author identity and author-contribution entries.
2. The restricted two-global-point theorem has a valid mathematical basis but **publication-level scientific importance** is not mechanically established by proof or formal checks.
3. Bayindir-Upmann and publisher-final Strandholm evidence gaps must be disclosed and, if they could absorb the theorem, should be closed with lawful institutional access before a positive originality decision.
4. The exact final source SHA, tests, pdf hash, and figure font/axis inspection must be logged after GitHub CI.
5. The submission fee and all portal-only conditions must be verified during Stage15 with express author approval. No submission is authorized by this draft PR.

**Preflight verdict: preparation only; not a publisher submission certificate.**
