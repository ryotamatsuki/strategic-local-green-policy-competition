import Mathlib

noncomputable section

open Set

namespace SLGPC

/-- Canonical switching polynomial from equation (witness-P) of the manuscript. -/
def witnessP (u : ℝ) : ℝ :=
  602500 * u ^ 4 - 8101550 * u ^ 3 + 39588109 * u ^ 2 - 74143042 * u + 31863144

/-- Ordinary derivative of `witnessP`. -/
def witnessPDeriv (u : ℝ) : ℝ :=
  2410000 * u ^ 3 - 24304650 * u ^ 2 + 79176218 * u - 74143042

/-- Cubic Bernstein representation of the derivative on `[0,1]`.

The coefficients are `B₀ = -74143042`, `3 B₁ = -143252908`,
`3 B₂ = -88381340`, and `B₃ = -16861474`.
-/
def witnessPBernstein (u : ℝ) : ℝ :=
  (-74143042) * (1 - u) ^ 3
    - 143252908 * u * (1 - u) ^ 2
    - 88381340 * u ^ 2 * (1 - u)
    - 16861474 * u ^ 3

lemma witnessPDeriv_eq_bernstein (u : ℝ) :
    witnessPDeriv u = witnessPBernstein u := by
  unfold witnessPDeriv witnessPBernstein
  ring

lemma witnessPDeriv_neg {u : ℝ} (hu : u ∈ Icc (0 : ℝ) 1) :
    witnessPDeriv u < 0 := by
  rw [witnessPDeriv_eq_bernstein]
  rcases hu with ⟨hu0, hu1⟩
  by_cases h1 : u = 1
  · subst u
    norm_num [witnessPBernstein]
  · have hu_lt_one : u < 1 := lt_of_le_of_ne hu1 h1
    have h1u : 0 < 1 - u := by linarith
    have hterm0 : (-74143042 : ℝ) * (1 - u) ^ 3 < 0 :=
      mul_neg_of_neg_of_pos (by norm_num) (pow_pos h1u 3)
    have hprod1 : 0 ≤ u * (1 - u) ^ 2 :=
      mul_nonneg hu0 (sq_nonneg (1 - u))
    have hprod2 : 0 ≤ u ^ 2 * (1 - u) :=
      mul_nonneg (sq_nonneg u) (le_of_lt h1u)
    have hprod3 : 0 ≤ u ^ 3 := pow_nonneg hu0 3
    have hterm1 : (-143252908 : ℝ) * u * (1 - u) ^ 2 ≤ 0 := by
      nlinarith
    have hterm2 : (-88381340 : ℝ) * u ^ 2 * (1 - u) ≤ 0 := by
      nlinarith
    have hterm3 : (-16861474 : ℝ) * u ^ 3 ≤ 0 := by
      nlinarith
    unfold witnessPBernstein
    nlinarith

lemma hasDerivAt_witnessP (u : ℝ) :
    HasDerivAt witnessP (witnessPDeriv u) u := by
  unfold witnessP witnessPDeriv
  convert!
    ((((((hasDerivAt_id u).pow 4).const_mul 602500).sub
      (((hasDerivAt_id u).pow 3).const_mul 8101550)).add
      (((hasDerivAt_id u).pow 2).const_mul 39588109)).sub
      ((hasDerivAt_id u).const_mul 74143042)).const_add 31863144 using 1
  · funext x
    simp only [Pi.pow_apply, Pi.sub_apply, Pi.add_apply, id_eq]
    ring
  · simp only [id_eq]
    ring

lemma witnessP_continuous : Continuous witnessP := by
  unfold witnessP
  fun_prop

/-- The canonical switching polynomial is strictly decreasing on `[0,1]`. -/
theorem witnessP_strictAntiOn : StrictAntiOn witnessP (Icc (0 : ℝ) 1) := by
  refine strictAntiOn_of_deriv_neg (convex_Icc (0 : ℝ) 1)
    witnessP_continuous.continuousOn ?_
  intro u hu
  rw [(hasDerivAt_witnessP u).deriv]
  exact witnessPDeriv_neg (interior_subset hu)

lemma witnessP_zero_pos : 0 < witnessP 0 := by
  norm_num [witnessP]

lemma witnessP_one_neg : witnessP 1 < 0 := by
  norm_num [witnessP]

/-- Existence of a switching root follows from the exact endpoint signs and continuity. -/
theorem witnessP_exists_root :
    ∃ u ∈ Ioo (0 : ℝ) 1, witnessP u = 0 := by
  have hmem : (0 : ℝ) ∈ Icc (witnessP 1) (witnessP 0) :=
    ⟨witnessP_one_neg.le, witnessP_zero_pos.le⟩
  have himage : (0 : ℝ) ∈ witnessP '' Icc (0 : ℝ) 1 :=
    intermediate_value_Icc' (by norm_num) witnessP_continuous.continuousOn hmem
  rcases himage with ⟨u, hu, hPu⟩
  refine ⟨u, ?_, hPu⟩
  constructor
  · by_contra h
    have hu_eq : u = 0 := by linarith [hu.1]
    subst u
    norm_num [witnessP] at hPu
  · by_contra h
    have hu_eq : u = 1 := by linarith [hu.2]
    subst u
    norm_num [witnessP] at hPu

/-- The canonical switching polynomial has exactly one root in `(0,1)`. -/
theorem witnessP_unique_root :
    ∃! u : ℝ, u ∈ Ioo (0 : ℝ) 1 ∧ witnessP u = 0 := by
  obtain ⟨u, hu, hPu⟩ := witnessP_exists_root
  refine ⟨u, ⟨hu, hPu⟩, ?_⟩
  intro v hv
  exact witnessP_strictAntiOn.injOn
    ⟨hv.1.1.le, hv.1.2.le⟩
    ⟨hu.1.le, hu.2.le⟩
    (by rw [hv.2, hPu])

lemma witnessP_5987_pos : 0 < witnessP ((5987 : ℝ) / 10000) := by
  norm_num [witnessP]

lemma witnessP_5988_neg : witnessP ((5988 : ℝ) / 10000) < 0 := by
  norm_num [witnessP]

/-- Exact rational localization of the unique `u = θ²` switching root. -/
theorem witnessP_root_in_rational_bracket :
    ∃ u ∈ Ioo ((5987 : ℝ) / 10000) ((5988 : ℝ) / 10000), witnessP u = 0 := by
  have hab : ((5987 : ℝ) / 10000) ≤ (5988 : ℝ) / 10000 := by norm_num
  have hmem : (0 : ℝ) ∈
      Icc (witnessP ((5988 : ℝ) / 10000)) (witnessP ((5987 : ℝ) / 10000)) :=
    ⟨witnessP_5988_neg.le, witnessP_5987_pos.le⟩
  have himage : (0 : ℝ) ∈ witnessP ''
      Icc ((5987 : ℝ) / 10000) ((5988 : ℝ) / 10000) :=
    intermediate_value_Icc' hab witnessP_continuous.continuousOn hmem
  rcases himage with ⟨u, hu, hPu⟩
  refine ⟨u, ?_, hPu⟩
  constructor
  · by_contra h
    have hu_eq : u = (5987 : ℝ) / 10000 := by linarith [hu.1]
    subst u
    nlinarith [witnessP_5987_pos]
  · by_contra h
    have hu_eq : u = (5988 : ℝ) / 10000 := by linarith [hu.2]
    subst u
    nlinarith [witnessP_5988_neg]

/-- Quadratic factor of the matched no-conventional-investment benchmark. -/
def noXQuadratic (u : ℝ) : ℝ :=
  602500 * u ^ 2 - 3281550 * u + 3486659

/-- The no-`x` quadratic factor is strictly positive on `[0,1]`. -/
theorem noXQuadratic_pos {u : ℝ} (hu : u ∈ Icc (0 : ℝ) 1) :
    0 < noXQuadratic u := by
  rcases hu with ⟨hu0, hu1⟩
  have h1 : 0 ≤ 1 - u := by linarith
  have hlin : 0 ≤ 2679050 - 602500 * u := by nlinarith
  have hprod : 0 ≤ (1 - u) * (2679050 - 602500 * u) :=
    mul_nonneg h1 hlin
  have hid : noXQuadratic u =
      807609 + (1 - u) * (2679050 - 602500 * u) := by
    unfold noXQuadratic
    ring
  rw [hid]
  nlinarith

/-- Full factorized no-`x` benchmark polynomial is positive on `[0,1]`. -/
def noXFactorized (u : ℝ) : ℝ := (4 - u) ^ 2 * noXQuadratic u

theorem noXFactorized_pos {u : ℝ} (hu : u ∈ Icc (0 : ℝ) 1) :
    0 < noXFactorized u := by
  have h4 : 0 < 4 - u := by linarith [hu.2]
  unfold noXFactorized
  exact mul_pos (pow_pos h4 2) (noXQuadratic_pos hu)

/-- The canonical primitives satisfy the maintained `R < 3/4` regularity bound exactly. -/
theorem canonical_R_lt_three_quarters :
    (1 / 4 : ℝ) + ((9 / 10 : ℝ) ^ 2) / 18 < 3 / 4 := by
  norm_num

end SLGPC
