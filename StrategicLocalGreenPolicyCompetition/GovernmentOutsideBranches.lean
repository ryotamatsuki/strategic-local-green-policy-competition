import StrategicLocalGreenPolicyCompetition.GovernmentGlobalNash

noncomputable section

open Set

namespace SLGPC

set_option maxRecDepth 100000

/-- Canonical own reduced intercept as a function of jurisdiction A's policies. -/
def canonicalOwnW (s h : ℝ) : ℝ :=
  reducedW 2 18 (9 / 10 : ℝ) (6 / 5 : ℝ) s h

/-- Government welfare evaluated from a downstream quantity and the scalar
private cost-reduction continuation.  This is the common primitive expression
used for the A-kink and A-monopoly branches. -/
def canonicalOutsideGovernmentWelfare
    (θ qA qB ellA s h : ℝ) : ℝ :=
  halfConsumerSurplus θ qA qB +
    (qA ^ 2 - 4 / 2 * (ellA / 4) ^ 2 -
      18 / 2 * ((s + (9 / 10 : ℝ) * ellA) / 18) ^ 2) -
    (4 / 5 : ℝ) / 2 * h ^ 2 -
    2 / 2 * ((11 / 10 : ℝ) * qA -
      (17 / 10 : ℝ) * ((s + (9 / 10 : ℝ) * ellA) / 18) -
      (1 / 10 : ℝ) * h) ^ 2

/-- A-kink government branch against rival post-investment intercept `WB`. -/
def canonicalKinkGovernmentWelfare (θ WB s h : ℝ) : ℝ :=
  canonicalOutsideGovernmentWelfare θ (WB / θ) 0
    ((2 * WB / θ - canonicalOwnW s h) / (59 / 200 : ℝ)) s h

/-- A-monopoly government branch. -/
def canonicalMonopolyGovernmentWelfare (θ s h : ℝ) : ℝ :=
  let q := canonicalOwnW s h / (341 / 200 : ℝ)
  canonicalOutsideGovernmentWelfare θ q 0 q s h

/-- Exact first derivatives of the kink branch. -/
def canonicalKinkGradS (θ WB s h : ℝ) : ℝ :=
  (47277 * WB + 22185 * h * θ - 33775 * s * θ + 52020 * θ) /
    (563922 * θ)

def canonicalKinkGradH (θ WB s h : ℝ) : ℝ :=
  (2468151 * WB - 1817757 * h * θ + 12325 * s * θ - 2637540 * θ) /
    (313290 * θ)

/-- Exact first derivatives of the monopoly branch. -/
def canonicalMonopolyGradS (s h : ℝ) : ℝ :=
  (1691487 * h - 1223659 * s + 3225276) / 18837522

def canonicalMonopolyGradH (s h : ℝ) : ℝ :=
  (-4841757 * h + 939715 * s + 3740940) / 10465290

/-- Constant Hessian entries on the two outside branches. -/
def canonicalKinkHss : ℝ := -33775 / 563922
def canonicalKinkHsh : ℝ := 2465 / 62658
def canonicalKinkHhh : ℝ := -201973 / 34810

def canonicalMonopolyHss : ℝ := -1223659 / 18837522
def canonicalMonopolyHsh : ℝ := 187943 / 2093058
def canonicalMonopolyHhh : ℝ := -537973 / 1162810

/-- Exact second-order expansion of the A-kink branch. -/
theorem canonicalKinkGovernmentWelfare_expansion
    {θ WB s0 h0 s h : ℝ} (hθ : θ ≠ 0) :
    canonicalKinkGovernmentWelfare θ WB s h =
      canonicalKinkGovernmentWelfare θ WB s0 h0 +
      (s - s0) * canonicalKinkGradS θ WB s0 h0 +
      (h - h0) * canonicalKinkGradH θ WB s0 h0 +
      (1 / 2 : ℝ) *
        (canonicalKinkHss * (s - s0) ^ 2 +
         2 * canonicalKinkHsh * (s - s0) * (h - h0) +
         canonicalKinkHhh * (h - h0) ^ 2) := by
  unfold canonicalKinkGovernmentWelfare canonicalOutsideGovernmentWelfare
    canonicalOwnW reducedW policyY halfConsumerSurplus
    canonicalKinkGradS canonicalKinkGradH
    canonicalKinkHss canonicalKinkHsh canonicalKinkHhh
  field_simp [hθ]
  ring

/-- Exact second-order expansion of the A-monopoly branch. -/
theorem canonicalMonopolyGovernmentWelfare_expansion
    {θ s0 h0 s h : ℝ} :
    canonicalMonopolyGovernmentWelfare θ s h =
      canonicalMonopolyGovernmentWelfare θ s0 h0 +
      (s - s0) * canonicalMonopolyGradS s0 h0 +
      (h - h0) * canonicalMonopolyGradH s0 h0 +
      (1 / 2 : ℝ) *
        (canonicalMonopolyHss * (s - s0) ^ 2 +
         2 * canonicalMonopolyHsh * (s - s0) * (h - h0) +
         canonicalMonopolyHhh * (h - h0) ^ 2) := by
  unfold canonicalMonopolyGovernmentWelfare canonicalOutsideGovernmentWelfare
    canonicalOwnW reducedW policyY halfConsumerSurplus
    canonicalMonopolyGradS canonicalMonopolyGradH
    canonicalMonopolyHss canonicalMonopolyHsh canonicalMonopolyHhh
  dsimp
  ring

lemma canonicalKinkHessian_sylvester :
    canonicalKinkHss < 0 ∧
    0 < canonicalKinkHss * canonicalKinkHhh - canonicalKinkHsh ^ 2 := by
  constructor <;>
    norm_num [canonicalKinkHss, canonicalKinkHsh, canonicalKinkHhh]

lemma canonicalMonopolyHessian_sylvester :
    canonicalMonopolyHss < 0 ∧
    0 < canonicalMonopolyHss * canonicalMonopolyHhh -
      canonicalMonopolyHsh ^ 2 := by
  constructor <;>
    norm_num [canonicalMonopolyHss, canonicalMonopolyHsh, canonicalMonopolyHhh]

/-- The kink-branch quadratic remainder is nonpositive in every direction. -/
theorem canonicalKinkQuadratic_nonpos (ds dh : ℝ) :
    canonicalKinkHss * ds ^ 2 + 2 * canonicalKinkHsh * ds * dh +
      canonicalKinkHhh * dh ^ 2 ≤ 0 := by
  by_cases hdir : ds ≠ 0 ∨ dh ≠ 0
  · exact (twoByTwo_quadratic_neg_of_sylvester
      canonicalKinkHessian_sylvester.1 canonicalKinkHessian_sylvester.2 hdir).le
  · push_neg at hdir
    rcases hdir with ⟨rfl, rfl⟩
    norm_num

/-- The monopoly-branch quadratic remainder is nonpositive in every direction. -/
theorem canonicalMonopolyQuadratic_nonpos (ds dh : ℝ) :
    canonicalMonopolyHss * ds ^ 2 + 2 * canonicalMonopolyHsh * ds * dh +
      canonicalMonopolyHhh * dh ^ 2 ≤ 0 := by
  by_cases hdir : ds ≠ 0 ∨ dh ≠ 0
  · exact (twoByTwo_quadratic_neg_of_sylvester
      canonicalMonopolyHessian_sylvester.1 canonicalMonopolyHessian_sylvester.2 hdir).le
  · push_neg at hdir
    rcases hdir with ⟨rfl, rfl⟩
    norm_num

end SLGPC
