# Stage 15 — ITPF Submission Freeze and Record

Date/time: 2026-09-06 20:48 JST.

Canonical workflow provenance: `ryotamatsuki/research-paper-workflow` v1.1, Stage 15 template `templates/STAGE_15_SUBMISSION_FREEZE.md` at workflow release SHA `488e5ab06c207909296a7564eaf9066f7f94319c` (template blob `7960ab57fd2e05efce13ee05f9e1aea443f9cd6b`).

Theory freeze: `SLGPC-THEORY-FREEZE-2026-09-05-v2`.

Target journal: **International Tax and Public Finance (ITPF)**.

Manuscript: **Strategic Local Green Policy Competition: Product-Market Rivalry and Instrument Switching**.

## 1. Submission-freeze verdict

**`FREEZE BLOCKED — LIVE PORTAL SUBMISSION-FEE GATE ONLY`**.

Stage 15 was entered after the post-Stage-13R Stage 14 re-QA. The manuscript, figures/tables, bibliography, declarations, metadata, source archive, symbolic/numerical checks, and PDF visual QA are all complete. The current `main` state also has a successful clean CI build.

However, the Stage 14 result is still a `CONDITIONAL PASS`, not a fully resolved conditional pass, because the project's zero-fee constraint requires confirmation inside the live ITPF submission workflow that no mandatory submission fee or payment is requested. The public Springer pages establish a no-APC subscription route but do not certify the absence of a submission charge.

Under the canonical Stage 15 entry rule, no immutable submission tag may be declared while that condition remains unresolved. Therefore this record preserves the fully verified freeze candidate but intentionally does **not** create a submission-freeze tag and does **not** claim `SUBMISSION FROZEN`, `UPLOADED`, or `SUBMITTED`.

## 2. Verified freeze candidate

Current repository `main` / package-generating commit:

- candidate canonical SHA: `470e5b8a961a5880ee92b5954c581bf9f5f54cce`;
- commit message: `Stage 14 re-QA: figure package compliance (#17)`;
- theory change: **none**;
- manuscript claim/proposition/proof change in the final artwork repair: **none**.

Clean main-branch verification:

- workflow: `verify-theory`;
- GitHub Actions run: `34008542393` (run #80);
- head SHA: `470e5b8a961a5880ee92b5954c581bf9f5f54cce`;
- conclusion: **SUCCESS**;
- artifact: `stage14-itpf-manuscript`;
- artifact ID: `9981744447`;
- artifact digest: `sha256:b945ca78c6948dbe76f4c2cf61e849bd530432479b092b6e4b74f1ff5785c1d5`.

## 3. Final-candidate artifact inventory and hashes

The run #80 artifact contains exactly:

1. `main.pdf`
   - SHA-256: `0f3f3092ee8b8439c62e5f94e3f61ed54936c28bd6b6912c43344763b8f9a19e`
   - pages: 24
   - encrypted: no
2. `main.log`
   - SHA-256: `a9ae81c903d61585370dc8def5d2eb225f185ff47df9b3cf3f34a353f3c97373`
3. `itpf-source.zip`
   - SHA-256: `68d39a8998ef9858b7b33c082ae4842da07ec695949eb7b03dc1233ce8b98331`

Artifact ZIP digest recorded by GitHub:

- `sha256:b945ca78c6948dbe76f4c2cf61e849bd530432479b092b6e4b74f1ff5785c1d5`.

## 4. Source archive inventory and provenance

`itpf-source.zip` contains:

- `main.tex` — `06edf0da894ef3eccaf7c2622759b09cb50188c49cd56c74bcbbbdc936b8f0c4`;
- `references.bib` — `cc3f44da1046bc64bffafb22f66035b0cc5ffe7fb17b24657aa9c810f34f5d6a`;
- `figures/figure1_threshold_response.pdf` — `27acad363f6262d3d8ec70dc443ffe81f302a163e942f46b38e5db96828cf573`;
- `figures/figure1_threshold_response.png` — `abf3af527fc578e17ac228340360de95612ad0b23f7ccc8edc793a3a778d5e11`;
- `scripts/make_figure1_threshold_response.py` — `2f0bb238dd7c6865250dafdce4e27d895fb34963bc37799dc5ba1fb6f0e6fa1c`;
- `sections/appendix.tex` — `12687c310c0136bf48a1afb887620fc24874069c8f6131d4d003684c2d0d3b70`;
- `sections/conclusion.tex` — `06e226593848c78183f473951e4f6225e7aae2b9a947640971ab97f711d1400b`;
- `sections/declarations.tex` — `21163ef6947e2fe8e5015dcc9706f9c2e239c9c41944012a3d6e7f8d70d0923f`;
- `sections/discussion.tex` — `cf2437e80b304eaf39d5198a076fbb15f8a7dc0fdbfcd505d1c59de5047941dd`;
- `sections/equilibrium.tex` — `e50c844edac5e7820be33d26aea589ae144670ab0f22e768d5d46f2694c3c05a`;
- `sections/global_equilibrium_appendix.tex` — `b50270fe4cdb47c6e6e1c48618f8630b23343e89d2ff66f40205538c219858d4`;
- `sections/institutional_bridge.tex` — `5035ffa0d76e005a164a598174bb4a8b777e9a572daf04aaa363f14ab28bfc8c`;
- `sections/introduction.tex` — `8c3f6c2b65d43c5fabe27ed31865a7045d9c0abd62dc13326bf71297d6921158`;
- `sections/main_results.tex` — `6e9cf657bcfd0f35e0e17908a690213b9fc27f8aafa7b05fcbb85648f8eecc60`;
- `sections/model.tex` — `653a26c2a19c8416adbf8f27b3ed7adeaaa087f39106a1be418bd1ba9ea9e0bf`;
- `sections/related_literature.tex` — `51fa0c1cdfc7e7ec4c3de4eb8bd7560367421fac8b37f48ba7f3b93e41d81774`;
- `sections/robustness.tex` — `b9759d9876d7c4299ee8e1ad6b1b85595eb79218acf56629d80b52703c720b25`;
- `sections/welfare.tex` — `2e19ccfdfa345d65c3d064861367945bc48236d26e68571bf484fee41ce2a29f`.

Figure 1's vector PDF contains only embedded/subset TrueType fonts; the artwork-compliance CI check passes.

## 5. Stage-14-to-Stage-15 drift check

The Stage 14 visual review was performed on run #75 artifact ID `9981631581`. The current-main run #80 candidate was compared directly against that reviewed package.

Result:

- extracted source trees: **byte-identical**;
- PDF text extraction: **no differences**;
- render comparison at 120 dpi across all 24 pages: **0 changed pages**;
- Figure 1 PDF/PNG/generator hashes: **identical** to the Stage 14 reviewed package.

The binary `main.pdf`, `main.log`, and `itpf-source.zip` hashes differ between CI runs because the build/archive metadata were regenerated, but the manuscript content, source tree, extracted text, and rendered pages are unchanged. Therefore no substantive or visual drift exists between the Stage 14 reviewed state and the current-main freeze candidate.

## 6. Verification artifact inventory

The run #80 clean-main verification reproduces the Stage 14 gates, including:

- deterministic Figure 1 generation;
- embedded-font kill test;
- `verify_stage9r_alignment.py`;
- `verify_stage10r_manuscript.py`;
- `verify_freeze.py`;
- `verify_stage4rg_global.py`;
- `verify_nox_global_counterexample.py`;
- `verify_stage7_postrepair.py`;
- `verify_stage10.py`;
- `verify_stage11r_target_scope.py`;
- `verify_stage14_submission_package.py`;
- `pytest` suite;
- clean LaTeX build;
- unresolved citation/cross-reference rejection;
- source-ZIP construction.

The theory freeze `SLGPC-THEORY-FREEZE-2026-09-05-v2` remains valid.

## 7. Journal-specific files and metadata

Prepared repository files at candidate SHA `470e5b8a961a5880ee92b5954c581bf9f5f54cce` include:

- `submission/itpf/cover_letter_body.md` — Git blob SHA `a9229eb1f8bef25bfdbc21dd16c71298bf7b895c`;
- `submission/itpf/metadata.md` — Git blob SHA `5a88b616026474ee6383abf5f0ddfcd6b00355c6`.

The metadata record fixes:

- journal: International Tax and Public Finance;
- article type: Regular Article;
- publishing route: subscription / non-open-access route;
- author: Ryota Matsuki;
- affiliation: Independent Researcher;
- location: Matsuyama, Ehime, Japan;
- corresponding email: `ryota.matsuki@gmail.com`;
- ORCID: `0009-0005-2329-531X`;
- keywords: 5;
- JEL codes: H23; H71; L13; Q55; Q58; R58.

Phone and postal-code details remain outside the public package and should be supplied only if the private portal requires them.

## 8. Disclosure/declaration record

The manuscript/source package contains the finalized declarations:

- Funding: no external funding;
- Competing interests: none declared;
- Data availability: no empirical dataset generated or analyzed;
- Code availability: public project repository identified;
- Generative AI: disclosed with explicit human verification and author responsibility;
- Author Contributions/CRediT: prepared in submission metadata.

No disclosure correction remains pending.

## 9. Submission status

Current evidence-supported status:

- manuscript/package QA: **PASS**;
- clean current-main build: **PASS**;
- freeze candidate identified: **YES**;
- submission-freeze tag: **NOT CREATED**;
- uploaded to ITPF: **NOT CLAIMED**;
- submitted to ITPF: **NOT CLAIMED**;
- live portal submission-fee gate: **UNRESOLVED**.

Accordingly, the only valid canonical Stage 15 status is:

**`FREEZE BLOCKED`**.

## 10. Exact unblock rule

Enter the live ITPF submission workflow and inspect any fee/payment step before committing to submission.

- If **no mandatory submission fee/payment** is requested, the Stage 14 conditional pass becomes fully resolved. Then create the immutable Stage 15 submission tag at the validated package commit (or at a documentation-only descendant explicitly mapped to that package), record the definitive final hashes, and set status to `SUBMISSION FROZEN`.
- If **any mandatory submission fee/payment** is requested, stop before payment and return to Stage 12 journal positioning under the project's hard zero-fee constraint.

No theory, manuscript, figure, table, citation, metadata, or declaration work remains to be done before this external gate.

## 11. Post-freeze / post-upload protocol

Once the fee gate is cleared and a freeze tag is created:

1. upload only the frozen PDF/source/ancillary files;
2. compare any portal-generated manuscript PDF against the frozen manuscript;
3. confirm title, author, abstract, keywords, JEL codes, declarations, and article type in the portal;
4. do not silently edit frozen source after upload;
5. if any substantive correction is needed, reopen the affected workflow stage and create a new freeze identifier;
6. record `SUBMITTED` only after the platform provides actual submission confirmation/identifier.

## 12. Final verdict

**`FREEZE BLOCKED — LIVE PORTAL SUBMISSION-FEE GATE ONLY`**.
