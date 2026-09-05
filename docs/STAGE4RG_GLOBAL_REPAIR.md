# Stage 4R-G — Global Equilibrium / Boundary Repair

Date: 2026-09-05

Trigger: Stage-11 Astra hostile audit of commit `98612b15ac34c3cb050ea8485a0ee1171c86bbc4`.

## Triggered failure

The Stage-10 manuscript treated the smooth two-active-firm branch as if its local government optimum automatically defined the original game's SPNE. That inference is false. For the hostile-audit parameter vector

`(kx,kg,mu,nu,kappa,d,e,beta,xi,m,Ebar)=(8,18,1,1.4,.42,2,1.4,2.8,.08,2,0)`

at `theta=.9`, the symmetric smooth candidate has approximately

`(s,h)=(6.3919487510,2.6740204872)` and `W_A=3.3830720944`,

while the unilateral policy deviation `(s_A,h_A)=(60,22)` induces a continuation with firm B inactive and yields exactly

`q_A=13008/655`, `x_A=1626/655`, `g_A=2906/655`,

and `W_A=4.0324093934`.

Therefore the previous interior regularity conditions are not sufficient for global SPNE.

The quartic cross-response factorization, all five coefficients, the Bernstein single-crossing proof, and the canonical root `theta*=0.773804386083461` survive. The failure is the connection from the smooth branch to the global game.

## Repair strategy

No primitive, timing, or policy instrument is added. The original action sets are retained. The repair explicitly accounts for nonnegative Cournot quantities and the induced active-set changes.

Let

`R=1/kx+mu^2/kg`, `b=mu/kg`, and let `z_i=x_i+mu g_i` denote private cost-reducing investment. Conditional on a chosen `z_i`, the firm minimizes net investment cost by

`x_i=lambda_i/kx`, `g_i=(s_i+mu lambda_i)/kg`, `lambda_i=(z_i-b s_i)/R`.

Hence the Stage-2 problem is scalar in `z_i`. Under `R<3/4`, each smooth branch is strictly concave; a firm best response can be on (i) the two-active Cournot branch, (ii) the rival-exit kink, (iii) the smooth monopoly branch, or (iv) its inactive branch.

For government deviations from a symmetric two-active candidate, every deviation therefore falls into a finite active-set class.

## Certified canonical interval

For the canonical primitive vector

`kx=4, kg=18, mu=.9, nu=1.2, kappa=.8, d=2, e=1.1, beta=1.7, xi=.1, m=2, Ebar=0`,

an exact SymPy certificate verifies the closed interval

`Theta_G=[18/25,21/25]=[0.72,0.84]`.

On this interval:

1. the symmetric two-active candidate has strictly positive `s*`, `h*`, and `q*`;
2. the government own-policy Hessian is negative definite;
3. a government cannot profit by a deviation that leaves both firms active, because the smooth-branch government objective is a strictly concave quadratic and the symmetric candidate satisfies its FOCs;
4. an own-firm-inactive continuation is impossible. If the rival firm tried to exclude the local firm at the exit kink, firm optimality implies
   `M_A <= theta M_B^low/(2-lambda)` with `lambda=4R/(4-theta^2)`, while exact root-count verification gives `m > theta M_B^low/(2-lambda)` throughout `Theta_G`. Since any nonnegative local policy gives `M_A>=m`, exclusion cannot occur. The rival's smooth-monopoly exclusion bound is even smaller;
5. if the rival firm becomes inactive, the local active firm can be either at its smooth monopoly optimum or at the rival-exit kink. The unconstrained maximum of local-government welfare on each of these branches is an upper bound on every feasible deviation in that class. Exact rational-function root counts show that the symmetric equilibrium welfare is strictly greater than both upper bounds throughout `Theta_G`.

The endpoint welfare gaps for the full model are:

- smooth-monopoly upper bound: about `0.5040` at `theta=.72` and `0.3384` at `theta=.84`;
- relaxed rival-exit-kink upper bound: about `1.2997` at `theta=.72` and `0.3246` at `theta=.84`.

All inequalities are strict on a compact interval. Therefore continuity gives an open neighborhood of the canonical primitive vector on which the same global active-set ordering holds.

## Repaired global threshold statement

The original primitive-coefficient theorem remains a local/smooth-branch theorem. It becomes a theorem about the original game when combined with a global-duopoly-dominance condition.

For the certified canonical interval `Theta_G`, the global condition is verified directly. Since

`theta*=0.773804386083461 in (0.72,0.84)`,

the global SPNE best response satisfies

- `d h_A^BR / d s_B < 0` for `0.72 <= theta < theta*`;
- `d h_A^BR / d s_B > 0` for `theta* < theta <= 0.84`.

At `theta=theta*` the derivative is zero. This is no longer a statement inferred from local Hessians alone: the certified branch gaps ensure that the smooth best response is the true global best response in a neighborhood of the equilibrium policy profile.

## No-conventional-investment benchmark

The same global active-set certificate is verified for the canonical no-`x` benchmark on `[0.72,0.84]`. The canonical benchmark polynomial is positive on `[0,1]`, hence the benchmark response remains negative on the certified interval while the full model crosses zero.

The contribution must therefore be stated as a **benchmark separation**:

> For a nonempty open parameter region, conventional competitive investment creates a switching reversal that is absent under the same primitives in the nested no-conventional-investment benchmark.

Do not state that conventional investment is universally necessary. Astra's `beta=1.3` no-`x` polynomial has an interior root (`theta approximately 0.939485`), so universal necessity is false.

## Stage 4R-G verdict

`GO`, conditional only on the repository certificate passing CI.

No model redesign is required. The frozen v1 theory is nevertheless superseded because its SPNE claim and contribution wording were too strong. Downstream routing after this repair is:

`Stage 6 Novelty Re-Kill -> Stage 7 -> Stage 7.5 -> Stage 8 new theory freeze`.

The manuscript must not proceed to Stage 11/12 under `SLGPC-THEORY-FREEZE-2026-09-05-v1`.
