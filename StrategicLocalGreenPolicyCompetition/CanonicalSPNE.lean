import StrategicLocalGreenPolicyCompetition.Stage2PrimitiveGlobalNash
import StrategicLocalGreenPolicyCompetition.Stage3GlobalNash
import StrategicLocalGreenPolicyCompetition.GovernmentGlobalGame

noncomputable section

open Set

namespace SLGPC

/-- Full Stage-2 firm payoff after the Stage-3 nonnegative Cournot continuation,
written in the manuscript's original net-investment-cost normalization. -/
def fullPrimitiveContinuationProfit
    (kx kg μ s θ wi vj x g : ℝ) : ℝ :=
  fullCournotOwnOperatingProfit θ (wi + scalarU kg μ s x g) vj -
    netInvestmentCost kx kg s x g

/-- The centered Stage-2 payoff used by the scalar bridge differs from the original
net-investment-cost payoff only by the policy-only completed-square constant. -/
theorem fullPrimitiveContinuationProfit_eq_centered
    {kx kg μ s θ wi vj x g : ℝ} (hkg : kg ≠ 0) :
    fullPrimitiveContinuationProfit kx kg μ s θ wi vj x g =
      primitiveCenteredContinuationProfit kx kg μ s θ wi vj x g +
        s ^ 2 / (2 * kg) := by
  unfold fullPrimitiveContinuationProfit primitiveCenteredContinuationProfit
  rw [netInvestmentCost_complete_square hkg]
  ring

/-- The tie-broken five-regime continuation always prescribes nonnegative scalar
private cost reductions under the maintained model restrictions. -/
theorem modelStage2Continuation_u_nonneg
    {kx kg μ θ wA wB : ℝ}
    (hkx : 0 < kx) (hkg : 0 < kg)
    (hθ : θ ∈ Icc (0 : ℝ) 1)
    (hR : investmentR kx kg μ < (3 / 4 : ℝ))
    (hwA : 0 < wA) (hwB : 0 < wB) :
    let z := modelStage2Continuation kx kg μ θ wA wB
    0 ≤ z.uA ∧ 0 ≤ z.uB := by
  dsimp
  have hRpos : 0 < investmentR kx kg μ := investmentR_pos hkx hkg
  have hMpos : 0 < monopolyM (investmentR kx kg μ) := monopolyM_pos hθ hR
  by_cases hzero : θ = 0
  · subst θ
    have hD := stage2_theta_zero_duopoly_region hR hwA hwB
    have hNo := stage2_theta_zero_no_exclusion hR hwA hwB
    have hadm := duopoly_admissible
      (reducedDet_pos (by constructor <;> norm_num) hR)
      (reducedL_lt_two hkx hkg (by constructor <;> norm_num)) hD
    simp [modelStage2Continuation, hNo.1, hNo.2.1, hD]
    exact ⟨hadm.2.2.1.le, hadm.2.2.2.le⟩
  · have hθpos : 0 < θ := lt_of_le_of_ne hθ.1 (Ne.symm hzero)
    by_cases hAM : aMonopolyRegion (investmentR kx kg μ) θ wA wB
    · have hadm := aMonopoly_admissible hRpos hMpos hwA hAM
      simp [modelStage2Continuation, hAM]
      exact ⟨hadm.2.2.1.le, by rw [hadm.2.2.2.1]⟩
    · by_cases hAK :
        aKinkRegion (investmentR kx kg μ) (reducedL kx kg μ θ) θ wA wB
      · have hadm := aKink_admissible hRpos hθpos hwB hAK
        simp [modelStage2Continuation, hAM, hAK]
        exact ⟨hadm.2.2.1.le, by rw [hadm.2.2.2.1]⟩
      · by_cases hD : duopolyRegion (reducedL kx kg μ θ) θ wA wB
        · have hadm := duopoly_admissible
            (reducedDet_pos hθ hR) (reducedL_lt_two hkx hkg hθ) hD
          simp [modelStage2Continuation, hAM, hAK, hD]
          exact ⟨hadm.2.2.1.le, hadm.2.2.2.le⟩
        · by_cases hBK :
            bKinkRegion (investmentR kx kg μ) (reducedL kx kg μ θ) θ wA wB
          · have hadm := bKink_admissible hRpos hθpos hwA hBK
            simp [modelStage2Continuation, hAM, hAK, hD, hBK]
            exact ⟨by rw [hadm.2.2.1], hadm.2.2.2.1.le⟩
          · have hex := model_stage2_region_exists
              (kx := kx) (kg := kg) (μ := μ) (θ := θ) (wA := wA) (wB := wB)
            rcases hex with hAM' | hAK' | hD' | hBK' | hBM
            · exact False.elim (hAM hAM')
            · exact False.elim (hAK hAK')
            · exact False.elim (hD hD')
            · exact False.elim (hBK hBK')
            · have hadm := bMonopoly_admissible hRpos hMpos hwB hBM
              simp [modelStage2Continuation, hAM, hAK, hD, hBK]
              exact ⟨by rw [hadm.2.2.1], hadm.2.2.2.1.le⟩

/-- The five-regime Stage-2 strategy is feasible in the manuscript's original
nonnegative `(x,g)` action set whenever subsidies are nonnegative. -/
theorem modelStage2Continuation_primitive_feasible
    {kx kg μ θ wA wB sA sB : ℝ}
    (hkx : 0 < kx) (hkg : 0 < kg) (hμ : 0 ≤ μ)
    (hθ : θ ∈ Icc (0 : ℝ) 1)
    (hR : investmentR kx kg μ < (3 / 4 : ℝ))
    (hwA : 0 < wA) (hwB : 0 < wB)
    (hsA : 0 ≤ sA) (hsB : 0 ≤ sB) :
    let z := modelStage2Continuation kx kg μ θ wA wB
    0 ≤ scalarX kx (investmentR kx kg μ) z.uA ∧
    0 ≤ scalarGreen kg μ (investmentR kx kg μ) sA z.uA ∧
    0 ≤ scalarX kx (investmentR kx kg μ) z.uB ∧
    0 ≤ scalarGreen kg μ (investmentR kx kg μ) sB z.uB := by
  dsimp
  let z := modelStage2Continuation kx kg μ θ wA wB
  have hu := modelStage2Continuation_u_nonneg hkx hkg hθ hR hwA hwB
  have hA := scalar_composition_nonnegative
    (kx := kx) (kg := kg) (μ := μ) (s := sA) (u := z.uA)
    hkx hkg hμ hsA hu.1
  have hB := scalar_composition_nonnegative
    (kx := kx) (kg := kg) (μ := μ) (s := sB) (u := z.uB)
    hkx hkg hμ hsB hu.2
  exact ⟨hA.1, hA.2, hB.1, hB.2⟩

/-- The primitive Stage-2 continuation is globally Nash in the original payoff
normalization, not merely in the centered scalar objective. -/
theorem modelStage2Continuation_fullPrimitive_global_nash
    {kx kg μ θ wA wB sA sB xA gA xB gB : ℝ}
    (hkx : 0 < kx) (hkg : 0 < kg)
    (hθ : θ ∈ Icc (0 : ℝ) 1)
    (hR : investmentR kx kg μ < (3 / 4 : ℝ))
    (hwA : 0 < wA) (hwB : 0 < wB)
    (hxA : 0 ≤ xA) (hgA : 0 ≤ gA)
    (hxB : 0 ≤ xB) (hgB : 0 ≤ gB) :
    let z := modelStage2Continuation kx kg μ θ wA wB
    fullPrimitiveContinuationProfit kx kg μ sA θ wA (wB + z.uB) xA gA ≤
      fullPrimitiveContinuationProfit kx kg μ sA θ wA (wB + z.uB)
        (scalarX kx (investmentR kx kg μ) z.uA)
        (scalarGreen kg μ (investmentR kx kg μ) sA z.uA) ∧
    fullPrimitiveContinuationProfit kx kg μ sB θ wB (wA + z.uA) xB gB ≤
      fullPrimitiveContinuationProfit kx kg μ sB θ wB (wA + z.uA)
        (scalarX kx (investmentR kx kg μ) z.uB)
        (scalarGreen kg μ (investmentR kx kg μ) sB z.uB) := by
  dsimp
  let z := modelStage2Continuation kx kg μ θ wA wB
  have hc := modelStage2Continuation_primitive_global_nash
    (kx := kx) (kg := kg) (μ := μ) (θ := θ) (wA := wA) (wB := wB)
    (sA := sA) (sB := sB) (xA := xA) (gA := gA) (xB := xB) (gB := gB)
    hkx hkg hθ hR hwA hwB hxA hgA hxB hgB
  have hdevA := fullPrimitiveContinuationProfit_eq_centered
    (kx := kx) (kg := kg) (μ := μ) (s := sA) (θ := θ)
    (wi := wA) (vj := wB + z.uB) (x := xA) (g := gA) hkg.ne'
  have hcanA := fullPrimitiveContinuationProfit_eq_centered
    (kx := kx) (kg := kg) (μ := μ) (s := sA) (θ := θ)
    (wi := wA) (vj := wB + z.uB)
    (x := scalarX kx (investmentR kx kg μ) z.uA)
    (g := scalarGreen kg μ (investmentR kx kg μ) sA z.uA) hkg.ne'
  have hdevB := fullPrimitiveContinuationProfit_eq_centered
    (kx := kx) (kg := kg) (μ := μ) (s := sB) (θ := θ)
    (wi := wB) (vj := wA + z.uA) (x := xB) (g := gB) hkg.ne'
  have hcanB := fullPrimitiveContinuationProfit_eq_centered
    (kx := kx) (kg := kg) (μ := μ) (s := sB) (θ := θ)
    (wi := wB) (vj := wA + z.uA)
    (x := scalarX kx (investmentR kx kg μ) z.uB)
    (g := scalarGreen kg μ (investmentR kx kg μ) sB z.uB) hkg.ne'
  constructor
  · rw [hdevA, hcanA]
    have hcA := hc.1
    dsimp [z] at hcA ⊢
    linarith
  · rw [hdevB, hcanB]
    have hcB := hc.2
    dsimp [z] at hcB ⊢
    linarith

/-- Canonical post-investment Stage-3 intercept.  The subsidy shift cancels between
`w` and centered private cost reduction, exactly as in the primitive model. -/
def canonicalPostInvestmentIntercept (s h x g : ℝ) : ℝ :=
  canonicalOwnW s h + scalarU 18 (9 / 10 : ℝ) s x g

lemma canonicalPostInvestmentIntercept_pos
    {s h x g : ℝ} (_hs : 0 ≤ s) (hh : 0 ≤ h) (hx : 0 ≤ x) (hg : 0 ≤ g) :
    0 < canonicalPostInvestmentIntercept s h x g := by
  unfold canonicalPostInvestmentIntercept canonicalOwnW reducedW policyY
    scalarU centeredGreen
  norm_num
  nlinarith

/-- Stage-1 global Nash condition at the canonical symmetric policy profile. -/
def CanonicalStage1GlobalNash (θ : ℝ) : Prop :=
  0 ≤ canonicalSymmetricS θ ∧ 0 ≤ canonicalSymmetricH θ ∧
  (∀ sA hA : ℝ, 0 ≤ sA → 0 ≤ hA →
    canonicalGovernmentDeviationWelfare θ sA hA ≤
      canonicalActiveGovernmentWelfare θ (canonicalSymmetricProfile θ)) ∧
  (∀ sB hB : ℝ, 0 ≤ sB → 0 ≤ hB →
    canonicalBGovernmentDeviationWelfare θ sB hB ≤
      canonicalActiveGovernmentWelfare θ (canonicalSymmetricProfile θ))

/-- Every Stage-2 subgame reached after an admissible nonnegative policy history
uses feasible primitive investments and is globally Nash against all nonnegative
primitive investment deviations. -/
def CanonicalStage2SubgamePerfect (θ : ℝ) : Prop :=
  ∀ sA hA sB hB : ℝ,
    0 ≤ sA → 0 ≤ hA → 0 ≤ sB → 0 ≤ hB →
    let wA := canonicalOwnW sA hA
    let wB := canonicalOwnW sB hB
    let z := modelStage2Continuation 4 18 (9 / 10 : ℝ) θ wA wB
    (0 ≤ scalarX 4 (investmentR 4 18 (9 / 10 : ℝ)) z.uA ∧
     0 ≤ scalarGreen 18 (9 / 10 : ℝ) (investmentR 4 18 (9 / 10 : ℝ)) sA z.uA ∧
     0 ≤ scalarX 4 (investmentR 4 18 (9 / 10 : ℝ)) z.uB ∧
     0 ≤ scalarGreen 18 (9 / 10 : ℝ) (investmentR 4 18 (9 / 10 : ℝ)) sB z.uB) ∧
    (∀ xA gA xB gB : ℝ,
      0 ≤ xA → 0 ≤ gA → 0 ≤ xB → 0 ≤ gB →
      fullPrimitiveContinuationProfit 4 18 (9 / 10 : ℝ) sA θ wA (wB + z.uB) xA gA ≤
        fullPrimitiveContinuationProfit 4 18 (9 / 10 : ℝ) sA θ wA (wB + z.uB)
          (scalarX 4 (investmentR 4 18 (9 / 10 : ℝ)) z.uA)
          (scalarGreen 18 (9 / 10 : ℝ) (investmentR 4 18 (9 / 10 : ℝ)) sA z.uA) ∧
      fullPrimitiveContinuationProfit 4 18 (9 / 10 : ℝ) sB θ wB (wA + z.uA) xB gB ≤
        fullPrimitiveContinuationProfit 4 18 (9 / 10 : ℝ) sB θ wB (wA + z.uA)
          (scalarX 4 (investmentR 4 18 (9 / 10 : ℝ)) z.uB)
          (scalarGreen 18 (9 / 10 : ℝ) (investmentR 4 18 (9 / 10 : ℝ)) sB z.uB))

/-- Every Stage-3 subgame after admissible policies and investments uses the full
nonnegative Cournot continuation and is globally Nash against all nonnegative
quantity deviations. -/
def CanonicalStage3SubgamePerfect (θ : ℝ) : Prop :=
  ∀ sA hA sB hB xA gA xB gB : ℝ,
    0 ≤ sA → 0 ≤ hA → 0 ≤ sB → 0 ≤ hB →
    0 ≤ xA → 0 ≤ gA → 0 ≤ xB → 0 ≤ gB →
    ∀ qA qB : ℝ, 0 ≤ qA → 0 ≤ qB →
    let vA := canonicalPostInvestmentIntercept sA hA xA gA
    let vB := canonicalPostInvestmentIntercept sB hB xB gB
    let zA := fullCournotOwnQuantity θ vA vB
    let zB := fullCournotOwnQuantity θ vB vA
    stage3OwnProfit vA θ zB qA ≤ stage3OwnProfit vA θ zB zA ∧
    stage3OwnProfit vB θ zA qB ≤ stage3OwnProfit vB θ zA zB

/-- Statement-faithful three-stage global-SPNE certificate: Stage 1 is globally
Nash on the full nonnegative policy domain, and the prescribed continuation is a
global Nash equilibrium in every admissible Stage-2 and Stage-3 subgame. -/
def CanonicalGlobalSPNE (θ : ℝ) : Prop :=
  CanonicalStage1GlobalNash θ ∧
  CanonicalStage2SubgamePerfect θ ∧
  CanonicalStage3SubgamePerfect θ

/-- Main formal-verification theorem for the canonical manuscript game. -/
theorem canonical_global_spne
    {θ : ℝ} (hθ : θ ∈ Icc (0 : ℝ) 1) : CanonicalGlobalSPNE θ := by
  have hR : investmentR 4 18 (9 / 10 : ℝ) < (3 / 4 : ℝ) := by
    rw [canonicalInvestmentR]
    norm_num
  constructor
  · unfold CanonicalStage1GlobalNash
    have hp := canonicalSymmetricPolicies_pos hθ
    have hn := canonicalSymmetricProfile_global_nash hθ
    exact ⟨hp.1.le, hp.2.le, hn.1, hn.2⟩
  · constructor
    · unfold CanonicalStage2SubgamePerfect
      intro sA hA sB hB hsA hhA hsB hhB
      dsimp
      have hwA := canonicalOwnW_pos hsA hhA
      have hwB := canonicalOwnW_pos hsB hhB
      have hfeas := modelStage2Continuation_primitive_feasible
        (kx := (4 : ℝ)) (kg := (18 : ℝ)) (μ := (9 / 10 : ℝ))
        (θ := θ) (wA := canonicalOwnW sA hA) (wB := canonicalOwnW sB hB)
        (sA := sA) (sB := sB)
        (by norm_num) (by norm_num) (by norm_num) hθ hR hwA hwB hsA hsB
      refine ⟨hfeas, ?_⟩
      intro xA gA xB gB hxA hgA hxB hgB
      exact modelStage2Continuation_fullPrimitive_global_nash
        (kx := (4 : ℝ)) (kg := (18 : ℝ)) (μ := (9 / 10 : ℝ))
        (θ := θ) (wA := canonicalOwnW sA hA) (wB := canonicalOwnW sB hB)
        (sA := sA) (sB := sB) (xA := xA) (gA := gA) (xB := xB) (gB := gB)
        (by norm_num) (by norm_num) hθ hR hwA hwB hxA hgA hxB hgB
    · unfold CanonicalStage3SubgamePerfect
      intro sA hA sB hB xA gA xB gB hsA hhA hsB hhB hxA hgA hxB hgB
      intro qA qB hqA hqB
      dsimp
      have hvA := canonicalPostInvestmentIntercept_pos hsA hhA hxA hgA
      have hvB := canonicalPostInvestmentIntercept_pos hsB hhB hxB hgB
      exact fullCournot_quantities_global_nash hθ hvA hvB hqA hqB

end SLGPC
