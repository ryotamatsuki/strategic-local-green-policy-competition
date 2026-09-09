import StrategicLocalGreenPolicyCompetition.FirmStage

noncomputable section

open Set

namespace SLGPC

/-- Entries of the Stage-2 investment Hessian on the active-duopoly branch. -/
def firmH11 (kx θ : ℝ) : ℝ := 8 / cournotD θ ^ 2 - kx

def firmH12 (μ θ : ℝ) : ℝ := 8 * μ / cournotD θ ^ 2

def firmH22 (kg μ θ : ℝ) : ℝ := 8 * μ ^ 2 / cournotD θ ^ 2 - kg

/-- Determinant of the symmetric 2x2 firm investment Hessian. -/
def firmHDet (kx kg μ θ : ℝ) : ℝ :=
  firmH11 kx θ * firmH22 kg μ θ - firmH12 μ θ ^ 2

/-- The Hessian quadratic form in an arbitrary investment direction `(dx,dg)`. -/
def firmHQuadraticForm
    (kx kg μ θ dx dg : ℝ) : ℝ :=
  firmH11 kx θ * dx ^ 2
    + 2 * firmH12 μ θ * dx * dg
    + firmH22 kg μ θ * dg ^ 2

lemma inverse_kx_lt_three_quarters
    {kx kg μ : ℝ}
    (hkg : 0 < kg)
    (hR : investmentR kx kg μ < (3 / 4 : ℝ)) :
    1 / kx < (3 / 4 : ℝ) := by
  have hmu : 0 ≤ μ ^ 2 / kg := div_nonneg (sq_nonneg μ) hkg.le
  unfold investmentR at hR
  linarith

lemma kx_gt_four_thirds
    {kx kg μ : ℝ}
    (hkx : 0 < kx) (hkg : 0 < kg)
    (hR : investmentR kx kg μ < (3 / 4 : ℝ)) :
    (4 / 3 : ℝ) < kx := by
  have hinv : 1 / kx < (3 / 4 : ℝ) :=
    inverse_kx_lt_three_quarters hkg hR
  have hmul : (1 : ℝ) < (3 / 4 : ℝ) * kx :=
    (div_lt_iff₀ hkx).mp hinv
  nlinarith

/-- The first leading principal entry of the firm Hessian is negative. -/
theorem firmH11_neg
    {kx kg μ θ : ℝ}
    (hkx : 0 < kx) (hkg : 0 < kg)
    (hθ : θ ∈ Icc (0 : ℝ) 1)
    (hR : investmentR kx kg μ < (3 / 4 : ℝ)) :
    firmH11 kx θ < 0 := by
  have hDpos : 0 < cournotD θ := cournotD_pos hθ
  have hDge : 3 ≤ cournotD θ := cournotD_ge_three hθ
  have hDsqPos : 0 < cournotD θ ^ 2 := sq_pos_of_pos hDpos
  have hDsqGe : 9 ≤ cournotD θ ^ 2 := by
    nlinarith [sq_nonneg (cournotD θ - 3)]
  have hkxLower : (4 / 3 : ℝ) < kx := kx_gt_four_thirds hkx hkg hR
  have hscaled : (4 / 3 : ℝ) * cournotD θ ^ 2 < kx * cournotD θ ^ 2 :=
    mul_lt_mul_of_pos_right hkxLower hDsqPos
  have h8 : (8 : ℝ) < kx * cournotD θ ^ 2 := by
    nlinarith
  unfold firmH11
  have hfrac : 8 / cournotD θ ^ 2 < kx :=
    (div_lt_iff₀ hDsqPos).2 h8
  linarith

/-- Exact factorization of the Hessian determinant through the aggregate feedback `R`. -/
lemma firmHDet_factorization
    {kx kg μ θ : ℝ}
    (hkx : kx ≠ 0) (hkg : kg ≠ 0) (hD : cournotD θ ≠ 0) :
    firmHDet kx kg μ θ =
      kx * kg * (1 - 8 * investmentR kx kg μ / cournotD θ ^ 2) := by
  unfold firmHDet firmH11 firmH12 firmH22 investmentR
  field_simp [hkx, hkg, hD]
  ring

/-- Under `R < 3/4`, the Hessian determinant is positive throughout `θ ∈ [0,1]`. -/
theorem firmHDet_pos
    {kx kg μ θ : ℝ}
    (hkx : 0 < kx) (hkg : 0 < kg)
    (hθ : θ ∈ Icc (0 : ℝ) 1)
    (hR : investmentR kx kg μ < (3 / 4 : ℝ)) :
    0 < firmHDet kx kg μ θ := by
  have hDpos : 0 < cournotD θ := cournotD_pos hθ
  have hDge : 3 ≤ cournotD θ := cournotD_ge_three hθ
  have hDsqPos : 0 < cournotD θ ^ 2 := sq_pos_of_pos hDpos
  have hDsqGe : 9 ≤ cournotD θ ^ 2 := by
    nlinarith [sq_nonneg (cournotD θ - 3)]
  have hfrac : 8 * investmentR kx kg μ / cournotD θ ^ 2 < 1 := by
    rw [div_lt_one hDsqPos]
    nlinarith
  rw [firmHDet_factorization hkx.ne' hkg.ne' hDpos.ne']
  exact mul_pos (mul_pos hkx hkg) (sub_pos.mpr hfrac)

/-- The two scalar Sylvester inequalities certifying negative definiteness of the
symmetric Stage-2 firm Hessian. -/
theorem firmHessian_sylvester_certificate
    {kx kg μ θ : ℝ}
    (hkx : 0 < kx) (hkg : 0 < kg)
    (hθ : θ ∈ Icc (0 : ℝ) 1)
    (hR : investmentR kx kg μ < (3 / 4 : ℝ)) :
    firmH11 kx θ < 0 ∧ 0 < firmHDet kx kg μ θ :=
  ⟨firmH11_neg hkx hkg hθ hR, firmHDet_pos hkx hkg hθ hR⟩

/-- Generic 2x2 Sylvester argument: `a<0` and `ac-b²>0` force the associated
symmetric quadratic form to be negative in every nonzero direction. -/
lemma twoByTwo_quadratic_neg_of_sylvester
    {a b c x y : ℝ}
    (ha : a < 0)
    (hdet : 0 < a * c - b ^ 2)
    (hxy : x ≠ 0 ∨ y ≠ 0) :
    a * x ^ 2 + 2 * b * x * y + c * y ^ 2 < 0 := by
  let Q := a * x ^ 2 + 2 * b * x * y + c * y ^ 2
  have hid :
      a * Q = (a * x + b * y) ^ 2 + (a * c - b ^ 2) * y ^ 2 := by
    dsimp [Q]
    ring
  have hrhs :
      0 < (a * x + b * y) ^ 2 + (a * c - b ^ 2) * y ^ 2 := by
    by_cases hy : y = 0
    · have hx : x ≠ 0 := hxy.resolve_right hy
      subst y
      simpa using sq_pos_of_ne_zero (mul_ne_zero ha.ne hx)
    · have hysq : 0 < y ^ 2 := sq_pos_of_ne_zero hy
      have hterm : 0 < (a * c - b ^ 2) * y ^ 2 := mul_pos hdet hysq
      nlinarith [sq_nonneg (a * x + b * y)]
  have hmul : 0 < a * Q := by
    rw [hid]
    exact hrhs
  rcases (mul_pos_iff.mp hmul) with hpp | hnn
  · linarith
  · exact hnn.2

/-- Full scalar negative-definiteness statement for the manuscript's Stage-2 firm Hessian. -/
theorem firmHQuadraticForm_neg
    {kx kg μ θ dx dg : ℝ}
    (hkx : 0 < kx) (hkg : 0 < kg)
    (hθ : θ ∈ Icc (0 : ℝ) 1)
    (hR : investmentR kx kg μ < (3 / 4 : ℝ))
    (hdir : dx ≠ 0 ∨ dg ≠ 0) :
    firmHQuadraticForm kx kg μ θ dx dg < 0 := by
  unfold firmHQuadraticForm
  apply twoByTwo_quadratic_neg_of_sylvester
  · exact firmH11_neg hkx hkg hθ hR
  · simpa [firmHDet] using firmHDet_pos hkx hkg hθ hR
  · exact hdir

end SLGPC
