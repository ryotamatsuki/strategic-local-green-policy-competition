import StrategicLocalGreenPolicyCompetition.Stage2GlobalContinuation

noncomputable section

open Set

namespace SLGPC

/-- If the rival's fixed post-investment intercept makes the firm inactive at
`u=0`, then under the maintained investment-curvature condition no nonnegative
scalar investment deviation can profitably activate it. -/
theorem fullScalar_zero_best_response_of_inactive
    {kx kg μ θ wi vj u : ℝ}
    (hkx : 0 < kx) (hkg : 0 < kg)
    (hθ : θ ∈ Icc (0 : ℝ) 1)
    (hR : investmentR kx kg μ < (3 / 4 : ℝ))
    (hw : 0 < wi) (hinactive : 2 * wi ≤ θ * vj) (hu : 0 ≤ u) :
    fullScalarContinuationProfit (investmentR kx kg μ) θ wi vj u ≤
      fullScalarContinuationProfit (investmentR kx kg μ) θ wi vj 0 := by
  let R := investmentR kx kg μ
  have hRpos : 0 < R := by dsimp [R]; exact investmentR_pos hkx hkg
  have hDpos : 0 < cournotD θ := cournotD_pos hθ
  have hq0 : duopolyOwnQuantity θ wi vj 0 ≤ 0 := by
    unfold duopolyOwnQuantity
    exact div_nonpos_of_nonpos_of_nonneg (by linarith) hDpos.le
  have heq0 := fullScalarContinuationProfit_eq_inactive
    (R := R) (θ := θ) (wi := wi) (vj := vj) (u := 0) hq0
  have hzero : fullScalarContinuationProfit R θ wi vj 0 = 0 := by
    rw [heq0]
    norm_num [inactiveScalarProfit]
  by_cases hact : 2 * (wi + u) ≤ θ * vj
  · have hq : duopolyOwnQuantity θ wi vj u ≤ 0 := by
      unfold duopolyOwnQuantity
      exact div_nonpos_of_nonpos_of_nonneg (by linarith) hDpos.le
    rw [fullScalarContinuationProfit_eq_inactive hq, hzero]
    simpa [inactiveScalarProfit] using inactive_branch_max_at_zero hRpos hu
  · have hnum : 0 < 2 * (wi + u) - θ * vj := by
      linarith [lt_of_not_ge hact]
    have hqnonneg : 0 ≤ duopolyOwnQuantity θ wi vj u := by
      unfold duopolyOwnQuantity
      exact (div_pos hnum hDpos).le
    have hnumle : 2 * (wi + u) - θ * vj ≤ 2 * u := by
      linarith
    have hqle : duopolyOwnQuantity θ wi vj u ≤ 2 * u / cournotD θ := by
      unfold duopolyOwnQuantity
      exact div_le_div_of_nonneg_right hnumle hDpos.le
    have hupper0 : 0 ≤ 2 * u / cournotD θ :=
      div_nonneg (mul_nonneg (by norm_num) hu) hDpos.le
    have hsq :
        duopolyOwnQuantity θ wi vj u ^ 2 ≤ (2 * u / cournotD θ) ^ 2 := by
      nlinarith
    have hAneg := model_duopolyQuadraticA_neg hkx hkg hθ hR
    have hcoef : 4 / cournotD θ ^ 2 < 1 / (2 * R) := by
      simpa [duopolyQuadraticA, R] using (sub_lt_zero.mp hAneg)
    have hid : (2 * u / cournotD θ) ^ 2 =
        (4 / cournotD θ ^ 2) * u ^ 2 := by ring
    have hcost : (2 * u / cournotD θ) ^ 2 ≤ u ^ 2 / (2 * R) := by
      rw [hid]
      have hm := mul_le_mul_of_nonneg_right hcoef.le (sq_nonneg u)
      simpa [div_eq_mul_inv, mul_assoc, mul_left_comm, mul_comm] using hm
    have hduo : duopolyScalarProfit R θ wi vj u ≤ 0 := by
      unfold duopolyScalarProfit
      nlinarith
    calc
      fullScalarContinuationProfit R θ wi vj u ≤
          duopolyScalarProfit R θ wi vj u :=
        fullScalarContinuationProfit_le_duopolyScalarProfit hw hu
      _ ≤ 0 := hduo
      _ = fullScalarContinuationProfit R θ wi vj 0 := hzero.symm

/-- In an A-monopoly Stage-2 regime, A's encoded scalar investment is globally
optimal against the rival's encoded zero investment under the full Stage-3
continuation. -/
theorem model_aMonopoly_fullScalar_best_response
    {kx kg μ θ wA wB u : ℝ}
    (hkx : 0 < kx) (hkg : 0 < kg)
    (hθ : θ ∈ Icc (0 : ℝ) 1)
    (hR : investmentR kx kg μ < (3 / 4 : ℝ))
    (hwA : 0 < wA)
    (hAM : aMonopolyRegion (investmentR kx kg μ) θ wA wB)
    (hu : 0 ≤ u) :
    let z := aMonopolyContinuation (investmentR kx kg μ) wA
    fullScalarContinuationProfit (investmentR kx kg μ) θ wA wB u ≤
      fullScalarContinuationProfit (investmentR kx kg μ) θ wA wB z.uA := by
  dsimp
  let R := investmentR kx kg μ
  let z := aMonopolyContinuation R wA
  have hRpos : 0 < R := by dsimp [R]; exact investmentR_pos hkx hkg
  have hMpos : 0 < monopolyM R := by dsimp [R]; exact monopolyM_pos hθ hR
  have hDpos : 0 < cournotD θ := cournotD_pos hθ
  rcases aMonopoly_admissible hRpos hMpos hwA hAM with
    ⟨hq, _hqB, _huA, _huB, hinactive⟩
  have hstage := aMonopoly_stage3_identity (R := R) (wA := wA) hMpos.ne'
  have hmEq : monopolyOwnQuantity wA z.uA = z.qA := by
    unfold monopolyOwnQuantity
    linarith
  have hθin : θ * wB ≤ θ ^ 2 * z.qA := by
    have hm := mul_le_mul_of_nonneg_left hinactive hθ.1
    nlinarith
  have hduo : z.qA ≤ duopolyOwnQuantity θ wA wB z.uA := by
    unfold duopolyOwnQuantity
    apply (le_div_iff₀ hDpos).2
    unfold cournotD
    nlinarith [hstage, hθin]
  have heq :
      fullScalarContinuationProfit R θ wA wB z.uA =
        monopolyScalarProfit R wA z.uA := by
    apply fullScalarContinuationProfit_eq_monopoly
    · rw [hmEq]
      exact hq.le
    · rw [hmEq]
      exact hduo
  have hfoc := model_aMonopoly_scalar_foc
    (kx := kx) (kg := kg) (μ := μ) (θ := θ) (wA := wA) (wB := wB)
    hkx hkg hθ hR
  calc
    fullScalarContinuationProfit R θ wA wB u ≤ monopolyScalarProfit R wA u :=
      fullScalarContinuationProfit_le_monopolyScalarProfit hwA hu
    _ ≤ monopolyScalarProfit R wA z.uA :=
      monopoly_branch_max_of_foc hkx hkg hR hfoc
    _ = fullScalarContinuationProfit R θ wA wB z.uA := heq.symm

/-- In an A-kink Stage-2 regime, A's kink scalar investment globally dominates
both the active-duopoly side and the monopoly side. -/
theorem model_aKink_fullScalar_best_response
    {kx kg μ θ wA wB u : ℝ}
    (hkx : 0 < kx) (hkg : 0 < kg)
    (hθ : θ ∈ Icc (0 : ℝ) 1) (hθpos : 0 < θ)
    (hR : investmentR kx kg μ < (3 / 4 : ℝ))
    (hwA : 0 < wA) (hwB : 0 < wB)
    (hAK : aKinkRegion (investmentR kx kg μ) (reducedL kx kg μ θ) θ wA wB)
    (hu : 0 ≤ u) :
    let z := aKinkContinuation θ wA wB
    fullScalarContinuationProfit (investmentR kx kg μ) θ wA wB u ≤
      fullScalarContinuationProfit (investmentR kx kg μ) θ wA wB z.uA := by
  dsimp
  let R := investmentR kx kg μ
  let z := aKinkContinuation θ wA wB
  have hRpos : 0 < R := by dsimp [R]; exact investmentR_pos hkx hkg
  rcases aKink_admissible hRpos hθpos hwB hAK with
    ⟨hq, _hqB, huZ, _huB, hkink⟩
  have hstage := aKink_stage3_identity (θ := θ) (wA := wA) (wB := wB)
  have hmEq : monopolyOwnQuantity wA z.uA = z.qA := by
    unfold monopolyOwnQuantity
    linarith
  have hduoEq : duopolyOwnQuantity θ wA wB z.uA = z.qA := by
    have hDpos : 0 < cournotD θ := cournotD_pos hθ
    unfold duopolyOwnQuantity
    apply (div_eq_iff hDpos.ne').2
    unfold cournotD
    nlinarith [hstage, hkink]
  have heqD :
      fullScalarContinuationProfit R θ wA wB z.uA =
        duopolyScalarProfit R θ wA wB z.uA := by
    apply fullScalarContinuationProfit_eq_duopoly
    · rw [hduoEq]
      exact hq.le
    · rw [hduoEq, hmEq]
  have heqM :
      fullScalarContinuationProfit R θ wA wB z.uA =
        monopolyScalarProfit R wA z.uA := by
    apply fullScalarContinuationProfit_eq_monopoly
    · rw [hmEq]
      exact hq.le
    · rw [hmEq, hduoEq]
  by_cases hleft : u ≤ z.uA
  · calc
      fullScalarContinuationProfit R θ wA wB u ≤
          duopolyScalarProfit R θ wA wB u :=
        fullScalarContinuationProfit_le_duopolyScalarProfit hwA hu
      _ ≤ duopolyScalarProfit R θ wA wB z.uA :=
        model_aKink_left_branch_max hkx hkg hθ hθpos hR hAK hleft
      _ = fullScalarContinuationProfit R θ wA wB z.uA := heqD.symm
  · have hright : z.uA ≤ u := le_of_not_ge hleft
    calc
      fullScalarContinuationProfit R θ wA wB u ≤ monopolyScalarProfit R wA u :=
        fullScalarContinuationProfit_le_monopolyScalarProfit hwA hu
      _ ≤ monopolyScalarProfit R wA z.uA :=
        model_aKink_right_branch_max hkx hkg hθ hθpos hR hAK hright
      _ = fullScalarContinuationProfit R θ wA wB z.uA := heqM.symm

end SLGPC
