# Stage 4 — Preliminary T1 Exact Lemma and Outstanding Global Regime Checks
Date: 2026-10-12. Status: **IN PROGRESS / NOT STAGE-4 GO**.

New research question (single extension): whether coordination that increases total modeled welfare but induces regional firm exit can satisfy **voluntary local participation without interregional side payments**. The only new institutional choice is the coalition's individual-rationality feasible set; the canonical primitive stage game is unchanged.

## Proved exact at theta = 9/10, canonical rational witness

Let `W_A^{NE}` be region A's welfare at the exhibited symmetric policy SPNE. It is computed from the two-active Cournot/private-investment continuation and A's own first-order conditions holding rival policies fixed:

`W_A^{NE} = 2129482118801677362193413324880/1947443098557072400775535945289 ≈ 1.09347591227671`.

If A operates on the **A-monopoly continuation**, its output equals `q_A=w_A/(2-R)`, its investments are `x_A=q_A/k_x`, `g_A=(s_A+mu q_A)/k_g`, and the (region A) welfare function depends only on own policy `(s_A,h_A)`, not B's policies, theta or B's strategic quantities. The 2x2 rational Hessian is strictly negative definite, and the unique **unconstrained real own-policy maximum** is attained at strictly positive

`s_A=10484064/2071201 ≈ 5.0618283788`,
`h_A=3635100/2071201 ≈ 1.7550686775`,
`sup_{s_A,h_A>=0} W_A^{monopoly}=1753200/2071201 ≈ 0.84646540823416`.

The exactly positive gap is

`W_A^{NE}-sup W_A^{monopoly}=996328253553893621212690252624106080/4033546093174506913558690825418522089 ≈ 0.24701050404255`.

**Theorem scope**: At this exact theta/canonical witness, NO mutually voluntary no-transfer cooperative policy inducing **A-monopoly interior continuation** can satisfy host A's participation constraint; symmetrically for B-monopoly. The bound holds for any B policy levels consistent with this monopoly continuation since A's firm/CS continuation is independent of B policy.

**IMPORTANT**: The distinct **limit-pricing kink** has an inactive rival output but a different active firm's investment formula. The above monopoly-branch bound alone DOES NOT prove all zero-rival-output policies fail consent. Kink must be separately attacked! Do not conflate a monopoly operation regime with the entire inactive-rival region.

Proof/regression source: `research/stage3_exact_host_participation_lemma.py` (SymPy exact rationals). Distinct unrestricted-planner A-monopoly branch aggregate welfare maximum `W_A+W_B=3691600/362551≈10.1822915948` at `(s_A,h_A,s_B,h_B)=(11078064/362551,6458100/362551,0,0)`; here local A welfare ≈-43.1519, region B ≈53.3342 and A would veto absent side payments. Proof source: `research/stage3_exact_market_exit_candidate.py`.

## Explored, not proved
SciPy partial searches (finite bounds [0,100] and multistart) suggest unrestricted welfare-maximizing planner chooses asymmetric A/B monopoly for theta .3/.5/.7/.9, while region-participation-constrained planner chooses asymmetric **duopoly** at theta .3 and .5, but symmetric duopoly at theta .7 and .9. Both global statements and crossing location remain uncertified.

Attempted independent full-theta symbolic elimination for `W_A^{NE}(theta)-0.8464654`, but symbolic rational factorization/root-count task did not complete; no full-interval theorem claimed.

An important well-posedness guard: even if the original policy SPNE exists, unrestricted total-welfare coordination may be unbounded for different environmental weights `d`. At other canonical parameters held fixed, the 2D A-monopoly-branch aggregate welfare Hessian determinant is `(3258751d-5792400)/188375220`. A necessary strict-concavity condition is `d>5792400/3258751≈1.77749`. Working canonical `d=2` satisfies it. **Do not generalize planner results to all allowed d or use a numerical box limit as an economic resource constraint.**

## Stage 4 proof obligations and explicit stop rules
1. Derive complete **unrestricted coordinator** regime-by-regime KKT/global candidate comparison including both kinks and both monopolies. Demonstrate globally highest welfare at a certified rational algebraic candidate, with all policy corners and no unbounded rays handled.
2. Derive complete **voluntary participation coordinator** over the same 5 regions and its two local IR inequalities, including both kink boundaries. Prove any zero-rival-output continuation is excluded (or document counterexample). Only then certify both-firms-active at its global optimum.
3. Test whether a genuine **switch in optimal consent-constrained policy symmetry** as theta increases survives global certification, not just SLSQP; derive strict inequalities and an open primitive interval.
4. Compare x=0, mu=0 and a least one generic public-input benchmark; if the result survives in generic parent games without a new strategic interaction, classify as familiar constrained welfare problem and stop/reframe.
5. Prior-art theorem absorption must focus on **Fenge–von Ehrlich–Wrede 2009**, **Parcero 2007**, **Markusen–Morey–Olewiler 1995**, and **Martín-Herrán–Martínez-García–Morales 2026**; any proposal sold solely as concentrated infrastructure/hosting aversion fails.
6. A future finance/side-payment mechanism is NOT authorized in the current one-institution model; such changes require returning to Stage 3 and choosing a different single model.

**Verdict remains Stage 4 IN PROGRESS (one rigorous monopoly-region lemma, numerical planner hypotheses; no new independent economics theorem certified yet).**
