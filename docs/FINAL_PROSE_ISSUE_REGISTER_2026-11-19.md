# Stage13 Four-MAJOR Revision Issue Register (2026-11-19)

Source PDF sha256 5dfe22de37cb10e047527e56bd60532b8767a7c2aea1fdb128ee54d3cb65f62f; base commit faad1f05cb20088734e43215c19e5b9fda79d1c4.

| Finding | Exact original problem and location | Revised file / safeguard | Verification status |
|---|---|---|---|
| A01 MAJOR | Introduction p2 'match ... retreat ... different instrument'; Results p8 lacks fixed rival hB | sections/introduction.tex, main_results.tex, institutional_bridge.tex, Fig1 and Table1 captions; hold hB fixed and optimize (sA,hA) | Source fix applied; second cold read pending |
| A02 MAJOR | Introduction p2 'mechanism composite'; pp8–9 direct effects could be read as negative at theta=.5 | intro, main_results around Proposition 2; positive raw derivative and Hessian-scaled contributions at .5 and .9 explicitly distinguished | Independent SymPy check agrees; second cold read pending |
| A03 MAJOR | Robustness p15: 'must be strong enough ... at lower rivalry'; Discussion p18 overgeneralization | sections/robustness.tex and discussion.tex; report only three d sign patterns | Confirmed from original script; second cold read pending |
| A04 MAJOR | Appendix A.6 pp23–24 'cannot reach rival-monopoly side' omits B kink | sections/global_equilibrium_appendix.tex five-region case table, F(theta)>0 exact proof, explicit KKT/global gap certificate | Independent all-theta rival exclusion and outside-welfare 3-point check; final PDF proof retest pending |

Phase B adds citation to Levaggi–Panteghini 2021 and refines comparison with Morita–Okoshi section 4.3 (product similarity). Original MINOR A05–A16 remain OPEN individually, even if partly incidentally improved. Scientific content/theorems unaltered. Stage13 final GO requires verified manuscript hash, actual full PDF QA, original and new referee independence records, complete second cold reading, all material editorial issues closed. Do not merge or submit on this report alone.
