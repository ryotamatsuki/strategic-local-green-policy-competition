import StrategicLocalGreenPolicyCompetition.Stage2Admissibility

noncomputable section

namespace SLGPC

/-- A-monopoly and A-kink regions are disjoint under the tie-breaking convention. -/
theorem aMonopoly_aKink_incompatible
    {R L θ wA wB : ℝ}
    (hAM : aMonopolyRegion R θ wA wB)
    (hAK : aKinkRegion R L θ wA wB) : False := by
  exact (not_lt_of_ge hAM) hAK.2

/-- A-kink and duopoly regions are disjoint. -/
theorem aKink_duopoly_incompatible
    {R L θ wA wB : ℝ}
    (hAK : aKinkRegion R L θ wA wB)
    (hD : duopolyRegion L θ wA wB) : False := by
  exact (not_lt_of_ge hAK.1) hD.1

/-- A-monopoly and duopoly regions are disjoint once `L < 2-R`. -/
theorem aMonopoly_duopoly_incompatible
    {R L θ wA wB : ℝ}
    (hLM : L < monopolyM R) (hwB : 0 < wB)
    (hAM : aMonopolyRegion R θ wA wB)
    (hD : duopolyRegion L θ wA wB) : False := by
  have hside : L * wB ≤ θ * wA := aMonopoly_implies_aSide hLM hwB hAM
  exact (not_lt_of_ge hside) hD.1

/-- B-monopoly and B-kink regions are disjoint under the tie-breaking convention. -/
theorem bMonopoly_bKink_incompatible
    {R L θ wA wB : ℝ}
    (hBM : bMonopolyRegion R θ wA wB)
    (hBK : bKinkRegion R L θ wA wB) : False := by
  exact (not_lt_of_ge hBM) hBK.2

/-- B-kink and duopoly regions are disjoint. -/
theorem bKink_duopoly_incompatible
    {R L θ wA wB : ℝ}
    (hBK : bKinkRegion R L θ wA wB)
    (hD : duopolyRegion L θ wA wB) : False := by
  exact (not_lt_of_ge hBK.1) hD.2

/-- B-monopoly and duopoly regions are disjoint once `L < 2-R`. -/
theorem bMonopoly_duopoly_incompatible
    {R L θ wA wB : ℝ}
    (hLM : L < monopolyM R) (hwA : 0 < wA)
    (hBM : bMonopolyRegion R θ wA wB)
    (hD : duopolyRegion L θ wA wB) : False := by
  have hside : L * wA ≤ θ * wB := bMonopoly_implies_bSide hLM hwA hBM
  exact (not_lt_of_ge hside) hD.2

/-- Model-level cross-side exclusion: no A-side regime can coexist with a B-side regime. -/
theorem model_stage2_cross_side_incompatible
    {kx kg μ θ wA wB : ℝ}
    (hkx : 0 < kx) (hkg : 0 < kg)
    (hθ : θ ∈ Set.Icc (0 : ℝ) 1) (hθpos : 0 < θ)
    (hR : investmentR kx kg μ < (3 / 4 : ℝ))
    (hwA : 0 < wA) (hwB : 0 < wB)
    (hA :
      aMonopolyRegion (investmentR kx kg μ) θ wA wB ∨
      aKinkRegion (investmentR kx kg μ) (reducedL kx kg μ θ) θ wA wB)
    (hB :
      bMonopolyRegion (investmentR kx kg μ) θ wA wB ∨
      bKinkRegion (investmentR kx kg μ) (reducedL kx kg μ θ) θ wA wB) : False := by
  exact aSide_bSide_regions_incompatible
    hθpos
    (reducedL_gt_theta hθ hR)
    (reducedL_lt_monopolyM hkx hkg hθ hθpos)
    hwA hwB hA hB

/-- The five model regime predicates are exhaustive and all possible overlaps are
excluded by the same-side, duopoly-side, and cross-side incompatibility lemmas above. -/
theorem model_stage2_region_exists
    {kx kg μ θ wA wB : ℝ} :
    aMonopolyRegion (investmentR kx kg μ) θ wA wB ∨
    aKinkRegion (investmentR kx kg μ) (reducedL kx kg μ θ) θ wA wB ∨
    duopolyRegion (reducedL kx kg μ θ) θ wA wB ∨
    bKinkRegion (investmentR kx kg μ) (reducedL kx kg μ θ) θ wA wB ∨
    bMonopolyRegion (investmentR kx kg μ) θ wA wB := by
  exact stage2_regions_exhaustive
    (investmentR kx kg μ) (reducedL kx kg μ θ) θ wA wB

end SLGPC
