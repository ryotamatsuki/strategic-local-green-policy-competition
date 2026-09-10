import StrategicLocalGreenPolicyCompetition.Stage2Regimes

noncomputable section

open Set

namespace SLGPC

/-- The maintained primitive restrictions order the three positive-rivalry thresholds
used in the Stage-2 regime map. -/
theorem stage2_threshold_ordering
    {kx kg μ θ : ℝ}
    (hkx : 0 < kx) (hkg : 0 < kg)
    (hθ : θ ∈ Icc (0 : ℝ) 1) (hθpos : 0 < θ)
    (hR : investmentR kx kg μ < (3 / 4 : ℝ)) :
    θ < reducedL kx kg μ θ ∧
    reducedL kx kg μ θ < monopolyM (investmentR kx kg μ) ∧
    0 < monopolyM (investmentR kx kg μ) := by
  exact ⟨reducedL_gt_theta hθ hR,
    reducedL_lt_monopolyM hkx hkg hθ hθpos,
    monopolyM_pos hθ hR⟩

/-- An A-monopoly continuation has positive own output and private cost reduction,
and satisfies the inactive-rival Stage-3 inequality. -/
theorem aMonopoly_admissible
    {R θ wA wB : ℝ}
    (hR : 0 < R) (hM : 0 < monopolyM R) (hwA : 0 < wA)
    (hAM : aMonopolyRegion R θ wA wB) :
    0 < (aMonopolyContinuation R wA).qA ∧
    (aMonopolyContinuation R wA).qB = 0 ∧
    0 < (aMonopolyContinuation R wA).uA ∧
    (aMonopolyContinuation R wA).uB = 0 ∧
    wB ≤ θ * (aMonopolyContinuation R wA).qA := by
  have hq : 0 < wA / monopolyM R := div_pos hwA hM
  have hinactive0 : wB ≤ (θ * wA) / monopolyM R :=
    (le_div_iff₀ hM).2 hAM
  have hinactive : wB ≤ θ * (wA / monopolyM R) := by
    calc
      wB ≤ (θ * wA) / monopolyM R := hinactive0
      _ = θ * (wA / monopolyM R) := by ring
  simp only [aMonopolyContinuation]
  exact ⟨hq, rfl, mul_pos hR hq, rfl, hinactive⟩

/-- An A-kink continuation has positive own output and private cost reduction and
places the rival exactly at its Stage-3 activity kink. -/
theorem aKink_admissible
    {R L θ wA wB : ℝ}
    (hR : 0 < R) (hθ : 0 < θ) (hwB : 0 < wB)
    (hAK : aKinkRegion R L θ wA wB) :
    0 < (aKinkContinuation θ wA wB).qA ∧
    (aKinkContinuation θ wA wB).qB = 0 ∧
    0 < (aKinkContinuation θ wA wB).uA ∧
    (aKinkContinuation θ wA wB).uB = 0 ∧
    wB = θ * (aKinkContinuation θ wA wB).qA := by
  have hMlt : monopolyM R < 2 := by
    unfold monopolyM
    linarith
  have hupper : θ * wA < 2 * wB := by
    have hMwB : monopolyM R * wB < 2 * wB :=
      mul_lt_mul_of_pos_right hMlt hwB
    exact lt_trans hAK.2 hMwB
  have hwAlt : wA < 2 * wB / θ := by
    rw [lt_div_iff₀ hθ]
    nlinarith
  have hq : 0 < wB / θ := div_pos hwB hθ
  have hu : 0 < 2 * wB / θ - wA := by linarith
  have hkink : wB = θ * (wB / θ) := by
    field_simp [hθ.ne']
  simp only [aKinkContinuation]
  exact ⟨hq, rfl, hu, rfl, hkink⟩

/-- Interior-duopoly region inequalities imply positive quantities; `L<2` then
implies positive private cost reductions in the encoded continuation. -/
theorem duopoly_admissible
    {L θ wA wB : ℝ}
    (hdet : 0 < L ^ 2 - θ ^ 2) (hL2 : L < 2)
    (hD : duopolyRegion L θ wA wB) :
    0 < (duopolyContinuation L θ wA wB).qA ∧
    0 < (duopolyContinuation L θ wA wB).qB ∧
    0 < (duopolyContinuation L θ wA wB).uA ∧
    0 < (duopolyContinuation L θ wA wB).uB := by
  obtain ⟨hqA, hqB⟩ := duopoly_outputs_pos hdet hD
  have hfeedback : 0 < 2 - L := sub_pos.mpr hL2
  simp only [duopolyContinuation]
  exact ⟨hqA, hqB, mul_pos hfeedback hqA, mul_pos hfeedback hqB⟩

/-- Symmetric B-kink admissibility certificate. -/
theorem bKink_admissible
    {R L θ wA wB : ℝ}
    (hR : 0 < R) (hθ : 0 < θ) (hwA : 0 < wA)
    (hBK : bKinkRegion R L θ wA wB) :
    (bKinkContinuation θ wA wB).qA = 0 ∧
    0 < (bKinkContinuation θ wA wB).qB ∧
    (bKinkContinuation θ wA wB).uA = 0 ∧
    0 < (bKinkContinuation θ wA wB).uB ∧
    wA = θ * (bKinkContinuation θ wA wB).qB := by
  have hMlt : monopolyM R < 2 := by
    unfold monopolyM
    linarith
  have hupper : θ * wB < 2 * wA := by
    have hMwA : monopolyM R * wA < 2 * wA :=
      mul_lt_mul_of_pos_right hMlt hwA
    exact lt_trans hBK.2 hMwA
  have hwBlt : wB < 2 * wA / θ := by
    rw [lt_div_iff₀ hθ]
    nlinarith
  have hq : 0 < wA / θ := div_pos hwA hθ
  have hu : 0 < 2 * wA / θ - wB := by linarith
  have hkink : wA = θ * (wA / θ) := by
    field_simp [hθ.ne']
  simp only [bKinkContinuation]
  exact ⟨rfl, hq, rfl, hu, hkink⟩

/-- Symmetric B-monopoly admissibility certificate. -/
theorem bMonopoly_admissible
    {R θ wA wB : ℝ}
    (hR : 0 < R) (hM : 0 < monopolyM R) (hwB : 0 < wB)
    (hBM : bMonopolyRegion R θ wA wB) :
    (bMonopolyContinuation R wB).qA = 0 ∧
    0 < (bMonopolyContinuation R wB).qB ∧
    (bMonopolyContinuation R wB).uA = 0 ∧
    0 < (bMonopolyContinuation R wB).uB ∧
    wA ≤ θ * (bMonopolyContinuation R wB).qB := by
  have hq : 0 < wB / monopolyM R := div_pos hwB hM
  have hinactive0 : wA ≤ (θ * wB) / monopolyM R :=
    (le_div_iff₀ hM).2 hBM
  have hinactive : wA ≤ θ * (wB / monopolyM R) := by
    calc
      wA ≤ (θ * wB) / monopolyM R := hinactive0
      _ = θ * (wB / monopolyM R) := by ring
  simp only [bMonopolyContinuation]
  exact ⟨rfl, hq, rfl, mul_pos hR hq, hinactive⟩

/-- Symmetric active-firm Stage-3 identity for the B-monopoly branch. -/
theorem bMonopoly_stage3_identity
    {R wB : ℝ} (hM : monopolyM R ≠ 0) :
    wB + (bMonopolyContinuation R wB).uB =
      2 * (bMonopolyContinuation R wB).qB := by
  simp [bMonopolyContinuation]
  unfold monopolyM at hM ⊢
  field_simp [hM]
  ring

/-- Symmetric active-firm Stage-3 identity for the B-kink branch. -/
theorem bKink_stage3_identity
    {θ wA wB : ℝ} :
    wB + (bKinkContinuation θ wA wB).uB =
      2 * (bKinkContinuation θ wA wB).qB := by
  simp [bKinkContinuation]
  ring

end SLGPC
