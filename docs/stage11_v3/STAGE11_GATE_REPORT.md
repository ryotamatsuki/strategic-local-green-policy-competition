# Green Subsidies — Stage 11 判定

| 判定軸 | 結論 |
| --- | --- |
| ITPF 編集者として | **Desk Reject 相当** |
| research-paper-workflow v3.0 | **REOPEN EARLIER STAGE — Stage 6** |
| 数学的認証 | 基準モデルの中心命題は今回の独立検算を通過。史料や選択に関する限界は下記の範囲。 |
| 論文の扱い | 現稿での投稿準備を止め、既存モデル内で論文としての貢献を一度だけ再判定。 |

2026年11月19日（JST）。対象は *Green Subsidies, Public Infrastructure, and Product-Market Rivalry: When Cross-Instrument Responses Reverse*。PR #31 の Stage 10B 先端 `cd078bbc092b3b41408e5c5e4dcfaa93ac87c3db`。ワークフローはタグ `v3.0`、コミット `7464e290775741f1435602ad655878a70e1f7b7e`。凍結理論の識別子は `SLGPC-THEORY-FREEZE-2026-09-05-v2`。Reviewer の割当は依頼どおり A 数学、B 新規性、C メカニズム、D ITPF 編集。

## 厳しい編集判断

現稿は、地域の競争力ショックに対するインフラ最適反応が、特定の環境目標と製品代替性の下で一度だけ符号を変えることを証明している。自地域が二つの政策を同時調整する以上、負と正の両方があり得るという直観には先行研究がある。実際、Hauptmeier et al. は別の政策の偏反応が市場曲率で反転する結果を、Morita–Okoshi は製品類似性で財政競争のインフラ水準効果が変わる結果を既に示している。現稿と同じ偏微分はこれらの命題から導かれないが、現稿で相手補助と相手インフラは同じ競争力指数に入る。これを踏まえてなお何を診断・識別できるかが弱く、閾値の存在と正確な数値、狭い範囲の大域認証だけでは ITPF の回付に足りない。協調例は主結果と別のベンチマークであり、政策選択・実施の根拠を補うものではない。

### 重大な三件

1. **B01 先行結果との距離**。Morita–Okoshi §4.3／付録 E と脚注20、Hauptmeier et al. ECB 版 eq. (11) を明示して Stage 6 を再検証する。同一の定理が既発表だとは確認していない。
2. **B02 貢献の十分性**。五枝を通じた相手政策の単一指数への還元と、通常投資を省いても反転する反例が残る。元のモデルの範囲で、先行研究より強い政策診断を何が成立させるかを特定し、意味のある反証条件を伴わせる。これは文章だけでは解消しない。
3. **C01 反転の論証**。原稿の直接交差微分は θ=.5 と .9 の両方で正だが、自己補助を内生化した総反応は負から正。自己補助の FOC を消去した式と二点の余剰・目標分解を主命題の近くに置く。

## 監査証拠と残る範囲

| 攻撃・監査 | 証拠と結果 |
| --- | --- |
| 非負行動と候補逸脱 | **PASS**。企業の片側微分から全域の厳密凹性、数量の相補性、一意な五枝を再構成。政府は相手屈折への到達不能、自己屈折・独占境界の接線／法線条件、端点スケールを厳密根数で検査。既知の領域外独占逸脱は再現。 [Reviewer A](REFEREE_A_MATHEMATICS.md) |
| 多重性と無差別 | **対象主張は維持、全政府均衡の一意性は未確定**。別の政府均衡を探索。別候補は見つからず、6回の固定点解探索は数値的に未解決として残した。no-x 屈折枝に実際に無差別な自己行動があり、相手の最適反応も変わり得る。企業継続の一意性と政府均衡の多重性を混同しない。選択／弱支配除去は用いなかった。 |
| 閾値、仮定、可搬性 | **基準・条件付き命題は PASS**。`θ*=.773804386083461`、Bernstein の四係数、`d=1.5,2,3` 根数、no-x 多項式と `β=1.3` の符号反例を独立に再現。Bertrand・所有比率の既存検証も再実行。局所 IFT の移植例であり任意の需要・公開情報・時間順序・非負制約の下で成り立つ定理にはしない。固定立地、排出ターゲット、完全情報、共同予算なしは外挿境界。 |
| 厚生・制度・実証 | **比較点の実行可能性と数値は PASS**。対称・複占協調ベンチマークの方が特定の分権 SPNE よりモデル厚生は高く、排出も多い。任意の分権／協調選択にわたる順序は対象外。先行の選択非依存主張をこの比較から作らない。GX は政策の併存を示す。実施主体や政策の独立ショックを同定しない。d 感度の均衡への外挿は C02 で要修正。 [Reviewer C](REFEREE_C_ECONOMIC_MECHANISM.md) |
| 既知クラス・新規性 | **要再認証**。政策縮約、HMR の IFT、M&O の逆方向微分／制度比較と付録、Strandholm の単一規制者を比較。一般的な符号反転と複数 R&D の新規性は成立しない。現稿固有の偏微分は直接吸収を確認できず、掲載価値は未達。HMR、Strandholm は合法の著者側全文を入手したが、掲載版本文と証明の完全一致は未確認。 [Reviewer B](REFEREE_B_NOVELTY.md) |
| 論証・紙面・手本 | **REVISE**。冒頭の問い、量化の留保、Figure 1 の比較、一次資料の説明は残せる。経済論証 C01 と継続→大域性 A01 が読者検証の主要な欠落。Stage 10A の三論文を原典の該当箇所・公式付録から再照合。 [独立初見](EDITORIAL_DESK_REVIEW.md) · [Reviewer D](REFEREE_D_EXPOSITION.md) |

### 前のゲートとの照合

- Stage 4R-G の歴史的回帰例を再現。基準の数学的認証に新しい失敗を認定しない。Stage 7.5 の既存凍結で留保した固定立地、局所可搬性、no-x の反例、補助とインフラの比例、比較ベンチマークの限定が現稿に残っている。Lean 記録が認証するのは定式化された一意性・縮約・基準内点四次式等で、全政府大域比較や選択の定理までは含まない。
- **新規性境界の再認証が必要**。旧 Stage 6 の「製品差別化は閾値変数でない」という整理は Proposition 1 に対しては正しいが、§4.3／付録 E の類似性比較を含めると不十分。また HMR の式 (11) が示す閾値は一般論をさらに狭める。Stage 6 では本文だけでなく公式補足を含めた対象行列を作る。これは出典範囲の後退であり、中心定理の直接吸収を確定したとの記録ではない。
- **Contribution completeness regression**。旧 Stage 7.5 が経済的に一般化可能とした部分のうち、単一の相手指数を越える貢献を識別しないまま誌面に移した。既存 `STAGE7P5_REPEAT_POST_REPAIR.md`、理論凍結、形式化記録には有用な証拠がある。再入場時には現行 v3.0 Stage 7.5A 相当の主張別・反例付き範囲を改めて明記し、旧い GO を新しい認証の代わりにしない。

## 出所・再現性

- 最初は `main.tex`、全組込 `sections/*.tex`、`references.bib` のみを通読。初見評価を別コミットに固定し、それから Stage 10A 手本マップ・青写真、Stage 10B 採用ログ・ゲート報告、既存の検証コード・知見を閲覧した。参考 PDF と CI PDF はバイナリが異なるが、ページ区切り付き `pdftotext -layout` の出力は全24ページで一致した。
- [CI #44406847110](https://github.com/ryotamatsuki/strategic-local-green-policy-competition/actions/runs/44406847110) は検証対象先端より前の `f6996432c463482355cef653e9ad77b236132e0d`。二コミットの差は Stage 10B の補助 Markdown 3ファイル。原稿、図表、実行コードの差分なし。成果物 ZIP と `main.pdf` の SHA256、24ページ、1.71451pt の overfull hbox を確認した。ローカル TeX のフォーマット欠落で現地コンパイルは完了していない。PDF の照合と DOI 文献確認は一次資料で補った。CI の成功は掲載判断の証拠に用いていない。
- 独立検算は [independent_review.py](independent_review.py) と [INDEPENDENT_VERIFICATION.txt](INDEPENDENT_VERIFICATION.txt)。検証主体は **AI**（査読・導出・比較）、**COMPUTATION**（独立 Python/SymPy、既存テストの再実行）、**FORMAL**（既存 Lean CI の範囲）。このレポートに **AUTHOR** または **EXTERNAL HUMAN** の検証を帰属させない。
- 適用した v3.0 の原典は `GOVERNANCE.md`、`THEORY_PAPER_RESEARCH_PIPELINE.md`、`templates/STAGE_11_REFEREE_GATE.md`、`templates/EDITORIAL_REFEREE_REPORT.md`、`checklists/REFEREE_ATTACK_CHECKLIST.md`、`checklists/EDITORIAL_ARGUMENT_QUALITY_CHECKLIST.md`、`checklists/EXEMPLARY_PAPER_BENCHMARKING_CHECKLIST.md`、`checklists/REVIEWER_VERIFIABILITY_CHECKLIST.md`。読者検証は FULL を適用し、内点の証明鎖に PASS、全域性の紙面に A01、経済論証に C01/C02 を付けた。 [v3.0](https://github.com/ryotamatsuki/research-paper-workflow/tree/v3.0)

## 再入場の条件

1. Stage 6 を対象限定で再開。HMR の掲載版、M&O §4.3／付録 E、Strandholm の刊行版、近い環境税競争の定理を照合し、相手の単一指数に対して何が独立した貢献として残るかを一件に絞る。既存の `d` と製品代替性による診断を候補とする。主張の単なる言い換えを採択条件にしない。
2. 新しい範囲を主張するなら Stage 4/4A と 7/7.5A でモデル、逸脱、端点、選択と既知定理との差を再検証する。残る経済的貢献が十分なら A01・C01・C02 を改稿し、新規性と文章を再度攻撃する。十分な差が示せなければ現行の ITPF フルペーパー路線を保留する。
3. Stage 12 の実行は再査読の合格後。今回は初見、四査読、台帳、ゲート、検算を Stage 10B 起点の Draft PR に記録する。原稿・モデル・投稿状態や自動同期設定を操作していない。

[全指摘と修正先](ISSUE_REGISTER.md) · [改訂方針と再検証条件](REVISION_PLAN.md)
