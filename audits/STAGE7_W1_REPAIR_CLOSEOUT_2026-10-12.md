# Stage 7 — W1 Repair, Re-verification, and Closeout (2026-10-12)

**Verdict: GO TO STAGE 7.5** as a Stage-7 *scientific/benchmark-scope* decision. This is **not** a fresh Stage-8 theory freeze, author sign-off, or manuscript build certificate. The pre-existing `SLGPC-THEORY-FREEZE-2026-09-05-v2` is historically retained; §17 needs consistent change-control treatment during a future Stage-8 refreeze.

## Prior finding and exact counterexample
Original `eq:planner` described `max_{s_A,h_A,s_B,h_B>=0} W_A+W_B`, whereas the coordinated table actually optimized a symmetric active-duopoly policy pair `s_A=s_B=s, h_A=h_B=h`.

Canonical rational witness, `theta=9/10`: symmetric restricted `C` candidate has exact aggregate welfare `674272009120/181241003453 ≈ 3.720306`. Feasible asymmetric policy `(30,18,0,0)` induces A monopoly with exact welfare `53153998/5232645 ≈ 10.158151`. Exact gap `6105457877897032694/948369830513323185 > 0`. This **disproves** the implicit unrestricted-planner-optimality statement, but does not find or claim the true unrestricted planner maximum. At that asymmetric profile, A's welfare is negative and B's positive, so total gains do not imply a Pareto improvement.

## Repair actually performed on this audit branch
1. `sections/welfare.tex`: replace old `eq:planner` with `max_{s,h>=0} [W_A(s,h,s,h)+W_B(s,h,s,h)]`; name and scope **symmetric-policy restricted coordination benchmark**. Under `m>0`, `R<3/4`, symmetry ensures duopoly throughout the admissible restricted choice set. Explain explicitly that this is NOT an unrestricted four-policy planner optimum and show the exact counterexample (rounded in prose).
2. `sections/introduction.tex`: replace normative 'Should governments match?' headline with positive conditional best-response question; explicitly bound coordinated welfare claims.
3. `sections/discussion.tex`, `sections/conclusion.tex`: distinguish second-best positive diagnostic theory from a fully implementable planner-optimal policy and from an all-equilibrium/always-greener theorem.
4. `scripts/verify_stage10r_manuscript.py`: reverse the erroneous old guard that *required* the unrestricted four-policy equation; require the correctly constrained equation and scope warning.
5. `tests/test_stage7_welfare_scope.py`: new static scope test and exact rational counterexample regression.
6. `Makefile` and `.github/workflows/verify.yml`: run `audits/stage7_exact_planner_counterexample.py` and `audits/stage7_independent_local_robustness.py`.
7. `docs/DECISIONS.md`, `docs/REPRODUCIBILITY.md`: disclose post-freeze welfare-scope correction and future theory-refreeze requirement. Do not rewrite old signed/frozen judgments.

## Independent re-check results and evidence status
- **EXACT-RATIONAL CHECK EXECUTED LOCALLY** in a fresh SymPy derivation: same symmetric optimal policy (two positive coordinates), exact restricted welfare `674272009120/181241003453`, strict symmetric Hessian negative definiteness, monopoly condition `959/50>0`, exact alternative `53153998/5232645`, positive gap. Verified outputs agree with new permanent regression source. Structural symmetry ensures the symmetric two-firm continuation under maintained regularity.
- **LOCAL ROBUSTNESS EXECUTED LOCALLY** in a separate SymPy transcription of the new audit script: Bertrand `theta=.3: -.001694484446836663`, `theta=.5: +.004012630093840069`; 90% local surplus capture `theta=.5: -.00009679840633480625`, `theta=.7: +.0032462408598272798`. Relevant government Hessians negative definite.
- **REMOTE STATIC CHECK**: GitHub files fetched after edits; confirmed corrected equation in `sections/welfare.tex`, exclusion of unrestricted four-policy equation, correct replacement assertions in `verify_stage10r_manuscript.py`, and CI/Makefile wiring.
- **NOT EXECUTED IN THIS SESSION**: full repository `make verify`, `pytest`, `latexmk` manuscript build, Lean build, and GitHub hosted CI on this audit branch (the connected GitHub source cannot be mounted locally and the branch has no PR-triggered CI run). Do not misrepresent these as passed; they remain pre-merge checks.
- **NO change**: model primitives, firm/game continuations, welfare objective `W_i`, market equilibrium, Stage-4A theorem and Stage-6 novelty, frozen v2 source document, paper title, figure numbers or derived table entries.

## Stage 7 selection, generality, policy limits carried forward
- Selected symmetric decentralized SPNE only; Stage-4A did not establish policy-equilibrium uniqueness across the entire unrestricted game. No all-equilibria welfare ranking.
- Restricted symmetric planner comparison is Pareto-improving for the *displayed* symmetric decentralized example at theta=.9 but not a certified general comparative-welfare theorem.
- Full planner may favor asymmetric monopoly/industrial concentration and sharp regional welfare conflict; coordination transfers/finance/participation not modeled. Do not prescribe it.
- Local Bertrand and local ownership leakage effects have sign crossings with strict interior curvature; not global-SPNE certificates. Environmental target weight d critically governs switching.
- Japanese METI GX area/firm assistance and subnational environmental roles support stylized instruments, not joint unrestricted fiscal authority in real prefectures.
- Positive BR derivative under fixed rival policy != welfare-optimal reaction or comparative statics of a simultaneous government policy equilibrium.

## Gate closure and downstream contract
**Stage 7: GO TO STAGE 7.5** solely on correctly labeled restricted benchmark and existing narrowly certified positive theorem. There is no welfare math blocker remaining for the restricted claim. The correction is a theory-freeze change-control event, even though the underlying W_i and headline theorem did not change.

The Stage 7.5 reviewer must independently decide whether the *narrow conditional government-policy best-response sign reversal*, known component overlap, strong dependence on territorial target loss, observational equivalence of rival instruments and newly revealed gap between social-planner welfare and feasible regional cooperation justify a full paper. It must compare baseline-only / one bounded genuine extension / research note, and can independently return CONDITIONAL GO or NO-GO. Stage 7.5A formalization/scope audit and Stage 8 re-freeze remain mandatory.
