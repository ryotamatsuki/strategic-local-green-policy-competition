import StrategicLocalGreenPolicyCompetition.Stage2PrimitiveBridge
import StrategicLocalGreenPolicyCompetition.Stage2Certificate

noncomputable section

open Set

namespace SLGPC

/-- Own active-duopoly quantity as a function of the firm's scalar investment `u`,
holding the rival's post-investment intercept fixed at `vj`. -/
def duopolyOwnQuantity (θ wi vj u : ℝ) : ℝ :=
  (2 * (wi + u) - θ * vj) / cournotD θ

/-- Own monopoly quantity as a function of scalar investment. -/
def monopolyOwnQuantity (wi u : ℝ) : ℝ :=
  (wi + u) / 2

/-- Scalar reduced profit on the active-duopoly branch, after dropping the
policy-dependent constant `s^2/(2kg)`. -/
def duopolyScalarProfit (R θ wi vj u : ℝ) : ℝ :=
  duopolyOwnQuantity θ wi vj u ^ 2 - u ^ 2 / (2 * R)

/-- Scalar reduced profit on the monopoly branch. -/
def monopolyScalarProfit (R wi u : ℝ) : ℝ :=
  monopolyOwnQuantity wi u ^ 2 - u ^ 2 / (2 * R)

/-- Scalar reduced profit while the firm is inactive. -/
def inactiveScalarProfit (R u : ℝ) : ℝ :=
  -u ^ 2 / (2 * R)

/-- Derivative expression generated mechanically from the active-duopoly scalar
profit. It is kept in product-rule form so the calculus certificate is transparent. -/
def duopolyScalarGradient (R θ wi vj u : ℝ) : ℝ :=
  2 * duopolyOwnQuantity θ wi vj u * (2 / cournotD θ) -
    2 * u / (2 * R)

/-- Derivative expression on the monopoly branch. -/
def monopolyScalarGradient (R wi u : ℝ) : ℝ :=
  2 * monopolyOwnQuantity wi u * (1 / 2) - 2 * u / (2 * R)

/-- Derivative expression on the inactive branch. -/
def inactiveScalarGradient (R u : ℝ) : ℝ :=
  -2 * u / (2 * R)

/-- Calculus bridge: the displayed active-duopoly scalar gradient is the actual
derivative of the reduced profit function. -/
theorem duopolyScalarProfit_hasDerivAt
    {R θ wi vj u : ℝ} :
    HasDerivAt (fun t => duopolyScalarProfit R θ wi vj t)
      (duopolyScalarGradient R θ wi vj u) u := by
  unfold duopolyScalarProfit duopolyScalarGradient duopolyOwnQuantity
  fun_prop

/-- Calculus bridge for the monopoly branch. -/
theorem monopolyScalarProfit_hasDerivAt
    {R wi u : ℝ} :
    HasDerivAt (fun t => monopolyScalarProfit R wi t)
      (monopolyScalarGradient R wi u) u := by
  unfold monopolyScalarProfit monopolyScalarGradient monopolyOwnQuantity
  fun_prop

/-- Calculus bridge for the inactive branch. -/
theorem inactiveScalarProfit_hasDerivAt
    {R u : ℝ} :
    HasDerivAt (fun t => inactiveScalarProfit R t)
      (inactiveScalarGradient R u) u := by
  unfold inactiveScalarProfit inactiveScalarGradient
  fun_prop

/-- Simplified manuscript form of the active-duopoly scalar FOC. -/
theorem duopolyScalarGradient_eq
    {R θ wi vj u : ℝ} (hR : R ≠ 0) :
    duopolyScalarGradient R θ wi vj u =
      4 * duopolyOwnQuantity θ wi vj u / cournotD θ - u / R := by
  unfold duopolyScalarGradient
  field_simp [hR]
  ring

/-- Simplified manuscript form of the monopoly scalar FOC. -/
theorem monopolyScalarGradient_eq
    {R wi u : ℝ} (hR : R ≠ 0) :
    monopolyScalarGradient R wi u = monopolyOwnQuantity wi u - u / R := by
  unfold monopolyScalarGradient
  field_simp [hR]
  ring

/-- Generic quadratic used to turn FOC plus negative curvature into a global
branch-optimality certificate. -/
def quadraticValue (A B C u : ℝ) : ℝ :=
  A * u ^ 2 + B * u + C

lemma quadratic_global_max_of_stationary
    {A B C u0 u : ℝ}
    (hA : A < 0) (hstat : 2 * A * u0 + B = 0) :
    quadraticValue A B C u ≤ quadraticValue A B C u0 := by
  unfold quadraticValue
  nlinarith [sq_nonneg (u - u0)]

lemma quadratic_left_max_of_nonnegative_gradient
    {A B C u0 u : ℝ}
    (hA : A < 0) (hgrad : 0 ≤ 2 * A * u0 + B) (hu : u ≤ u0) :
    quadraticValue A B C u ≤ quadraticValue A B C u0 := by
  have hdelta : 0 ≤ u0 - u := sub_nonneg.mpr hu
  have hbracket : 0 ≤ A * (u0 + u) + B := by nlinarith
  have hprod : 0 ≤ (u0 - u) * (A * (u0 + u) + B) :=
    mul_nonneg hdelta hbracket
  unfold quadraticValue
  nlinarith

lemma quadratic_right_max_of_nonpositive_gradient
    {A B C u0 u : ℝ}
    (hA : A < 0) (hgrad : 2 * A * u0 + B ≤ 0) (hu : u0 ≤ u) :
    quadraticValue A B C u ≤ quadraticValue A B C u0 := by
  have hdelta : u0 - u ≤ 0 := sub_nonpos.mpr hu
  have hbracket : A * (u0 + u) + B ≤ 0 := by nlinarith
  have hprod : 0 ≤ (u0 - u) * (A * (u0 + u) + B) :=
    mul_nonneg_of_nonpos_of_nonpos hdelta hbracket
  unfold quadraticValue
  nlinarith

/-- Leading quadratic coefficient on the active-duopoly scalar branch. -/
def duopolyQuadraticA (R θ : ℝ) : ℝ :=
  4 / cournotD θ ^ 2 - 1 / (2 * R)

/-- Linear coefficient on the active-duopoly scalar branch. -/
def duopolyQuadraticB (θ wi vj : ℝ) : ℝ :=
  4 * (2 * wi - θ * vj) / cournotD θ ^ 2

/-- Constant coefficient on the active-duopoly scalar branch. -/
def duopolyQuadraticC (θ wi vj : ℝ) : ℝ :=
  (2 * wi - θ * vj) ^ 2 / cournotD θ ^ 2

/-- Exact quadratic expansion of the active-duopoly scalar profit. -/
theorem duopolyScalarProfit_quadratic
    {R θ wi vj u : ℝ} :
    duopolyScalarProfit R θ wi vj u =
      quadraticValue (duopolyQuadraticA R θ)
        (duopolyQuadraticB θ wi vj) (duopolyQuadraticC θ wi vj) u := by
  unfold duopolyScalarProfit duopolyOwnQuantity quadraticValue
    duopolyQuadraticA duopolyQuadraticB duopolyQuadraticC
  ring

/-- The calculus gradient is exactly the derivative of the quadratic expansion. -/
theorem duopolyScalarGradient_quadratic
    {R θ wi vj u : ℝ} :
    duopolyScalarGradient R θ wi vj u =
      2 * duopolyQuadraticA R θ * u + duopolyQuadraticB θ wi vj := by
  unfold duopolyScalarGradient duopolyOwnQuantity
    duopolyQuadraticA duopolyQuadraticB
  ring

/-- Monopoly-branch quadratic coefficients. -/
def monopolyQuadraticA (R : ℝ) : ℝ := 1 / 4 - 1 / (2 * R)
def monopolyQuadraticB (wi : ℝ) : ℝ := wi / 2
def monopolyQuadraticC (wi : ℝ) : ℝ := wi ^ 2 / 4

/-- Exact quadratic expansion of the monopoly scalar profit. -/
theorem monopolyScalarProfit_quadratic
    {R wi u : ℝ} :
    monopolyScalarProfit R wi u =
      quadraticValue (monopolyQuadraticA R)
        (monopolyQuadraticB wi) (monopolyQuadraticC wi) u := by
  unfold monopolyScalarProfit monopolyOwnQuantity quadraticValue
    monopolyQuadraticA monopolyQuadraticB monopolyQuadraticC
  ring

/-- Monopoly gradient equals the derivative of its quadratic expansion. -/
theorem monopolyScalarGradient_quadratic
    {R wi u : ℝ} :
    monopolyScalarGradient R wi u =
      2 * monopolyQuadraticA R * u + monopolyQuadraticB wi := by
  unfold monopolyScalarGradient monopolyOwnQuantity monopolyQuadraticA monopolyQuadraticB
  ring

/-- Maintained firm-stage regularity makes the active-duopoly scalar objective
strictly concave. -/
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

/-- Maintained regularity also makes the monopoly scalar objective strictly concave. -/
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

/-- A zero active-duopoly scalar gradient therefore gives the unique branch
maximizer in value terms. -/
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

/-- A zero monopoly scalar gradient gives the monopoly-branch global maximizer. -/
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

/-- The Phase-4 A-monopoly continuation satisfies the primitive scalar monopoly FOC. -/
theorem model_aMonopoly_scalar_foc
    {kx kg μ θ wA wB : ℝ}
    (hkx : 0 < kx) (hkg : 0 < kg)
    (hθ : θ ∈ Icc (0 : ℝ) 1)
    (hR : investmentR kx kg μ < (3 / 4 : ℝ)) :
    monopolyScalarGradient (investmentR kx kg μ) wA
      (aMonopolyContinuation (investmentR kx kg μ) wA).uA = 0 := by
  let R := investmentR kx kg μ
  have hRpos : 0 < R := by dsimp [R]; exact investmentR_pos hkx hkg
  have hMpos : 0 < monopolyM R := by
    dsimp [R]
    exact monopolyM_pos hθ hR
  have hstage := aMonopoly_stage3_identity (R := R) (wA := wA) hMpos.ne'
  have hq : monopolyOwnQuantity wA (aMonopolyContinuation R wA).uA =
      (aMonopolyContinuation R wA).qA := by
    unfold monopolyOwnQuantity
    linarith
  rw [monopolyScalarGradient_eq hRpos.ne', hq]
  simp [aMonopolyContinuation]

/-- Symmetric B-monopoly scalar FOC. -/
theorem model_bMonopoly_scalar_foc
    {kx kg μ θ wA wB : ℝ}
    (hkx : 0 < kx) (hkg : 0 < kg)
    (hθ : θ ∈ Icc (0 : ℝ) 1)
    (hR : investmentR kx kg μ < (3 / 4 : ℝ)) :
    monopolyScalarGradient (investmentR kx kg μ) wB
      (bMonopolyContinuation (investmentR kx kg μ) wB).uB = 0 := by
  let R := investmentR kx kg μ
  have hRpos : 0 < R := by dsimp [R]; exact investmentR_pos hkx hkg
  have hMpos : 0 < monopolyM R := by
    dsimp [R]
    exact monopolyM_pos hθ hR
  have hstage := bMonopoly_stage3_identity (R := R) (wB := wB) hMpos.ne'
  have hq : monopolyOwnQuantity wB (bMonopolyContinuation R wB).uB =
      (bMonopolyContinuation R wB).qB := by
    unfold monopolyOwnQuantity
    linarith
  rw [monopolyScalarGradient_eq hRpos.ne', hq]
  simp [bMonopolyContinuation]

/-- Both Phase-4 active-duopoly investments satisfy the scalar FOCs. -/
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
  have hcournot := cournot_active_solution hθ hstage.1 hstage.2
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
    field_simp [hRpos.ne', hDpos.ne']
    ring
  · have hq : duopolyOwnQuantity θ wB (wA + z.uA) z.uB = z.qB := by
      unfold duopolyOwnQuantity
      exact hcournot.2.symm
    rw [duopolyScalarGradient_eq hRpos.ne', hq, hfeedbackB]
    field_simp [hRpos.ne', hDpos.ne']
    ring

/-- At an A-kink candidate the left (duopoly) derivative is nonnegative and the
right (monopoly) derivative is nonpositive. These are exactly the one-sided KKT
conditions encoded by the Phase-4 regime inequalities. -/
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
  have hq : duopolyOwnQuantity θ wA wB (aKinkContinuation θ wA wB).uA = wB / θ := by
    unfold duopolyOwnQuantity aKinkContinuation cournotD
    field_simp [hθpos.ne']
    ring
  have hqm : monopolyOwnQuantity wA (aKinkContinuation θ wA wB).uA = wB / θ := by
    unfold monopolyOwnQuantity aKinkContinuation
    field_simp [hθpos.ne']
    ring
  constructor
  · rw [duopolyScalarGradient_eq hRpos.ne', hq]
    dsimp [aKinkContinuation]
    unfold reducedL investmentLambda at hAK
    have hlow := hAK.1
    dsimp [R] at hlow ⊢
    field_simp [hθpos.ne', hDpos.ne', hRpos.ne'] at hlow ⊢
    nlinarith
  · rw [monopolyScalarGradient_eq hRpos.ne', hqm]
    dsimp [aKinkContinuation]
    have hupp := hAK.2
    unfold aKinkRegion monopolyM at hupp
    dsimp [R] at hupp ⊢
    field_simp [hθpos.ne', hRpos.ne'] at hupp ⊢
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
  have hq : duopolyOwnQuantity θ wB wA (bKinkContinuation θ wA wB).uB = wA / θ := by
    unfold duopolyOwnQuantity bKinkContinuation cournotD
    field_simp [hθpos.ne']
    ring
  have hqm : monopolyOwnQuantity wB (bKinkContinuation θ wA wB).uB = wA / θ := by
    unfold monopolyOwnQuantity bKinkContinuation
    field_simp [hθpos.ne']
    ring
  constructor
  · rw [duopolyScalarGradient_eq hRpos.ne', hq]
    dsimp [bKinkContinuation]
    unfold reducedL investmentLambda at hBK
    have hlow := hBK.1
    dsimp [R] at hlow ⊢
    field_simp [hθpos.ne', hDpos.ne', hRpos.ne'] at hlow ⊢
    nlinarith
  · rw [monopolyScalarGradient_eq hRpos.ne', hqm]
    dsimp [bKinkContinuation]
    have hupp := hBK.2
    unfold bKinkRegion monopolyM at hupp
    dsimp [R] at hupp ⊢
    field_simp [hθpos.ne', hRpos.ne'] at hupp ⊢
    nlinarith

end SLGPC
