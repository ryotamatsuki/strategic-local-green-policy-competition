import Mathlib

noncomputable section

open Set

namespace SLGPC

/-- Generic quartic switching polynomial from Proposition 2. -/
def thresholdQuartic
    (A4 A3 A2 A1 A0 u : ℝ) : ℝ :=
  A4 * u ^ 4 + A3 * u ^ 3 + A2 * u ^ 2 + A1 * u + A0

/-- Ordinary derivative of the generic quartic. -/
def thresholdQuarticDeriv
    (A4 A3 A2 A1 : ℝ) (u : ℝ) : ℝ :=
  4 * A4 * u ^ 3 + 3 * A3 * u ^ 2 + 2 * A2 * u + A1

/-- Bernstein coefficients of `P'` on `[0,1]`, exactly as in Proposition 2. -/
def thresholdB0 (A1 : ℝ) : ℝ := A1

def thresholdB1 (A2 A1 : ℝ) : ℝ := A1 + (2 / 3 : ℝ) * A2

def thresholdB2 (A3 A2 A1 : ℝ) : ℝ :=
  A1 + (4 / 3 : ℝ) * A2 + A3

def thresholdB3 (A4 A3 A2 A1 : ℝ) : ℝ :=
  A1 + 2 * A2 + 3 * A3 + 4 * A4

/-- Cubic Bernstein representation of the generic quartic derivative. -/
def thresholdQuarticBernstein
    (A4 A3 A2 A1 : ℝ) (u : ℝ) : ℝ :=
  thresholdB0 A1 * (1 - u) ^ 3
    + 3 * thresholdB1 A2 A1 * u * (1 - u) ^ 2
    + 3 * thresholdB2 A3 A2 A1 * u ^ 2 * (1 - u)
    + thresholdB3 A4 A3 A2 A1 * u ^ 3

lemma thresholdQuarticDeriv_eq_bernstein
    (A4 A3 A2 A1 u : ℝ) :
    thresholdQuarticDeriv A4 A3 A2 A1 u =
      thresholdQuarticBernstein A4 A3 A2 A1 u := by
  unfold thresholdQuarticDeriv thresholdQuarticBernstein
    thresholdB0 thresholdB1 thresholdB2 thresholdB3
  ring

lemma thresholdQuarticDeriv_neg
    {A4 A3 A2 A1 u : ℝ}
    (hB0 : thresholdB0 A1 < 0)
    (hB1 : thresholdB1 A2 A1 < 0)
    (hB2 : thresholdB2 A3 A2 A1 < 0)
    (hB3 : thresholdB3 A4 A3 A2 A1 < 0)
    (hu : u ∈ Icc (0 : ℝ) 1) :
    thresholdQuarticDeriv A4 A3 A2 A1 u < 0 := by
  rw [thresholdQuarticDeriv_eq_bernstein]
  rcases hu with ⟨hu0, hu1⟩
  by_cases h1 : u = 1
  · subst u
    simp [thresholdQuarticBernstein]
    exact hB3
  · have hu_lt_one : u < 1 := lt_of_le_of_ne hu1 h1
    have h1u : 0 < 1 - u := by linarith
    have hterm0 : thresholdB0 A1 * (1 - u) ^ 3 < 0 :=
      mul_neg_of_neg_of_pos hB0 (pow_pos h1u 3)
    have hprod1 : 0 ≤ u * (1 - u) ^ 2 :=
      mul_nonneg hu0 (sq_nonneg (1 - u))
    have hprod2 : 0 ≤ u ^ 2 * (1 - u) :=
      mul_nonneg (sq_nonneg u) (le_of_lt h1u)
    have hprod3 : 0 ≤ u ^ 3 := pow_nonneg hu0 3
    have hterm1 : 3 * thresholdB1 A2 A1 * u * (1 - u) ^ 2 ≤ 0 := by
      have hb : 3 * thresholdB1 A2 A1 ≤ 0 := by nlinarith
      nlinarith
    have hterm2 : 3 * thresholdB2 A3 A2 A1 * u ^ 2 * (1 - u) ≤ 0 := by
      have hb : 3 * thresholdB2 A3 A2 A1 ≤ 0 := by nlinarith
      nlinarith
    have hterm3 : thresholdB3 A4 A3 A2 A1 * u ^ 3 ≤ 0 := by
      exact mul_nonpos_of_nonpos_of_nonneg hB3.le hprod3
    unfold thresholdQuarticBernstein
    nlinarith

lemma hasDerivAt_thresholdQuartic
    (A4 A3 A2 A1 A0 u : ℝ) :
    HasDerivAt (thresholdQuartic A4 A3 A2 A1 A0)
      (thresholdQuarticDeriv A4 A3 A2 A1 u) u := by
  unfold thresholdQuartic thresholdQuarticDeriv
  convert!
    ((((((hasDerivAt_id u).pow 4).const_mul A4).add
      (((hasDerivAt_id u).pow 3).const_mul A3)).add
      (((hasDerivAt_id u).pow 2).const_mul A2)).add
      ((hasDerivAt_id u).const_mul A1)).const_add A0 using 1
  · funext x
    simp only [Pi.pow_apply, Pi.add_apply, id_eq]
    ring
  · simp only [id_eq]
    ring

lemma thresholdQuartic_continuous
    (A4 A3 A2 A1 A0 : ℝ) :
    Continuous (thresholdQuartic A4 A3 A2 A1 A0) := by
  unfold thresholdQuartic
  fun_prop

/-- Negative Bernstein coefficients make the generic quartic strictly decreasing on `[0,1]`. -/
theorem thresholdQuartic_strictAntiOn
    {A4 A3 A2 A1 A0 : ℝ}
    (hB0 : thresholdB0 A1 < 0)
    (hB1 : thresholdB1 A2 A1 < 0)
    (hB2 : thresholdB2 A3 A2 A1 < 0)
    (hB3 : thresholdB3 A4 A3 A2 A1 < 0) :
    StrictAntiOn (thresholdQuartic A4 A3 A2 A1 A0) (Icc (0 : ℝ) 1) := by
  refine strictAntiOn_of_deriv_neg (convex_Icc (0 : ℝ) 1)
    (thresholdQuartic_continuous A4 A3 A2 A1 A0).continuousOn ?_
  intro u hu
  rw [(hasDerivAt_thresholdQuartic A4 A3 A2 A1 A0 u).deriv]
  exact thresholdQuarticDeriv_neg hB0 hB1 hB2 hB3 (interior_subset hu)

/-- Algebraic core of Proposition 2: endpoint sign reversal plus negative derivative
Bernstein coefficients imply exactly one switching root in `(0,1)`. -/
theorem thresholdQuartic_unique_root
    {A4 A3 A2 A1 A0 : ℝ}
    (hP0 : 0 < thresholdQuartic A4 A3 A2 A1 A0 0)
    (hP1 : thresholdQuartic A4 A3 A2 A1 A0 1 < 0)
    (hB0 : thresholdB0 A1 < 0)
    (hB1 : thresholdB1 A2 A1 < 0)
    (hB2 : thresholdB2 A3 A2 A1 < 0)
    (hB3 : thresholdB3 A4 A3 A2 A1 < 0) :
    ∃! u : ℝ,
      u ∈ Ioo (0 : ℝ) 1 ∧ thresholdQuartic A4 A3 A2 A1 A0 u = 0 := by
  let P := thresholdQuartic A4 A3 A2 A1 A0
  have hcont : Continuous P := thresholdQuartic_continuous A4 A3 A2 A1 A0
  have hanti : StrictAntiOn P (Icc (0 : ℝ) 1) :=
    thresholdQuartic_strictAntiOn hB0 hB1 hB2 hB3
  have hmem : (0 : ℝ) ∈ Icc (P 1) (P 0) := ⟨hP1.le, hP0.le⟩
  have himage : (0 : ℝ) ∈ P '' Icc (0 : ℝ) 1 :=
    intermediate_value_Icc' (by norm_num) hcont.continuousOn hmem
  rcases himage with ⟨u, hu, hPu⟩
  have hu_open : u ∈ Ioo (0 : ℝ) 1 := by
    constructor
    · by_contra h
      have hu_eq : u = 0 := by linarith [hu.1]
      subst u
      exact (ne_of_gt hP0) hPu
    · by_contra h
      have hu_eq : u = 1 := by linarith [hu.2]
      subst u
      exact (ne_of_lt hP1) hPu
  refine ⟨u, ⟨hu_open, hPu⟩, ?_⟩
  intro v hv
  exact hanti.injOn
    ⟨hv.1.1.le, hv.1.2.le⟩
    ⟨hu_open.1.le, hu_open.2.le⟩
    (by simpa [P] using hv.2.trans hPu.symm)

end SLGPC
