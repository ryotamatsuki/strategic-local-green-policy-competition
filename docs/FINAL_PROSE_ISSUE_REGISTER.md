# FINAL_PROSE_ISSUE_REGISTER — Stage 13 v3.1 (2026-11-19)

Original full-PDF Phase A report: `FINAL_PROSE_REFEREE_REPORT.md` (ChatGPT file Library), 24 pages, SHA-256 `5dfe22de37cb10e047527e56bd60532b8767a7c2aea1fdb128ee54d3cb65f62f`; the reporter disclosed previous contextual exposure, so complete blindness was not guaranteed. Revised production content: `366fb705ffb4b4c0677a65b2d30a96e8bc74ec79`; local clean-built 26-page PDF SHA-256 `b0893897ec9780cb95dbe8d079c1979a5f7958f8bb17f199ec9fe2ed3c86a3c1`. The CI-produced final handoff PDF is separately frozen by its own SHA. **All source-side repairs have been applied; second independent whole-PDF critical-reader closure remains pending for every MAJOR. No Stage13 GO.**

## A01 — MAJOR

**Original PDF location:** p. 2 §1 第1・第5段落、p. 8 §4 冒頭、p. 10 式(36)前後、pp. 16–17 §7.1、p. 19 §10 最終段落。

**Exact original phrase reported:** “Should a local government match that support, retreat, or respond through a different instrument?” ／ “In the canonical high-rivalry region the local government reduces its own firm-specific subsidy but raises infrastructure.”

**Referee diagnosis:** 冒頭の三択は一つの政策の選択や政策パッケージ全体の均衡変化を連想させる。識別した比較は、相手のインフラを固定し、相手の補助率に対して自地域が二政策を同時に最適化した偏微分。§3.4と式(25)、(36)で復元できるが、本文が売り出す最初の結果にはこの条件がない。また命題2はインフラ反応に関するもので、表1が報告する自地域補助率の符号は二点分。高競争域全体を対象とする後者の記述をその表だけでは確認できない。

**Exact revised excerpt** (`sections/introduction.tex:6`):

> We ask whether product-market substitutability changes the sign of $\partial h_A^{BR}/\partial s_B$, where jurisdiction $A$ reoptimizes $(s_A,h_A)$ in response to $B$'s subsidy, holding $h_B$ and the model primitives fixed. The de

**Bounded remedy and closure test:** Partial h_A best-response to s_B, rival h_B fixed, both own policies reoptimized; own subsidy sign only for canonical theta=.9. §1の問い、§4の記号定義、§7.1の実証上の対象に、固定する相手政策と調整する自地域政策を一文ずつ配置する。自地域補助率の方向は、本文中に示した高競争の例（θ = .9）に結びつける。相手の両政策が動く観測と式(36)の関係を§7.1で明示する。

**Scientific guardrail:** 命題2の偏微分、相手政策の合成変数、大域最適反応としての追加要件を維持する。自地域補助率の符号を全域へ広げたり、政策均衡全体のショック反応を導いたりしない。

**Status:** SOURCE REPAIR APPLIED; revised PDF second-reader retest PENDING. Any full-PDF first or second reviewer independence requirement cannot be certified by this revising agent.

## A02 — MAJOR

**Original PDF location:** p. 1 Abstract、p. 2 §1「The main result」および「The economic mechanism」の段落、p. 8 §4.1 式(26)直後、p. 9 命題2直後と§4.2。

**Exact original phrase reported:** “The economic mechanism is composite.” ／ “A sign reversal is possible when product-market rivalry changes their relative strength.”

**Referee diagnosis:** 本文の入口は四次多項式、Bernstein係数、大域検証を順に紹介するが、経済的にどの二つの項が反対方向に働くかはp. 9後半まで具体化されない。特にθ = .5でもインフラの直接交差効果は正である。その段階で総反応を負にするのは自地域補助率の調整であり、θ = .9では直接項が勝る。この対照が先に見えないと、読者は「中程度の競争では直接効果も負」と読みかねない。「target-loss consequence」の説明も、0.952と−0.0242が何故正の寄与を生むのかを本文でつなぎ切っていない。

**Exact revised excerpt** (`sections/main_results.tex:88`):

> At the canonical parameters the direct effect and the own-subsidy adjustment pull in opposite directions at both representative rivalry levels. At $\theta=.5$, the direct term's contribution to the policy slope is $+0.000677$ but 

**Bounded remedy and closure test:** Hessian-scaled decomposition with positive direct term at theta=.5/.9 and opposite total response. §1と式(26)の後に二つの反応の短い対照を置く。命題2の直後に、基準例におけるθ = .5とθ = .9の比較を一段落で示し、相手補助率が自地域の排出を押し下げ、インフラ拡大はその例では産出を通じ排出を押し上げるため、目標損失項の混合偏微分が正になる、と説明する。必要なら `−d E_{A,h_A} E_{A,s_B}` を本文のアフィンな排出設定に結びつける。Bernsteinの技術説明は命題とAppendix A.3で保てる。

**Scientific guardrail:** 各成分の符号は基準例の記述として扱う。正の直接交差効果とインフラ最適反応の傾きは尺度が異なるため、そのまま差し引かない。命題2の一意性は既存の多項式条件に帰し、一般的な環境改善や単調増加を含意しない。

**Status:** SOURCE REPAIR APPLIED; revised PDF second-reader retest PENDING. Any full-PDF first or second reviewer independence requirement cannot be certified by this revising agent.

## A03 — MAJOR

**Original PDF location:** p. 15 §6.3 表3直後、p. 18 §9「The territorial objective」の段落。

**Exact original phrase reported:** “the territorial objective must be strong enough to offset the purely competitiveness-oriented margins at lower rivalry” ／ “The sign reversal appears between these cases.”

**Referee diagnosis:** 低競争側で何を相殺するのかが不明で、総効果を指すなら基準例の低競争側が負という表の読み方と整合しない。特定の直接成分を指すとしても、§4.2で目標項と生産者余剰項の大小が示されるのはθ = .9であり、この箇所の「at lower rivalry」は裏づけられていない。三つの重みで得た符号パターンからは、重みについて一般に成り立つ必要条件や全範囲の単調な区分までは読めない。

**Exact revised excerpt** (`sections/robustness.tex:95`):

> These three interior calculations show that the sign pattern depends on the target-loss weight $d$ when the other canonical primitives are held fixed: the slope is negative at every positive rivalry level for $d=1.5$, changes from

**Bounded remedy and closure test:** Only three reported d values; no global necessary condition or novel global-SPNE claim. 他の基準パラメータを固定した内点比較として、報告した三つの重みの符号を簡潔に説明する。直観は「強い競争側の基準例で、目標項が直接効果を押し上げる」という§4.2の具体的結果につなぐ。低競争での相殺条件を残すなら、どの項を意味するかと裏づけを示す。

**Scientific guardrail:** d = 1.5、2、3の根数と符号、θ = 0のゼロ、dが目標損失の重みであることを維持する。表3の内点結果に大域SPNEの主張を加えない。

**Status:** SOURCE REPAIR APPLIED; revised PDF second-reader retest PENDING. Any full-PDF first or second reviewer independence requirement cannot be certified by this revising agent.

## A04 — MAJOR

**Original PDF location:** p. 5 §3.1 最終段落、p. 7 §3.4 第2段落・命題1、pp. 23–24 Appendix A.6。

**Exact original phrase reported:** “cannot reach the rival-monopoly side” ／ “Exact KKT signs select that common boundary” ／ “The accompanying verification script reproduces the continuation comparisons”.

**Referee diagnosis:** §3.3は相手方のkinkとmonopolyを別々に定義する。A.6の逸脱比較に移る箇所では相手のmonopolyを除外したあと、自地域のkinkとmonopolyを比較する。相手のkinkが到達不能なのか、monopoly sideに含めた略称なのか、別に比較したのかを本文から確定できない。また「Exact KKT signs」「root counts」と三点の例だけでは、どの条件で各候補を落とし、どの符号判定で全区間を覆ったかを独立して追いにくい。これは証明の誤りという指摘ではなく、主張と提示された論証の対応の問題である。

**Exact revised excerpt** (`sections/global_equilibrium_appendix.tex:24`):

> The rival-firm limit-pricing kink requires $\theta w_B^*\geq Lw_A$; the rival-firm monopoly requires the still stronger $\theta w_B^*\geq(2-R)w_A$, where $2-R\geq L$. Both rival-firm inactivity regions are consequently unreachable

**Bounded remedy and closure test:** Five-region map; both rival-exclusion branches, constrained KKT maxima and continuous exact gap. A.6に小さな表または短い段落を足し、両方向のkink・monopolyおよびduopolyについて、逸脱で到達できるか、到達できる場合の最大値候補、根拠となる不等式・KKT判定を対応づける。必要なら相手側kinkの到達条件を§3.3から明示する。厳密計算を引用する場合、該当する検証箇所と判定対象の式・区間を示す。現行証明に該当する確認が存在しない場合は、文章で補完せず均衡証明の確認へ差し戻す。

**Scientific guardrail:** 全非負行動、θ ∈ [0, 1]、θ = 0での排除不可とスケーリング、基準ベクトルと共通開近傍を維持する。既存検証が支える範囲で記載する。

**Status:** SOURCE REPAIR APPLIED; revised PDF second-reader retest PENDING. Any full-PDF first or second reviewer independence requirement cannot be certified by this revising agent.

## A05 — MINOR

**Original PDF location:** pp. 1–2 §1 第1・第2段落。

**Exact original phrase reported:** “Green industrial policy is increasingly place based.” ／ “This raises a cross-instrument public-finance question.”

**Referee diagnosis:** 本文を起点に読むと、インフラ例、日本のGX、OECDの説明を経て次頁で初めて問いに出会う。p. 2にも貢献段落と主結果段落で閾値・大域検証が重なる。

**Exact revised excerpt** (`sections/introduction.tex:4`):

> When a rival jurisdiction raises its green-investment subsidy, should a local government expand or contract productive infrastructure? This question concerns the local government's joint best response in subsidies and infrastructu

**Bounded remedy and closure test:** Question now appears in Introduction's first sentence before the policy-background paragraphs. 冒頭に補助率の上昇に伴うインフラ反応の問いを置き、制度背景を動機づけの短い例にまとめる。本文冒頭の詳細な一意性の論証は§4へ送る。

**Scientific guardrail:** GXの政策手段の対応は機能面に限定し、政府の法的権限に新しい主張を加えない。

**Status:** SOURCE REPAIR APPLIED; revised PDF second-reader retest PENDING. Any full-PDF first or second reviewer independence requirement cannot be certified by this revising agent.

## A06 — MINOR

**Original PDF location:** pp. 17–18 §8 冒頭、財政競争・Morita and Okoshi・Strandholmの段落。

**Exact original phrase reported:** “The analysis draws together environmental federalism, fiscal competition over productive public inputs, place-based business incentives, and environmental investment under oligopoly.”

**Referee diagnosis:** 四系統を並べる導入で始まるため、結果レベルの比較は中盤まで現れない。§8には、二政策の同時調整、FDIをめぐるインフラの結果、二種類の投資という比較の材料がすでにある。

**Exact revised excerpt** (`sections/related_literature.tex:4`):

> The closest comparison is how productive infrastructure reacts to a rival fiscal instrument when the local government also adjusts its own policies. Multidimensional strategic responses are already established in fiscal competitio

**Bounded remedy and closure test:** Result-level prior-work comparisons placed first, including Morita–Okoshi product similarity and Levaggi–Panteghini signed reaction functions. 財政競争の近接研究を起点に、相手の財政手段に対する地元インフラの反応に何が既知か、本稿が固定立地の下で同じ反応の符号を何に沿って比較したかを続けて書く。Morita and Okoshiの具体的な交通費条件を文章に追加する場合は原著を確認してからにする。

**Scientific guardrail:** 既存研究の結果を新たに断定しない。本稿の比較は固定立地・条件付きの最適反応、従来型投資の効果は基準例での比較。

**Status:** SOURCE REPAIR APPLIED; revised PDF second-reader retest PENDING. Any full-PDF first or second reviewer independence requirement cannot be certified by this revising agent.

## A07 — MINOR

**Original PDF location:** p. 4 §2.3 式(4)直後、p. 6 §3.2 式(22)直後・§3.3 式(24)前。

**Exact original phrase reported:** “either local policy raises the local firm’s output” ／ “the cost-minimizing investment composition”.

**Referee diagnosis:** µの許容域が技術節で一覧化されず、補助金が産出を増やすという文がµ = 0にも及ぶように見える。式(24)は補助金控除後の投資費用を最小化した配分であることが明示されず、読者が式(5)の粗費用で再現を試す余地がある。

**Exact revised excerpt** (`sections/equilibrium.tex:101`):

> The composition below minimizes the net investment cost $C_i(x_i,g_i)-s_i g_i$ conditional on effective cost reduction $z_i$, rather than the unsubsidized cost $C_i$ alone. On the nonnegative-policy continuation characterized belo

**Bounded remedy and closure test:** mu>=0 and mu=0 case; subsidy-net investment cost and nonnegative equilibrium composition distinguished. §2.3に証明で使うµの許容域を明記し、産出に対する補助率の効果をµ > 0の場合に限定する。式(24)の直前に補助金控除後の費用を使うことと、非負制約の下で当該配分を用いられる範囲を一文で添える。

**Scientific guardrail:** 実際に使う許容域と行動集合を維持し、系1のµ = 0を残す。内点投資式を別の境界へ拡張しない。

**Status:** SOURCE REPAIR APPLIED; revised PDF second-reader retest PENDING. Any full-PDF first or second reviewer independence requirement cannot be certified by this revising agent.

## A08 — MINOR

**Original PDF location:** p. 3 §1 第2段落、p. 12 §5 式(40)前後、p. 13 表2直後2段落。

**Exact original phrase reported:** “In the canonical example coordination raises total model welfare” ／ “the coordinated solution tolerates higher territorial emissions.”

**Referee diagnosis:** §5の中盤と表注には内点の限定があるが、Introductionと表後の解釈では、非負行動の全域で解いた協調政策が排出を上げたようにも読める。表は対称な活動デュオポリーでの協調比較である。

**Exact revised excerpt** (`sections/welfare.tex:11`):

> The objective defines the coordinated policy problem. The reported numerical comparison evaluates a symmetric interior active-duopoly candidate; it does not establish the planner's global optimum over all nonnegative policies and 

**Bounded remedy and closure test:** Reported coordinated calculation is a symmetric interior active-duopoly benchmark, not certified planner global optimum. 式(40)で目的を示した直後に計算対象の枝を予告し、Introduction・表後とも「報告した協調内点ベンチマーク」での厚生・排出の差に統一する。

**Scientific guardrail:** 表2、θ = .9の厚生・産出・排出値、領域目標と地球規模の気候損害の違い、計画者の大域最適性を別途主張しない限定を維持。

**Status:** SOURCE REPAIR APPLIED; revised PDF second-reader retest PENDING. Any full-PDF first or second reviewer independence requirement cannot be certified by this revising agent.

## A09 — MINOR

**Original PDF location:** p. 12 §5 式(43)の直前。

**Exact original phrase reported:** “has no meaningful unit interpretation and is not used.”

**Referee diagnosis:** 読者に導入されていない比率を退けてから実際の指標を定義するため、文脈なしに校閲・検証時の論点に応答する文のように見える。

**Exact revised excerpt** (`sections/welfare.tex:33`):

> To compare the subsidy outlay and infrastructure expenditure in common units, define the descriptive fiscal-composition share

**Bounded remedy and closure test:** Unnecessary discussion of never-used ratio removed; unchanged phi_h definition. 補助金支出とインフラ支出を同じ単位で比べるためにφ_hを用いる、と直接定義する。

**Scientific guardrail:** 式(43)、計算値、厚生目的における補助金の移転相殺を維持する。

**Status:** SOURCE REPAIR APPLIED; revised PDF second-reader retest PENDING. Any full-PDF first or second reviewer independence requirement cannot be certified by this revising agent.

## A10 — MINOR

**Original PDF location:** p. 14 §6.1 最終段落。

**Exact original phrase reported:** “The interior IFT must therefore not be extrapolated beyond its active-policy region.”

**Referee diagnosis:** IFTが本文でこの形では未定義であり、外挿できない対象が数学の手法なのか政策の傾きなのか即座には分からない。

**Exact revised excerpt** (`sections/robustness.tex:46`):

> Once that boundary binds, the derivative obtained by inverting the two interior government first-order conditions no longer characterizes the constrained policy best response; its slope must not be extrapolated beyond the active-p

**Bounded remedy and closure test:** Constrained h=0 boundary at theta~.545 invalidates the interior two-policy slope. h = 0が拘束するとこの内点式で最適反応の傾きを評価できない旨を述べ、約.545を当該例の境界として接続する。

**Scientific guardrail:** 局所的な符号反転、報告された閾値・境界、Bertrandでの大域主張の限定を維持する。

**Status:** SOURCE REPAIR APPLIED; revised PDF second-reader retest PENDING. Any full-PDF first or second reviewer independence requirement cannot be certified by this revising agent.

## A11 — MINOR

**Original PDF location:** p. 15 §6.5 第2段落、pp. 18–19 §9 中盤〜最終段落、p. 24 Appendix A.7。

**Exact original phrase reported:** “the repository retains a no-x counterexample” ／ “The empirical implications are threshold rather than globally linear.”

**Referee diagnosis:** 反例は§4.4とA.7に示されるので、§6.5で保管場所を主語にもう一度述べると論旨が止まる。§9では§4の分解と§7.1の非線形性の再掲が続き、固定立地や地域目標が結果の使い方をどう制限するかが目立ちにくい。

**Exact revised excerpt** (`sections/discussion.tex:12`):

> Conventional investment strengthens the response of quantities to policy-induced productivity changes. The matched no-$x$ comparison isolates this margin at the canonical parameters, without establishing that conventional investme

**Bounded remedy and closure test:** Duplicate discussion and repository-process language condensed while the no-x counterexample remains. §6.5の反例を§4.4・A.7への参照に縮める。§9は固定された生産立地と地域目標の下で、同じ相手補助率ショックが異なるインフラ対応につながるという制度的含意に絞る。実証設計の説明は§7.1に集約できる。

**Scientific guardrail:** no-xの反例、環境目標の限定、全国的な炭素価格はモデルの均衡結果として扱わないこと、再現用資料への案内を維持する。

**Status:** SOURCE REPAIR APPLIED; revised PDF second-reader retest PENDING. Any full-PDF first or second reviewer independence requirement cannot be certified by this revising agent.

## A12 — MINOR

**Original PDF location:** p. 16 §7「The parameter」の段落と§7.1の第4予測。

**Exact original phrase reported:** “or product attributes valued by customers” ／ “the response should weaken sharply”.

**Referee diagnosis:** 商品属性の評価は通常、式(4)の限界費用の低下とは別の需要側の経路を指す。「sharply」は、µ = 0で偏微分がゼロという系1だけからは減衰率の主張として読めない。

**Exact revised excerpt** (`sections/institutional_bridge.tex:24`):

> Fourth, the subsidy-specific product-market transmission vanishes at $\mu=0$ in Corollary~\ref{cor:mu-zero}; where the same regular interior branch persists as $\mu$ approaches zero, the response accordingly tends to zero. The mod

**Bounded remedy and closure test:** Marginal-cost production channel replaces demand-side quality explanation; no unverified response decay rate. 現行の費用式に直接対応する省エネ・工程効率の例を使う。µが小さい場合の表現は、正則な枝で伝達が弱まるという方向づけにとどめる。

**Scientific guardrail:** 需要・費用式、µの定義、µ = 0の結果を維持し、効果の減衰率や実証事実を追加しない。

**Status:** SOURCE REPAIR APPLIED; revised PDF second-reader retest PENDING. Any full-PDF first or second reviewer independence requirement cannot be certified by this revising agent.

## A13 — MINOR

**Original PDF location:** p. 11 図1と表1、p. 13 表2、p. 15 表3。

**Exact original phrase reported:** “Canonical cross-instrument infrastructure response.” ／ “Response of jurisdiction A to a higher rival green subsidy” ／ “Target intensity and the interior cross-infrastructure response”.

**Referee diagnosis:** 図はゼロ線、閾値線、二曲線を示すが、相手インフラを固定した比較であることはキャプションに記されていない。表1も固定相手政策と自地域の同時最適化を省く。表2のφ_hと表3のd、uの意味は本文を戻らないと分からず、表3の “negative then positive” はθの昇順を前提にする。

**Exact revised excerpt** (`sections/welfare.tex:58`):

> Notes: $NE$ denotes the symmetric decentralized global-policy Nash equilibrium; $C$ denotes the symmetric coordinated interior candidate on the active-duopoly branch, not a proven global planner optimum. The fiscal share $\phi_h=(

**Bounded remedy and closure test:** Self-contained captions and Notes for NE, C, phi_h, theta near threshold, d and u; table numbers frozen. 図1・表1で固定条件と基準値への参照を示す。表2注でNE、C、φ_hを定義し、0.774が閾値の丸め表示か実際に使った評価点か、必要なら著者が確認して表記する。表3注にdの意味、u = θ²、他のパラメータの固定、昇順を添える。

**Scientific guardrail:** 実線・破線の計算、符号、丸め前の値、表の数値、内点と大域の区別を維持する。

**Status:** SOURCE REPAIR APPLIED; revised PDF second-reader retest PENDING. Any full-PDF first or second reviewer independence requirement cannot be certified by this revising agent.

## A14 — MINOR

**Original PDF location:** p. 1 AI利用脚注、p. 19 Statements and Declarations末尾。

**Exact original phrase reported:** “AI use disclosure” ／ “Use of generative AI”.

**Referee diagnosis:** 用途の列挙が冒頭と末尾で重なる。著者責任まで記した末尾の宣言の方が自立しており、p. 1では問いを追う読者を中断させる。

**Exact revised excerpt** (`main.tex:28`):

> \footnotetext{AI use disclosure: Generative AI tools, including OpenAI ChatGPT, were used to assist with exploratory model development, literature organization, mathematical derivations and theoretical-proof checking, symbolic cro

**Bounded remedy and closure test:** ITPF expressly requires a title-page AI footnote; same material AI use retained in Declarations; no author-fact attestation changed. 掲載誌が指定する掲載箇所を後段で確認し、許される範囲で重複を減らす。

**Scientific guardrail:** 列挙されたAIの用途、著者責任、その他の宣言は著者確認なしに変更しない。誌の規定適合性はここでは判定していない。

**Status:** JOURNAL-REQUIRED RETENTION; declaration placement maintained. Any full-PDF first or second reviewer independence requirement cannot be certified by this revising agent.

## A15 — MINOR

**Original PDF location:** p. 1 Abstract中盤、p. 7 §3.4 命題1。

**Exact original phrase reported:** “a canonical rational witness is a true subgame-perfect Nash equilibrium”.

**Referee diagnosis:** Abstractの主語は基準パラメータ例を指すが、SPNEを構成するのは所与のパラメータ下の戦略プロファイル。命題1にはこの区別がある。

**Exact revised excerpt** (`main.tex:32`):

> verify that, at the canonical rational parameter vector and on a nonempty open primitive neighborhood, the induced policy profile and downstream continuation strategies constitute a true subgame-perfect Nash equilibrium (SPNE) of 

**Bounded remedy and closure test:** SPNE predicated on induced policy profile plus continuation strategies, not a parameter vector. 「基準パラメータとその近傍において、内点政策プロファイルと下流の継続戦略がSPNEを形成する」という命題と同じ主語関係にする。

**Scientific guardrail:** 大域的な最適反応、非負行動集合、基準値からの開近傍の範囲を維持する。

**Status:** SOURCE REPAIR APPLIED; revised PDF second-reader retest PENDING. Any full-PDF first or second reviewer independence requirement cannot be certified by this revising agent.

## A16 — MINOR

**Original PDF location:** p. 15 §6.4 唯一の段落。

**Exact original phrase reported:** “the government Jacobian, and the switching root are all strict.”

**Referee diagnosis:** 厳密性は不等式に、正則性はヤコビアンに、単純性は根に当てる概念である。まとめて “strict” とすると何が摂動に対して維持されるか読み取りにくい。

**Exact revised excerpt** (`sections/robustness.tex:99`):

> At the canonical symmetric configuration, the relevant policy inequalities and the global-equilibrium gap are strict, the full government first-order-condition Jacobian is nonsingular, and the switching root is simple. Under suffi

**Bounded remedy and closure test:** Strict inequalities, nonsingular Jacobian and simple switching root distinguished; local only. 厳密なギャップ・領域不等式、ヤコビアンの非特異性、閾値の単純根を、対応箇所に接続して記す。管轄間で異なる摂動について、どの局所的配置を保存するのかを短く指定する。

**Scientific guardrail:** 非対称な全パラメータ集合に対する閾値定理や閉形式解を加えない。偏微分の定義と元の継続性による射程を維持する。

**Status:** SOURCE REPAIR APPLIED; revised PDF second-reader retest PENDING. Any full-PDF first or second reviewer independence requirement cannot be certified by this revising agent.

## Closure conditions

Original Phase A: 0 FATAL EDITORIAL, 4 MAJOR, 12 MINOR. All 16 have a source disposition, but no peer-review-like assurance is claimed. All original equation, align, proposition, corollary and tabular environments are byte-identical after this MINOR-only revision; Figure 1 artwork and bibliography remain unchanged. The canonical model's negative results, no-x counterexample and global-equilibrium scope are preserved. The journal-mandated title-page AI footnote is kept despite unavoidable declaration overlap. Stage 13 GO remains blocked pending **a distinct genuine second complete-PDF critical reader**, source/PDF hash acceptance, review closure and author science/AI factual accountability.
