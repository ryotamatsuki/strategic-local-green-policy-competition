import StrategicLocalGreenPolicyCompetition.Stage2Certificate

noncomputable section

open Set

namespace SLGPC

/-- At `theta = 0`, positive reduced intercepts place the continuation in the
active-duopoly region. -/
theorem stage2_theta_zero_duopoly_region
    {kx kg μ wA wB : ℝ}
    (hR : investmentR kx kg μ < (3 / 4 : ℝ))
    (hwA : 0 < wA) (hwB : 0 < wB) :
    duopolyRegion (reducedL kx kg μ 0) 0 wA wB := by
  have hθ0 : (0 : ℝ) ∈ Icc (0 : ℝ) 1 := by
    constructor <;> norm_num
  have hLpos : 0 < reducedL kx kg μ 0 := reducedL_pos hθ0 hR
  unfold duopolyRegion
  constructor
  · simpa using mul_pos hLpos hwB
  · simpa using mul_pos hLpos hwA

/-- At `theta = 0`, none of the four exclusion/kink predicates can hold when both
reduced intercepts are positive. -/
theorem stage2_theta_zero_no_exclusion
    {kx kg μ wA wB : ℝ}
    (hR : investmentR kx kg μ < (3 / 4 : ℝ))
    (hwA : 0 < wA) (hwB : 0 < wB) :
    ¬ aMonopolyRegion (investmentR kx kg μ) 0 wA wB ∧
    ¬ aKinkRegion (investmentR kx kg μ) (reducedL kx kg μ 0) 0 wA wB ∧
    ¬ bKinkRegion (investmentR kx kg μ) (reducedL kx kg μ 0) 0 wA wB ∧
    ¬ bMonopolyRegion (investmentR kx kg μ) 0 wA wB := by
  have hθ0 : (0 : ℝ) ∈ Icc (0 : ℝ) 1 := by
    constructor <;> norm_num
  have hLpos : 0 < reducedL kx kg μ 0 := reducedL_pos hθ0 hR
  have hMpos : 0 < monopolyM (investmentR kx kg μ) := monopolyM_pos hθ0 hR
  constructor
  · intro hAM
    have hprod : 0 < monopolyM (investmentR kx kg μ) * wB :=
      mul_pos hMpos hwB
    change monopolyM (investmentR kx kg μ) * wB ≤ 0 * wA at hAM
    nlinarith
  · constructor
    · intro hAK
      have hprod : 0 < reducedL kx kg μ 0 * wB := mul_pos hLpos hwB
      have hlower := hAK.1
      change reducedL kx kg μ 0 * wB ≤ 0 * wA at hlower
      nlinarith
    · constructor
      · intro hBK
        have hprod : 0 < reducedL kx kg μ 0 * wA := mul_pos hLpos hwA
        have hlower := hBK.1
        change reducedL kx kg μ 0 * wA ≤ 0 * wB at hlower
        nlinarith
      · intro hBM
        have hprod : 0 < monopolyM (investmentR kx kg μ) * wA :=
          mul_pos hMpos hwA
        change monopolyM (investmentR kx kg μ) * wA ≤ 0 * wB at hBM
        nlinarith

/-- Combined endpoint certificate matching the manuscript statement that strategic
exclusion is impossible at `theta = 0` and the active-duopoly continuation applies. -/
theorem stage2_theta_zero_certificate
    {kx kg μ wA wB : ℝ}
    (hR : investmentR kx kg μ < (3 / 4 : ℝ))
    (hwA : 0 < wA) (hwB : 0 < wB) :
    duopolyRegion (reducedL kx kg μ 0) 0 wA wB ∧
    ¬ aMonopolyRegion (investmentR kx kg μ) 0 wA wB ∧
    ¬ aKinkRegion (investmentR kx kg μ) (reducedL kx kg μ 0) 0 wA wB ∧
    ¬ bKinkRegion (investmentR kx kg μ) (reducedL kx kg μ 0) 0 wA wB ∧
    ¬ bMonopolyRegion (investmentR kx kg μ) 0 wA wB := by
  refine ⟨stage2_theta_zero_duopoly_region hR hwA hwB, ?_⟩
  exact stage2_theta_zero_no_exclusion hR hwA hwB

end SLGPC
