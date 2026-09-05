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

Next: **Stage 9R — Repository / Reproducibility Alignment**. The production repository already exists, so Stage 9R aligns all verification, status, manuscript, and CI artifacts to v2 before Stage 10 reconstruction.

Any theory change after v2 requires an explicit theory-change record and rerunning the earliest affected workflow gates.
