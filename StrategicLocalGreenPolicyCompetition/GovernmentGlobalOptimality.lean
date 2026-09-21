import StrategicLocalGreenPolicyCompetition.GovernmentGlobalBoundary

noncomputable section

open Set

namespace SLGPC

set_option maxRecDepth 100000

/-- Exact link between the Bernstein-certified lower-margin polynomial and the
model inequality excluding rival-dominance regimes. -/
theorem canonicalLowerMargin_identity
    {θ : ℝ} (hθ : θ ∈ Icc (0 : ℝ) 1) :
    2 * canonicalL θ - θ * canonicalSymmetricW θ =
      canonicalLowerMarginPoly θ /
        (25 * cournotD θ * canonicalSymmetricDen θ) := by
  have hD : cournotD θ ≠ 0 := (cournotD_pos hθ).ne'
  have hden : canonicalSymmetricDen θ ≠ 0 :=
    (canonicalSymmetricDen_pos hθ).ne'
  unfold canonicalSymmetricW reducedW policyY canonicalSymmetricS canonicalSymmetricH
  rw [canonicalL_closed hθ]
  field_simp [hD, hden]
  unfold canonicalLowerMarginPoly canonicalSymmetricDen
    canonicalSymmetricSNum canonicalSymmetricHNum cournotD
  ring

/-- Against the symmetric canonical rival, any nonnegative own policy profile has
an intercept high enough that the B-kink/B-monopoly side is strictly inaccessible. -/
theorem canonicalLowerSide_inaccessible
    {θ s h : ℝ} (hθ : θ ∈ Icc (0 : ℝ) 1) (hs : 0 ≤ s) (hh : 0 ≤ h) :
    θ * canonicalSymmetricW θ < canonicalL θ * canonicalOwnW s h := by
  have hD := cournotD_pos hθ
  have hden := canonicalSymmetricDen_pos hθ
  have hp := canonicalLowerMarginPoly_pos hθ
  have hmargin : 0 < 2 * canonicalL θ - θ * canonicalSymmetricW θ := by
    rw [canonicalLowerMargin_identity hθ]
    exact div_pos hp (mul_pos (mul_pos (by norm_num) hD) hden)
  have hR : investmentR 4 18 (9 / 10 : ℝ) < (3 / 4 : ℝ) := by
    rw [canonicalInvestmentR]
    norm_num
  have hL : 0 < canonicalL θ := reducedL_pos hθ hR
  have hw : 2 ≤ canonicalOwnW s h := by
    unfold canonicalOwnW reducedW policyY
    nlinarith
  nlinarith [mul_nonneg hL.le (sub_nonneg.mpr hw)]

/-- At the common K/M boundary, the kink continuation and monopoly continuation
have the same quantity and scalar private cost reduction, hence the same welfare. -/
theorem canonicalBoundary_kink_eq_monopoly
    {θ : ℝ} (hθ : θ ∈ Ioc (0 : ℝ) 1) :
    canonicalKinkGovernmentWelfare θ (canonicalSymmetricW θ)
        (canonicalBoundaryS θ) (canonicalBoundaryH θ) =
      canonicalMonopolyGovernmentWelfare θ
        (canonicalBoundaryS θ) (canonicalBoundaryH θ) := by
  have ht : θ ≠ 0 := hθ.1.ne'
  have hb := canonicalBoundary_intercept hθ
  let wb := canonicalOwnW (canonicalBoundaryS θ) (canonicalBoundaryH θ)
  let wr := canonicalSymmetricW θ
  have hq : wr / θ = wb / (341 / 200 : ℝ) := by
    dsimp [wb, wr]
    field_simp [ht]
    nlinarith [hb]
  have hell :
      (2 * wr / θ - wb) / (59 / 200 : ℝ) = wb / (341 / 200 : ℝ) := by
    dsimp [wb, wr]
    field_simp [ht]
    nlinarith [hb]
  unfold canonicalKinkGovernmentWelfare canonicalMonopolyGovernmentWelfare
  dsimp [wb, wr]
  rw [hq, hell]

/-- The common boundary is the global maximum of the kink branch over its side
of the boundary. -/
theorem canonicalKink_branch_le_boundary
    {θ s h : ℝ} (hθ : θ ∈ Ioc (0 : ℝ) 1)
    (hside : canonicalOwnW s h ≤
      canonicalOwnW (canonicalBoundaryS θ) (canonicalBoundaryH θ)) :
    canonicalKinkGovernmentWelfare θ (canonicalSymmetricW θ) s h ≤
      canonicalKinkGovernmentWelfare θ (canonicalSymmetricW θ)
        (canonicalBoundaryS θ) (canonicalBoundaryH θ) := by
  have hexp := canonicalKinkGovernmentWelfare_expansion
    (θ := θ) (WB := canonicalSymmetricW θ)
    (s0 := canonicalBoundaryS θ) (h0 := canonicalBoundaryH θ)
    (s := s) (h := h) hθ.1.ne'
  rcases canonicalBoundary_kink_gradient hθ with ⟨hgs, hgh⟩
  have hlam := canonicalKinkMultiplier_pos hθ
  have hdw :
      (1 / 20 : ℝ) * (s - canonicalBoundaryS θ) +
        (6 / 5 : ℝ) * (h - canonicalBoundaryH θ) ≤ 0 := by
    unfold canonicalOwnW reducedW policyY at hside
    nlinarith
  have hlin0 : canonicalKinkMultiplier θ *
      ((1 / 20 : ℝ) * (s - canonicalBoundaryS θ) +
        (6 / 5 : ℝ) * (h - canonicalBoundaryH θ)) ≤ 0 :=
    mul_nonpos_of_nonneg_of_nonpos hlam.le hdw
  have hquad := canonicalKinkQuadratic_nonpos
    (s - canonicalBoundaryS θ) (h - canonicalBoundaryH θ)
  rw [hexp, hgs, hgh]
  nlinarith

/-- The common boundary is the global maximum of the monopoly branch over its
side of the boundary. -/
theorem canonicalMonopoly_branch_le_boundary
    {θ s h : ℝ} (hθ : θ ∈ Ioc (0 : ℝ) 1)
    (hside : canonicalOwnW (canonicalBoundaryS θ) (canonicalBoundaryH θ) ≤
      canonicalOwnW s h) :
    canonicalMonopolyGovernmentWelfare θ s h ≤
      canonicalMonopolyGovernmentWelfare θ
        (canonicalBoundaryS θ) (canonicalBoundaryH θ) := by
  have hexp := canonicalMonopolyGovernmentWelfare_expansion
    (θ := θ) (s0 := canonicalBoundaryS θ) (h0 := canonicalBoundaryH θ)
    (s := s) (h := h)
  rcases canonicalBoundary_monopoly_gradient hθ with ⟨hgs, hgh⟩
  have hlam := canonicalMonopolyMultiplier_neg hθ
  have hdw :
      0 ≤ (1 / 20 : ℝ) * (s - canonicalBoundaryS θ) +
        (6 / 5 : ℝ) * (h - canonicalBoundaryH θ) := by
    unfold canonicalOwnW reducedW policyY at hside
    nlinarith
  have hlin0 : canonicalMonopolyMultiplier θ *
      ((1 / 20 : ℝ) * (s - canonicalBoundaryS θ) +
        (6 / 5 : ℝ) * (h - canonicalBoundaryH θ)) ≤ 0 :=
    mul_nonpos_of_nonpos_of_nonneg hlam.le hdw
  have hquad := canonicalMonopolyQuadratic_nonpos
    (s - canonicalBoundaryS θ) (h - canonicalBoundaryH θ)
  rw [hexp, hgs, hgh]
  nlinarith

/-- First positive factor in the exact equilibrium-versus-boundary welfare gap. -/
def canonicalGapP6 (θ : ℝ) : ℝ :=
  -605750 * θ ^ 6 + 6803700 * θ ^ 4 - 22987057 * θ ^ 2 + 22571813

def canonicalGapP6Bernstein (θ : ℝ) : ℝ :=
  22571813 * (1 - θ) ^ 6 +
    135430878 * θ * (1 - θ) ^ 5 +
    315590138 * θ ^ 2 * (1 - θ) ^ 4 +
    359488032 * θ ^ 3 * (1 - θ) ^ 3 +
    207458553 * θ ^ 4 * (1 - θ) ^ 2 +
    57090050 * θ ^ 5 * (1 - θ) +
    5782706 * θ ^ 6

lemma canonicalGapP6_bernstein (θ : ℝ) :
    canonicalGapP6 θ = canonicalGapP6Bernstein θ := by
  unfold canonicalGapP6 canonicalGapP6Bernstein
  ring

theorem canonicalGapP6_pos {θ : ℝ} (hθ : θ ∈ Ioc (0 : ℝ) 1) :
    0 < canonicalGapP6 θ := by
  have ht : 0 < θ := hθ.1
  have hb : 0 ≤ 1 - θ := sub_nonneg.mpr hθ.2
  rw [canonicalGapP6_bernstein]
  unfold canonicalGapP6Bernstein
  positivity

/-- Second positive factor in the exact equilibrium-versus-boundary welfare gap. -/
def canonicalGapP14 (θ : ℝ) : ℝ :=
  -2935464500000000 * θ ^ 14 - 1467732250000000 * θ ^ 13 +
    64546933037500000 * θ ^ 12 + 22484629809375000 * θ ^ 11 -
    585285271038500000 * θ ^ 10 - 106668091596375000 * θ ^ 9 +
    2851273741590887500 * θ ^ 8 + 109072100726950000 * θ ^ 7 -
    8131345252276991000 * θ ^ 6 + 348492958346767750 * θ ^ 5 +
    13802322991331619100 * θ ^ 4 - 587951673614838500 * θ ^ 3 -
    13158532603132076017 * θ ^ 2 + 5436225316285641053

def canonicalGapP14Bernstein (θ : ℝ) : ℝ :=
  5436225316285641053 * (1 - θ) ^ 14 +
    76107154427998974742 * θ * (1 - θ) ^ 13 +
    481537971178861259806 * θ ^ 2 * (1 - θ) ^ 12 +
    1820295672216773592588 * θ ^ 3 * (1 - θ) ^ 11 +
    4580533244376778072531 * θ ^ 4 * (1 - θ) ^ 10 +
    8094480291337643505616 * θ ^ 5 * (1 - θ) ^ 9 +
    10330608586091720879494 * θ ^ 6 * (1 - θ) ^ 8 +
    9645426227061608136432 * θ ^ 7 * (1 - θ) ^ 7 +
    6598565174365378746951 * θ ^ 8 * (1 - θ) ^ 6 +
    3276163249226157949342 * θ ^ 9 * (1 - θ) ^ 5 +
    1152835627950881925638 * θ ^ 10 * (1 - θ) ^ 4 +
    274551310612832179052 * θ ^ 11 * (1 - θ) ^ 3 +
    40481852492511089201 * θ ^ 12 * (1 - θ) ^ 2 +
    3037944936623236788 * θ ^ 13 * (1 - θ) +
    60232582719959886 * θ ^ 14

lemma canonicalGapP14_bernstein (θ : ℝ) :
    canonicalGapP14 θ = canonicalGapP14Bernstein θ := by
  unfold canonicalGapP14 canonicalGapP14Bernstein
  ring

theorem canonicalGapP14_pos {θ : ℝ} (hθ : θ ∈ Ioc (0 : ℝ) 1) :
    0 < canonicalGapP14 θ := by
  have ht : 0 < θ := hθ.1
  have hb : 0 ≤ 1 - θ := sub_nonneg.mpr hθ.2
  rw [canonicalGapP14_bernstein]
  unfold canonicalGapP14Bernstein
  positivity

end SLGPC
