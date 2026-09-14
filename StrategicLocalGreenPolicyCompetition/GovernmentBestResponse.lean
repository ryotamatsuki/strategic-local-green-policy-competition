import StrategicLocalGreenPolicyCompetition.CanonicalQuarticBridge
import StrategicLocalGreenPolicyCompetition.FirmHessian

noncomputable section

open Set

namespace SLGPC

/-- Polynomial numerator certifying negativity of the canonical own-subsidy
Hessian entry after the positive denominator has been removed. -/
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

lemma theta_sq_mem_Icc {θ : ℝ} (hθ : θ ∈ Icc (0 : ℝ) 1) :
    θ ^ 2 ∈ Icc (0 : ℝ) 1 := by
  constructor
  · exact sq_nonneg θ
  · nlinarith [mul_nonneg hθ.1 (sub_nonneg.mpr hθ.2)]

/-- The canonical own-subsidy Hessian numerator is positive on `[0,1]`. -/
theorem canonicalHssU_pos {u : ℝ} (hu : u ∈ Icc (0 : ℝ) 1) :
    0 < canonicalHssU u := by
  rcases hu with ⟨hu0, hu1⟩
  by_cases h1 : u = 1
  · subst u
    norm_num [canonicalHssU]
  · have huLt : u < 1 := lt_of_le_of_ne hu1 h1
    have hbase : 0 < 1 - u := by linarith
    have h0 : 0 < 4268648765370 * (1 - u) ^ 6 := by positivity
    have h1n : 0 ≤ 17540580608610 * u * (1 - u) ^ 5 := by positivity
    have h2n : 0 ≤ 29772549811770 * u ^ 2 * (1 - u) ^ 4 := by positivity
    have h3n : 0 ≤ 26704310344380 * u ^ 3 * (1 - u) ^ 3 := by positivity
    have h4n : 0 ≤ 13343059151820 * u ^ 4 * (1 - u) ^ 2 := by positivity
    have h5n : 0 ≤ 3520247223000 * u ^ 5 * (1 - u) := by positivity
    have h6n : 0 ≤ 383109822030 * u ^ 6 := by positivity
    have hscaled : 0 < 30 * canonicalHssU u := by
      rw [canonicalHssU_scaled_eq_bernstein]
      unfold canonicalHssUBernsteinScaled
      nlinarith
    nlinarith

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

/-- The canonical own-policy Hessian determinant is positive on `[0,1]`. -/
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
objective. -/
def governmentDirectionalGradient
    (θ rho cg kg κ d e β ξ Ebar qA qB sA hA aq bq es eh : ℝ) : ℝ :=
  2 * ((1 : ℝ) / 4 + rho) * qA * aq +
    (1 : ℝ) / 2 * qB * bq +
    θ / 2 * (aq * qB + qA * bq) -
    cg * (es * qA + sA * aq) -
    sA / kg * es - κ * hA * eh -
    d * (reducedEmissions e β cg kg ξ qA sA hA - Ebar) *
      reducedEmissionsSlope e β cg kg ξ aq es eh

/-- Government directional gradient after inserting the Phase-3 affine firm
continuation. -/
def modelGovernmentGradient
    (kx kg μ ν κ d e β ξ Ebar m L θ : ℝ)
    (z : PolicyProfile) (i : PolicyCoord) : ℝ :=
  governmentDirectionalGradient θ (producerRho kx kg μ θ)
    (interiorChiG kg μ θ) kg κ d e β ξ Ebar
    (interiorPolicyQA m kg μ ν L θ z)
    (interiorPolicyQB m kg μ ν L θ z) z.sA z.hA
    (qASlope kg μ ν L θ i) (qBSlope kg μ ν L θ i)
    (ownSubsidySlope i) (ownInfrastructureSlope i)

/-- Exact affine-gradient/Hessian identity. -/
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

/-- Canonical active-duopoly government objective. -/
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
  have hexp := interiorReducedGovernmentPolicyWelfare_own_shift_expansion
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
  by_cases hds : ds = 0
  · by_cases hdh : dh = 0
    · subst ds
      subst dh
      simp [ownPolicyShift, shiftPolicy]
    · exact (canonicalActiveGovernment_strict_best_response hθ hs hh (Or.inr hdh)).le
  · exact (canonicalActiveGovernment_strict_best_response hθ hs hh (Or.inl hds)).le

/-- Own-subsidy response coefficient from the same 2x2 FOC system as the Phase-7
infrastructure response. -/
def canonicalSubsidyResponse (θ : ℝ) : ℝ :=
  (canonicalGovernmentHessianEntry θ .sA .hA *
      canonicalGovernmentHessianEntry θ .hA .sB -
    canonicalGovernmentHessianEntry θ .hA .hA *
      canonicalGovernmentHessianEntry θ .sA .sB) /
    canonicalOwnPolicyDet θ

/-- Generic inverse-of-a-symmetric-2x2-system identity. -/
lemma twoByTwo_response_solution
    {a b c p q : ℝ} (hdet : a * c - b ^ 2 ≠ 0) :
    a * ((b * q - c * p) / (a * c - b ^ 2)) +
        b * ((b * p - a * q) / (a * c - b ^ 2)) = -p ∧
    b * ((b * q - c * p) / (a * c - b ^ 2)) +
        c * ((b * p - a * q) / (a * c - b ^ 2)) = -q := by
  have hdet' : -b ^ 2 + c * a ≠ 0 := by
    simpa [sub_eq_add_neg, add_comm, add_left_comm, add_assoc, mul_comm] using hdet
  constructor <;> field_simp [hdet, hdet'] <;> ring_nf

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
  have hdet0 := (canonicalOwnPolicyDet_pos hθ).ne'
  have hdet :
      canonicalGovernmentHessianEntry θ .sA .sA *
          canonicalGovernmentHessianEntry θ .hA .hA -
        canonicalGovernmentHessianEntry θ .sA .hA ^ 2 ≠ 0 := by
    simpa [canonicalOwnPolicyDet, ownPolicyDet] using hdet0
  have h := twoByTwo_response_solution
    (a := canonicalGovernmentHessianEntry θ .sA .sA)
    (b := canonicalGovernmentHessianEntry θ .sA .hA)
    (c := canonicalGovernmentHessianEntry θ .hA .hA)
    (p := canonicalGovernmentHessianEntry θ .sA .sB)
    (q := canonicalGovernmentHessianEntry θ .hA .sB) hdet
  simpa [canonicalSubsidyResponse, canonicalInfrastructureResponse,
    canonicalCrossInstrumentNumerator, crossInstrumentNumerator,
    canonicalOwnPolicyDet, ownPolicyDet] using h

/-- Actual active-branch best-response path induced by changing the rival subsidy
by `r`, starting from any canonical active FOC point. -/
def canonicalActiveBRPath
    (θ : ℝ) (z : PolicyProfile) (r : ℝ) : PolicyProfile :=
  ownPolicyShift (shiftPolicy z .sB r)
    (r * canonicalSubsidyResponse θ)
    (r * canonicalInfrastructureResponse θ)

lemma canonicalActiveGovernmentGradient_shift
    {θ r : ℝ} {z : PolicyProfile} (i j : PolicyCoord) :
    canonicalActiveGovernmentGradient θ (shiftPolicy z j r) i =
      canonicalActiveGovernmentGradient θ z i +
        r * canonicalGovernmentHessianEntry θ i j := by
  exact modelGovernmentGradient_shift i j

/-- Along the canonical path both exact government FOCs remain zero. -/
theorem canonicalActiveBRPath_FOCs
    {θ : ℝ} (hθ : θ ∈ Icc (0 : ℝ) 1) {z : PolicyProfile}
    (hs : canonicalActiveGovernmentGradient θ z .sA = 0)
    (hh : canonicalActiveGovernmentGradient θ z .hA = 0)
    (r : ℝ) :
    canonicalActiveGovernmentGradient θ (canonicalActiveBRPath θ z r) .sA = 0 ∧
    canonicalActiveGovernmentGradient θ (canonicalActiveBRPath θ z r) .hA = 0 := by
  rcases canonicalResponse_solves_linearized_FOCs hθ with ⟨hrespS, hrespH⟩
  unfold canonicalActiveBRPath ownPolicyShift
  constructor
  · rw [canonicalActiveGovernmentGradient_shift,
      canonicalActiveGovernmentGradient_shift,
      canonicalActiveGovernmentGradient_shift, hs]
    linear_combination r * hrespS
  · rw [canonicalActiveGovernmentGradient_shift,
      canonicalActiveGovernmentGradient_shift,
      canonicalActiveGovernmentGradient_shift, hh]
    rw [canonicalGovernmentHessianEntry_symm θ .hA .sA]
    linear_combination r * hrespH

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

/-- Infrastructure coordinate of the exact active best-response path. -/
lemma canonicalActiveBRPath_hA
    (θ : ℝ) (z : PolicyProfile) (r : ℝ) :
    (canonicalActiveBRPath θ z r).hA =
      z.hA + r * canonicalInfrastructureResponse θ := by
  simp [canonicalActiveBRPath, ownPolicyShift, shiftPolicy]

/-- Calculus-level closure of the IFT bridge. -/
theorem canonicalActiveBRPath_hasDerivAt_hA
    (θ : ℝ) (z : PolicyProfile) (r : ℝ) :
    HasDerivAt (fun x => (canonicalActiveBRPath θ z x).hA)
      (canonicalInfrastructureResponse θ) r := by
  have hmul : HasDerivAt (fun x : ℝ => x * canonicalInfrastructureResponse θ)
      (canonicalInfrastructureResponse θ) r := by
    simpa using (hasDerivAt_id r).mul_const (canonicalInfrastructureResponse θ)
  have haff : HasDerivAt
      (fun x : ℝ => z.hA + x * canonicalInfrastructureResponse θ)
      (canonicalInfrastructureResponse θ) r := by
    simpa using hmul.const_add z.hA
  simpa [canonicalActiveBRPath, ownPolicyShift, shiftPolicy] using haff

/-- The derivative of the actual active best response is the Phase-7 quartic
response on positive rivalry. -/
theorem canonicalActualActiveBRDerivative_eq_thresholdResponse
    {θ : ℝ} (hθ : θ ∈ Ioc (0 : ℝ) 1) (z : PolicyProfile) (r : ℝ) :
    HasDerivAt (fun x => (canonicalActiveBRPath θ z x).hA)
      (-canonicalOmega θ * witnessP (θ ^ 2)) r := by
  rw [← canonicalInfrastructureResponse_eq_thresholdResponse hθ]
  exact canonicalActiveBRPath_hasDerivAt_hA θ z r

end SLGPC
