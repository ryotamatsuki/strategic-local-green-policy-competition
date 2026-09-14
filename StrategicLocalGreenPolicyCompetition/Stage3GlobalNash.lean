import StrategicLocalGreenPolicyCompetition.Stage2GlobalBestResponse

noncomputable section

open Set

namespace SLGPC

/-- Stage-3 operating profit as a function of own quantity, holding the rival
quantity and post-investment intercept fixed. -/
def stage3OwnProfit (vi θ qj qi : ℝ) : ℝ :=
  (vi - qi - θ * qj) * qi

/-- An active Cournot FOC is a global best response over the nonnegative quantity
domain because own operating profit is a concave quadratic. -/
theorem stage3_active_global_best_response
    {vi θ qj qi q : ℝ}
    (hFOC : 2 * qi + θ * qj = vi) (_hqi : 0 ≤ qi) (_hq : 0 ≤ q) :
    stage3OwnProfit vi θ qj q ≤ stage3OwnProfit vi θ qj qi := by
  unfold stage3OwnProfit
  nlinarith [sq_nonneg (q - qi)]

/-- If the net intercept is below the rival-pressure threshold, zero output is a
global best response over all nonnegative quantities. -/
theorem stage3_inactive_global_best_response
    {vi θ qj q : ℝ}
    (hinactive : vi ≤ θ * qj) (hq : 0 ≤ q) :
    stage3OwnProfit vi θ qj q ≤ stage3OwnProfit vi θ qj 0 := by
  have hnet : vi - θ * qj ≤ 0 := sub_nonpos.mpr hinactive
  have hprod : (vi - θ * qj) * q ≤ 0 :=
    mul_nonpos_of_nonpos_of_nonneg hnet hq
  unfold stage3OwnProfit
  nlinarith [sq_nonneg q]

/-- For positive post-investment intercepts, the clipped closed-form quantities
used in the downstream bridge form a global Nash equilibrium of the Stage-3
nonnegative Cournot game. -/
theorem fullCournot_quantities_global_nash
    {θ vA vB qA qB : ℝ}
    (hθ : θ ∈ Icc (0 : ℝ) 1)
    (hvA : 0 < vA) (hvB : 0 < vB)
    (hqA : 0 ≤ qA) (hqB : 0 ≤ qB) :
    let zA := fullCournotOwnQuantity θ vA vB
    let zB := fullCournotOwnQuantity θ vB vA
    stage3OwnProfit vA θ zB qA ≤ stage3OwnProfit vA θ zB zA ∧
    stage3OwnProfit vB θ zA qB ≤ stage3OwnProfit vB θ zA zB := by
  dsimp
  have hDpos : 0 < cournotD θ := cournotD_pos hθ
  by_cases hAin : 2 * vA ≤ θ * vB
  · have hnumA : (2 * vA - θ * vB) / cournotD θ ≤ 0 :=
      div_nonpos_of_nonpos_of_nonneg (by linarith) hDpos.le
    have hminA : min (vA / 2) ((2 * vA - θ * vB) / cournotD θ) ≤ 0 :=
      le_trans (min_le_right _ _) hnumA
    have hzA : fullCournotOwnQuantity θ vA vB = 0 := by
      unfold fullCournotOwnQuantity
      rw [max_eq_left hminA]
    have hθv : θ * (2 * vA) ≤ θ * (θ * vB) :=
      mul_le_mul_of_nonneg_left hAin hθ.1
    have hduoB : vB / 2 ≤ (2 * vB - θ * vA) / cournotD θ := by
      apply (le_div_iff₀ hDpos).2
      unfold cournotD
      nlinarith [hθv]
    have hzB : fullCournotOwnQuantity θ vB vA = vB / 2 := by
      unfold fullCournotOwnQuantity
      rw [min_eq_left hduoB]
      have hvBhalf : 0 ≤ vB / 2 := by linarith
      rw [max_eq_right hvBhalf]
    rw [hzA, hzB]
    constructor
    · apply stage3_inactive_global_best_response
      · linarith
      · exact hqA
    · apply stage3_active_global_best_response
      · ring
      · linarith
      · exact hqB
  · by_cases hBin : 2 * vB ≤ θ * vA
    · have hnumB : (2 * vB - θ * vA) / cournotD θ ≤ 0 :=
        div_nonpos_of_nonpos_of_nonneg (by linarith) hDpos.le
      have hminB : min (vB / 2) ((2 * vB - θ * vA) / cournotD θ) ≤ 0 :=
        le_trans (min_le_right _ _) hnumB
      have hzB : fullCournotOwnQuantity θ vB vA = 0 := by
        unfold fullCournotOwnQuantity
        rw [max_eq_left hminB]
      have hθv : θ * (2 * vB) ≤ θ * (θ * vA) :=
        mul_le_mul_of_nonneg_left hBin hθ.1
      have hduoA : vA / 2 ≤ (2 * vA - θ * vB) / cournotD θ := by
        apply (le_div_iff₀ hDpos).2
        unfold cournotD
        nlinarith [hθv]
      have hzA : fullCournotOwnQuantity θ vA vB = vA / 2 := by
        unfold fullCournotOwnQuantity
        rw [min_eq_left hduoA]
        have hvAhalf : 0 ≤ vA / 2 := by linarith
        rw [max_eq_right hvAhalf]
      rw [hzA, hzB]
      constructor
      · apply stage3_active_global_best_response
        · ring
        · linarith
        · exact hqA
      · apply stage3_inactive_global_best_response
        · linarith
        · exact hqB
  · have hAact : θ * vB < 2 * vA := lt_of_not_ge hAin
    have hBact : θ * vA < 2 * vB := lt_of_not_ge hBin
    have hnumA : 0 < (2 * vA - θ * vB) / cournotD θ :=
      div_pos (by linarith) hDpos
    have hnumB : 0 < (2 * vB - θ * vA) / cournotD θ :=
      div_pos (by linarith) hDpos
    have hθA : θ * (θ * vA) ≤ θ * (2 * vB) :=
      mul_le_mul_of_nonneg_left hBact.le hθ.1
    have hθB : θ * (θ * vB) ≤ θ * (2 * vA) :=
      mul_le_mul_of_nonneg_left hAact.le hθ.1
    have hduoA : (2 * vA - θ * vB) / cournotD θ ≤ vA / 2 := by
      apply (div_le_iff₀ hDpos).2
      unfold cournotD
      nlinarith [hθA]
    have hduoB : (2 * vB - θ * vA) / cournotD θ ≤ vB / 2 := by
      apply (div_le_iff₀ hDpos).2
      unfold cournotD
      nlinarith [hθB]
    have hzA :
        fullCournotOwnQuantity θ vA vB =
          (2 * vA - θ * vB) / cournotD θ := by
      unfold fullCournotOwnQuantity
      rw [min_eq_right hduoA, max_eq_right hnumA.le]
    have hzB :
        fullCournotOwnQuantity θ vB vA =
          (2 * vB - θ * vA) / cournotD θ := by
      unfold fullCournotOwnQuantity
      rw [min_eq_right hduoB, max_eq_right hnumB.le]
    have hFOCA :
        2 * fullCournotOwnQuantity θ vA vB +
          θ * fullCournotOwnQuantity θ vB vA = vA := by
      rw [hzA, hzB]
      field_simp [hDpos.ne']
      unfold cournotD
      ring
    have hFOCB :
        2 * fullCournotOwnQuantity θ vB vA +
          θ * fullCournotOwnQuantity θ vA vB = vB := by
      rw [hzA, hzB]
      field_simp [hDpos.ne']
      unfold cournotD
      ring
    constructor
    · exact stage3_active_global_best_response hFOCA hnumA.le hqA
    · exact stage3_active_global_best_response hFOCB hnumB.le hqB

end SLGPC
