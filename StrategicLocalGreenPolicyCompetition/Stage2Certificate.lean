import StrategicLocalGreenPolicyCompetition.Stage2Partition

noncomputable section

open Set

namespace SLGPC

/-- Under the model assumptions, the five tie-broken regime predicates form a
pairwise-disjoint family. Together with `model_stage2_region_exists`, this is the
formal partition certificate for positive rivalry. -/
theorem model_stage2_regions_pairwise_disjoint
    {kx kg μ θ wA wB : ℝ}
    (hkx : 0 < kx) (hkg : 0 < kg)
    (hθ : θ ∈ Icc (0 : ℝ) 1) (hθpos : 0 < θ)
    (hR : investmentR kx kg μ < (3 / 4 : ℝ))
    (hwA : 0 < wA) (hwB : 0 < wB) :
    ¬ (aMonopolyRegion (investmentR kx kg μ) θ wA wB ∧
       aKinkRegion (investmentR kx kg μ) (reducedL kx kg μ θ) θ wA wB) ∧
    ¬ (aMonopolyRegion (investmentR kx kg μ) θ wA wB ∧
       duopolyRegion (reducedL kx kg μ θ) θ wA wB) ∧
    ¬ (aMonopolyRegion (investmentR kx kg μ) θ wA wB ∧
       bKinkRegion (investmentR kx kg μ) (reducedL kx kg μ θ) θ wA wB) ∧
    ¬ (aMonopolyRegion (investmentR kx kg μ) θ wA wB ∧
       bMonopolyRegion (investmentR kx kg μ) θ wA wB) ∧
    ¬ (aKinkRegion (investmentR kx kg μ) (reducedL kx kg μ θ) θ wA wB ∧
       duopolyRegion (reducedL kx kg μ θ) θ wA wB) ∧
    ¬ (aKinkRegion (investmentR kx kg μ) (reducedL kx kg μ θ) θ wA wB ∧
       bKinkRegion (investmentR kx kg μ) (reducedL kx kg μ θ) θ wA wB) ∧
    ¬ (aKinkRegion (investmentR kx kg μ) (reducedL kx kg μ θ) θ wA wB ∧
       bMonopolyRegion (investmentR kx kg μ) θ wA wB) ∧
    ¬ (duopolyRegion (reducedL kx kg μ θ) θ wA wB ∧
       bKinkRegion (investmentR kx kg μ) (reducedL kx kg μ θ) θ wA wB) ∧
    ¬ (duopolyRegion (reducedL kx kg μ θ) θ wA wB ∧
       bMonopolyRegion (investmentR kx kg μ) θ wA wB) ∧
    ¬ (bKinkRegion (investmentR kx kg μ) (reducedL kx kg μ θ) θ wA wB ∧
       bMonopolyRegion (investmentR kx kg μ) θ wA wB) := by
  have hLM : reducedL kx kg μ θ < monopolyM (investmentR kx kg μ) :=
    reducedL_lt_monopolyM hkx hkg hθ hθpos
  constructor
  · rintro ⟨hAM, hAK⟩
    exact aMonopoly_aKink_incompatible hAM hAK
  · constructor
    · rintro ⟨hAM, hD⟩
      exact aMonopoly_duopoly_incompatible hLM hwB hAM hD
    · constructor
      · rintro ⟨hAM, hBK⟩
        exact model_stage2_cross_side_incompatible hkx hkg hθ hθpos hR hwA hwB
          (Or.inl hAM) (Or.inr hBK)
      · constructor
        · rintro ⟨hAM, hBM⟩
          exact model_stage2_cross_side_incompatible hkx hkg hθ hθpos hR hwA hwB
            (Or.inl hAM) (Or.inl hBM)
        · constructor
          · rintro ⟨hAK, hD⟩
            exact aKink_duopoly_incompatible hAK hD
          · constructor
            · rintro ⟨hAK, hBK⟩
              exact model_stage2_cross_side_incompatible hkx hkg hθ hθpos hR hwA hwB
                (Or.inr hAK) (Or.inr hBK)
            · constructor
              · rintro ⟨hAK, hBM⟩
                exact model_stage2_cross_side_incompatible hkx hkg hθ hθpos hR hwA hwB
                  (Or.inr hAK) (Or.inl hBM)
              · constructor
                · rintro ⟨hD, hBK⟩
                  exact bKink_duopoly_incompatible hBK hD
                · constructor
                  · rintro ⟨hD, hBM⟩
                    exact bMonopoly_duopoly_incompatible hLM hwA hBM hD
                  · rintro ⟨hBK, hBM⟩
                    exact bMonopoly_bKink_incompatible hBM hBK

/-- Full continuation matching at the A kink/monopoly boundary. -/
theorem aKink_aMonopoly_boundary_continuation
    {R θ wA wB : ℝ}
    (hθ : θ ≠ 0) (hM : monopolyM R ≠ 0)
    (hb : θ * wA = monopolyM R * wB) :
    aKinkContinuation θ wA wB = aMonopolyContinuation R wA := by
  apply Stage2Continuation.ext
  · exact aKink_aMonopoly_boundary_q hθ hM hb
  · rfl
  · exact aKink_aMonopoly_boundary_u hθ hM hb
  · rfl

/-- Full continuation matching at the A kink/duopoly boundary. -/
theorem aKink_duopoly_boundary_continuation
    {L θ wA wB : ℝ}
    (hθ : θ ≠ 0) (hdet : L ^ 2 - θ ^ 2 ≠ 0)
    (hb : θ * wA = L * wB) :
    duopolyContinuation L θ wA wB = aKinkContinuation θ wA wB := by
  apply Stage2Continuation.ext
  · exact aKink_duopoly_boundary_qA hθ hdet hb
  · change duopolyQB L θ wA wB = 0
    exact aKink_duopoly_boundary_qB hb
  · exact aKink_duopoly_boundary_uA hθ hdet hb
  · change (2 - L) * duopolyQB L θ wA wB = 0
    rw [aKink_duopoly_boundary_qB hb]
    ring

/-- Full continuation matching at the B kink/duopoly boundary. -/
theorem bKink_duopoly_boundary_continuation
    {L θ wA wB : ℝ}
    (hθ : θ ≠ 0) (hdet : L ^ 2 - θ ^ 2 ≠ 0)
    (hb : θ * wB = L * wA) :
    duopolyContinuation L θ wA wB = bKinkContinuation θ wA wB := by
  apply Stage2Continuation.ext
  · change duopolyQA L θ wA wB = 0
    exact bKink_duopoly_boundary_qA hb
  · exact bKink_duopoly_boundary_qB hθ hdet hb
  · change (2 - L) * duopolyQA L θ wA wB = 0
    rw [bKink_duopoly_boundary_qA hb]
    ring
  · exact bKink_duopoly_boundary_uB hθ hdet hb

/-- Full continuation matching at the B kink/monopoly boundary. -/
theorem bKink_bMonopoly_boundary_continuation
    {R θ wA wB : ℝ}
    (hθ : θ ≠ 0) (hM : monopolyM R ≠ 0)
    (hb : θ * wB = monopolyM R * wA) :
    bKinkContinuation θ wA wB = bMonopolyContinuation R wB := by
  apply Stage2Continuation.ext
  · rfl
  · exact bKink_bMonopoly_boundary_q hθ hM hb
  · rfl
  · exact bKink_bMonopoly_boundary_u hθ hM hb

/-- Model-level A kink/monopoly boundary certificate with all nonzero denominators
supplied by the maintained regularity conditions. -/
theorem model_aKink_aMonopoly_boundary_continuation
    {kx kg μ θ wA wB : ℝ}
    (hθ : θ ∈ Icc (0 : ℝ) 1) (hθpos : 0 < θ)
    (hR : investmentR kx kg μ < (3 / 4 : ℝ))
    (hb : θ * wA = monopolyM (investmentR kx kg μ) * wB) :
    aKinkContinuation θ wA wB =
      aMonopolyContinuation (investmentR kx kg μ) wA := by
  exact aKink_aMonopoly_boundary_continuation hθpos.ne'
    (monopolyM_pos hθ hR).ne' hb

/-- Model-level A kink/duopoly boundary certificate. -/
theorem model_aKink_duopoly_boundary_continuation
    {kx kg μ θ wA wB : ℝ}
    (hθ : θ ∈ Icc (0 : ℝ) 1) (hθpos : 0 < θ)
    (hR : investmentR kx kg μ < (3 / 4 : ℝ))
    (hb : θ * wA = reducedL kx kg μ θ * wB) :
    duopolyContinuation (reducedL kx kg μ θ) θ wA wB =
      aKinkContinuation θ wA wB := by
  exact aKink_duopoly_boundary_continuation hθpos.ne'
    (reducedDet_pos hθ hR).ne' hb

/-- Model-level B kink/duopoly boundary certificate. -/
theorem model_bKink_duopoly_boundary_continuation
    {kx kg μ θ wA wB : ℝ}
    (hθ : θ ∈ Icc (0 : ℝ) 1) (hθpos : 0 < θ)
    (hR : investmentR kx kg μ < (3 / 4 : ℝ))
    (hb : θ * wB = reducedL kx kg μ θ * wA) :
    duopolyContinuation (reducedL kx kg μ θ) θ wA wB =
      bKinkContinuation θ wA wB := by
  exact bKink_duopoly_boundary_continuation hθpos.ne'
    (reducedDet_pos hθ hR).ne' hb

/-- Model-level B kink/monopoly boundary certificate. -/
theorem model_bKink_bMonopoly_boundary_continuation
    {kx kg μ θ wA wB : ℝ}
    (hθ : θ ∈ Icc (0 : ℝ) 1) (hθpos : 0 < θ)
    (hR : investmentR kx kg μ < (3 / 4 : ℝ))
    (hb : θ * wB = monopolyM (investmentR kx kg μ) * wA) :
    bKinkContinuation θ wA wB =
      bMonopolyContinuation (investmentR kx kg μ) wB := by
  exact bKink_bMonopoly_boundary_continuation hθpos.ne'
    (monopolyM_pos hθ hR).ne' hb

end SLGPC
