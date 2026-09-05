# Strategic Local Green Policy Competition

Production repository for the theory paper tentatively titled **Strategic Local Green Policy Competition: Product-Market Rivalry and Instrument Switching**.

Canonical theory freeze: `SLGPC-THEORY-FREEZE-2026-09-05-v2`.

Superseded historical freeze: `SLGPC-THEORY-FREEZE-2026-09-05-v1`.

Canonical workflow: `ryotamatsuki/research-paper-workflow`, version `v1.1`, release SHA `488e5ab06c207909296a7564eaf9066f7f94319c`.

## Research question

When competing local governments can use a targeted green-investment subsidy and productive green public infrastructure, can stronger product-market rivalry reverse the sign of a local government's infrastructure response to a rival productive green-policy shock when firms endogenously adjust conventional and green investment?

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

Stage 11R found no new unresolved fatal attack. It sharpened the Hauptmeier/Morita–Okoshi novelty boundary and added an exact target-intensity scope check: holding other canonical primitives fixed, the interior response is negative throughout at `d=1.5`, switches once at `d=2`, and is positive throughout at `d=3`. The result is therefore a conditional strategic-feedback theorem, not a claim that rivalry mechanically creates switching.

GitHub Actions runner execution is temporarily unavailable because the account has exhausted its included Actions minutes. The repository remains wired to run the full v2 regression and manuscript-verification stack automatically when runner access resumes. This external quota condition is recorded in the stage status files and is not a theory/manuscript failure.

Next: **Stage 12 — Journal Positioning**.

Any theory change after v2 requires an explicit theory-change record and rerunning the earliest affected workflow gates.
