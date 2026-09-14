import StrategicLocalGreenPolicyCompetition.Stage2GlobalNash

noncomputable section

open Set

namespace SLGPC

/-- At the manuscript's scalar-composition candidate, the centered primitive
Stage-2 continuation payoff is exactly the full scalar continuation payoff. -/
theorem primitiveCenteredContinuationProfit_at_scalar_candidate
    {kx kg μ s θ wi vj u : ℝ}
    (hkx : 0 < kx) (hkg : 0 < kg) :
    primitiveCenteredContinuationProfit kx kg μ s θ wi vj
        (scalarX kx (investmentR kx kg μ) u)
        (scalarGreen kg μ (investmentR kx kg μ) s u) =
      fullScalarContinuationProfit (investmentR kx kg μ) θ wi vj u := by
  have hcenter := centeredGreen_scalarGreen
    (kg := kg) (μ := μ) (R := investmentR kx kg μ) (s := s) (u := u)
  have hU := scalar_candidate_constraint
    (kx := kx) (kg := kg) (μ := μ) (u := u) hkx hkg
  have hscalarU :
      scalarU kg μ s
          (scalarX kx (investmentR kx kg μ) u)
          (scalarGreen kg μ (investmentR kx kg μ) s u) = u := by
    unfold scalarU
    rw [hcenter]
    exact hU
  have hcost := scalar_candidate_centered_cost_eq
    (kx := kx) (kg := kg) (μ := μ) (u := u) hkx hkg
  unfold primitiveCenteredContinuationProfit fullScalarContinuationProfit
  rw [hscalarU, hcenter, hcost]

/-- The selected five-regime Stage-2 scalar continuation weakly dominates every
feasible primitive investment deviation `(x_i,g_i)` once the rival stays at its
selected continuation action.  The proof explicitly passes through the global
primitive-to-scalar reduction, including negative centered scalar deviations. -/
theorem modelStage2Continuation_primitive_global_nash
    {kx kg μ θ wA wB sA sB xA gA xB gB : ℝ}
    (hkx : 0 < kx) (hkg : 0 < kg)
    (hθ : θ ∈ Icc (0 : ℝ) 1)
    (hR : investmentR kx kg μ < (3 / 4 : ℝ))
    (hwA : 0 < wA) (hwB : 0 < wB)
    (_hxA : 0 ≤ xA) (_hgA : 0 ≤ gA)
    (_hxB : 0 ≤ xB) (_hgB : 0 ≤ gB) :
    let z := modelStage2Continuation kx kg μ θ wA wB
    primitiveCenteredContinuationProfit kx kg μ sA θ wA (wB + z.uB) xA gA ≤
      primitiveCenteredContinuationProfit kx kg μ sA θ wA (wB + z.uB)
        (scalarX kx (investmentR kx kg μ) z.uA)
        (scalarGreen kg μ (investmentR kx kg μ) sA z.uA) ∧
    primitiveCenteredContinuationProfit kx kg μ sB θ wB (wA + z.uA) xB gB ≤
      primitiveCenteredContinuationProfit kx kg μ sB θ wB (wA + z.uA)
        (scalarX kx (investmentR kx kg μ) z.uB)
        (scalarGreen kg μ (investmentR kx kg μ) sB z.uB) := by
  dsimp
  let z := modelStage2Continuation kx kg μ θ wA wB
  obtain ⟨uA, huA, hredA⟩ := primitive_deviation_reduces_to_nonnegative_scalar
    (kx := kx) (kg := kg) (μ := μ) (s := sA) (θ := θ)
    (wi := wA) (vj := wB + z.uB) (x := xA) (g := gA) hkx hkg hθ
  obtain ⟨uB, huB, hredB⟩ := primitive_deviation_reduces_to_nonnegative_scalar
    (kx := kx) (kg := kg) (μ := μ) (s := sB) (θ := θ)
    (wi := wB) (vj := wA + z.uA) (x := xB) (g := gB) hkx hkg hθ
  have hnash := modelStage2Continuation_fullScalar_global_nash
    (kx := kx) (kg := kg) (μ := μ) (θ := θ) (wA := wA) (wB := wB)
    (uA := uA) (uB := uB) hkx hkg hθ hR hwA hwB huA huB
  have heqA := primitiveCenteredContinuationProfit_at_scalar_candidate
    (kx := kx) (kg := kg) (μ := μ) (s := sA) (θ := θ)
    (wi := wA) (vj := wB + z.uB) (u := z.uA) hkx hkg
  have heqB := primitiveCenteredContinuationProfit_at_scalar_candidate
    (kx := kx) (kg := kg) (μ := μ) (s := sB) (θ := θ)
    (wi := wB) (vj := wA + z.uA) (u := z.uB) hkx hkg
  constructor
  · exact le_trans hredA (by simpa [z] using (le_trans hnash.1 heqA.ge))
  · exact le_trans hredB (by simpa [z] using (le_trans hnash.2 heqB.ge))

end SLGPC
