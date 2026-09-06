# Strategic Local Green Policy Competition

Production repository for the theory paper tentatively titled **Strategic Local Green Policy Competition: Product-Market Rivalry and Instrument Switching**.

Canonical theory freeze: `SLGPC-THEORY-FREEZE-2026-09-05-v2`.

Superseded historical freeze: `SLGPC-THEORY-FREEZE-2026-09-05-v1`.

Canonical workflow: `ryotamatsuki/research-paper-workflow`, version `v1.1`, release SHA `488e5ab06c207909296a7564eaf9066f7f94319c`.

## Research question

When competing local governments can use a targeted green-investment subsidy and productive green infrastructure, can stronger product-market rivalry reverse the sign of a local government's infrastructure response to a rival productive green-policy shock when firms endogenously adjust conventional and green investment?

The headline cross-instrument object is `∂h_A^BR/∂s_B`. On the interior reduced system, rival policy enters through the composite `y_B=(mu/k_g)s_B+nu h_B`, so the subsidy is a headline normalization rather than a uniquely identified rival-policy channel.

## Core game

1. Governments simultaneously choose nonnegative firm-specific green-investment subsidy `s_i` and productive green infrastructure `h_i`.
2. Firms simultaneously choose nonnegative conventional cost-reducing investment `x_i` and green investment `g_i`.
3. Firms choose nonnegative quantities in a differentiated Cournot market.

The full continuation includes duopoly, limit-pricing-kink, and monopoly regions. The canonical v2 equilibrium claim is a global SPNE claim, not merely an interior stationary-point claim.

## Core result

On a nonempty open global-SPNE region, product substitutability can generate a unique negative-to-positive sign reversal in `∂h_A^BR/∂s_B`. At the canonical rational witness,

`theta* = 0.773804386083461...`.

At the same canonical remaining primitives, removing conventional competitive investment eliminates the reversal. This is a matched benchmark separation only: conventional investment is **not** necessary for every possible reversal.

## Current status

- Stage 4R-G global-equilibrium repair: `GO`.
- Stage 6 post-repair novelty re-kill: `GO` (`DISTINCT BUT NARROW`).
- Stage 7 post-repair welfare/generality/institutional validation: `GO`.
- Stage 7.5 repeat: `GO`.
- Stage 8 post-repair canonical theory freeze: `GO — THEORY FROZEN`.
- Stage 9R repository/reproducibility alignment: `GO`.
- Stage 10R post-repair section-by-section manuscript reconstruction: `GO`.
- Stage 11R post-repair robustness/referee attack gate: `GO TO JOURNAL POSITIONING`.
- Stage 12 journal positioning: `PRIMARY JOURNAL SELECTED — ZERO-FEE CONSTRAINT SATISFIED SUBJECT TO LIVE PORTAL HARD GATE`.
- Stage 13 ITPF full-paper integration: `INTEGRATED MANUSCRIPT READY FOR SUBMISSION QA`.
- Post-Stage-13 Astra one-shot hostile audit: `GO WITH MINOR REPAIR`; bounded repairs incorporated, with no fatal finding or novelty collapse.
- Stage 13R bounded figure integration: `COMPLETE` — canonical switching response and matched no-`x` benchmark visualized; no theory change.
- Stage 14 ITPF re-QA after Figure 1 integration: `CONDITIONAL PASS — LIVE PORTAL FEE GATE ONLY`.

Stage 11R found no new unresolved fatal attack. It sharpened the Hauptmeier/Morita–Okoshi novelty boundary and added an exact target-intensity scope check: holding other canonical primitives fixed, the interior response is negative throughout at `d=1.5`, switches once at `d=2`, and is positive throughout at `d=3`. The result is therefore a conditional strategic-feedback theorem, not a claim that rivalry mechanically creates switching.

Stage 12 selects **International Tax and Public Finance** as the primary submission target. Under the zero-fee constraint, the active ladder is `ITPF -> Environmental and Resource Economics -> Journal of Public Economic Theory -> FinanzArchiv / European Journal of Public Finance -> Environmental Economics and Policy Studies`. `Journal of Environmental Economics and Management` is removed from the active ladder because it does not satisfy the zero-submission-fee constraint. See `docs/STAGE12_JOURNAL_POSITIONING.md` and the authoritative fee amendment `docs/STAGE12_FEE_CONSTRAINT_AMENDMENT.md`.

Stage 13 integrates the manuscript for ITPF without changing frozen theory. The abstract and Introduction foreground the cross-instrument public-finance contribution and closest-paper boundary; Data Availability, Code Availability, and generative-AI-use statements are included. The Stage-13 pull request passed the complete symbolic/regression suite, pytest, and LaTeX manuscript build. Full audit details are in `docs/STAGE13_FULL_PAPER_INTEGRATION.md`.

The one-shot Astra audit independently rechecked the global-SPNE certificate, switching polynomial, Bernstein uniqueness argument, canonical threshold, matched no-conventional-investment benchmark, and closest-paper novelty boundary. Its bounded repairs make explicit the `m=a-c>0` continuation domain, the `mu>0` switching-theorem scope, and the scaled-gap/Jacobian regularity used in the open-neighborhood proof. See `docs/POST_STAGE13_ASTRA_BOUNDED_REPAIR.md`.

Stage 13R adds a reproducible Figure 1 that plots the actual canonical derivative `∂h_A^BR/∂s_B` and the matched no-`x` derivative over the rivalry range, with the zero line and the verified threshold `theta*=0.773804386083461...`. The Introduction and Main Results receive bounded exposition edits only; propositions, proofs, table values, theory, robustness, and contribution claims are unchanged. See `docs/STAGE13R_FIGURE_INTEGRATION.md`.

The post-Stage-13R Stage 14 re-QA reruns the complete mathematical/reproducibility/package/visual audit on the 24-page manuscript. It found and repaired one non-substantive artwork issue: Figure 1's original vector PDF referenced a non-embedded core font. The current Figure 1 embeds its TrueType fonts, and CI now fails if any vector-figure font is not embedded. The full symbolic/regression suite, 9 pytest tests, LaTeX build, source-package construction, bibliography checks, metadata/declarations audit, and 24-page visual inspection pass. See `docs/STAGE14_ITPF_SUBMISSION_QA.md`.

The live ITPF portal hard gate remains unchanged. If the submission workflow requests any mandatory submission fee or payment, stop before payment and return to Stage 12. The subscription publication route itself has no APC.

Next: **verify the live ITPF portal fee gate; then Stage 15 — Submission Freeze and Record**.

Any theory change after v2 requires an explicit theory-change record and rerunning the earliest affected workflow gates.
