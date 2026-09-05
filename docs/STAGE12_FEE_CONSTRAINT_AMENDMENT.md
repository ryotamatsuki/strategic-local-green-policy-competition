# Stage 12 Amendment — Zero-Fee Submission Constraint

Date: 2026-09-05.

Canonical theory freeze: `SLGPC-THEORY-FREEZE-2026-09-05-v2`.

This amendment supplements `docs/STAGE12_JOURNAL_POSITIONING.md` and is authoritative for downstream submission sequencing wherever the two documents differ on journal fees.

## Hard fee constraint

Active targets must satisfy both conditions at the time of submission:

1. submission fee = 0; and
2. mandatory publication/page/APC charge under the standard subscription route = 0.

Optional open-access APCs do not violate the constraint provided a zero-APC subscription route remains available.

## Revised active ladder

1. **International Tax and Public Finance (ITPF)** — primary.
2. **Environmental and Resource Economics (ERE)** — fallback 1.
3. **Journal of Public Economic Theory (JPET)** — fallback 2.
4. **FinanzArchiv / European Journal of Public Finance** — fallback 3 / public-finance safety.
5. **Environmental Economics and Policy Studies (EEPS)** — environmental-economics safety.

**Journal of Environmental Economics and Management (JEEM)** is removed from the active ladder because the zero-submission-fee constraint is not satisfied.

The journal-fit logic of the original Stage 12 remains unchanged: ITPF is the preferred target because the paper's central contribution is a theorem about cross-instrument interjurisdictional policy responses under product-market rivalry, rather than a broad environmental-welfare theorem.

## ITPF fee check

Official sources checked on 2026-09-05:

- Submission guidelines: https://link.springer.com/journal/10797/submission-guidelines
- How to publish with us: https://link.springer.com/journal/10797/how-to-publish-with-us

The current official publishing page states that authors may choose the subscription publishing model and that **no APC charges apply** under that route. The current official submission guidelines contain no submission-fee requirement.

Because historical third-party/archived instructions have contained a submission fee, Stage 14 must perform a live submission-portal hard gate: **if the live ITPF portal requests any mandatory submission charge, stop before payment and return to journal positioning.**

## Revised Stage 12 verdict

`PRIMARY JOURNAL SELECTED — ZERO-FEE CONSTRAINT SATISFIED SUBJECT TO LIVE PORTAL HARD GATE`.

Primary target remains **International Tax and Public Finance**.
