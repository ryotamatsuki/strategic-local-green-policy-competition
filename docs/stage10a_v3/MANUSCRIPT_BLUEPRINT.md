# Manuscript Blueprint — Green Subsidies (Stage 10A / workflow v3.0)

Date: **2026-11-19 JST**. Prospective **editorial rewrite blueprint** for the existing 24-page ITPF draft. No draft text or theorem is changed at Stage 10A. Full-text role benchmarks: [register](EXEMPLARY_PAPER_REGISTER.md); [comparative role map](EDITORIAL_EXEMPLAR_MAP.md).

## Exact contract and reader-arrival targets

- **Frozen scientific scope:** `SLGPC-THEORY-FREEZE-2026-09-05-v2`, including Stage 4R-G global-equilibrium repair, Stage 6 DISTINCT BUT NARROW novelty classification, Stage 7/7.5/8 and Stage 11R hostile-audit corrections. Do not alter primitives, proof quantifiers, action sets, timing, welfare objective, counterexample data, conclusions or theorem names merely to match an exemplar.
- **Article type/journal:** theoretical public-finance / environmental-IO *regular article* targeting *International Tax and Public Finance*. Verify live requirements again at the Stage 12/13 refresh; submission fee remains an unresolved Stage15 portal-only hard gate.
- **Paper's single research question:** Holding a fixed-location two-region market, when does higher product substitutability reverse the sign of A's optimal productive green infrastructure response to B's green-investment subsidy?
- **Headline finding, accurately quantified:** On a bounded, regular interior branch satisfying primitive and Bernstein sufficient conditions, the cross-instrument best response crosses once from negative to positive as `θ` increases; the **global policy SPNE** interpretation has been established for a rational canonical witness over `θ∈[0,1]` and a nonempty open primitive neighborhood. Canonical threshold `θ*=0.7738043861…`. Never conflate the conditional formula with a universal global equilibrium classification.
- **Counterfactual:** With other canonical primitives fixed, removal of conventional firm investment eliminates the reversal. This is **matched-example separation, not a necessity theorem**: an independently checked no-`x`, altered-`β` counterexample also reverses.
- **Cold-reader contract:** by paragraph 2, a specialist should recover the government decision and the countervailing sign possibilities; by end of the opening page, the exact conditional contribution and closest known alternative; immediately after the main theorem, why the sign can reverse; by the first paragraph of Discussion, why welfare improvement is not equivalent to emission reduction; by Conclusion, the narrow inference and decisive limitations.

## Original one-story opening architecture (write fresh prose at Stage 10B)

1. **Puzzle and stakes (first 1–2 paragraphs):** B increases a firm-facing green subsidy. A can withdraw productive infrastructure or reinforce it. Explain why this is economically consequential when a common product market couples the regions. Do not lead with Japan-specific details or a list of variables.
2. **Contending forces (next paragraph):** competition shifts output and private investment; producer rents/business stealing, CS, territorial emissions target and own-subsidy adjustment can point in opposite directions. Identify the endogenous channel that a naive one-policy picture misses; explicitly say `d` matters.
3. **Precise answer and significance:** one sign crossing of `∂h_A^BR/∂s_B` under theorem conditions, `θ*` for the certified witness, and the **global-SPNE domain qualifier in the same immediate breath**. Distinguish strategic reaction from a discrete substitution of one program for another.
4. **Closest theory comparison (one compact paragraph):** Hauptmeier already gives cross-instrument reactions; Morita–Okoshi already combines incentives/infrastructure/Cournot/threshold but addresses MNE location and a different infrastructure comparison; Strandholm already studies conventional and green R&D. Our narrow original *inference* is the product-substitutability-indexed sign reversal in the specified global continuation; not a first-ever combination of ingredients. There may still be an editorial novelty dispute.
5. **Matched counterfactual and limits:** same-primitives no-`x` contrast but nonnecessity; territorial target `d` sensitivity and direct policy-path proportionality; welfare-coordination result distinguished from physical emissions. Explicitly identify illustrative Japanese GX relevance without claiming literal authority or evidence.
6. **Compact roadmap:** follow economic question → game → main results → limits rather than listing every minor sub-section.

Avoid an introductory sequence of repeated "we do not claim X" sentences; one explicit related-theorem comparison suffices. The limitations remain visible close to claims, not buried until Discussion.

## Section-by-section production architecture and artifact contract

| Planned location (existing source) | Reader task | Stage10B exact change | Proof/science retention |
|---|---|---|---|
| Abstract in `main.tex` | In 150–250 words, identify policy-response puzzle, unique conditional sign switch, global witness scope, matched benchmark, major limit. | Rewrite as question → opposing forces → conditional inference → near-neighbor value → restriction, not method inventory. | `θ*` only a canonical numerical witness; no all-primitives global result or universal dual-investment necessity. |
| `sections/introduction.tex` | Reach the puzzle, central result and exact closest-paper distinction early. | Re-author architecture from scratch; strongest framing after close-paper study, rather than tacking disclaimers onto old paragraphs. | Keep institutional applicability and globality caveats in opening. |
| `sections/model.tex` | Understand who moves, what is chosen, how green and conventional investment enter profit and emissions. | Use a compact text/diagram of three stages, then introduce `s,h,x,g,θ,d,μ` and exact restrictions. | No model changes; `m>0`, non-negativity, no binding budget coupling, fixed locations. |
| `sections/equilibrium.tex` | Distinguish locally interior continuation from full admissible game. | Move to a clean regime map (duopoly / kink / monopoly) and why off-path deviations matter. | Preserve all five regimes, uniqueness/selection bounds, and branch conditions. |
| `sections/main_results.tex` | State signed derivative and explain why it reverses. | Theorem in body, then **immediate economic mechanism**, then visible proof bridge `-H^{-1} c` → `-ΩP` → Bernstein single root; rational global-SPNE witness separately labelled; full algebra in appendix. Figure1 adjacent. | Preserve `μ>0`, polynomial, coefficient restrictions, `θ=0` zero, exact witness `θ*`, global caveat, no all-primitive proof. |
| Existing no-`x` subsection | Identify what two investment margins do and what they do not prove. | Present same-primitives comparison and one sentence of nonnecessity/counterexample; no lengthy second novelty pitch. | Preserve `β=1.3` no-`x` reversal counterexample and formal matched-scope difference. |
| `sections/welfare.tex` | Know what welfare can and cannot show. | Lead with accounting: subsidy transfers, second-best local capture, regional CS/PS, territorial target. Present coordinated active-duopoly benchmark and the fact that emissions may increase. | Do not call constrained coordinated active-duopoly solution a global planner optimum or emission abatement theorem. |
| `sections/robustness.tex` | Distinguish robust qualitative inference from special conditions. | Frontload exact `d=1.5` negative / `d=2` switch / `d=3` positive sensitivity; classify Bertrand/ownership as locally interior, global claim only original Cournot witness/open set. | Report parameter-domain/active-policy restrictions; no off-boundary extrapolation. |
| `sections/institutional_bridge.tex` | Translate model to a falsifiable policy comparison without pretending to estimate it. | Explain what rival-policy exposure, market substitutability and infrastructure would need to mean in a future study; threshold/nonlinear design, confounding and endogenous policy choice; Japan only motivation. | No evidence of causal estimates, policy budget/accounting, relocation or authority equivalence. |
| `sections/related_literature.tex` | Test that the new proposition survives three closest papers. | Reorganize around **theorem object / timing / equilibrium domain / counterfactual**; one concise comparison for Hauptmeier, Morita–Okoshi and Strandholm, then broader fiscal/environmental literature. | Novelty remains `DISTINCT BUT NARROW`; source-level absorption must still be rechecked at Stage 11/12. |
| `sections/discussion.tex` | Synthesize economic decision and binding limitations. | Organize short, non-repetitive sections: mechanism, limits of equilibrium/globality, `d`, no-`x`, emission/welfare, institution and identification; end with feasible future tests. | No stronger causal or policy prescription. |
| `sections/conclusion.tex` | Remember one insight and its decisive scope. | One direct paragraph of conditional threshold response plus one concise paragraph of limits and research implication. | No new theorem or inference. |
| `sections/global_equilibrium_appendix.tex`, `sections/appendix.tex` | Reconstruct every nontrivial global-best-response and root-count step. | Preserve and clarify any proof-critical bridge referred from main body; move only routine arithmetic; avoid shortening by dropping discontinuous deviations. | Keep rational witness, exact inequalities, root-free Jacobian/scaled-gap endpoints and kink/monopoly hostile test. |

The existing paper's ordering can be moderately adjusted at Stage 10B when all references remain valid. This blueprint does NOT demand a new empirical section or added theorem.

## Proof design and reviewer-verifiability plan

**Main proof chain the referee must reconstruct from text alone:**
1. From the two government FOCs and own-policy Hessian `H_A`, derive
   `(∂s_A^BR/∂s_B, ∂h_A^BR/∂s_B)' = -H_A^{-1}(W_{s_As_B},W_{h_As_B})'`.
2. Identify the *economic* roles of own-instrument coupling and the direct rival-subsidy cross term, including its CS/PS/territorial components. Do not let a compact Jacobian notation conceal the mechanism.
3. On a certified interior duopoly domain with `μ>0`, derive `∂h_A^BR/∂s_B=-Ω(θ)P(θ²)`, `Ω>0`. Preserve `P(0)>0>P(1)` and negative Bernstein coefficients yielding one root, not simply plot evidence.
4. Separately prove the candidate best response is a **global government best response** against duopoly/kink/monopoly deviations at the canonical rational witness. Expose why earlier interior-only FOCs failed; retain exact outside-branch welfare-gap comparison and `θ→0` scaling/regularity bridge.
5. Report `θ*` and Figure1 only after the relevant theorem domain is defined; Figure1 is illustrative of canonical parameters, not proof of globality for all primitives.
6. Match the no-`x` calculation to identical remaining canonical primitives; explicitly countercheck the `β=1.3` no-`x` exception against universal necessity.
7. Ensure welfare and sensitivity claims cite the matching theoretical regime (global policy vs local interior diagnostic) rather than blending them.

**Appendix allocation:** detailed algebra of five continuation regimes, exact rational root/positivity certificates, KKT sign checks and symbolically generated robustness tests may remain in appendices/code; domain restrictions, major inequalities, the fact of global-deviation testing and interpretation of conditional scope must remain in the body. Keep deterministic scripts/Lean/LaTeX reproducibility; no numerical or formal proof invented in a prose rewrite.

## Exhibit plan and scarcity test

1. **Essential Figure1** existing `figures/figure1_threshold_response.pdf`: signed `∂h_A^BR/∂s_B` vs `θ`, zero and single crossing, matched no-`x` path, clear canonical-parameter label and not-universal annotation. Must regenerate with the existing script; never hand trace.
2. **Optional compact three-row scope table** for fixed-other-primitive `d=1.5,2,3`: signed response regimes with source statement that this is an *interior, local exercise*, not a three-global-SPNE theorem. Add only if it helps cold reading more than prose.
3. **Optional closest-paper comparison table**, probably unnecessary in final journal manuscript; keep the full analytical comparison in this blueprint/literature notes unless the editor test demonstrates real reader benefit.
4. **Existing welfare table** retained if it distinguishes model welfare from territorial emissions without duplicating main result. Do not claim absolute policy units or actual prefectural expenditures.
5. **Any fourth/fifth candidate exhibit** must earn its pages by revealing a new proof-critical regime/limitation. The best current design needs only the response figure and a concise table if truly necessary.

## Required limitations placement: a positive result with exact boundaries

| Limitation | State where? | Safe claim |
|---|---|---|
| **Globality/generalization** | Abstract qualifier, theorem/global-bridge paragraph, Discussion | True global SPNE certified for rational canonical witness over the specified rivalry domain and open primitive neighborhood; not arbitrary feasible primitives. |
| **Policy target dependence** | Right after mechanism, `robustness`, Discussion | Rivalry changes relative force of channels; `d=1.5,2,3` examples show no reversal / reversal / no reversal, so rivalry alone is not sufficient. |
| **No conventional-investment necessity** | Immediately after no-`x` result, Discussion | Matched canonical benchmark separation only; `β=1.3` independent no-`x` counterexample excludes universal necessity. |
| **Subsidy vs infrastructure shock** | Mechanism paragraph | Rival policies enter through composite `y_B=(μ/k_g)s_B+νh_B`; the theorem does not isolate a unique subsidy causal path. |
| **Welfare vs emissions** | Welfare example and Discussion | At canonical case coordination can increase model welfare and territorial emissions; not global climate efficiency. |
| **Institutions** | Intro (brief) and Institutional Bridge/Discussion | Fixed incumbent locations; no national transfers / hard joint budget / complex local powers / congestible network; Japanese examples motivate but do not literally map instruments. |
| **Empirics** | Discussion | Nonlinear/threshold comparative-statics prediction only; no causal evidence or identified instrument shock, and possible strategic policy endogeneity. |
| **Technical robustness** | Equilibrium and Robustness | `μ>0,m>0`, positive/nonnegative actions, interior conditions, Bertrand policy boundary around θ=.545; partial capture only in small neighborhood. |

## Cold-reader and quality gates after the rewrite

- **Test A (specialist first pass):** show only final manuscript; ask what decision maker chooses, what changes sign, and whether the result is global for all primitives. A response "competition always makes governments spend more" must FAIL.
- **Test B (novelty):** editor must distinguish existing instrument-reaction theory/Hauptmeier, M&O's location/infrastructure level contrast, Strandholm's dual-investment finding from the paper's narrowly distinct conditional cross-derivative theorem. An answer "we combine models" must FAIL.
- **Test C (economic mechanism):** editor identifies at least CS, PS/business stealing, territorial target and own-policy coupling, and correctly says `d` can eliminate switch.
- **Test D (proof):** independent referee reconstructs one FOC→sign→root chain and sees the global off-branch check, without using author notes. Failure cannot be patched by a prose-only "obvious" assertion.
- **Test E (negative evidence):** editor finds the no-`x` exception, emission-increase example, fixed-location and journal-source caveats. No silent omissions.
- **Test F (journal fit):** ITPF conventional real paper scope and all current submission constraints after Stage12/13 revalidation. No unconditional acceptance claim.

When Stage 10B finishes, produce `EDITORIAL_ADOPTION_LOG.md` with source location → implemented manuscript line/page → reason/deviation, and the full before/after diff. Stage11: use `templates/EDITORIAL_REFEREE_REPORT.md` in an independent cold run (not provided blueprint). Stage13 re-audit after findings; Stage14 rerun proofs, figures, exact final PDF visual/metadata test. Theory drift or a hidden source theorem returns to the earliest scientific gate, not a cosmetic rewrite.

## Coherence verdict before writing

**PASS — design only.** One signed policy-response question controls Intro, theorem, Fig1, matched benchmark, robustness and Discussion. No model or scientific result is imported from the exemplars. Main-text mathematical bridges remain visible; appendix algebra remains accessible. Contradictory writing styles resolved by precise theorem-level economy (Matsumoto) plus adjacent opposing-force intuition (Lai) and explicit policy-regime narrative (Morita–Okoshi). All seven binding limits have a planned near-claim location and nonrepetitive synthesis. Stage10A design can therefore pass to Stage10B without changing the frozen model.

**Stage 10B is future work. Stage 15 remains blocked by live ITPF portal fee check. This blueprint does not authorize submission.**
