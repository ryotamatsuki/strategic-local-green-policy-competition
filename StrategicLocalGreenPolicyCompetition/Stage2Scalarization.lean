import StrategicLocalGreenPolicyCompetition.FirmStage

noncomputable section

namespace SLGPC

/-- Green investment after completing the square around the subsidy shift `s/kg`. -/
def centeredGreen (kg s g : ℝ) : ℝ := g - s / kg

/-- Scalar private cost reduction used in the Stage-2 regime map:
`u = x + μ (g - s/kg)`. -/
def scalarU (kg μ s x g : ℝ) : ℝ :=
  x + μ * centeredGreen kg s g

/-- Cost-minimizing conventional-investment component conditional on scalar reduction `u`. -/
def scalarX (kx R u : ℝ) : ℝ :=
  u / (R * kx)

/-- Cost-minimizing centered green-investment component conditional on `u`. -/
def scalarGreenCentered (kg μ R u : ℝ) : ℝ :=
  μ * u / (R * kg)

/-- Cost-minimizing green investment in the manuscript's original variable. -/
def scalarGreen (kg μ R s u : ℝ) : ℝ :=
  s / kg + scalarGreenCentered kg μ R u

/-- Quadratic investment cost after the subsidy square has been completed. -/
def centeredInvestmentCost (kx kg x v : ℝ) : ℝ :=
  kx / 2 * x ^ 2 + kg / 2 * v ^ 2

/-- Original investment cost net of the firm-specific green subsidy. -/
def netInvestmentCost (kx kg s x g : ℝ) : ℝ :=
  kx / 2 * x ^ 2 + kg / 2 * g ^ 2 - s * g

/-- The manuscript's composition formulas exactly deliver the requested scalar reduction. -/
theorem scalar_candidate_constraint
    {kx kg μ u : ℝ}
    (hkx : 0 < kx) (hkg : 0 < kg) :
    scalarX kx (investmentR kx kg μ) u +
      μ * scalarGreenCentered kg μ (investmentR kx kg μ) u = u := by
  let R := investmentR kx kg μ
  have hRpos : 0 < R := by
    dsimp [R]
    exact investmentR_pos hkx hkg
  have hRne : R ≠ 0 := hRpos.ne'
  change scalarX kx R u + μ * scalarGreenCentered kg μ R u = u
  unfold scalarX scalarGreenCentered
  calc
    u / (R * kx) + μ * (μ * u / (R * kg)) =
        (u / R) * (1 / kx + μ ^ 2 / kg) := by
          field_simp [hRne, hkx.ne', hkg.ne'] <;> ring
    _ = (u / R) * R := by rfl
    _ = u := by field_simp [hRne]

/-- The candidate components satisfy the equality condition in the weighted
Cauchy--Schwarz certificate. -/
theorem scalar_candidate_ratio
    {kx kg μ u : ℝ}
    (hkx : 0 < kx) (hkg : 0 < kg) :
    μ * kx * scalarX kx (investmentR kx kg μ) u =
      kg * scalarGreenCentered kg μ (investmentR kx kg μ) u := by
  let R := investmentR kx kg μ
  have hRne : R ≠ 0 := by
    dsimp [R]
    exact (investmentR_pos hkx hkg).ne'
  change μ * kx * scalarX kx R u = kg * scalarGreenCentered kg μ R u
  unfold scalarX scalarGreenCentered
  field_simp [hRne, hkx.ne', hkg.ne'] <;> ring

/-- Exact weighted Cauchy gap underlying the one-dimensional Stage-2 reduction. -/
theorem scalar_weighted_gap_identity
    {kx kg μ x v : ℝ}
    (hkx : kx ≠ 0) (hkg : kg ≠ 0) :
    investmentR kx kg μ * (kx * x ^ 2 + kg * v ^ 2) -
        (x + μ * v) ^ 2 =
      (μ * kx * x - kg * v) ^ 2 / (kx * kg) := by
  unfold investmentR
  field_simp [hkx, hkg] <;> ring

/-- Positive investment-cost weights imply the scalar reduction cannot be achieved
with weighted energy below the Cauchy lower bound. -/
theorem scalar_energy_lower_bound
    {kx kg μ x v : ℝ}
    (hkx : 0 < kx) (hkg : 0 < kg) :
    (x + μ * v) ^ 2 ≤
      investmentR kx kg μ * (kx * x ^ 2 + kg * v ^ 2) := by
  have hden : 0 < kx * kg := mul_pos hkx hkg
  have hsquare : 0 ≤ (μ * kx * x - kg * v) ^ 2 := sq_nonneg _
  have hgapNonneg :
      0 ≤ (μ * kx * x - kg * v) ^ 2 / (kx * kg) :=
    div_nonneg hsquare hden.le
  have hid := scalar_weighted_gap_identity
    (kx := kx) (kg := kg) (μ := μ) (x := x) (v := v) hkx.ne' hkg.ne'
  linarith

/-- Conditional on a fixed scalar reduction `u`, the manuscript composition weakly
minimizes the centered quadratic investment cost. -/
theorem scalar_composition_minimizes_centered_cost
    {kx kg μ u x v : ℝ}
    (hkx : 0 < kx) (hkg : 0 < kg)
    (hfeas : x + μ * v = u) :
    centeredInvestmentCost kx kg
        (scalarX kx (investmentR kx kg μ) u)
        (scalarGreenCentered kg μ (investmentR kx kg μ) u) ≤
      centeredInvestmentCost kx kg x v := by
  let R := investmentR kx kg μ
  have hRpos : 0 < R := by
    dsimp [R]
    exact investmentR_pos hkx hkg
  have hcandidate := scalar_candidate_constraint
    (kx := kx) (kg := kg) (μ := μ) (u := u) hkx hkg
  have hratio := scalar_candidate_ratio
    (kx := kx) (kg := kg) (μ := μ) (u := u) hkx hkg
  have hcandidateGap := scalar_weighted_gap_identity
    (kx := kx) (kg := kg) (μ := μ)
    (x := scalarX kx R u)
    (v := scalarGreenCentered kg μ R u) hkx.ne' hkg.ne'
  change scalarX kx R u + μ * scalarGreenCentered kg μ R u = u at hcandidate
  change μ * kx * scalarX kx R u = kg * scalarGreenCentered kg μ R u at hratio
  change
    R * (kx * (scalarX kx R u) ^ 2 +
        kg * (scalarGreenCentered kg μ R u) ^ 2) -
        (scalarX kx R u + μ * scalarGreenCentered kg μ R u) ^ 2 =
      (μ * kx * scalarX kx R u -
        kg * scalarGreenCentered kg μ R u) ^ 2 / (kx * kg)
    at hcandidateGap
  rw [hcandidate, hratio] at hcandidateGap
  simp at hcandidateGap
  have hcandidateEnergy :
      R * (kx * (scalarX kx R u) ^ 2 +
        kg * (scalarGreenCentered kg μ R u) ^ 2) = u ^ 2 := by
    linarith
  have hactual := scalar_energy_lower_bound
    (kx := kx) (kg := kg) (μ := μ) (x := x) (v := v) hkx hkg
  rw [hfeas] at hactual
  change u ^ 2 ≤ R * (kx * x ^ 2 + kg * v ^ 2) at hactual
  have hmult :
      R * (kx * (scalarX kx R u) ^ 2 +
        kg * (scalarGreenCentered kg μ R u) ^ 2) ≤
      R * (kx * x ^ 2 + kg * v ^ 2) := by
    linarith
  have henergy :
      kx * (scalarX kx R u) ^ 2 +
          kg * (scalarGreenCentered kg μ R u) ^ 2 ≤
        kx * x ^ 2 + kg * v ^ 2 :=
    le_of_mul_le_mul_left hmult hRpos
  unfold centeredInvestmentCost
  nlinarith

/-- Reintroducing the subsidy shift recovers the manuscript green-investment formula. -/
theorem centeredGreen_scalarGreen
    {kg μ R s u : ℝ} :
    centeredGreen kg s (scalarGreen kg μ R s u) =
      scalarGreenCentered kg μ R u := by
  unfold centeredGreen scalarGreen
  ring

/-- Completing the square rewrites original investment cost net of subsidy as the
centered cost minus a policy-dependent constant. -/
theorem netInvestmentCost_complete_square
    {kx kg s x g : ℝ} (hkg : kg ≠ 0) :
    netInvestmentCost kx kg s x g =
      centeredInvestmentCost kx kg x (centeredGreen kg s g) -
        s ^ 2 / (2 * kg) := by
  unfold netInvestmentCost centeredInvestmentCost centeredGreen
  field_simp [hkg] <;> ring

/-- Therefore, among all `(x,g)` delivering the same scalar reduction `u`, the
manuscript composition minimizes the original quadratic investment cost net of subsidy. -/
theorem scalar_composition_minimizes_net_cost
    {kx kg μ s u x g : ℝ}
    (hkx : 0 < kx) (hkg : 0 < kg)
    (hfeas : scalarU kg μ s x g = u) :
    netInvestmentCost kx kg s
        (scalarX kx (investmentR kx kg μ) u)
        (scalarGreen kg μ (investmentR kx kg μ) s u) ≤
      netInvestmentCost kx kg s x g := by
  have hfeas' : x + μ * centeredGreen kg s g = u := by
    simpa [scalarU] using hfeas
  have hcenter := scalar_composition_minimizes_centered_cost
    (kx := kx) (kg := kg) (μ := μ) (u := u)
    (x := x) (v := centeredGreen kg s g) hkx hkg hfeas'
  calc
    netInvestmentCost kx kg s
        (scalarX kx (investmentR kx kg μ) u)
        (scalarGreen kg μ (investmentR kx kg μ) s u)
        = centeredInvestmentCost kx kg
            (scalarX kx (investmentR kx kg μ) u)
            (centeredGreen kg s
              (scalarGreen kg μ (investmentR kx kg μ) s u)) -
            s ^ 2 / (2 * kg) :=
          netInvestmentCost_complete_square hkg.ne'
    _ = centeredInvestmentCost kx kg
            (scalarX kx (investmentR kx kg μ) u)
            (scalarGreenCentered kg μ (investmentR kx kg μ) u) -
            s ^ 2 / (2 * kg) := by
          rw [centeredGreen_scalarGreen]
    _ ≤ centeredInvestmentCost kx kg x (centeredGreen kg s g) -
            s ^ 2 / (2 * kg) := sub_le_sub_right hcenter _
    _ = netInvestmentCost kx kg s x g :=
          (netInvestmentCost_complete_square hkg.ne').symm

/-- Under nonnegative subsidy, spillover productivity, and scalar reduction, the
cost-minimizing composition respects the firm's nonnegative investment constraints. -/
theorem scalar_composition_nonnegative
    {kx kg μ s u : ℝ}
    (hkx : 0 < kx) (hkg : 0 < kg)
    (hμ : 0 ≤ μ) (hs : 0 ≤ s) (hu : 0 ≤ u) :
    0 ≤ scalarX kx (investmentR kx kg μ) u ∧
    0 ≤ scalarGreen kg μ (investmentR kx kg μ) s u := by
  have hRpos : 0 < investmentR kx kg μ := investmentR_pos hkx hkg
  have hxden : 0 ≤ investmentR kx kg μ * kx := (mul_pos hRpos hkx).le
  have hgden : 0 ≤ investmentR kx kg μ * kg := (mul_pos hRpos hkg).le
  have hx : 0 ≤ scalarX kx (investmentR kx kg μ) u := by
    unfold scalarX
    exact div_nonneg hu hxden
  have hcenter :
      0 ≤ scalarGreenCentered kg μ (investmentR kx kg μ) u := by
    unfold scalarGreenCentered
    exact div_nonneg (mul_nonneg hμ hu) hgden
  have hshift : 0 ≤ s / kg := div_nonneg hs hkg.le
  constructor
  · exact hx
  · unfold scalarGreen
    linarith

end SLGPC
