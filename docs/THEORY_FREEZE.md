# SLGPC Canonical Theory Freeze

Freeze ID: `SLGPC-THEORY-FREEZE-2026-09-05-v1`

Status: `SUPERSEDED PENDING REVALIDATION`.

This file is retained as the historical Stage-8 freeze. A hostile Stage-11 audit found that the original equilibrium characterization omitted global deviations into rival-inactivity continuation regions and that the phrase “dual-investment necessity” admitted an overbroad reading. The project rolled back to Stage 4R-G. Do not treat this freeze as submission-valid. A new freeze ID will be issued only after Stage 6, Stage 7, and Stage 7.5 are rerun.

Workflow: `ryotamatsuki/research-paper-workflow` v1.1, release SHA `488e5ab06c207909296a7564eaf9066f7f94319c`.

## Frozen research question

When competing local governments can use firm-specific green subsidies and shared green infrastructure, can product-market rivalry reverse the optimal cross-instrument response to a rival's green subsidy when firms endogenously choose both conventional competitive investment and green investment?

## Historical frozen architecture

- Two jurisdictions, one incumbent firm in each; plant locations fixed.
- Complete information; SPNE.
- Stage 1: governments simultaneously choose `(s_i, h_i)`.
- Stage 2: firms simultaneously choose `(x_i, g_i)`.
- Stage 3: differentiated Cournot competition.
- Inverse demand: `p_i = a - q_i - theta q_j`.
- Marginal cost: `c_i = c - x_i - mu g_i - nu h_i`.
- Investment cost: `(k_x/2)x_i^2 + (k_g/2)g_i^2`.
- Emissions: `E_i = e q_i - beta g_i - xi h_i`.
- Local welfare: half of integrated-market consumer surplus plus real local producer surplus, less infrastructure cost and territorial-emissions-target loss.

The Stage-4R-G repair keeps this economic architecture but explicitly completes the nonnegative action sets and all duopoly/kink/monopoly continuation regions.

## Historical frozen main results

1. Unique instrument-switching threshold under primitive coefficient conditions: the sign of `d h_A^BR / d s_B` switches from negative to positive at a unique `theta*`.
2. Historical wording: “dual-investment necessity.” This wording is superseded. The valid object to carry forward is a same-primitives nested-benchmark separation result, not universal necessity.
3. Competitiveness-link benchmark: if `mu = 0`, the cross-jurisdictional mechanism vanishes.
4. Local comparative statics around the canonical interior region: `d theta*/d nu < 0` and `d theta*/d k_x > 0`.

## Historical novelty boundary

Do **not** claim novelty for multi-instrument fiscal competition, cross-instrument responses in general, subsidy-infrastructure interaction in general, policy-composition distortion in general, or the coexistence of conventional and green R&D.

The contribution boundary must be re-killed at Stage 6 after the global-equilibrium repair and the benchmark-claim correction.

## Theory-change rule

Any baseline addition or change involving a third policy instrument, public procurement, endogenous location, hard public budget constraints, nonseparable investment costs, a major government-objective change, or global climate damages requires an explicit theory-change record and rerunning the affected canonical gates.
