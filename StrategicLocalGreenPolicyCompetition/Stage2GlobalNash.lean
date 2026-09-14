import StrategicLocalGreenPolicyCompetition.Stage2RegimeGlobality
import StrategicLocalGreenPolicyCompetition.Stage2Endpoint

noncomputable section

open Set

namespace SLGPC

set_option maxHeartbeats 1000000
local instance (p : Prop) : Decidable p := Classical.propDecidable p

/-- Symmetric active-firm global best response on the B-monopoly branch. -/
theorem model_bMonopoly_fullScalar_best_response
    {kx kg μ θ wA wB u : ℝ}
    (hkx : 0 < kx) (hkg : 0 < kg)
    (hθ : θ ∈ Icc (0 : ℝ) 1)
    (hR : investmentR kx kg μ < (3 / 4 : ℝ))
    (hwB : 0 < wB)
    (hBM : bMonopolyRegion (investmentR kx kg μ) θ wA wB)
    (hu : 0 ≤ u) :
    let z := bMonopolyContinuation (investmentR kx kg μ) wB
    fullScalarContinuationProfit (investmentR kx kg μ) θ wB wA u ≤
      fullScalarContinuationProfit (investmentR kx kg μ) θ wB wA z.uB := by
  dsimp
  let R := investmentR kx kg μ
  let z := bMonopolyContinuation R wB
  have hRpos : 0 < R := by dsimp [R]; exact investmentR_pos hkx hkg
  have hMpos : 0 < monopolyM R := by dsimp [R]; exact monopolyM_pos hθ hR
  have hDpos : 0 < cournotD θ := cournotD_pos hθ
  rcases bMonopoly_admissible hRpos hMpos hwB hBM with
    ⟨_hqA, hq, _huA, _huB, hinactive⟩
  have hstage := bMonopoly_stage3_identity (R := R) (wB := wB) hMpos.ne'
  have hmEq : monopolyOwnQuantity wB z.uB = z.qB := by
    unfold monopolyOwnQuantity
    linarith
  have hθin : θ * wA ≤ θ ^ 2 * z.qB := by
    have hm := mul_le_mul_of_nonneg_left hinactive hθ.1
    nlinarith
  have hduo : z.qB ≤ duopolyOwnQuantity θ wB wA z.uB := by
    unfold duopolyOwnQuantity
    apply (le_div_iff₀ hDpos).2
    unfold cournotD
    nlinarith [hstage, hθin]
  have heq :
      fullScalarContinuationProfit R θ wB wA z.uB =
        monopolyScalarProfit R wB z.uB := by
    apply fullScalarContinuationProfit_eq_monopoly
    · rw [hmEq]
      exact hq.le
    · rw [hmEq]
      exact hduo
  have hfoc := model_bMonopoly_scalar_foc
    (kx := kx) (kg := kg) (μ := μ) (θ := θ) (_wA := wA) (wB := wB)
    hkx hkg hθ hR
  calc
    fullScalarContinuationProfit R θ wB wA u ≤ monopolyScalarProfit R wB u :=
      fullScalarContinuationProfit_le_monopolyScalarProfit hwB hu
    _ ≤ monopolyScalarProfit R wB z.uB :=
      monopoly_branch_max_of_foc hkx hkg hR hfoc
    _ = fullScalarContinuationProfit R θ wB wA z.uB := heq.symm

/-- Symmetric active-firm global best response on the B-kink branch. -/
theorem model_bKink_fullScalar_best_response
    {kx kg μ θ wA wB u : ℝ}
    (hkx : 0 < kx) (hkg : 0 < kg)
    (hθ : θ ∈ Icc (0 : ℝ) 1) (hθpos : 0 < θ)
    (hR : investmentR kx kg μ < (3 / 4 : ℝ))
    (hwA : 0 < wA) (hwB : 0 < wB)
    (hBK : bKinkRegion (investmentR kx kg μ) (reducedL kx kg μ θ) θ wA wB)
    (hu : 0 ≤ u) :
    let z := bKinkContinuation θ wA wB
    fullScalarContinuationProfit (investmentR kx kg μ) θ wB wA u ≤
      fullScalarContinuationProfit (investmentR kx kg μ) θ wB wA z.uB := by
  dsimp
  let R := investmentR kx kg μ
  let z := bKinkContinuation θ wA wB
  have hRpos : 0 < R := by dsimp [R]; exact investmentR_pos hkx hkg
  rcases bKink_admissible hRpos hθpos hwA hBK with
    ⟨_hqA, hq, _huA, huZ, hkink⟩
  have hstage := bKink_stage3_identity (θ := θ) (wA := wA) (wB := wB)
  have hmEq : monopolyOwnQuantity wB z.uB = z.qB := by
    unfold monopolyOwnQuantity
    linarith
  have hduoEq : duopolyOwnQuantity θ wB wA z.uB = z.qB := by
    have hDpos : 0 < cournotD θ := cournotD_pos hθ
    unfold duopolyOwnQuantity
    apply (div_eq_iff hDpos.ne').2
    unfold cournotD
    nlinarith [hstage, hkink]
  have heqD :
      fullScalarContinuationProfit R θ wB wA z.uB =
        duopolyScalarProfit R θ wB wA z.uB := by
    apply fullScalarContinuationProfit_eq_duopoly
    · rw [hduoEq]
      exact hq.le
    · rw [hduoEq, hmEq]
  have heqM :
      fullScalarContinuationProfit R θ wB wA z.uB =
        monopolyScalarProfit R wB z.uB := by
    apply fullScalarContinuationProfit_eq_monopoly
    · rw [hmEq]
      exact hq.le
    · rw [hmEq, hduoEq]
  by_cases hleft : u ≤ z.uB
  · calc
      fullScalarContinuationProfit R θ wB wA u ≤
          duopolyScalarProfit R θ wB wA u :=
        fullScalarContinuationProfit_le_duopolyScalarProfit hwB hu
      _ ≤ duopolyScalarProfit R θ wB wA z.uB :=
        model_bKink_left_branch_max hkx hkg hθ hθpos hR hBK hleft
      _ = fullScalarContinuationProfit R θ wB wA z.uB := heqD.symm
  · have hright : z.uB ≤ u := le_of_not_ge hleft
    calc
      fullScalarContinuationProfit R θ wB wA u ≤ monopolyScalarProfit R wB u :=
        fullScalarContinuationProfit_le_monopolyScalarProfit hwB hu
      _ ≤ monopolyScalarProfit R wB z.uB :=
        model_bKink_right_branch_max hkx hkg hθ hθpos hR hBK hright
      _ = fullScalarContinuationProfit R θ wB wA z.uB := heqM.symm

/-- Full scalar Nash certificate on the A-monopoly branch. -/
theorem model_aMonopoly_fullScalar_nash
    {kx kg μ θ wA wB uA uB : ℝ}
    (hkx : 0 < kx) (hkg : 0 < kg)
    (hθ : θ ∈ Icc (0 : ℝ) 1)
    (hR : investmentR kx kg μ < (3 / 4 : ℝ))
    (hwA : 0 < wA) (hwB : 0 < wB)
    (hAM : aMonopolyRegion (investmentR kx kg μ) θ wA wB)
    (huA : 0 ≤ uA) (huB : 0 ≤ uB) :
    let z := aMonopolyContinuation (investmentR kx kg μ) wA
    fullScalarContinuationProfit (investmentR kx kg μ) θ wA (wB + z.uB) uA ≤
      fullScalarContinuationProfit (investmentR kx kg μ) θ wA (wB + z.uB) z.uA ∧
    fullScalarContinuationProfit (investmentR kx kg μ) θ wB (wA + z.uA) uB ≤
      fullScalarContinuationProfit (investmentR kx kg μ) θ wB (wA + z.uA) z.uB := by
  dsimp
  let R := investmentR kx kg μ
  let z := aMonopolyContinuation R wA
  have hRpos : 0 < R := by dsimp [R]; exact investmentR_pos hkx hkg
  have hMpos : 0 < monopolyM R := by dsimp [R]; exact monopolyM_pos hθ hR
  rcases aMonopoly_admissible hRpos hMpos hwA hAM with
    ⟨hq, _hqB, _huAz, _huBz, hinactive⟩
  have hstage := aMonopoly_stage3_identity (R := R) (wA := wA) hMpos.ne'
  have hInactiveB : 2 * wB ≤ θ * (wA + z.uA) := by
    nlinarith [hinactive, hstage]
  constructor
  · simpa [z, R, aMonopolyContinuation] using
      model_aMonopoly_fullScalar_best_response
        (kx := kx) (kg := kg) (μ := μ) (θ := θ) (wA := wA) (wB := wB) (u := uA)
        hkx hkg hθ hR hwA hAM huA
  · have hb := fullScalar_zero_best_response_of_inactive
      (kx := kx) (kg := kg) (μ := μ) (θ := θ)
      (wi := wB) (vj := wA + z.uA) (u := uB)
      hkx hkg hθ hR hwB hInactiveB huB
    simpa [z, R, aMonopolyContinuation] using hb

/-- Full scalar Nash certificate on the A-kink branch. -/
theorem model_aKink_fullScalar_nash
    {kx kg μ θ wA wB uA uB : ℝ}
    (hkx : 0 < kx) (hkg : 0 < kg)
    (hθ : θ ∈ Icc (0 : ℝ) 1) (hθpos : 0 < θ)
    (hR : investmentR kx kg μ < (3 / 4 : ℝ))
    (hwA : 0 < wA) (hwB : 0 < wB)
    (hAK : aKinkRegion (investmentR kx kg μ) (reducedL kx kg μ θ) θ wA wB)
    (huA : 0 ≤ uA) (huB : 0 ≤ uB) :
    let z := aKinkContinuation θ wA wB
    fullScalarContinuationProfit (investmentR kx kg μ) θ wA (wB + z.uB) uA ≤
      fullScalarContinuationProfit (investmentR kx kg μ) θ wA (wB + z.uB) z.uA ∧
    fullScalarContinuationProfit (investmentR kx kg μ) θ wB (wA + z.uA) uB ≤
      fullScalarContinuationProfit (investmentR kx kg μ) θ wB (wA + z.uA) z.uB := by
  dsimp
  let R := investmentR kx kg μ
  let z := aKinkContinuation θ wA wB
  have hRpos : 0 < R := by dsimp [R]; exact investmentR_pos hkx hkg
  rcases aKink_admissible hRpos hθpos hwB hAK with
    ⟨hq, _hqB, _huAz, _huBz, hkink⟩
  have hstage := aKink_stage3_identity (θ := θ) (wA := wA) (wB := wB)
  have hInactiveB : 2 * wB ≤ θ * (wA + z.uA) := by
    nlinarith [hkink, hstage]
  constructor
  · simpa [z, R, aKinkContinuation] using
      model_aKink_fullScalar_best_response
        (kx := kx) (kg := kg) (μ := μ) (θ := θ) (wA := wA) (wB := wB) (u := uA)
        hkx hkg hθ hθpos hR hwA hwB hAK huA
  · have hb := fullScalar_zero_best_response_of_inactive
      (kx := kx) (kg := kg) (μ := μ) (θ := θ)
      (wi := wB) (vj := wA + z.uA) (u := uB)
      hkx hkg hθ hR hwB hInactiveB huB
    simpa [z, R, aKinkContinuation] using hb

/-- Full scalar Nash certificate on the B-kink branch. -/
theorem model_bKink_fullScalar_nash
    {kx kg μ θ wA wB uA uB : ℝ}
    (hkx : 0 < kx) (hkg : 0 < kg)
    (hθ : θ ∈ Icc (0 : ℝ) 1) (hθpos : 0 < θ)
    (hR : investmentR kx kg μ < (3 / 4 : ℝ))
    (hwA : 0 < wA) (hwB : 0 < wB)
    (hBK : bKinkRegion (investmentR kx kg μ) (reducedL kx kg μ θ) θ wA wB)
    (huA : 0 ≤ uA) (huB : 0 ≤ uB) :
    let z := bKinkContinuation θ wA wB
    fullScalarContinuationProfit (investmentR kx kg μ) θ wA (wB + z.uB) uA ≤
      fullScalarContinuationProfit (investmentR kx kg μ) θ wA (wB + z.uB) z.uA ∧
    fullScalarContinuationProfit (investmentR kx kg μ) θ wB (wA + z.uA) uB ≤
      fullScalarContinuationProfit (investmentR kx kg μ) θ wB (wA + z.uA) z.uB := by
  dsimp
  let R := investmentR kx kg μ
  let z := bKinkContinuation θ wA wB
  have hRpos : 0 < R := by dsimp [R]; exact investmentR_pos hkx hkg
  rcases bKink_admissible hRpos hθpos hwA hBK with
    ⟨_hqA, hq, _huA, _huB, hkink⟩
  have hstage := bKink_stage3_identity (θ := θ) (wA := wA) (wB := wB)
  have hInactiveA : 2 * wA ≤ θ * (wB + z.uB) := by
    nlinarith [hkink, hstage]
  constructor
  · have ha := fullScalar_zero_best_response_of_inactive
      (kx := kx) (kg := kg) (μ := μ) (θ := θ)
      (wi := wA) (vj := wB + z.uB) (u := uA)
      hkx hkg hθ hR hwA hInactiveA huA
    simpa [z, R, bKinkContinuation] using ha
  · simpa [z, R, bKinkContinuation] using
      model_bKink_fullScalar_best_response
        (kx := kx) (kg := kg) (μ := μ) (θ := θ) (wA := wA) (wB := wB) (u := uB)
        hkx hkg hθ hθpos hR hwA hwB hBK huB

/-- Full scalar Nash certificate on the B-monopoly branch. -/
theorem model_bMonopoly_fullScalar_nash
    {kx kg μ θ wA wB uA uB : ℝ}
    (hkx : 0 < kx) (hkg : 0 < kg)
    (hθ : θ ∈ Icc (0 : ℝ) 1)
    (hR : investmentR kx kg μ < (3 / 4 : ℝ))
    (hwA : 0 < wA) (hwB : 0 < wB)
    (hBM : bMonopolyRegion (investmentR kx kg μ) θ wA wB)
    (huA : 0 ≤ uA) (huB : 0 ≤ uB) :
    let z := bMonopolyContinuation (investmentR kx kg μ) wB
    fullScalarContinuationProfit (investmentR kx kg μ) θ wA (wB + z.uB) uA ≤
      fullScalarContinuationProfit (investmentR kx kg μ) θ wA (wB + z.uB) z.uA ∧
    fullScalarContinuationProfit (investmentR kx kg μ) θ wB (wA + z.uA) uB ≤
      fullScalarContinuationProfit (investmentR kx kg μ) θ wB (wA + z.uA) z.uB := by
  dsimp
  let R := investmentR kx kg μ
  let z := bMonopolyContinuation R wB
  have hRpos : 0 < R := by dsimp [R]; exact investmentR_pos hkx hkg
  have hMpos : 0 < monopolyM R := by dsimp [R]; exact monopolyM_pos hθ hR
  rcases bMonopoly_admissible hRpos hMpos hwB hBM with
    ⟨_hqA, hq, _huA, _huB, hinactive⟩
  have hstage := bMonopoly_stage3_identity (R := R) (wB := wB) hMpos.ne'
  have hInactiveA : 2 * wA ≤ θ * (wB + z.uB) := by
    nlinarith [hinactive, hstage]
  constructor
  · have ha := fullScalar_zero_best_response_of_inactive
      (kx := kx) (kg := kg) (μ := μ) (θ := θ)
      (wi := wA) (vj := wB + z.uB) (u := uA)
      hkx hkg hθ hR hwA hInactiveA huA
    simpa [z, R, bMonopolyContinuation] using ha
  · simpa [z, R, bMonopolyContinuation] using
      model_bMonopoly_fullScalar_best_response
        (kx := kx) (kg := kg) (μ := μ) (θ := θ) (wA := wA) (wB := wB) (u := uB)
        hkx hkg hθ hR hwB hBM huB

/-- Tie-broken five-regime Stage-2 continuation. -/
def modelStage2Continuation (kx kg μ θ wA wB : ℝ) : Stage2Continuation :=
  if aMonopolyRegion (investmentR kx kg μ) θ wA wB then
    aMonopolyContinuation (investmentR kx kg μ) wA
  else if aKinkRegion (investmentR kx kg μ) (reducedL kx kg μ θ) θ wA wB then
    aKinkContinuation θ wA wB
  else if duopolyRegion (reducedL kx kg μ θ) θ wA wB then
    duopolyContinuation (reducedL kx kg μ θ) θ wA wB
  else if bKinkRegion (investmentR kx kg μ) (reducedL kx kg μ θ) θ wA wB then
    bKinkContinuation θ wA wB
  else
    bMonopolyContinuation (investmentR kx kg μ) wB

/-- Across the complete five-regime partition, the selected scalar continuation is
 a global Nash equilibrium of Stage 2 against every nonnegative scalar investment
 deviation.  This includes `theta=0`, where the endpoint certificate forces the
 duopoly branch. -/
theorem modelStage2Continuation_fullScalar_global_nash
    {kx kg μ θ wA wB uA uB : ℝ}
    (hkx : 0 < kx) (hkg : 0 < kg)
    (hθ : θ ∈ Icc (0 : ℝ) 1)
    (hR : investmentR kx kg μ < (3 / 4 : ℝ))
    (hwA : 0 < wA) (hwB : 0 < wB)
    (huA : 0 ≤ uA) (huB : 0 ≤ uB) :
    let z := modelStage2Continuation kx kg μ θ wA wB
    fullScalarContinuationProfit (investmentR kx kg μ) θ wA (wB + z.uB) uA ≤
      fullScalarContinuationProfit (investmentR kx kg μ) θ wA (wB + z.uB) z.uA ∧
    fullScalarContinuationProfit (investmentR kx kg μ) θ wB (wA + z.uA) uB ≤
      fullScalarContinuationProfit (investmentR kx kg μ) θ wB (wA + z.uA) z.uB := by
  by_cases hzero : θ = 0
  · subst θ
    have hD := stage2_theta_zero_duopoly_region hR hwA hwB
    have hNo := stage2_theta_zero_no_exclusion hR hwA hwB
    simp [modelStage2Continuation, hNo.1, hNo.2.1, hD]
    exact model_duopoly_fullScalar_best_responses hkx hkg (by constructor <;> norm_num)
      hR hwA hwB hD huA huB
  · have hθpos : 0 < θ := lt_of_le_of_ne hθ.1 (Ne.symm hzero)
    by_cases hAM : aMonopolyRegion (investmentR kx kg μ) θ wA wB
    · simp [modelStage2Continuation, hAM]
      exact model_aMonopoly_fullScalar_nash hkx hkg hθ hR hwA hwB hAM huA huB
    · by_cases hAK : aKinkRegion (investmentR kx kg μ) (reducedL kx kg μ θ) θ wA wB
      · simp [modelStage2Continuation, hAM, hAK]
        exact model_aKink_fullScalar_nash hkx hkg hθ hθpos hR hwA hwB hAK huA huB
      · by_cases hD : duopolyRegion (reducedL kx kg μ θ) θ wA wB
        · simp [modelStage2Continuation, hAM, hAK, hD]
          exact model_duopoly_fullScalar_best_responses hkx hkg hθ hR hwA hwB hD huA huB
        · by_cases hBK : bKinkRegion (investmentR kx kg μ) (reducedL kx kg μ θ) θ wA wB
          · simp [modelStage2Continuation, hAM, hAK, hD, hBK]
            exact model_bKink_fullScalar_nash hkx hkg hθ hθpos hR hwA hwB hBK huA huB
          · have hex := model_stage2_region_exists
              (kx := kx) (kg := kg) (μ := μ) (θ := θ) (wA := wA) (wB := wB)
            rcases hex with hAM' | hAK' | hD' | hBK' | hBM
            · exact False.elim (hAM hAM')
            · exact False.elim (hAK hAK')
            · exact False.elim (hD hD')
            · exact False.elim (hBK hBK')
            · simp [modelStage2Continuation, hAM, hAK, hD, hBK]
              exact model_bMonopoly_fullScalar_nash hkx hkg hθ hR hwA hwB hBM huA huB

end SLGPC
