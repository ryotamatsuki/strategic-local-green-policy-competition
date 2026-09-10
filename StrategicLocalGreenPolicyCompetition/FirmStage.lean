import Mathlib

noncomputable section

open Set

namespace SLGPC

/-- Cournot denominator `D = 4 - θ²`. -/
def cournotD (θ : ℝ) : ℝ := 4 - θ ^ 2

/-- Investment-feedback coefficient `R = 1/kx + μ²/kg`. -/
def investmentR (kx kg μ : ℝ) : ℝ :=
  1 / kx + μ ^ 2 / kg

/-- `λ = 4R/D`. -/
def investmentLambda (kx kg μ θ : ℝ) : ℝ :=
  4 * investmentR kx kg μ / cournotD θ

/-- `L = 2 - λ`. -/
def reducedL (kx kg μ θ : ℝ) : ℝ :=
  2 - investmentLambda kx kg μ θ

/-- Local policy shifter `y_i = (μ/kg)s_i + ν h_i`. -/
def policyY (kg μ ν s h : ℝ) : ℝ :=
  μ / kg * s + ν * h

/-- Reduced intercept `w_i = m + y_i`. -/
def reducedW (m kg μ ν s h : ℝ) : ℝ :=
  m + policyY kg μ ν s h

/-- Interior conventional investment from the Stage-2 FOC. -/
def interiorX (kx θ q : ℝ) : ℝ :=
  4 * q / (cournotD θ * kx)

/-- Interior green investment from the Stage-2 FOC. -/
def interiorG (kg μ s θ q : ℝ) : ℝ :=
  (4 * μ * q / cournotD θ + s) / kg

/-- Constant and policy coefficients in the manuscript's affine output representation. -/
def reducedQ0 (m L θ : ℝ) : ℝ := m / (L + θ)

def reducedT0 (L θ : ℝ) : ℝ := L / (L ^ 2 - θ ^ 2)

def reducedT1 (L θ : ℝ) : ℝ := -θ / (L ^ 2 - θ ^ 2)

lemma cournotD_ge_three {θ : ℝ} (hθ : θ ∈ Icc (0 : ℝ) 1) :
    3 ≤ cournotD θ := by
  rcases hθ with ⟨hθ0, hθ1⟩
  have hprod : 0 ≤ θ * (1 - θ) :=
    mul_nonneg hθ0 (sub_nonneg.mpr hθ1)
  unfold cournotD
  nlinarith

lemma cournotD_pos {θ : ℝ} (hθ : θ ∈ Icc (0 : ℝ) 1) :
    0 < cournotD θ := by
  linarith [cournotD_ge_three hθ]

lemma investmentR_pos
    {kx kg μ : ℝ} (hkx : 0 < kx) (hkg : 0 < kg) :
    0 < investmentR kx kg μ := by
  unfold investmentR
  have hkxInv : 0 < (1 / kx : ℝ) := one_div_pos.mpr hkx
  have hmu : 0 ≤ μ ^ 2 / kg := div_nonneg (sq_nonneg μ) hkg.le
  linarith

/-- The maintained `R < 3/4` condition implies `λ < 1` uniformly on `θ ∈ [0,1]`. -/
theorem investmentLambda_lt_one
    {kx kg μ θ : ℝ}
    (hθ : θ ∈ Icc (0 : ℝ) 1)
    (hR : investmentR kx kg μ < (3 / 4 : ℝ)) :
    investmentLambda kx kg μ θ < 1 := by
  have hDpos : 0 < cournotD θ := cournotD_pos hθ
  have hDge : 3 ≤ cournotD θ := cournotD_ge_three hθ
  unfold investmentLambda
  rw [div_lt_one hDpos]
  nlinarith

/-- The paper's convenient regularity condition implies `L > θ` on the full rivalry range. -/
theorem reducedL_gt_theta
    {kx kg μ θ : ℝ}
    (hθ : θ ∈ Icc (0 : ℝ) 1)
    (hR : investmentR kx kg μ < (3 / 4 : ℝ)) :
    θ < reducedL kx kg μ θ := by
  have hLam : investmentLambda kx kg μ θ < 1 :=
    investmentLambda_lt_one hθ hR
  unfold reducedL
  linarith [hθ.2, hLam]

lemma reducedL_pos
    {kx kg μ θ : ℝ}
    (hθ : θ ∈ Icc (0 : ℝ) 1)
    (hR : investmentR kx kg μ < (3 / 4 : ℝ)) :
    0 < reducedL kx kg μ θ := by
  have hL := reducedL_gt_theta hθ hR
  linarith [hθ.1]

/-- Hence the reduced two-firm determinant `L²-θ²` is strictly positive. -/
theorem reducedDet_pos
    {kx kg μ θ : ℝ}
    (hθ : θ ∈ Icc (0 : ℝ) 1)
    (hR : investmentR kx kg μ < (3 / 4 : ℝ)) :
    0 < reducedL kx kg μ θ ^ 2 - θ ^ 2 := by
  let L := reducedL kx kg μ θ
  have hLθ : θ < L := reducedL_gt_theta hθ hR
  have hsum : 0 < L + θ := by linarith [hθ.1]
  have hdiff : 0 < L - θ := sub_pos.mpr hLθ
  have hprod : 0 < (L - θ) * (L + θ) := mul_pos hdiff hsum
  dsimp [L] at hprod ⊢
  nlinarith

/-- Stage-3 active-duopoly FOCs solve to the manuscript Cournot formula. -/
theorem cournot_active_solution
    {θ vA vB qA qB : ℝ}
    (hθ : θ ∈ Icc (0 : ℝ) 1)
    (hA : 2 * qA + θ * qB = vA)
    (hB : θ * qA + 2 * qB = vB) :
    qA = (2 * vA - θ * vB) / cournotD θ ∧
    qB = (2 * vB - θ * vA) / cournotD θ := by
  have hDne : cournotD θ ≠ 0 := (cournotD_pos hθ).ne'
  constructor
  · apply (eq_div_iff hDne).2
    unfold cournotD
    linear_combination 2 * hA - θ * hB
  · apply (eq_div_iff hDne).2
    unfold cournotD
    linear_combination 2 * hB - θ * hA

/-- The active Cournot system has at most one solution on `θ ∈ [0,1]`. -/
theorem cournot_active_unique
    {θ vA vB qA qB qA' qB' : ℝ}
    (hθ : θ ∈ Icc (0 : ℝ) 1)
    (hA : 2 * qA + θ * qB = vA)
    (hB : θ * qA + 2 * qB = vB)
    (hA' : 2 * qA' + θ * qB' = vA)
    (hB' : θ * qA' + 2 * qB' = vB) :
    qA = qA' ∧ qB = qB' := by
  obtain ⟨hqA, hqB⟩ := cournot_active_solution hθ hA hB
  obtain ⟨hqA', hqB'⟩ := cournot_active_solution hθ hA' hB'
  exact ⟨hqA.trans hqA'.symm, hqB.trans hqB'.symm⟩

/-- Substituting the two Stage-2 investment FOC solutions collapses private cost reduction
into `λ q + y`. -/
theorem interior_cost_reduction_eq
    {kx kg μ ν s h θ q : ℝ}
    (hkx : kx ≠ 0) (hkg : kg ≠ 0) (hD : cournotD θ ≠ 0) :
    interiorX kx θ q + μ * interiorG kg μ s θ q + ν * h =
      investmentLambda kx kg μ θ * q + policyY kg μ ν s h := by
  unfold interiorX interiorG investmentLambda investmentR policyY
  field_simp [hkx, hkg, hD]
  ring

/-- The active Stage-3 equation plus the Stage-2 FOC solutions implies the compact
reduced-output equation `L q_i + θ q_j = w_i`. -/
theorem reduced_output_equation
    {kx kg μ ν s h θ m qi qj : ℝ}
    (hkx : kx ≠ 0) (hkg : kg ≠ 0)
    (hθ : θ ∈ Icc (0 : ℝ) 1)
    (hCournot :
      2 * qi + θ * qj =
        m + interiorX kx θ qi + μ * interiorG kg μ s θ qi + ν * h) :
    reducedL kx kg μ θ * qi + θ * qj =
      reducedW m kg μ ν s h := by
  have hDne : cournotD θ ≠ 0 := (cournotD_pos hθ).ne'
  have hcost := interior_cost_reduction_eq
    (kx := kx) (kg := kg) (μ := μ) (ν := ν) (s := s) (h := h)
    (θ := θ) (q := qi) hkx hkg hDne
  unfold reducedL reducedW
  nlinarith [hCournot, hcost]

/-- Closed form for the reduced two-firm Stage-2 quantity system. -/
theorem reduced_system_solution
    {L θ wA wB qA qB : ℝ}
    (hdet : L ^ 2 - θ ^ 2 ≠ 0)
    (hA : L * qA + θ * qB = wA)
    (hB : θ * qA + L * qB = wB) :
    qA = (L * wA - θ * wB) / (L ^ 2 - θ ^ 2) ∧
    qB = (L * wB - θ * wA) / (L ^ 2 - θ ^ 2) := by
  constructor
  · apply (eq_div_iff hdet).2
    linear_combination L * hA - θ * hB
  · apply (eq_div_iff hdet).2
    linear_combination L * hB - θ * hA

/-- Under `R < 3/4`, the reduced Stage-2 system has a unique solution. -/
theorem reduced_system_unique
    {kx kg μ θ wA wB qA qB qA' qB' : ℝ}
    (hθ : θ ∈ Icc (0 : ℝ) 1)
    (hR : investmentR kx kg μ < (3 / 4 : ℝ))
    (hA : reducedL kx kg μ θ * qA + θ * qB = wA)
    (hB : θ * qA + reducedL kx kg μ θ * qB = wB)
    (hA' : reducedL kx kg μ θ * qA' + θ * qB' = wA)
    (hB' : θ * qA' + reducedL kx kg μ θ * qB' = wB) :
    qA = qA' ∧ qB = qB' := by
  have hdet : reducedL kx kg μ θ ^ 2 - θ ^ 2 ≠ 0 :=
    (reducedDet_pos hθ hR).ne'
  obtain ⟨hqA, hqB⟩ := reduced_system_solution hdet hA hB
  obtain ⟨hqA', hqB'⟩ := reduced_system_solution hdet hA' hB'
  exact ⟨hqA.trans hqA'.symm, hqB.trans hqB'.symm⟩

/-- Algebraic equivalence between the closed-form system solution and the manuscript's
`q0 + t0 y_i + t1 y_j` representation. -/
theorem reduced_solution_eq_affine
    {m L θ yi yj : ℝ}
    (hLθ : L ≠ θ) (hLpθ : L + θ ≠ 0) :
    (L * (m + yi) - θ * (m + yj)) / (L ^ 2 - θ ^ 2) =
      reducedQ0 m L θ + reducedT0 L θ * yi + reducedT1 L θ * yj := by
  unfold reducedQ0 reducedT0 reducedT1
  have hfactor : L ^ 2 - θ ^ 2 = (L - θ) * (L + θ) := by ring
  have hdet : L ^ 2 - θ ^ 2 ≠ 0 := by
    rw [hfactor]
    exact mul_ne_zero (sub_ne_zero.mpr hLθ) hLpθ
  field_simp [hdet, hLpθ]
  ring

/-- `t0 > 0` under the paper's regularity condition. -/
theorem reducedT0_pos
    {kx kg μ θ : ℝ}
    (hθ : θ ∈ Icc (0 : ℝ) 1)
    (hR : investmentR kx kg μ < (3 / 4 : ℝ)) :
    0 < reducedT0 (reducedL kx kg μ θ) θ := by
  unfold reducedT0
  exact div_pos (reducedL_pos hθ hR) (reducedDet_pos hθ hR)

/-- `t1 ≤ 0`, with strict negativity whenever `θ > 0`. -/
theorem reducedT1_nonpos
    {kx kg μ θ : ℝ}
    (hθ : θ ∈ Icc (0 : ℝ) 1)
    (hR : investmentR kx kg μ < (3 / 4 : ℝ)) :
    reducedT1 (reducedL kx kg μ θ) θ ≤ 0 := by
  unfold reducedT1
  exact div_nonpos_of_nonpos_of_nonneg (neg_nonpos.mpr hθ.1) (reducedDet_pos hθ hR).le

theorem reducedT1_neg
    {kx kg μ θ : ℝ}
    (hθ : θ ∈ Icc (0 : ℝ) 1)
    (hθpos : 0 < θ)
    (hR : investmentR kx kg μ < (3 / 4 : ℝ)) :
    reducedT1 (reducedL kx kg μ θ) θ < 0 := by
  unfold reducedT1
  exact div_neg_of_neg_of_pos (neg_neg_of_pos hθpos) (reducedDet_pos hθ hR)

end SLGPC
