import StrategicLocalGreenPolicyCompetition.Stage2OptimizationBridge

noncomputable section

open Set

namespace SLGPC

/-- Firm i's Stage-3 Cournot quantity after imposing both nonnegativity constraints.
For fixed rival post-investment intercept `vj`, the unconstrained duopoly quantity is
clipped first by the monopoly quantity `vi/2` and then by zero. -/
def fullCournotOwnQuantity (θ vi vj : ℝ) : ℝ :=
  max 0 (min (vi / 2) ((2 * vi - θ * vj) / cournotD θ))

/-- The full nonnegative Cournot own quantity is nonnegative by construction. -/
lemma fullCournotOwnQuantity_nonneg (θ vi vj : ℝ) :
    0 ≤ fullCournotOwnQuantity θ vi vj := by
  unfold fullCournotOwnQuantity
  exact le_max_left _ _

/-- Holding the rival post-investment intercept fixed, the full nonnegative Cournot
own quantity is weakly increasing in the firm's own post-investment intercept. -/
theorem fullCournotOwnQuantity_mono
    {θ vi vi' vj : ℝ} (hθ : θ ∈ Icc (0 : ℝ) 1) (hvi : vi ≤ vi') :
    fullCournotOwnQuantity θ vi vj ≤ fullCournotOwnQuantity θ vi' vj := by
  have hD : 0 < cournotD θ := cournotD_pos hθ
  have hhalf : vi / 2 ≤ vi' / 2 := by linarith
  have hnum : 2 * vi - θ * vj ≤ 2 * vi' - θ * vj := by linarith
  have hduo :
      (2 * vi - θ * vj) / cournotD θ ≤
        (2 * vi' - θ * vj) / cournotD θ :=
    div_le_div_of_nonneg_right hnum hD.le
  unfold fullCournotOwnQuantity
  exact max_le_max le_rfl (min_le_min hhalf hduo)

/-- Stage-3 operating profit of a firm after the full nonnegative Cournot continuation. -/
def fullCournotOwnOperatingProfit (θ vi vj : ℝ) : ℝ :=
  fullCournotOwnQuantity θ vi vj ^ 2

/-- Stage-3 operating profit is weakly increasing in the firm's own net-demand
intercept.  This is the key certificate needed for feasible primitive deviations
whose centered scalar `u` is negative. -/
theorem fullCournotOwnOperatingProfit_mono
    {θ vi vi' vj : ℝ} (hθ : θ ∈ Icc (0 : ℝ) 1) (hvi : vi ≤ vi') :
    fullCournotOwnOperatingProfit θ vi vj ≤
      fullCournotOwnOperatingProfit θ vi' vj := by
  have hq := fullCournotOwnQuantity_mono (vj := vj) hθ hvi
  have hq0 := fullCournotOwnQuantity_nonneg θ vi vj
  have hq0' := fullCournotOwnQuantity_nonneg θ vi' vj
  have hdiff :
      0 ≤ fullCournotOwnQuantity θ vi' vj - fullCournotOwnQuantity θ vi vj :=
    sub_nonneg.mpr hq
  have hsum :
      0 ≤ fullCournotOwnQuantity θ vi' vj + fullCournotOwnQuantity θ vi vj :=
    add_nonneg hq0' hq0
  have hprod :
      0 ≤ (fullCournotOwnQuantity θ vi' vj - fullCournotOwnQuantity θ vi vj) *
        (fullCournotOwnQuantity θ vi' vj + fullCournotOwnQuantity θ vi vj) :=
    mul_nonneg hdiff hsum
  unfold fullCournotOwnOperatingProfit
  nlinarith

/-- Scalar Stage-2 continuation payoff, omitting only the policy-only completed-square
constant `s^2/(2kg)`.  Unlike the earlier branch-specific objects, the operating
profit here uses the full nonnegative Stage-3 Cournot continuation. -/
def fullScalarContinuationProfit (R θ wi vj u : ℝ) : ℝ :=
  fullCournotOwnOperatingProfit θ (wi + u) vj - u ^ 2 / (2 * R)

/-- Primitive Stage-2 continuation payoff in centered investment coordinates,
again omitting the common policy-only completed-square constant. -/
def primitiveCenteredContinuationProfit
    (kx kg μ s θ wi vj x g : ℝ) : ℝ :=
  fullCournotOwnOperatingProfit θ (wi + scalarU kg μ s x g) vj -
    centeredInvestmentCost kx kg x (centeredGreen kg s g)

lemma centeredInvestmentCost_nonneg
    {kx kg x v : ℝ} (hkx : 0 < kx) (hkg : 0 < kg) :
    0 ≤ centeredInvestmentCost kx kg x v := by
  have hx : 0 ≤ kx / 2 * x ^ 2 :=
    mul_nonneg (div_nonneg hkx.le (by norm_num)) (sq_nonneg x)
  have hv : 0 ≤ kg / 2 * v ^ 2 :=
    mul_nonneg (div_nonneg hkg.le (by norm_num)) (sq_nonneg v)
  unfold centeredInvestmentCost
  linarith

/-- For a nonnegative scalar reduction, the manuscript's cost-minimizing primitive
composition dominates every `(x,g)` implementing the same `u`, while preserving
the exact full Stage-3 continuation value. -/
theorem primitiveCenteredContinuationProfit_le_scalar_of_nonnegative_u
    {kx kg μ s θ wi vj x g u : ℝ}
    (hkx : 0 < kx) (hkg : 0 < kg)
    (hfeas : scalarU kg μ s x g = u) (_hu : 0 ≤ u) :
    primitiveCenteredContinuationProfit kx kg μ s θ wi vj x g ≤
      fullScalarContinuationProfit (investmentR kx kg μ) θ wi vj u := by
  have hcost := scalar_composition_minimizes_centered_cost
    (kx := kx) (kg := kg) (μ := μ) (u := u)
    (x := x) (v := centeredGreen kg s g) hkx hkg (by
      simpa [scalarU] using hfeas)
  rw [scalar_candidate_centered_cost_eq hkx hkg] at hcost
  unfold primitiveCenteredContinuationProfit fullScalarContinuationProfit
  rw [hfeas]
  linarith

/-- A feasible primitive deviation with negative centered scalar `u` is dominated
by the feasible `u=0` benchmark.  The proof does not use the infeasible
unconstrained conditional minimizer at negative `u`: it uses monotonicity of the
actual nonnegative Cournot continuation and nonnegativity of centered investment
cost. -/
theorem primitiveCenteredContinuationProfit_le_scalar_zero_of_negative_u
    {kx kg μ s θ wi vj x g : ℝ}
    (hkx : 0 < kx) (hkg : 0 < kg)
    (hθ : θ ∈ Icc (0 : ℝ) 1)
    (hu : scalarU kg μ s x g < 0) :
    primitiveCenteredContinuationProfit kx kg μ s θ wi vj x g ≤
      fullScalarContinuationProfit (investmentR kx kg μ) θ wi vj 0 := by
  have hvi : wi + scalarU kg μ s x g ≤ wi := by linarith
  have hop := fullCournotOwnOperatingProfit_mono
    (θ := θ) (vi := wi + scalarU kg μ s x g) (vi' := wi) (vj := vj) hθ hvi
  have hcost := centeredInvestmentCost_nonneg
    (kx := kx) (kg := kg) (x := x) (v := centeredGreen kg s g) hkx hkg
  unfold primitiveCenteredContinuationProfit fullScalarContinuationProfit
  norm_num
  linarith

/-- Every primitive investment deviation reduces to a nonnegative scalar challenger.
This closes the action-set hole created by feasible primitive choices with negative
centered `u`; no extra model assumption is introduced. -/
theorem primitive_deviation_reduces_to_nonnegative_scalar
    {kx kg μ s θ wi vj x g : ℝ}
    (hkx : 0 < kx) (hkg : 0 < kg)
    (hθ : θ ∈ Icc (0 : ℝ) 1) :
    ∃ u : ℝ, 0 ≤ u ∧
      primitiveCenteredContinuationProfit kx kg μ s θ wi vj x g ≤
        fullScalarContinuationProfit (investmentR kx kg μ) θ wi vj u := by
  by_cases hu : 0 ≤ scalarU kg μ s x g
  · refine ⟨scalarU kg μ s x g, hu, ?_⟩
    exact primitiveCenteredContinuationProfit_le_scalar_of_nonnegative_u
      hkx hkg rfl hu
  · have hneg : scalarU kg μ s x g < 0 := lt_of_not_ge hu
    refine ⟨0, le_rfl, ?_⟩
    exact primitiveCenteredContinuationProfit_le_scalar_zero_of_negative_u
      hkx hkg hθ hneg

end SLGPC
