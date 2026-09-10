import StrategicLocalGreenPolicyCompetition.Stage2Scalarization

noncomputable section

namespace SLGPC

/-- Primitive inverse demand for firm `i`. -/
def inversePrice (a θ qi qj : ℝ) : ℝ :=
  a - qi - θ * qj

/-- Primitive marginal cost after private and public cost reduction. -/
def primitiveMarginalCost (c μ ν x g h : ℝ) : ℝ :=
  c - x - μ * g - ν * h

/-- Primitive firm profit from the manuscript. -/
def primitiveFirmProfit
    (a c kx kg μ ν s h θ qi qj x g : ℝ) : ℝ :=
  (inversePrice a θ qi qj - primitiveMarginalCost c μ ν x g h) * qi -
    kx / 2 * x ^ 2 - kg / 2 * g ^ 2 + s * g

/-- The centered scalar `u` and policy intercept `w` exactly reconstruct the
primitive Stage-3 net-demand intercept `a-c_i`. -/
theorem primitive_intercept_eq_reducedW_add_scalarU
    {a c kg μ ν s h x g : ℝ} (hkg : kg ≠ 0) :
    a - primitiveMarginalCost c μ ν x g h =
      reducedW (a - c) kg μ ν s h + scalarU kg μ s x g := by
  unfold primitiveMarginalCost reducedW policyY scalarU centeredGreen
  field_simp [hkg]
  ring

/-- The active Cournot first-order equation implies the familiar markup identity
`p_i-c_i=q_i`. -/
theorem active_markup_eq_quantity
    {a c μ ν θ qi qj x g h : ℝ}
    (hCournot :
      2 * qi + θ * qj = a - primitiveMarginalCost c μ ν x g h) :
    inversePrice a θ qi qj - primitiveMarginalCost c μ ν x g h = qi := by
  unfold inversePrice
  linarith

/-- On an active Cournot branch, primitive profit reduces exactly to operating
profit `q_i^2` minus investment cost net of subsidy. -/
theorem primitive_profit_active_reduction
    {a c kx kg μ ν s h θ qi qj x g : ℝ}
    (hCournot :
      2 * qi + θ * qj = a - primitiveMarginalCost c μ ν x g h) :
    primitiveFirmProfit a c kx kg μ ν s h θ qi qj x g =
      qi ^ 2 - netInvestmentCost kx kg s x g := by
  have hm := active_markup_eq_quantity hCournot
  unfold primitiveFirmProfit
  rw [hm]
  unfold netInvestmentCost
  ring

/-- At the cost-minimizing composition from Phase 4, centered quadratic investment
cost is exactly `u^2/(2R)`. -/
theorem scalar_candidate_centered_cost_eq
    {kx kg μ u : ℝ}
    (hkx : 0 < kx) (hkg : 0 < kg) :
    centeredInvestmentCost kx kg
        (scalarX kx (investmentR kx kg μ) u)
        (scalarGreenCentered kg μ (investmentR kx kg μ) u) =
      u ^ 2 / (2 * investmentR kx kg μ) := by
  have hR : 0 < investmentR kx kg μ := investmentR_pos hkx hkg
  unfold centeredInvestmentCost scalarX scalarGreenCentered investmentR
  field_simp [hkx.ne', hkg.ne', hR.ne']
  ring

/-- Reintroducing the subsidy shift gives the exact minimized primitive investment
cost net of subsidy. -/
theorem scalar_candidate_net_cost_eq
    {kx kg μ s u : ℝ}
    (hkx : 0 < kx) (hkg : 0 < kg) :
    netInvestmentCost kx kg s
        (scalarX kx (investmentR kx kg μ) u)
        (scalarGreen kg μ (investmentR kx kg μ) s u) =
      u ^ 2 / (2 * investmentR kx kg μ) - s ^ 2 / (2 * kg) := by
  calc
    netInvestmentCost kx kg s
        (scalarX kx (investmentR kx kg μ) u)
        (scalarGreen kg μ (investmentR kx kg μ) s u) =
      centeredInvestmentCost kx kg
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
    _ = u ^ 2 / (2 * investmentR kx kg μ) - s ^ 2 / (2 * kg) := by
      rw [scalar_candidate_centered_cost_eq hkx hkg]

/-- Therefore, once the Stage-3 markup identity holds, primitive profit evaluated at
the Phase-4 cost-minimizing composition equals scalar reduced profit plus the
policy-dependent constant `s^2/(2kg)`. -/
theorem primitive_profit_at_scalar_candidate
    {a c kx kg μ ν s h θ qi qj u : ℝ}
    (hkx : 0 < kx) (hkg : 0 < kg)
    (hCournot :
      2 * qi + θ * qj =
        a - primitiveMarginalCost c μ ν
          (scalarX kx (investmentR kx kg μ) u)
          (scalarGreen kg μ (investmentR kx kg μ) s u) h) :
    primitiveFirmProfit a c kx kg μ ν s h θ qi qj
        (scalarX kx (investmentR kx kg μ) u)
        (scalarGreen kg μ (investmentR kx kg μ) s u) =
      qi ^ 2 - u ^ 2 / (2 * investmentR kx kg μ) + s ^ 2 / (2 * kg) := by
  rw [primitive_profit_active_reduction hCournot]
  rw [scalar_candidate_net_cost_eq hkx hkg]
  ring

/-- The scalar candidate itself reconstructs the reduced intercept `w+u`. -/
theorem scalar_candidate_intercept
    {a c kx kg μ ν s h u : ℝ}
    (hkx : 0 < kx) (hkg : 0 < kg) :
    a - primitiveMarginalCost c μ ν
        (scalarX kx (investmentR kx kg μ) u)
        (scalarGreen kg μ (investmentR kx kg μ) s u) h =
      reducedW (a - c) kg μ ν s h + u := by
  have hI := primitive_intercept_eq_reducedW_add_scalarU
    (a := a) (c := c) (kg := kg) (μ := μ) (ν := ν)
    (s := s) (h := h)
    (x := scalarX kx (investmentR kx kg μ) u)
    (g := scalarGreen kg μ (investmentR kx kg μ) s u) hkg.ne'
  have hU := scalar_candidate_constraint
    (kx := kx) (kg := kg) (μ := μ) (u := u) hkx hkg
  have hcenter := centeredGreen_scalarGreen
    (kg := kg) (μ := μ) (R := investmentR kx kg μ) (s := s) (u := u)
  unfold scalarU at hI
  rw [hcenter] at hI
  rw [hU] at hI
  exact hI

end SLGPC
