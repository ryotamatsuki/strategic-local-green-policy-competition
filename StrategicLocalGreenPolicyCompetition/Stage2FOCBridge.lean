import StrategicLocalGreenPolicyCompetition.Stage2PrimitiveBridge
import StrategicLocalGreenPolicyCompetition.Stage2Certificate

noncomputable section

open Set

namespace SLGPC

/-- Own active-duopoly quantity as a function of scalar private cost reduction `u`,
holding the rival's post-investment intercept fixed at `vj`. -/
def duopolyOwnQuantity (θ wi vj u : ℝ) : ℝ :=
  (2 * (wi + u) - θ * vj) / cournotD θ

/-- Own monopoly quantity as a function of scalar private cost reduction. -/
def monopolyOwnQuantity (wi u : ℝ) : ℝ :=
  (wi + u) / 2

/-- Scalar reduced profit on the active-duopoly branch, after dropping the policy-only
constant `s^2/(2kg)`. -/
def duopolyScalarProfit (R θ wi vj u : ℝ) : ℝ :=
  duopolyOwnQuantity θ wi vj u ^ 2 - u ^ 2 / (2 * R)

/-- Scalar reduced profit on the monopoly branch. -/
def monopolyScalarProfit (R wi u : ℝ) : ℝ :=
  monopolyOwnQuantity wi u ^ 2 - u ^ 2 / (2 * R)

/-- Scalar reduced profit while the firm is inactive. -/
def inactiveScalarProfit (R u : ℝ) : ℝ :=
  -u ^ 2 / (2 * R)

/-- Algebraic first-order expression on the active-duopoly scalar branch. -/
def duopolyScalarGradient (R θ wi vj u : ℝ) : ℝ :=
  2 * duopolyOwnQuantity θ wi vj u * (2 / cournotD θ) -
    2 * u / (2 * R)

/-- Algebraic first-order expression on the monopoly scalar branch. -/
def monopolyScalarGradient (R wi u : ℝ) : ℝ :=
  2 * monopolyOwnQuantity wi u * (1 / 2) - 2 * u / (2 * R)

/-- Algebraic first-order expression on the inactive branch. -/
def inactiveScalarGradient (R u : ℝ) : ℝ :=
  -2 * u / (2 * R)

/-- Simplified manuscript form of the active-duopoly scalar FOC. -/
theorem duopolyScalarGradient_eq
    {R θ wi vj u : ℝ} (hR : R ≠ 0) :
    duopolyScalarGradient R θ wi vj u =
      4 * duopolyOwnQuantity θ wi vj u / cournotD θ - u / R := by
  unfold duopolyScalarGradient
  field_simp [hR] <;> ring

/-- Simplified manuscript form of the monopoly scalar FOC. -/
theorem monopolyScalarGradient_eq
    {R wi u : ℝ} (hR : R ≠ 0) :
    monopolyScalarGradient R wi u = monopolyOwnQuantity wi u - u / R := by
  unfold monopolyScalarGradient
  field_simp [hR] <;> ring

/-- Generic quadratic used for exact branch-optimality certificates. -/
def quadraticValue (A B C u : ℝ) : ℝ :=
  A * u ^ 2 + B * u + C

/-- Algebraic derivative of the generic quadratic. -/
def quadraticGradient (A B u : ℝ) : ℝ := 2 * A * u + B

lemma quadratic_global_max_of_stationary
    {A B C u0 u : ℝ}
    (hA : A < 0) (hstat : quadraticGradient A B u0 = 0) :
    quadraticValue A B C u ≤ quadraticValue A B C u0 := by
  unfold quadraticGradient at hstat
  have hB : B = -2 * A * u0 := by linarith
  rw [hB]
  unfold quadraticValue
  have hnonneg : 0 ≤ -A * (u - u0) ^ 2 :=
    mul_nonneg (neg_nonneg.mpr hA.le) (sq_nonneg _)
  nlinarith

lemma quadratic_left_max_of_nonnegative_gradient
    {A B C u0 u : ℝ}
    (hA : A < 0) (hgrad : 0 ≤ quadraticGradient A B u0) (hu : u ≤ u0) :
    quadraticValue A B C u ≤ quadraticValue A B C u0 := by
  unfold quadraticGradient at hgrad
  have hdelta : 0 ≤ u0 - u := sub_nonneg.mpr hu
  have hbracket : 0 ≤ A * (u0 + u) + B := by nlinarith
  have hprod : 0 ≤ (u0 - u) * (A * (u0 + u) + B) :=
    mul_nonneg hdelta hbracket
  unfold quadraticValue
  nlinarith

lemma quadratic_right_max_of_nonpositive_gradient
    {A B C u0 u : ℝ}
    (hA : A < 0) (hgrad : quadraticGradient A B u0 ≤ 0) (hu : u0 ≤ u) :
    quadraticValue A B C u ≤ quadraticValue A B C u0 := by
  unfold quadraticGradient at hgrad
  have hdelta : u0 - u ≤ 0 := sub_nonpos.mpr hu
  have hbracket : A * (u0 + u) + B ≤ 0 := by nlinarith
  have hprod : 0 ≤ (u0 - u) * (A * (u0 + u) + B) :=
    mul_nonneg_of_nonpos_of_nonpos hdelta hbracket
  unfold quadraticValue
  nlinarith

/-- Active-duopoly scalar-profit quadratic coefficients. -/
def duopolyQuadraticA (R θ : ℝ) : ℝ :=
  4 / cournotD θ ^ 2 - 1 / (2 * R)

def duopolyQuadraticB (θ wi vj : ℝ) : ℝ :=
  4 * (2 * wi - θ * vj) / cournotD θ ^ 2

def duopolyQuadraticC (θ wi vj : ℝ) : ℝ :=
  (2 * wi - θ * vj) ^ 2 / cournotD θ ^ 2

/-- Exact quadratic expansion of active-duopoly scalar profit. -/
theorem duopolyScalarProfit_quadratic
    {R θ wi vj u : ℝ} :
    duopolyScalarProfit R θ wi vj u =
      quadraticValue (duopolyQuadraticA R θ)
        (duopolyQuadraticB θ wi vj) (duopolyQuadraticC θ wi vj) u := by
  unfold duopolyScalarProfit duopolyOwnQuantity quadraticValue
    duopolyQuadraticA duopolyQuadraticB duopolyQuadraticC
  ring

/-- The displayed active-duopoly first-order expression is exactly the formal
quadratic derivative `2 A u + B`. -/
theorem duopolyScalarGradient_quadratic
    {R θ wi vj u : ℝ} :
    duopolyScalarGradient R θ wi vj u =
      quadraticGradient (duopolyQuadraticA R θ) (duopolyQuadraticB θ wi vj) u := by
  unfold duopolyScalarGradient duopolyOwnQuantity quadraticGradient
    duopolyQuadraticA duopolyQuadraticB
  ring

/-- Monopoly scalar-profit quadratic coefficients. -/
def monopolyQuadraticA (R : ℝ) : ℝ := 1 / 4 - 1 / (2 * R)
def monopolyQuadraticB (wi : ℝ) : ℝ := wi / 2
def monopolyQuadraticC (wi : ℝ) : ℝ := wi ^ 2 / 4

/-- Exact quadratic expansion of monopoly scalar profit. -/
theorem monopolyScalarProfit_quadratic
    {R wi u : ℝ} :
    monopolyScalarProfit R wi u =
      quadraticValue (monopolyQuadraticA R)
        (monopolyQuadraticB wi) (monopolyQuadraticC wi) u := by
  unfold monopolyScalarProfit monopolyOwnQuantity quadraticValue
    monopolyQuadraticA monopolyQuadraticB monopolyQuadraticC
  ring

/-- The displayed monopoly first-order expression is exactly the formal quadratic
derivative `2 A u + B`. -/
theorem monopolyScalarGradient_quadratic
    {R wi u : ℝ} :
    monopolyScalarGradient R wi u =
      quadraticGradient (monopolyQuadraticA R) (monopolyQuadraticB wi) u := by
  unfold monopolyScalarGradient monopolyOwnQuantity quadraticGradient
    monopolyQuadraticA monopolyQuadraticB
  ring

/-- Maintained firm-stage regularity makes active-duopoly scalar profit strictly concave. -/
theorem model_duopolyQuadraticA_neg
    {kx kg μ θ : ℝ}
    (hkx : 0 < kx) (hkg : 0 < kg)
    (hθ : θ ∈ Icc (0 : ℝ) 1)
    (hR : investmentR kx kg μ < (3 / 4 : ℝ)) :
    duopolyQuadraticA (investmentR kx kg μ) θ < 0 := by
  have hRpos : 0 < investmentR kx kg μ := investmentR_pos hkx hkg
  have hDpos : 0 < cournotD θ := cournotD_pos hθ
  have hDge : 3 ≤ cournotD θ := cournotD_ge_three hθ
  have hDsq : 8 * investmentR kx kg μ < cournotD θ ^ 2 := by
    nlinarith [sq_nonneg (cournotD θ - 3)]
  unfold duopolyQuadraticA
  rw [sub_lt_zero]
  rw [div_lt_div_iff₀ (sq_pos_of_pos hDpos) (mul_pos (by norm_num) hRpos)]
  nlinarith

/-- Maintained firm-stage regularity makes monopoly scalar profit strictly concave. -/
theorem model_monopolyQuadraticA_neg
    {kx kg μ : ℝ}
    (hkx : 0 < kx) (hkg : 0 < kg)
    (hR : investmentR kx kg μ < (3 / 4 : ℝ)) :
    monopolyQuadraticA (investmentR kx kg μ) < 0 := by
  have hRpos : 0 < investmentR kx kg μ := investmentR_pos hkx hkg
  unfold monopolyQuadraticA
  rw [sub_lt_zero]
  rw [div_lt_div_iff₀ (by norm_num : (0 : ℝ) < 4)
      (mul_pos (by norm_num) hRpos)]
  nlinarith

/-- A zero active-duopoly FOC is a global maximum of that concave branch. -/
theorem duopoly_branch_max_of_foc
    {kx kg μ θ wi vj u0 u : ℝ}
    (hkx : 0 < kx) (hkg : 0 < kg)
    (hθ : θ ∈ Icc (0 : ℝ) 1)
    (hR : investmentR kx kg μ < (3 / 4 : ℝ))
    (hfoc : duopolyScalarGradient (investmentR kx kg μ) θ wi vj u0 = 0) :
    duopolyScalarProfit (investmentR kx kg μ) θ wi vj u ≤
      duopolyScalarProfit (investmentR kx kg μ) θ wi vj u0 := by
  rw [duopolyScalarProfit_quadratic, duopolyScalarProfit_quadratic]
  apply quadratic_global_max_of_stationary (model_duopolyQuadraticA_neg hkx hkg hθ hR)
  rw [← duopolyScalarGradient_quadratic]
  exact hfoc

/-- A zero monopoly FOC is a global maximum of that concave branch. -/
theorem monopoly_branch_max_of_foc
    {kx kg μ wi u0 u : ℝ}
    (hkx : 0 < kx) (hkg : 0 < kg)
    (hR : investmentR kx kg μ < (3 / 4 : ℝ))
    (hfoc : monopolyScalarGradient (investmentR kx kg μ) wi u0 = 0) :
    monopolyScalarProfit (investmentR kx kg μ) wi u ≤
      monopolyScalarProfit (investmentR kx kg μ) wi u0 := by
  rw [monopolyScalarProfit_quadratic, monopolyScalarProfit_quadratic]
  apply quadratic_global_max_of_stationary (model_monopolyQuadraticA_neg hkx hkg hR)
  rw [← monopolyScalarGradient_quadratic]
  exact hfoc

/-- The Phase-4 A-monopoly continuation satisfies the scalar monopoly FOC. -/
theorem model_aMonopoly_scalar_foc
    {kx kg μ θ wA wB : ℝ}
    (hkx : 0 < kx) (hkg : 0 < kg)
    (_hθ : θ ∈ Icc (0 : ℝ) 1)
    (_hR : investmentR kx kg μ < (3 / 4 : ℝ)) :
    monopolyScalarGradient (investmentR kx kg μ) wA
      (aMonopolyContinuation (investmentR kx kg μ) wA).uA = 0 := by
  have hRpos : 0 < investmentR kx kg μ := investmentR_pos hkx hkg
  rw [monopolyScalarGradient_eq hRpos.ne']
  simp only [monopolyOwnQuantity, aMonopolyContinuation]
  field_simp [hRpos.ne'] <;> ring

/-- Symmetric B-monopoly scalar FOC. -/
theorem model_bMonopoly_scalar_foc
    {kx kg μ θ wA wB : ℝ}
    (hkx : 0 < kx) (hkg : 0 < kg)
    (_hθ : θ ∈ Icc (0 : ℝ) 1)
    (_hR : investmentR kx kg μ < (3 / 4 : ℝ)) :
    monopolyScalarGradient (investmentR kx kg μ) wB
      (bMonopolyContinuation (investmentR kx kg μ) wB).uB = 0 := by
  have hRpos : 0 < investmentR kx kg μ := investmentR_pos hkx hkg
  rw [monopolyScalarGradient_eq hRpos.ne']
  simp only [monopolyOwnQuantity, bMonopolyContinuation]
  field_simp [hRpos.ne'] <;> ring

/-- Both active-duopoly components of the Phase-4 continuation satisfy their scalar FOCs. -/
theorem model_duopoly_scalar_focs
    {kx kg μ θ wA wB : ℝ}
    (hkx : 0 < kx) (hkg : 0 < kg)
    (hθ : θ ∈ Icc (0 : ℝ) 1)
    (hR : investmentR kx kg μ < (3 / 4 : ℝ)) :
    let L := reducedL kx kg μ θ
    let z := duopolyContinuation L θ wA wB
    duopolyScalarGradient (investmentR kx kg μ) θ wA (wB + z.uB) z.uA = 0 ∧
    duopolyScalarGradient (investmentR kx kg μ) θ wB (wA + z.uA) z.uB = 0 := by
  dsimp
  let R := investmentR kx kg μ
  let L := reducedL kx kg μ θ
  let z := duopolyContinuation L θ wA wB
  have hRpos : 0 < R := by dsimp [R]; exact investmentR_pos hkx hkg
  have hDpos : 0 < cournotD θ := cournotD_pos hθ
  have hdet : L ^ 2 - θ ^ 2 ≠ 0 := by
    dsimp [L]
    exact (reducedDet_pos hθ hR).ne'
  have hstage := duopoly_stage3_identities
    (L := L) (θ := θ) (wA := wA) (wB := wB) hdet
  have hcournot := cournot_active_solution hθ hstage.1.symm hstage.2.symm
  have hfeedbackA : z.uA = 4 * R * z.qA / cournotD θ := by
    dsimp [z, duopolyContinuation, L, reducedL, investmentLambda, R]
    ring
  have hfeedbackB : z.uB = 4 * R * z.qB / cournotD θ := by
    dsimp [z, duopolyContinuation, L, reducedL, investmentLambda, R]
    ring
  constructor
  · have hq : duopolyOwnQuantity θ wA (wB + z.uB) z.uA = z.qA := by
      unfold duopolyOwnQuantity
      exact hcournot.1.symm
    rw [duopolyScalarGradient_eq hRpos.ne', hq, hfeedbackA]
    field_simp [hRpos.ne', hDpos.ne'] <;> ring
  · have hq : duopolyOwnQuantity θ wB (wA + z.uA) z.uB = z.qB := by
      unfold duopolyOwnQuantity
      exact hcournot.2.symm
    rw [duopolyScalarGradient_eq hRpos.ne', hq, hfeedbackB]
    field_simp [hRpos.ne', hDpos.ne'] <;> ring

/-- Generic kink identity for the duopoly-side derivative after clearing denominators. -/
theorem kink_duopoly_gradient_scaled
    {R θ wi wj : ℝ}
    (hR : R ≠ 0) (hθ : θ ≠ 0) (hD : cournotD θ ≠ 0) :
    R * θ * cournotD θ *
        duopolyScalarGradient R θ wi wj (2 * wj / θ - wi) =
      cournotD θ *
        (θ * wi - (2 - 4 * R / cournotD θ) * wj) := by
  rw [duopolyScalarGradient_eq hR]
  unfold duopolyOwnQuantity cournotD
  field_simp [hR, hθ, hD] <;> ring

/-- Generic kink identity for the monopoly-side derivative after clearing denominators. -/
theorem kink_monopoly_gradient_scaled
    {R θ wi wj : ℝ}
    (hR : R ≠ 0) (hθ : θ ≠ 0) :
    R * θ * monopolyScalarGradient R wi (2 * wj / θ - wi) =
      θ * wi - (2 - R) * wj := by
  rw [monopolyScalarGradient_eq hR]
  unfold monopolyOwnQuantity
  field_simp [hR, hθ] <;> ring

/-- At an A-kink candidate the left derivative is nonnegative and the right derivative
is nonpositive: the one-sided KKT conditions are exactly the Phase-4 kink inequalities. -/
theorem model_aKink_one_sided_kkt
    {kx kg μ θ wA wB : ℝ}
    (hkx : 0 < kx) (hkg : 0 < kg)
    (hθ : θ ∈ Icc (0 : ℝ) 1) (hθpos : 0 < θ)
    (hR : investmentR kx kg μ < (3 / 4 : ℝ))
    (hAK : aKinkRegion (investmentR kx kg μ) (reducedL kx kg μ θ) θ wA wB) :
    0 ≤ duopolyScalarGradient (investmentR kx kg μ) θ wA wB
      (aKinkContinuation θ wA wB).uA ∧
    monopolyScalarGradient (investmentR kx kg μ) wA
      (aKinkContinuation θ wA wB).uA ≤ 0 := by
  let R := investmentR kx kg μ
  have hRpos : 0 < R := by dsimp [R]; exact investmentR_pos hkx hkg
  have hDpos : 0 < cournotD θ := cournotD_pos hθ
  have hlow : (2 - 4 * R / cournotD θ) * wB ≤ θ * wA := by
    simpa [R, reducedL, investmentLambda] using hAK.1
  have hupp : θ * wA < (2 - R) * wB := by
    simpa [R, aKinkRegion, monopolyM] using hAK.2
  have hleft := kink_duopoly_gradient_scaled
    (R := R) (θ := θ) (wi := wA) (wj := wB)
    hRpos.ne' hθpos.ne' hDpos.ne'
  have hright := kink_monopoly_gradient_scaled
    (R := R) (θ := θ) (wi := wA) (wj := wB) hRpos.ne' hθpos.ne'
  change 0 ≤ duopolyScalarGradient R θ wA wB (2 * wB / θ - wA) ∧
    monopolyScalarGradient R wA (2 * wB / θ - wA) ≤ 0
  constructor
  · have hrhs : 0 ≤ cournotD θ *
        (θ * wA - (2 - 4 * R / cournotD θ) * wB) :=
      mul_nonneg hDpos.le (sub_nonneg.mpr hlow)
    have hmult : 0 < R * θ * cournotD θ := mul_pos (mul_pos hRpos hθpos) hDpos
    nlinarith
  · have hmult : 0 < R * θ := mul_pos hRpos hθpos
    nlinarith

/-- Symmetric B-kink one-sided KKT certificate. -/
theorem model_bKink_one_sided_kkt
    {kx kg μ θ wA wB : ℝ}
    (hkx : 0 < kx) (hkg : 0 < kg)
    (hθ : θ ∈ Icc (0 : ℝ) 1) (hθpos : 0 < θ)
    (hR : investmentR kx kg μ < (3 / 4 : ℝ))
    (hBK : bKinkRegion (investmentR kx kg μ) (reducedL kx kg μ θ) θ wA wB) :
    0 ≤ duopolyScalarGradient (investmentR kx kg μ) θ wB wA
      (bKinkContinuation θ wA wB).uB ∧
    monopolyScalarGradient (investmentR kx kg μ) wB
      (bKinkContinuation θ wA wB).uB ≤ 0 := by
  let R := investmentR kx kg μ
  have hRpos : 0 < R := by dsimp [R]; exact investmentR_pos hkx hkg
  have hDpos : 0 < cournotD θ := cournotD_pos hθ
  have hlow : (2 - 4 * R / cournotD θ) * wA ≤ θ * wB := by
    simpa [R, reducedL, investmentLambda] using hBK.1
  have hupp : θ * wB < (2 - R) * wA := by
    simpa [R, bKinkRegion, monopolyM] using hBK.2
  have hleft := kink_duopoly_gradient_scaled
    (R := R) (θ := θ) (wi := wB) (wj := wA)
    hRpos.ne' hθpos.ne' hDpos.ne'
  have hright := kink_monopoly_gradient_scaled
    (R := R) (θ := θ) (wi := wB) (wj := wA) hRpos.ne' hθpos.ne'
  change 0 ≤ duopolyScalarGradient R θ wB wA (2 * wA / θ - wB) ∧
    monopolyScalarGradient R wB (2 * wA / θ - wB) ≤ 0
  constructor
  · have hrhs : 0 ≤ cournotD θ *
        (θ * wB - (2 - 4 * R / cournotD θ) * wA) :=
      mul_nonneg hDpos.le (sub_nonneg.mpr hlow)
    have hmult : 0 < R * θ * cournotD θ := mul_pos (mul_pos hRpos hθpos) hDpos
    nlinarith
  · have hmult : 0 < R * θ := mul_pos hRpos hθpos
    nlinarith

/-- The A-kink candidate maximizes the duopoly-side quadratic over scalar choices
weakly to the left of the kink. -/
theorem model_aKink_left_branch_max
    {kx kg μ θ wA wB u : ℝ}
    (hkx : 0 < kx) (hkg : 0 < kg)
    (hθ : θ ∈ Icc (0 : ℝ) 1) (hθpos : 0 < θ)
    (hR : investmentR kx kg μ < (3 / 4 : ℝ))
    (hAK : aKinkRegion (investmentR kx kg μ) (reducedL kx kg μ θ) θ wA wB)
    (hu : u ≤ (aKinkContinuation θ wA wB).uA) :
    duopolyScalarProfit (investmentR kx kg μ) θ wA wB u ≤
      duopolyScalarProfit (investmentR kx kg μ) θ wA wB
        (aKinkContinuation θ wA wB).uA := by
  rw [duopolyScalarProfit_quadratic, duopolyScalarProfit_quadratic]
  apply quadratic_left_max_of_nonnegative_gradient
    (model_duopolyQuadraticA_neg hkx hkg hθ hR)
  · rw [← duopolyScalarGradient_quadratic]
    exact (model_aKink_one_sided_kkt hkx hkg hθ hθpos hR hAK).1
  · exact hu

/-- The A-kink candidate maximizes the monopoly-side quadratic over scalar choices
weakly to the right of the kink. -/
theorem model_aKink_right_branch_max
    {kx kg μ θ wA wB u : ℝ}
    (hkx : 0 < kx) (hkg : 0 < kg)
    (hθ : θ ∈ Icc (0 : ℝ) 1) (hθpos : 0 < θ)
    (hR : investmentR kx kg μ < (3 / 4 : ℝ))
    (hAK : aKinkRegion (investmentR kx kg μ) (reducedL kx kg μ θ) θ wA wB)
    (hu : (aKinkContinuation θ wA wB).uA ≤ u) :
    monopolyScalarProfit (investmentR kx kg μ) wA u ≤
      monopolyScalarProfit (investmentR kx kg μ) wA
        (aKinkContinuation θ wA wB).uA := by
  rw [monopolyScalarProfit_quadratic, monopolyScalarProfit_quadratic]
  apply quadratic_right_max_of_nonpositive_gradient
    (model_monopolyQuadraticA_neg hkx hkg hR)
  · rw [← monopolyScalarGradient_quadratic]
    exact (model_aKink_one_sided_kkt hkx hkg hθ hθpos hR hAK).2
  · exact hu

/-- Symmetric duopoly-side branch maximum at the B kink. -/
theorem model_bKink_left_branch_max
    {kx kg μ θ wA wB u : ℝ}
    (hkx : 0 < kx) (hkg : 0 < kg)
    (hθ : θ ∈ Icc (0 : ℝ) 1) (hθpos : 0 < θ)
    (hR : investmentR kx kg μ < (3 / 4 : ℝ))
    (hBK : bKinkRegion (investmentR kx kg μ) (reducedL kx kg μ θ) θ wA wB)
    (hu : u ≤ (bKinkContinuation θ wA wB).uB) :
    duopolyScalarProfit (investmentR kx kg μ) θ wB wA u ≤
      duopolyScalarProfit (investmentR kx kg μ) θ wB wA
        (bKinkContinuation θ wA wB).uB := by
  rw [duopolyScalarProfit_quadratic, duopolyScalarProfit_quadratic]
  apply quadratic_left_max_of_nonnegative_gradient
    (model_duopolyQuadraticA_neg hkx hkg hθ hR)
  · rw [← duopolyScalarGradient_quadratic]
    exact (model_bKink_one_sided_kkt hkx hkg hθ hθpos hR hBK).1
  · exact hu

/-- Symmetric monopoly-side branch maximum at the B kink. -/
theorem model_bKink_right_branch_max
    {kx kg μ θ wA wB u : ℝ}
    (hkx : 0 < kx) (hkg : 0 < kg)
    (hθ : θ ∈ Icc (0 : ℝ) 1) (hθpos : 0 < θ)
    (hR : investmentR kx kg μ < (3 / 4 : ℝ))
    (hBK : bKinkRegion (investmentR kx kg μ) (reducedL kx kg μ θ) θ wA wB)
    (hu : (bKinkContinuation θ wA wB).uB ≤ u) :
    monopolyScalarProfit (investmentR kx kg μ) wB u ≤
      monopolyScalarProfit (investmentR kx kg μ) wB
        (bKinkContinuation θ wA wB).uB := by
  rw [monopolyScalarProfit_quadratic, monopolyScalarProfit_quadratic]
  apply quadratic_right_max_of_nonpositive_gradient
    (model_monopolyQuadraticA_neg hkx hkg hR)
  · rw [← monopolyScalarGradient_quadratic]
    exact (model_bKink_one_sided_kkt hkx hkg hθ hθpos hR hBK).2
  · exact hu

/-- With positive `R`, the inactive branch is maximized at zero over nonnegative scalar choices. -/
theorem inactive_branch_max_at_zero
    {R u : ℝ} (hR : 0 < R) (_hu : 0 ≤ u) :
    inactiveScalarProfit R u ≤ inactiveScalarProfit R 0 := by
  have hden : 0 < 2 * R := mul_pos (by norm_num) hR
  unfold inactiveScalarProfit
  norm_num
  exact div_nonpos_of_nonpos_of_nonneg (neg_nonpos.mpr (sq_nonneg u)) hden.le

/-- Conditional on a common scalar reduction `u` and the same active Stage-3 quantity,
the Phase-4 cost-minimizing `(x,g)` composition weakly dominates every primitive
investment composition implementing that `u`. -/
theorem primitive_scalar_candidate_dominates_same_u
    {a c kx kg μ ν s h θ qi qj u x g : ℝ}
    (hkx : 0 < kx) (hkg : 0 < kg)
    (hfeas : scalarU kg μ s x g = u)
    (hCournot :
      2 * qi + θ * qj = a - primitiveMarginalCost c μ ν x g h) :
    primitiveFirmProfit a c kx kg μ ν s h θ qi qj x g ≤
      primitiveFirmProfit a c kx kg μ ν s h θ qi qj
        (scalarX kx (investmentR kx kg μ) u)
        (scalarGreen kg μ (investmentR kx kg μ) s u) := by
  have hactualI := primitive_intercept_eq_reducedW_add_scalarU
    (a := a) (c := c) (kg := kg) (μ := μ) (ν := ν)
    (s := s) (h := h) (x := x) (g := g) hkg.ne'
  rw [hfeas] at hactualI
  have hcandI := scalar_candidate_intercept
    (a := a) (c := c) (kx := kx) (kg := kg) (μ := μ) (ν := ν)
    (s := s) (h := h) (u := u) hkx hkg
  have hcandCournot :
      2 * qi + θ * qj =
        a - primitiveMarginalCost c μ ν
          (scalarX kx (investmentR kx kg μ) u)
          (scalarGreen kg μ (investmentR kx kg μ) s u) h := by
    linarith
  rw [primitive_profit_active_reduction hCournot,
      primitive_profit_active_reduction hcandCournot]
  have hcost := scalar_composition_minimizes_net_cost
    (kx := kx) (kg := kg) (μ := μ) (s := s) (u := u)
    (x := x) (g := g) hkx hkg hfeas
  linarith

end SLGPC
