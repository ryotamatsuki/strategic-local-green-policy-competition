import StrategicLocalGreenPolicyCompetition.CanonicalQuarticBridge
import StrategicLocalGreenPolicyCompetition.FirmHessian

noncomputable section

open Set

namespace SLGPC

/-- The canonical own-subsidy Hessian numerator written as a polynomial in
`u = theta^2`. -/
def canonicalHssU (u : ℝ) : ℝ :=
  74312500 * u ^ 6 - 1737628125 * u ^ 5 + 16311746125 * u ^ 4 -
    78435270800 * u ^ 3 + 203312608309 * u ^ 2 -
    269043732787 * u + 142288292179

/-- Positive Bernstein representation of `30 * canonicalHssU`. -/
def canonicalHssUBernsteinScaled (u : ℝ) : ℝ :=
  4268648765370 * (1 - u) ^ 6 +
    17540580608610 * u * (1 - u) ^ 5 +
    29772549811770 * u ^ 2 * (1 - u) ^ 4 +
    26704310344380 * u ^ 3 * (1 - u) ^ 3 +
    13343059151820 * u ^ 4 * (1 - u) ^ 2 +
    3520247223000 * u ^ 5 * (1 - u) +
    383109822030 * u ^ 6

lemma canonicalHssU_scaled_eq_bernstein (u : ℝ) :
    30 * canonicalHssU u = canonicalHssUBernsteinScaled u := by
  unfold canonicalHssU canonicalHssUBernsteinScaled
  ring

lemma canonicalHssPoly_eq_u (θ : ℝ) :
    canonicalHssPoly θ = canonicalHssU (θ ^ 2) := by
  unfold canonicalHssPoly canonicalHssU
  ring

/-- The numerator determining the sign of the canonical own-subsidy Hessian
entry is positive throughout the rivalry interval. -/
theorem canonicalHssU_pos {u : ℝ} (hu : u ∈ Icc (0 : ℝ) 1) :
    0 < canonicalHssU u := by
  rcases hu with ⟨hu0, hu1⟩
  by_cases h1 : u = 1
  · subst u
    norm_num [canonicalHssU]
  · have huLt : u < 1 := lt_of_le_of_ne hu1 h1
    have h1u : 0 < 1 - u := by linarith
    have h0 : 0 < 4268648765370 * (1 - u) ^ 6 := by positivity
    have hA : 0 ≤ 17540580608610 * u * (1 - u) ^ 5 := by positivity
    have hB : 0 ≤ 29772549811770 * u ^ 2 * (1 - u) ^ 4 := by positivity
    have hC : 0 ≤ 26704310344380 * u ^ 3 * (1 - u) ^ 3 := by positivity
    have hD : 0 ≤ 13343059151820 * u ^ 4 * (1 - u) ^ 2 := by positivity
    have hE : 0 ≤ 3520247223000 * u ^ 5 * (1 - u) := by positivity
    have hF : 0 ≤ 383109822030 * u ^ 6 := by positivity
    have hscaled : 0 < 30 * canonicalHssU u := by
      rw [canonicalHssU_scaled_eq_bernstein]
      unfold canonicalHssUBernsteinScaled
      nlinarith
    nlinarith

lemma theta_sq_mem_Icc {θ : ℝ} (hθ : θ ∈ Icc (0 : ℝ) 1) :
    θ ^ 2 ∈ Icc (0 : ℝ) 1 := by
  constructor
  · exact sq_nonneg θ
  · nlinarith [mul_nonneg hθ.1 (sub_nonneg.mpr hθ.2)]

/-- Canonical active-duopoly government welfare is strictly concave in its own
subsidy direction. -/
theorem canonicalGovernmentHss_neg
    {θ : ℝ} (hθ : θ ∈ Icc (0 : ℝ) 1) :
    canonicalGovernmentHessianEntry θ .sA .sA < 0 := by
  rw [canonicalHss_closed hθ]
  have hnum : 0 < canonicalHssPoly θ := by
    rw [canonicalHssPoly_eq_u]
    exact canonicalHssU_pos (theta_sq_mem_Icc hθ)
  have hden : 0 < 162 * canonicalSlopeCore θ :=
    mul_pos (by norm_num) (canonicalSlopeCore_pos hθ)
  exact div_neg_of_neg_of_pos (by linarith) hden

/-- The canonical own-policy Hessian determinant is positive on the full rivalry
interval, including the zero-rivalry endpoint. -/
theorem canonicalOwnPolicyDet_pos
    {θ : ℝ} (hθ : θ ∈ Icc (0 : ℝ) 1) :
    0 < canonicalOwnPolicyDet θ := by
  rw [canonicalOwnPolicyDet_closed hθ]
  exact div_pos (witnessDetQ_pos (theta_sq_mem_Icc hθ))
    (mul_pos (by norm_num) (canonicalSlopeCore_pos hθ))

/-- Full negative-definiteness certificate for the canonical government's own
`(s_A,h_A)` Hessian. -/
theorem canonicalGovernmentOwnQuadraticForm_neg
    {θ ds dh : ℝ} (hθ : θ ∈ Icc (0 : ℝ) 1)
    (hdir : ds ≠ 0 ∨ dh ≠ 0) :
    canonicalGovernmentHessianEntry θ .sA .sA * ds ^ 2 +
      2 * canonicalGovernmentHessianEntry θ .sA .hA * ds * dh +
      canonicalGovernmentHessianEntry θ .hA .hA * dh ^ 2 < 0 := by
  apply twoByTwo_quadratic_neg_of_sylvester
  · exact canonicalGovernmentHss_neg hθ
  · simpa [canonicalOwnPolicyDet, ownPolicyDet] using canonicalOwnPolicyDet_pos hθ
  · exact hdir

/-- Exact first directional coefficient of the reduced quadratic government
objective.  Since the objective is quadratic, this is also its directional
derivative, but the definition itself is purely algebraic. -/
def governmentDirectionalGradient
    (θ rho cg kg κ d e β ξ Ebar qA qB sA hA
      aq bq es eh : ℝ) : ℝ :=
  2 * ((1 : ℝ) / 4 + rho) * qA * aq +
    (1 : ℝ) / 2 * qB * bq +
    θ / 2 * (aq * qB + qA * bq) -
    cg * (es * qA + sA * aq) -
    sA / kg * es - κ * hA * eh -
    d * (reducedEmissions e β cg kg ξ qA sA hA - Ebar) *
      reducedEmissionsSlope e β cg kg ξ aq es eh

/-- Directional gradient of the Stage-1 policy objective after inserting the
Phase-3 affine firm continuation. -/
def modelGovernmentGradient
    (kx kg μ ν κ d e β ξ Ebar m L θ : ℝ)
    (z : PolicyProfile) (i : PolicyCoord) : ℝ :=
  governmentDirectionalGradient θ (producerRho kx kg μ θ)
    (interiorChiG kg μ θ) kg κ d e β ξ Ebar
    (interiorPolicyQA m kg μ ν L θ z)
    (interiorPolicyQB m kg μ ν L θ z) z.sA z.hA
    (qASlope kg μ ν L θ i) (qBSlope kg μ ν L θ i)
    (ownSubsidySlope i) (ownInfrastructureSlope i)

/-- A policy shift changes the exact first directional coefficient by the
corresponding Hessian entry times the shift.  This is the algebraic content of
linearizing the government FOC system. -/
theorem modelGovernmentGradient_shift
    {kx kg μ ν κ d e β ξ Ebar m L θ r : ℝ}
    {z : PolicyProfile} (i j : PolicyCoord) :
    modelGovernmentGradient kx kg μ ν κ d e β ξ Ebar m L θ
        (shiftPolicy z j r) i =
      modelGovernmentGradient kx kg μ ν κ d e β ξ Ebar m L θ z i +
        r * modelGovernmentHessianEntry kx kg μ ν κ d e β ξ L θ i j := by
  unfold modelGovernmentGradient modelGovernmentHessianEntry
  rw [interiorPolicyQA_shift, interiorPolicyQB_shift,
      shiftPolicy_sA, shiftPolicy_hA]
  unfold governmentDirectionalGradient governmentHessianEntry
    reducedEmissions reducedEmissionsSlope
  ring

/-- The model-specialized Hessian inherits symmetry from the generic quadratic
government objective. -/
lemma modelGovernmentHessianEntry_symm
    (kx kg μ ν κ d e β ξ L θ : ℝ) (i j : PolicyCoord) :
    modelGovernmentHessianEntry kx kg μ ν κ d e β ξ L θ i j =
      modelGovernmentHessianEntry kx kg μ ν κ d e β ξ L θ j i := by
  unfold modelGovernmentHessianEntry
  exact governmentHessianEntry_symm

/-- Shift only jurisdiction A's two own policy coordinates. -/
def ownPolicyShift (z : PolicyProfile) (ds dh : ℝ) : PolicyProfile :=
  shiftPolicy (shiftPolicy z .sA ds) .hA dh

/-- Exact second-order expansion of the reduced government objective along an
arbitrary own-policy displacement. -/
theorem interiorReducedGovernmentPolicyWelfare_own_shift_expansion
    {kx kg μ ν κ d e β ξ Ebar m L θ ds dh : ℝ}
    {z : PolicyProfile} :
    interiorReducedGovernmentPolicyWelfare kx kg μ ν κ d e β ξ Ebar m L θ
        (ownPolicyShift z ds dh) =
      interiorReducedGovernmentPolicyWelfare kx kg μ ν κ d e β ξ Ebar m L θ z +
        ds * modelGovernmentGradient kx kg μ ν κ d e β ξ Ebar m L θ z .sA +
        dh * modelGovernmentGradient kx kg μ ν κ d e β ξ Ebar m L θ z .hA +
        (1 / 2 : ℝ) *
          (modelGovernmentHessianEntry kx kg μ ν κ d e β ξ L θ .sA .sA * ds ^ 2 +
           2 * modelGovernmentHessianEntry kx kg μ ν κ d e β ξ L θ .sA .hA * ds * dh +
           modelGovernmentHessianEntry kx kg μ ν κ d e β ξ L θ .hA .hA * dh ^ 2) := by
  unfold ownPolicyShift interiorReducedGovernmentPolicyWelfare
  rw [interiorPolicyQA_shift_two, interiorPolicyQB_shift_two,
      shiftPolicy_sA_two, shiftPolicy_hA_two]
  unfold modelGovernmentGradient modelGovernmentHessianEntry
    reducedGovernmentWelfare governmentDirectionalGradient governmentHessianEntry
    reducedEmissions reducedEmissionsSlope
  simp [qASlope, qBSlope, ownSubsidySlope, ownInfrastructureSlope]
  ring

/-- Canonical active-duopoly government objective used in the global witness. -/
def canonicalActiveGovernmentWelfare (θ : ℝ) (z : PolicyProfile) : ℝ :=
  interiorReducedGovernmentPolicyWelfare 4 18 (9 / 10 : ℝ) (6 / 5 : ℝ)
    (4 / 5 : ℝ) 2 (11 / 10 : ℝ) (17 / 10 : ℝ) (1 / 10 : ℝ)
    0 2 (canonicalL θ) θ z

/-- Canonical exact government FOC coefficient. -/
def canonicalActiveGovernmentGradient
    (θ : ℝ) (z : PolicyProfile) (i : PolicyCoord) : ℝ :=
  modelGovernmentGradient 4 18 (9 / 10 : ℝ) (6 / 5 : ℝ)
    (4 / 5 : ℝ) 2 (11 / 10 : ℝ) (17 / 10 : ℝ) (1 / 10 : ℝ)
    0 2 (canonicalL θ) θ z i

lemma canonicalGovernmentHessianEntry_symm
    (θ : ℝ) (i j : PolicyCoord) :
    canonicalGovernmentHessianEntry θ i j =
      canonicalGovernmentHessianEntry θ j i := by
  unfold canonicalGovernmentHessianEntry
  exact modelGovernmentHessianEntry_symm _ _ _ _ _ _ _ _ _ _ _ i j

/-- A zero of both canonical government FOCs is the unique global maximizer of
its active-duopoly quadratic branch over all own policy displacements. -/
theorem canonicalActiveGovernment_strict_best_response
    {θ : ℝ} (hθ : θ ∈ Icc (0 : ℝ) 1) {z : PolicyProfile}
    (hs : canonicalActiveGovernmentGradient θ z .sA = 0)
    (hh : canonicalActiveGovernmentGradient θ z .hA = 0)
    {ds dh : ℝ} (hdir : ds ≠ 0 ∨ dh ≠ 0) :
    canonicalActiveGovernmentWelfare θ (ownPolicyShift z ds dh) <
      canonicalActiveGovernmentWelfare θ z := by
  have hexp :=
    interiorReducedGovernmentPolicyWelfare_own_shift_expansion
      (kx := (4 : ℝ)) (kg := (18 : ℝ)) (μ := (9 / 10 : ℝ))
      (ν := (6 / 5 : ℝ)) (κ := (4 / 5 : ℝ)) (d := (2 : ℝ))
      (e := (11 / 10 : ℝ)) (β := (17 / 10 : ℝ)) (ξ := (1 / 10 : ℝ))
      (Ebar := (0 : ℝ)) (m := (2 : ℝ)) (L := canonicalL θ)
      (θ := θ) (ds := ds) (dh := dh) (z := z)
  have hs' :
      modelGovernmentGradient 4 18 (9 / 10 : ℝ) (6 / 5 : ℝ)
        (4 / 5 : ℝ) 2 (11 / 10 : ℝ) (17 / 10 : ℝ) (1 / 10 : ℝ)
        0 2 (canonicalL θ) θ z .sA = 0 := by
    simpa [canonicalActiveGovernmentGradient] using hs
  have hh' :
      modelGovernmentGradient 4 18 (9 / 10 : ℝ) (6 / 5 : ℝ)
        (4 / 5 : ℝ) 2 (11 / 10 : ℝ) (17 / 10 : ℝ) (1 / 10 : ℝ)
        0 2 (canonicalL θ) θ z .hA = 0 := by
    simpa [canonicalActiveGovernmentGradient] using hh
  have hq := canonicalGovernmentOwnQuadraticForm_neg hθ hdir
  have hq' :
      modelGovernmentHessianEntry 4 18 (9 / 10 : ℝ) (6 / 5 : ℝ)
        (4 / 5 : ℝ) 2 (11 / 10 : ℝ) (17 / 10 : ℝ) (1 / 10 : ℝ)
        (canonicalL θ) θ .sA .sA * ds ^ 2 +
      2 * modelGovernmentHessianEntry 4 18 (9 / 10 : ℝ) (6 / 5 : ℝ)
        (4 / 5 : ℝ) 2 (11 / 10 : ℝ) (17 / 10 : ℝ) (1 / 10 : ℝ)
        (canonicalL θ) θ .sA .hA * ds * dh +
      modelGovernmentHessianEntry 4 18 (9 / 10 : ℝ) (6 / 5 : ℝ)
        (4 / 5 : ℝ) 2 (11 / 10 : ℝ) (17 / 10 : ℝ) (1 / 10 : ℝ)
        (canonicalL θ) θ .hA .hA * dh ^ 2 < 0 := by
    simpa [canonicalGovernmentHessianEntry] using hq
  unfold canonicalActiveGovernmentWelfare
  rw [hexp, hs', hh']
  nlinarith

/-- Weak best-response form, useful when embedding the active branch in a game. -/
theorem canonicalActiveGovernment_best_response
    {θ : ℝ} (hθ : θ ∈ Icc (0 : ℝ) 1) {z : PolicyProfile}
    (hs : canonicalActiveGovernmentGradient θ z .sA = 0)
    (hh : canonicalActiveGovernmentGradient θ z .hA = 0)
    (ds dh : ℝ) :
    canonicalActiveGovernmentWelfare θ (ownPolicyShift z ds dh) ≤
      canonicalActiveGovernmentWelfare θ z := by
  by_cases hdir : ds ≠ 0 ∨ dh ≠ 0
  · exact (canonicalActiveGovernment_strict_best_response hθ hs hh hdir).le
  · have hds : ds = 0 := by
      by_contra hne
      exact hdir (Or.inl hne)
    have hdh : dh = 0 := by
      by_contra hne
      exact hdir (Or.inr hne)
    subst ds
    subst dh
    simp [ownPolicyShift, shiftPolicy]

/-- Own-subsidy response coefficient obtained from the same 2x2 FOC system as
Phase 7's infrastructure response. -/
def canonicalSubsidyResponse (θ : ℝ) : ℝ :=
  (canonicalGovernmentHessianEntry θ .sA .hA *
      canonicalGovernmentHessianEntry θ .hA .sB -
    canonicalGovernmentHessianEntry θ .hA .hA *
      canonicalGovernmentHessianEntry θ .sA .sB) /
    canonicalOwnPolicyDet θ

/-- The two canonical response coefficients solve the differentiated government
FOC system exactly. -/
theorem canonicalResponse_solves_linearized_FOCs
    {θ : ℝ} (hθ : θ ∈ Icc (0 : ℝ) 1) :
    canonicalGovernmentHessianEntry θ .sA .sA * canonicalSubsidyResponse θ +
        canonicalGovernmentHessianEntry θ .sA .hA *
          canonicalInfrastructureResponse θ =
      -canonicalGovernmentHessianEntry θ .sA .sB ∧
    canonicalGovernmentHessianEntry θ .sA .hA * canonicalSubsidyResponse θ +
        canonicalGovernmentHessianEntry θ .hA .hA *
          canonicalInfrastructureResponse θ =
      -canonicalGovernmentHessianEntry θ .hA .sB := by
  have hdet : canonicalOwnPolicyDet θ ≠ 0 :=
    (canonicalOwnPolicyDet_pos hθ).ne'
  have hdet' :
      canonicalGovernmentHessianEntry θ .sA .sA *
          canonicalGovernmentHessianEntry θ .hA .hA -
        canonicalGovernmentHessianEntry θ .sA .hA ^ 2 ≠ 0 := by
    simpa [canonicalOwnPolicyDet, ownPolicyDet] using hdet
  constructor <;>
    unfold canonicalSubsidyResponse canonicalInfrastructureResponse
      canonicalCrossInstrumentNumerator crossInstrumentNumerator
      canonicalOwnPolicyDet ownPolicyDet <;>
    field_simp [hdet'] <;> ring

/-- Actual active-branch best-response path induced by changing the rival subsidy
by `r`, starting from any canonical active FOC point. -/
def canonicalActiveBRPath
    (θ : ℝ) (z : PolicyProfile) (r : ℝ) : PolicyProfile :=
  ownPolicyShift (shiftPolicy z .sB r)
    (r * canonicalSubsidyResponse θ)
    (r * canonicalInfrastructureResponse θ)

/-- Along the canonical path, both exact government FOCs remain zero.  Combined
with strict concavity, this turns the Phase-7 linear-system quotient into the
slope of the actual unique active-branch best response, not merely a formal FOC
solution. -/
theorem canonicalActiveBRPath_FOCs
    {θ : ℝ} (hθ : θ ∈ Icc (0 : ℝ) 1) {z : PolicyProfile}
    (hs : canonicalActiveGovernmentGradient θ z .sA = 0)
    (hh : canonicalActiveGovernmentGradient θ z .hA = 0)
    (r : ℝ) :
    canonicalActiveGovernmentGradient θ (canonicalActiveBRPath θ z r) .sA = 0 ∧
    canonicalActiveGovernmentGradient θ (canonicalActiveBRPath θ z r) .hA = 0 := by
  rcases canonicalResponse_solves_linearized_FOCs hθ with ⟨hrespS, hrespH⟩
  have hs' :
      modelGovernmentGradient 4 18 (9 / 10 : ℝ) (6 / 5 : ℝ)
        (4 / 5 : ℝ) 2 (11 / 10 : ℝ) (17 / 10 : ℝ) (1 / 10 : ℝ)
        0 2 (canonicalL θ) θ z .sA = 0 := by
    simpa [canonicalActiveGovernmentGradient] using hs
  have hh' :
      modelGovernmentGradient 4 18 (9 / 10 : ℝ) (6 / 5 : ℝ)
        (4 / 5 : ℝ) 2 (11 / 10 : ℝ) (17 / 10 : ℝ) (1 / 10 : ℝ)
        0 2 (canonicalL θ) θ z .hA = 0 := by
    simpa [canonicalActiveGovernmentGradient] using hh
  have hrespS' :
      modelGovernmentHessianEntry 4 18 (9 / 10 : ℝ) (6 / 5 : ℝ)
        (4 / 5 : ℝ) 2 (11 / 10 : ℝ) (17 / 10 : ℝ) (1 / 10 : ℝ)
        (canonicalL θ) θ .sA .sA * canonicalSubsidyResponse θ +
      modelGovernmentHessianEntry 4 18 (9 / 10 : ℝ) (6 / 5 : ℝ)
        (4 / 5 : ℝ) 2 (11 / 10 : ℝ) (17 / 10 : ℝ) (1 / 10 : ℝ)
        (canonicalL θ) θ .sA .hA * canonicalInfrastructureResponse θ =
      -modelGovernmentHessianEntry 4 18 (9 / 10 : ℝ) (6 / 5 : ℝ)
        (4 / 5 : ℝ) 2 (11 / 10 : ℝ) (17 / 10 : ℝ) (1 / 10 : ℝ)
        (canonicalL θ) θ .sA .sB := by
    simpa [canonicalGovernmentHessianEntry] using hrespS
  have hrespH' :
      modelGovernmentHessianEntry 4 18 (9 / 10 : ℝ) (6 / 5 : ℝ)
        (4 / 5 : ℝ) 2 (11 / 10 : ℝ) (17 / 10 : ℝ) (1 / 10 : ℝ)
        (canonicalL θ) θ .hA .sA * canonicalSubsidyResponse θ +
      modelGovernmentHessianEntry 4 18 (9 / 10 : ℝ) (6 / 5 : ℝ)
        (4 / 5 : ℝ) 2 (11 / 10 : ℝ) (17 / 10 : ℝ) (1 / 10 : ℝ)
        (canonicalL θ) θ .hA .hA * canonicalInfrastructureResponse θ =
      -modelGovernmentHessianEntry 4 18 (9 / 10 : ℝ) (6 / 5 : ℝ)
        (4 / 5 : ℝ) 2 (11 / 10 : ℝ) (17 / 10 : ℝ) (1 / 10 : ℝ)
        (canonicalL θ) θ .hA .sB := by
    rw [modelGovernmentHessianEntry_symm 4 18 (9 / 10 : ℝ) (6 / 5 : ℝ)
      (4 / 5 : ℝ) 2 (11 / 10 : ℝ) (17 / 10 : ℝ) (1 / 10 : ℝ)
      (canonicalL θ) θ .hA .sA]
    simpa [canonicalGovernmentHessianEntry] using hrespH
  constructor
  · unfold canonicalActiveBRPath ownPolicyShift canonicalActiveGovernmentGradient
    rw [modelGovernmentGradient_shift, modelGovernmentGradient_shift,
        modelGovernmentGradient_shift, hs']
    nlinarith [hrespS']
  · unfold canonicalActiveBRPath ownPolicyShift canonicalActiveGovernmentGradient
    rw [modelGovernmentGradient_shift, modelGovernmentGradient_shift,
        modelGovernmentGradient_shift, hh']
    nlinarith [hrespH']

/-- Every point on the FOC-preserving path is the actual unique maximizer of the
active quadratic branch. -/
theorem canonicalActiveBRPath_is_best_response
    {θ : ℝ} (hθ : θ ∈ Icc (0 : ℝ) 1) {z : PolicyProfile}
    (hs : canonicalActiveGovernmentGradient θ z .sA = 0)
    (hh : canonicalActiveGovernmentGradient θ z .hA = 0)
    (r ds dh : ℝ) :
    canonicalActiveGovernmentWelfare θ
        (ownPolicyShift (canonicalActiveBRPath θ z r) ds dh) ≤
      canonicalActiveGovernmentWelfare θ (canonicalActiveBRPath θ z r) := by
  rcases canonicalActiveBRPath_FOCs hθ hs hh r with ⟨hS, hH⟩
  exact canonicalActiveGovernment_best_response hθ hS hH ds dh

/-- The infrastructure coordinate of the actual active best-response path is
explicitly affine in the rival subsidy perturbation. -/
lemma canonicalActiveBRPath_hA
    (θ : ℝ) (z : PolicyProfile) (r : ℝ) :
    (canonicalActiveBRPath θ z r).hA =
      z.hA + r * canonicalInfrastructureResponse θ := by
  simp [canonicalActiveBRPath, ownPolicyShift, shiftPolicy]

/-- Calculus-level closure of the IFT bridge: the derivative of the actual unique
active-branch best-response path equals the Phase-7 response quotient. -/
theorem canonicalActiveBRPath_hasDerivAt_hA
    (θ : ℝ) (z : PolicyProfile) (r : ℝ) :
    HasDerivAt (fun x => (canonicalActiveBRPath θ z x).hA)
      (canonicalInfrastructureResponse θ) r := by
  have hfun :
      (fun x : ℝ => (canonicalActiveBRPath θ z x).hA) =
        (fun x : ℝ => z.hA + x * canonicalInfrastructureResponse θ) := by
    funext x
    exact canonicalActiveBRPath_hA θ z x
  rw [hfun]
  have hc : HasDerivAt (fun _ : ℝ => z.hA) 0 r := hasDerivAt_const r z.hA
  have hx : HasDerivAt (fun x : ℝ => x * canonicalInfrastructureResponse θ)
      (canonicalInfrastructureResponse θ) r := by
    simpa using (hasDerivAt_id r).mul_const (canonicalInfrastructureResponse θ)
  convert hc.add hx using 1 <;> simp

/-- Combining the actual-best-response derivative bridge with Phase 7 identifies
its derivative with the canonical quartic response on positive rivalry. -/
theorem canonicalActualActiveBRDerivative_eq_thresholdResponse
    {θ : ℝ} (hθ : θ ∈ Ioc (0 : ℝ) 1) (z : PolicyProfile) (r : ℝ) :
    HasDerivAt (fun x => (canonicalActiveBRPath θ z x).hA)
      (-canonicalOmega θ * witnessP (θ ^ 2)) r := by
  rw [← canonicalInfrastructureResponse_eq_thresholdResponse hθ]
  exact canonicalActiveBRPath_hasDerivAt_hA θ z r

end SLGPC
