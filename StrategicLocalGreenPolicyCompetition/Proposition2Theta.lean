import StrategicLocalGreenPolicyCompetition.Proposition2Sign

noncomputable section

open Set

namespace SLGPC

/-- Reduced cross-instrument response in Proposition 2: `-Ω(θ) P(θ²)`. -/
def thresholdResponse
    (Ω : ℝ → ℝ) (A4 A3 A2 A1 A0 θ : ℝ) : ℝ :=
  -Ω θ * thresholdQuartic A4 A3 A2 A1 A0 (θ ^ 2)

/-- The unique quartic root induces a unique positive threshold in `θ`-space. -/
theorem thresholdQuartic_unique_theta_root
    {A4 A3 A2 A1 A0 : ℝ}
    (hP0 : 0 < thresholdQuartic A4 A3 A2 A1 A0 0)
    (hP1 : thresholdQuartic A4 A3 A2 A1 A0 1 < 0)
    (hB0 : thresholdB0 A1 < 0)
    (hB1 : thresholdB1 A2 A1 < 0)
    (hB2 : thresholdB2 A3 A2 A1 < 0)
    (hB3 : thresholdB3 A4 A3 A2 A1 < 0) :
    ∃! θ : ℝ,
      θ ∈ Ioo (0 : ℝ) 1 ∧
        thresholdQuartic A4 A3 A2 A1 A0 (θ ^ 2) = 0 := by
  obtain ⟨uStar, huStar, hPStar, huUnique⟩ :=
    thresholdQuartic_unique_root hP0 hP1 hB0 hB1 hB2 hB3
  let θStar : ℝ := Real.sqrt uStar
  have huNonneg : 0 ≤ uStar := huStar.1.le
  have hθsq : θStar ^ 2 = uStar := by
    simpa [θStar] using Real.sq_sqrt huNonneg
  have hθPos : 0 < θStar := by
    by_contra h
    have hzero : θStar = 0 := by
      have hnonneg : 0 ≤ θStar := by
        dsimp [θStar]
        exact Real.sqrt_nonneg uStar
      linarith
    rw [hzero] at hθsq
    norm_num at hθsq
    linarith
  have hθLtOne : θStar < 1 := by
    by_contra h
    have hone : 1 ≤ θStar := by linarith
    nlinarith [hθsq, huStar.2]
  refine ⟨θStar, ⟨⟨hθPos, hθLtOne⟩, ?_⟩, ?_⟩
  · rw [hθsq]
    exact hPStar
  · intro θ hθ
    have hθPos' : 0 < θ := hθ.1.1
    have hθSqPos : 0 < θ ^ 2 := sq_pos_of_pos hθPos'
    have hunitProd : 0 < (1 - θ) * (1 + θ) := by
      exact mul_pos (by linarith [hθ.1.2]) (by linarith)
    have hθSqLtOne : θ ^ 2 < 1 := by
      nlinarith [hunitProd]
    have hθSquareMem : θ ^ 2 ∈ Ioo (0 : ℝ) 1 := ⟨hθSqPos, hθSqLtOne⟩
    have hsqEq : θ ^ 2 = uStar :=
      huUnique (θ ^ 2) ⟨hθSquareMem, hθ.2⟩
    have hprod : (θ - θStar) * (θ + θStar) = 0 := by
      nlinarith [hsqEq, hθsq]
    rcases mul_eq_zero.mp hprod with hdiff | hsum
    · linarith
    · linarith

/-- Full reduced-form sign-switch conclusion of Proposition 2.

Given the manuscript's reduction `∂h_A^BR/∂s_B = -Ω(θ)P(θ²)` with `Ω(θ)>0`, the
quartic endpoint and Bernstein conditions imply one threshold `θ* ∈ (0,1)`, a negative
response below it, and a positive response above it. -/
theorem thresholdResponse_unique_switch
    {A4 A3 A2 A1 A0 : ℝ}
    (Ω : ℝ → ℝ)
    (hP0 : 0 < thresholdQuartic A4 A3 A2 A1 A0 0)
    (hP1 : thresholdQuartic A4 A3 A2 A1 A0 1 < 0)
    (hB0 : thresholdB0 A1 < 0)
    (hB1 : thresholdB1 A2 A1 < 0)
    (hB2 : thresholdB2 A3 A2 A1 < 0)
    (hB3 : thresholdB3 A4 A3 A2 A1 < 0)
    (hΩ : ∀ θ ∈ Ioc (0 : ℝ) 1, 0 < Ω θ) :
    ∃ θStar ∈ Ioo (0 : ℝ) 1,
      thresholdQuartic A4 A3 A2 A1 A0 (θStar ^ 2) = 0 ∧
      (∀ θ ∈ Ioo (0 : ℝ) θStar,
        thresholdResponse Ω A4 A3 A2 A1 A0 θ < 0) ∧
      (∀ θ ∈ Ioc θStar (1 : ℝ),
        0 < thresholdResponse Ω A4 A3 A2 A1 A0 θ) := by
  obtain ⟨uStar, huStar, hPStar, hPosBelow, hNegAbove⟩ :=
    thresholdQuartic_sign_around_root hP0 hP1 hB0 hB1 hB2 hB3
  let θStar : ℝ := Real.sqrt uStar
  have huNonneg : 0 ≤ uStar := huStar.1.le
  have hθsq : θStar ^ 2 = uStar := by
    simpa [θStar] using Real.sq_sqrt huNonneg
  have hθPos : 0 < θStar := by
    by_contra h
    have hzero : θStar = 0 := by
      have hnonneg : 0 ≤ θStar := by
        dsimp [θStar]
        exact Real.sqrt_nonneg uStar
      linarith
    rw [hzero] at hθsq
    norm_num at hθsq
    linarith
  have hθLtOne : θStar < 1 := by
    by_contra h
    have hone : 1 ≤ θStar := by linarith
    nlinarith [hθsq, huStar.2]
  refine ⟨θStar, ⟨hθPos, hθLtOne⟩, ?_, ?_, ?_⟩
  · rw [hθsq]
    exact hPStar
  · intro θ hθ
    have hsumPos : 0 < θStar + θ := by linarith
    have hdiffPos : 0 < θStar - θ := by linarith
    have hprodPos : 0 < (θStar - θ) * (θStar + θ) :=
      mul_pos hdiffPos hsumPos
    have hθSqLt : θ ^ 2 < uStar := by
      nlinarith [hprodPos, hθsq]
    have hPθ : 0 < thresholdQuartic A4 A3 A2 A1 A0 (θ ^ 2) :=
      hPosBelow (θ ^ 2) ⟨sq_nonneg θ, hθSqLt⟩
    have hθLeOne : θ ≤ 1 := le_trans (le_of_lt hθ.2) hθLtOne.le
    have hΩθ : 0 < Ω θ := hΩ θ ⟨hθ.1, hθLeOne⟩
    unfold thresholdResponse
    exact mul_neg_of_neg_of_pos (neg_neg_of_pos hΩθ) hPθ
  · intro θ hθ
    have hθPos' : 0 < θ := lt_trans hθPos hθ.1
    have hsumPos : 0 < θ + θStar := by linarith
    have hdiffPos : 0 < θ - θStar := sub_pos.mpr hθ.1
    have hprodPos : 0 < (θ - θStar) * (θ + θStar) :=
      mul_pos hdiffPos hsumPos
    have huLtSq : uStar < θ ^ 2 := by
      nlinarith [hprodPos, hθsq]
    have hunitProd : 0 ≤ (1 - θ) * (1 + θ) := by
      exact mul_nonneg (by linarith) (by linarith)
    have hθSqLeOne : θ ^ 2 ≤ 1 := by
      nlinarith [hunitProd]
    have hPθ : thresholdQuartic A4 A3 A2 A1 A0 (θ ^ 2) < 0 :=
      hNegAbove (θ ^ 2) ⟨huLtSq, hθSqLeOne⟩
    have hΩθ : 0 < Ω θ := hΩ θ ⟨hθPos', hθ.2⟩
    unfold thresholdResponse
    exact mul_pos_of_neg_of_neg (neg_neg_of_pos hΩθ) hPθ

end SLGPC
