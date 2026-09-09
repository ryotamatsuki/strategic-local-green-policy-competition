import StrategicLocalGreenPolicyCompetition.Proposition2

noncomputable section

open Set

namespace SLGPC

/-- The unique quartic root separates positive and negative values exactly as used in
Proposition 2 before the change of variables `u = θ²`. -/
theorem thresholdQuartic_sign_around_root
    {A4 A3 A2 A1 A0 : ℝ}
    (hP0 : 0 < thresholdQuartic A4 A3 A2 A1 A0 0)
    (hP1 : thresholdQuartic A4 A3 A2 A1 A0 1 < 0)
    (hB0 : thresholdB0 A1 < 0)
    (hB1 : thresholdB1 A2 A1 < 0)
    (hB2 : thresholdB2 A3 A2 A1 < 0)
    (hB3 : thresholdB3 A4 A3 A2 A1 < 0) :
    ∃ uStar ∈ Ioo (0 : ℝ) 1,
      thresholdQuartic A4 A3 A2 A1 A0 uStar = 0 ∧
      (∀ u ∈ Ico (0 : ℝ) uStar,
        0 < thresholdQuartic A4 A3 A2 A1 A0 u) ∧
      (∀ u ∈ Ioc uStar (1 : ℝ),
        thresholdQuartic A4 A3 A2 A1 A0 u < 0) := by
  obtain ⟨uStar, huStar, hPStar⟩ :=
    (thresholdQuartic_unique_root hP0 hP1 hB0 hB1 hB2 hB3).exists
  have hanti :
      StrictAntiOn (thresholdQuartic A4 A3 A2 A1 A0) (Icc (0 : ℝ) 1) :=
    thresholdQuartic_strictAntiOn hB0 hB1 hB2 hB3
  have huStarClosed : uStar ∈ Icc (0 : ℝ) 1 :=
    ⟨huStar.1.le, huStar.2.le⟩
  refine ⟨uStar, huStar, hPStar, ?_, ?_⟩
  · intro u hu
    have huClosed : u ∈ Icc (0 : ℝ) 1 :=
      ⟨hu.1, le_trans (le_of_lt hu.2) huStar.2.le⟩
    have hsign := hanti huClosed huStarClosed hu.2
    rw [hPStar] at hsign
    exact hsign
  · intro u hu
    have huClosed : u ∈ Icc (0 : ℝ) 1 :=
      ⟨le_trans huStar.1.le (le_of_lt hu.1), hu.2⟩
    have hsign := hanti huStarClosed huClosed hu.1
    rw [hPStar] at hsign
    exact hsign

end SLGPC
