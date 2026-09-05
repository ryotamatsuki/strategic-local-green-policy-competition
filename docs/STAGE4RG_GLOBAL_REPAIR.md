# Stage 4R-G — Global Equilibrium / Boundary Repair

Status: `GO`.

Verification: repair PR CI passed both symbolic verification and manuscript build. The exact global-equilibrium certificate, the retained hostile counterexample regression, the no-x counterexample, legacy algebra checks, pytest, and PDF build all passed.

Trigger: hostile Stage-11 audit of commit `98612b15ac34c3cb050ea8485a0ee1171c86bbc4` found a valid deviation in which one government induces rival-firm inactivity.  The previous interior Hessian/IFT conditions therefore did not by themselves establish SPNE of the original nonnegative-quantity game.

This repair changes no policy instrument, player, timing, demand system, production technology, environmental technology, or government objective.  It completes the action sets and continuation equilibrium omitted by the earlier interior analysis.

## 1. Action sets

The repaired game uses

- `s_i >= 0`, `h_i >= 0`;
- `x_i >= 0`, `g_i >= 0`;
- `q_i >= 0`.

Let

`D = 4-theta^2`,

`R = 1/k_x + mu^2/k_g`,

`b = mu/k_g`,

`w_i = m + b s_i + nu h_i`,

`lambda = 4R/D`,

`L = 2-lambda`.

The sufficient regularity restriction `R < 3/4` implies `L > theta` for every `theta in [0,1]`.

## 2. Full Stage-3 Cournot continuation

Writing `v_i = m + x_i + mu g_i + nu h_i`, the nonnegative-quantity Cournot equilibrium is piecewise:

- both firms active when `2 v_i > theta v_j` for both firms;
- firm A monopoly when `v_B <= theta v_A/2`;
- firm B monopoly symmetrically.

For two active firms,

`q_i = (2 v_i - theta v_j)/D`.

For an active monopolist,

`q_i = v_i/2`.

Thus `p_i-c_i=q_i` is an active-firm identity, not a global identity for an inactive firm.

## 3. Scalar reduction of the investment game

Conditional on the effective private cost reduction `z_i=x_i+mu g_i`, the optimal composition of investment gives

`x_i = u_i/(R k_x)`,

`g_i = s_i/k_g + mu u_i/(R k_g)`,

where `u_i = z_i - b s_i >= 0`.

The investment problem therefore reduces to a scalar problem with effective intercept

`v_i = w_i + u_i`

and net quadratic investment cost `u_i^2/(2R)` up to the policy-only constant `s_i^2/(2k_g)`.

The operating-profit derivative has three branches: inactive, duopoly, and monopoly.  Under `R < 3/4`, the resulting two-firm investment equilibrium is uniquely classified by the ratio of `w_A` and `w_B`.

## 4. Exact Stage-2 regime map

For `theta>0`, the unique continuation is:

### A monopoly

If

`theta w_A >= (2-R) w_B`,

then

`q_A = w_A/(2-R)`, `q_B=0`,

`u_A = R q_A`, `u_B=0`.

### A limit-pricing kink

If

`L w_B <= theta w_A <= (2-R) w_B`,

then

`q_A = w_B/theta`, `q_B=0`,

`u_A = 2 w_B/theta - w_A`, `u_B=0`.

At this kink the left and right investment derivatives bracket zero.  This region is essential: it is the missing continuation between the duopoly and monopoly investment FOCs.

### Duopoly

If

`theta w_A < L w_B` and `theta w_B < L w_A`,

then

`L q_A + theta q_B = w_A`,

`theta q_A + L q_B = w_B`,

and

`u_i = lambda q_i`.

### B kink / B monopoly

The symmetric conditions and formulas apply.

At all regime boundaries the candidate continuation coincides, so the investment equilibrium is uniquely defined.

## 5. Canonical global-SPNE certificate

For the exact canonical witness

`k_x=4`, `k_g=18`, `mu=9/10`, `nu=6/5`, `kappa=4/5`, `d=2`, `e=11/10`, `beta=17/10`, `xi=1/10`, `m=2`, `Ebar=0`,

we have `R=59/200`.

The repair script reconstructs the symmetric policy FOCs on the duopoly branch and proves, by exact rational polynomial root counts, all of the following for every `theta in [0,1]`:

1. `s*(theta)>0` and `h*(theta)>0`.
2. The own-policy Hessian on the duopoly branch is negative definite.
3. The symmetric continuation remains strictly inside the duopoly region.
4. Given the symmetric rival policy, nonnegative own policies cannot reach the rival-monopoly or rival-kink regions.
5. The A-kink and A-monopoly government objectives are each strictly concave.
6. Their global maxima are attained at their common boundary `theta w_A=(2-R)w_B`.
7. The best policy composition on that boundary has strictly positive `s` and `h`.
8. The exact welfare gap between the symmetric duopoly optimum and the best monopoly-inducing challenger is strictly positive for every `theta in (0,1]`; at `theta=0` the rival cannot be strategically excluded and the duopoly branch is the full continuation.

The proof of item 6 uses exact KKT multipliers.  At the common kink/monopoly boundary, the multiplier from the kink side is positive and the multiplier from the monopoly side is negative.  Strict concavity therefore makes the common boundary the maximum of each outside branch.

The exact global-gap numerator factors into two root-free polynomials that are both negative on `[0,1]`; the denominator is positive.  Hence the product, and the welfare gap, is strictly positive.

CI checkpoints for the exact gap are approximately:

- `theta=.5`: `7.6486576065`;
- `theta=.9`: `.4277511004`;
- `theta=1`: `.0734123751`.

Consequently the canonical symmetric policy candidate is a true global policy Nash equilibrium, not merely an interior stationary point.  Because the branch gap and all regularity inequalities are strict, continuity gives a nonempty open neighborhood of primitives in which the same global-SPNE property survives.

This restores the economic meaning of the local IFT cross-response derivative: around the canonical equilibrium it is the derivative of the true global best response, not of a spurious local branch.

## 6. Hostile counterexample retained as regression test

The repair script also reproduces the audit counterexample

`(k_x,k_g,mu,nu,kappa,d,e,beta,xi,m)=(8,18,1,1.4,.42,2,1.4,2.8,.08,2)`

at `theta=.9`.

The old symmetric interior candidate has welfare approximately `3.3830720944`, while the deviation `(s_A,h_A)=(60,22)` moves the continuation to the A-monopoly region and raises welfare to approximately `4.0324093934`.

This is retained permanently as a regression test: the previous interior sufficient conditions must never again be interpreted as a global-equilibrium theorem.

## 7. Nested benchmark correction

The hostile audit also correctly rejects a universal reading of “dual-investment necessity.”

Removing `x_i` is exactly the `1/k_x -> 0` benchmark, and the previously stated positive-Bernstein sufficient conditions still imply no reversal in the canonical benchmark.  But conventional investment is not globally necessary for switching.

Keeping the other canonical primitives and setting `beta=1.3`, the no-x cross-response numerator contains

`2778500 theta^4 - 13520550 theta^2 + 9769111`,

which has the unique root

`theta = 0.939485055557332...`

in `(0,1)`.

The repaired no-x verifier also solves the full nonnegative continuation at `theta=.9` and `theta=1`.  Both symmetric policy candidates are true global policy equilibria after comparison with kink and monopoly deviations.  The cross-response switching index is negative at `.9` and positive at `1`, while the global-equilibrium welfare gaps against the best exclusionary challenger are approximately `1.8638141` and `1.2625468`, respectively.  In the no-x kink branch the government objective is flat in the subsidy direction and strictly concave in infrastructure; the verifier treats this semidefinite structure directly rather than imposing false strict concavity.

Therefore the surviving claim is only:

> On a nonempty primitive region containing the canonical witness, adding conventional competitive investment generates a sign reversal that is absent under the same primitives in the nested no-conventional-investment benchmark.

Do not claim that conventional investment is necessary for every possible sign reversal.

## 8. Stage-4R-G verdict

`GO`.

The fatal SPNE objection is repaired without changing the frozen economic architecture.  The general quartic/Bernstein sign theorem survives as an interior best-response theorem, and the canonical rational witness now supplies an exact global-SPNE/open-set bridge.

However `SLGPC-THEORY-FREEZE-2026-09-05-v1` is no longer submission-valid because its “necessity” language and its incomplete continuation characterization require downstream revision.

Routing after this repair:

`Stage 6 — Novelty Re-Kill` -> `Stage 7 — Welfare / Generality / Institutional Validation` -> repeat `Stage 7.5` -> new Stage-8 theory freeze.

Do not return directly to Stage 10 or Stage 11.
