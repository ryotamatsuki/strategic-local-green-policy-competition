import StrategicLocalGreenPolicyCompetition.Stage2GlobalBestResponse

noncomputable section

open Set

namespace SLGPC

/-- On nonnegative scalar deviations from a positive reduced intercept, the full
nonnegative Cournot operating payoff is bounded above by the algebraic active-
duopoly square.  Clipping a negative active quantity to zero or clipping an
excessively large active quantity to the monopoly best response can only reduce
its square. -/
theorem fullCournotOperatingProfit_le_duopoly_square
    {θ wi vj u : ℝ} (hwi : 0 < wi) (hu : 0 ≤ u) :
    fullCournotOwnOperatingProfit θ (wi + u) vj ≤
      duopolyOwnQuantity θ wi vj u ^ 2 := by
  have hm : 0 ≤ (wi + u) / 2 := by linarith
  unfold fullCournotOwnOperatingProfit fullCournotOwnQuantity duopolyOwnQuantity
  by_cases hd : 0 ≤ (2 * (wi + u) - θ * vj) / cournotD θ
  · have hmin :
        0 ≤ min ((wi + u) / 2) ((2 * (wi + u) - θ * vj) / cournotD θ) :=
      le_min hm hd
    rw [max_eq_right hmin]
    have hle :
        min ((wi + u) / 2) ((2 * (wi + u) - θ * vj) / cournotD θ) ≤
          (2 * (wi + u) - θ * vj) / cournotD θ := by
      exact min_le_right _ _
    have hdiff :
        0 ≤ (2 * (wi + u) - θ * vj) / cournotD θ -
          min ((wi + u) / 2) ((2 * (wi + u) - θ * vj) / cournotD θ) :=
      sub_nonneg.mpr hle
    have hsum :
        0 ≤ (2 * (wi + u) - θ * vj) / cournotD θ +
          min ((wi + u) / 2) ((2 * (wi + u) - θ * vj) / cournotD θ) := by
      linarith
    have hprod :
        0 ≤ ((2 * (wi + u) - θ * vj) / cournotD θ -
          min ((wi + u) / 2) ((2 * (wi + u) - θ * vj) / cournotD θ)) *
          ((2 * (wi + u) - θ * vj) / cournotD θ +
          min ((wi + u) / 2) ((2 * (wi + u) - θ * vj) / cournotD θ)) :=
      mul_nonneg hdiff hsum
    nlinarith
  · have hdle : (2 * (wi + u) - θ * vj) / cournotD θ ≤ 0 :=
      le_of_not_ge hd
    have hdm :
        (2 * (wi + u) - θ * vj) / cournotD θ ≤ (wi + u) / 2 := by
      linarith
    rw [min_eq_right hdm, max_eq_left hdle]
    exact sq_nonneg _

/-- Hence the full scalar continuation payoff is bounded above by the active-
duopoly quadratic on every nonnegative scalar deviation. -/
theorem fullScalarContinuationProfit_le_duopolyScalarProfit
    {R θ wi vj u : ℝ} (hwi : 0 < wi) (hu : 0 ≤ u) :
    fullScalarContinuationProfit R θ wi vj u ≤
      duopolyScalarProfit R θ wi vj u := by
  have hop := fullCournotOperatingProfit_le_duopoly_square
    (θ := θ) (wi := wi) (vj := vj) (u := u) hwi hu
  unfold fullScalarContinuationProfit duopolyScalarProfit
  linarith

/-- The full continuation is also bounded above by the monopoly branch whenever
own reduced demand is positive and the scalar deviation is nonnegative. -/
theorem fullScalarContinuationProfit_le_monopolyScalarProfit
    {R θ wi vj u : ℝ} (hwi : 0 < wi) (hu : 0 ≤ u) :
    fullScalarContinuationProfit R θ wi vj u ≤
      monopolyScalarProfit R wi u := by
  have hm : 0 ≤ (wi + u) / 2 := by linarith
  have hq0 := fullCournotOwnQuantity_nonneg θ (wi + u) vj
  have hqle : fullCournotOwnQuantity θ (wi + u) vj ≤ (wi + u) / 2 := by
    unfold fullCournotOwnQuantity
    exact max_le hm (min_le_left _ _)
  have hsquare :
      fullCournotOwnQuantity θ (wi + u) vj ^ 2 ≤ ((wi + u) / 2) ^ 2 := by
    have hdiff : 0 ≤ (wi + u) / 2 - fullCournotOwnQuantity θ (wi + u) vj :=
      sub_nonneg.mpr hqle
    have hsum : 0 ≤ (wi + u) / 2 + fullCournotOwnQuantity θ (wi + u) vj := by
      linarith
    have hprod :
        0 ≤ ((wi + u) / 2 - fullCournotOwnQuantity θ (wi + u) vj) *
          ((wi + u) / 2 + fullCournotOwnQuantity θ (wi + u) vj) :=
      mul_nonneg hdiff hsum
    nlinarith
  unfold fullScalarContinuationProfit fullCournotOwnOperatingProfit
    monopolyScalarProfit monopolyOwnQuantity
  linarith

/-- If the active-duopoly quantity is nonnegative and below the monopoly quantity,
the full nonnegative Cournot continuation is exactly the active-duopoly formula. -/
theorem fullScalarContinuationProfit_eq_duopoly
    {R θ wi vj u : ℝ}
    (h0 : 0 ≤ duopolyOwnQuantity θ wi vj u)
    (hM : duopolyOwnQuantity θ wi vj u ≤ monopolyOwnQuantity wi u) :
    fullScalarContinuationProfit R θ wi vj u =
      duopolyScalarProfit R θ wi vj u := by
  unfold fullScalarContinuationProfit fullCournotOwnOperatingProfit
    fullCournotOwnQuantity duopolyScalarProfit duopolyOwnQuantity monopolyOwnQuantity at *
  rw [min_eq_right hM, max_eq_right h0]

/-- If the monopoly quantity is nonnegative and no larger than the active formula,
the full nonnegative Cournot continuation is exactly the monopoly formula. -/
theorem fullScalarContinuationProfit_eq_monopoly
    {R θ wi vj u : ℝ}
    (h0 : 0 ≤ monopolyOwnQuantity wi u)
    (hD : monopolyOwnQuantity wi u ≤ duopolyOwnQuantity θ wi vj u) :
    fullScalarContinuationProfit R θ wi vj u =
      monopolyScalarProfit R wi u := by
  unfold fullScalarContinuationProfit fullCournotOwnOperatingProfit
    fullCournotOwnQuantity monopolyScalarProfit duopolyOwnQuantity monopolyOwnQuantity at *
  rw [min_eq_left hD, max_eq_right h0]

/-- If the algebraic active quantity is nonpositive, the full continuation is the
inactive branch. -/
theorem fullScalarContinuationProfit_eq_inactive
    {R θ wi vj u : ℝ}
    (hD : duopolyOwnQuantity θ wi vj u ≤ 0) :
    fullScalarContinuationProfit R θ wi vj u = inactiveScalarProfit R u := by
  unfold fullScalarContinuationProfit fullCournotOwnOperatingProfit
    fullCournotOwnQuantity inactiveScalarProfit duopolyOwnQuantity at *
  have hmin : min ((wi + u) / 2) ((2 * (wi + u) - θ * vj) / cournotD θ) ≤ 0 := by
    have hright :
        min ((wi + u) / 2) ((2 * (wi + u) - θ * vj) / cournotD θ) ≤
          (2 * (wi + u) - θ * vj) / cournotD θ := min_le_right _ _
    linarith
  rw [max_eq_left hmin]
  ring

/-- On the active-duopoly Stage-2 region, each firm's encoded scalar investment is
a global best response against the rival encoded investment after the full
nonnegative Stage-3 Cournot continuation. -/
theorem model_duopoly_fullScalar_best_responses
    {kx kg μ θ wA wB uA uB : ℝ}
    (hkx : 0 < kx) (hkg : 0 < kg)
    (hθ : θ ∈ Icc (0 : ℝ) 1)
    (hR : investmentR kx kg μ < (3 / 4 : ℝ))
    (hwA : 0 < wA) (hwB : 0 < wB)
    (hD : duopolyRegion (reducedL kx kg μ θ) θ wA wB)
    (huA : 0 ≤ uA) (huB : 0 ≤ uB) :
    let z := duopolyContinuation (reducedL kx kg μ θ) θ wA wB
    fullScalarContinuationProfit (investmentR kx kg μ) θ wA (wB + z.uB) uA ≤
      fullScalarContinuationProfit (investmentR kx kg μ) θ wA (wB + z.uB) z.uA ∧
    fullScalarContinuationProfit (investmentR kx kg μ) θ wB (wA + z.uA) uB ≤
      fullScalarContinuationProfit (investmentR kx kg μ) θ wB (wA + z.uA) z.uB := by
  dsimp
  let R := investmentR kx kg μ
  let L := reducedL kx kg μ θ
  let z := duopolyContinuation L θ wA wB
  have hdetpos : 0 < L ^ 2 - θ ^ 2 := by
    dsimp [L]
    exact reducedDet_pos hθ hR
  have hdet : L ^ 2 - θ ^ 2 ≠ 0 := hdetpos.ne'
  have hadm := duopoly_admissible hdetpos (reducedL_lt_two hkx hkg hθ) hD
  rcases hadm with ⟨hqA, hqB, huAz, huBz⟩
  have hstage := duopoly_stage3_identities (L := L) (θ := θ)
    (wA := wA) (wB := wB) hdet
  have hcournot := cournot_active_solution hθ hstage.1.symm hstage.2.symm
  have hownA : duopolyOwnQuantity θ wA (wB + z.uB) z.uA = z.qA := by
    unfold duopolyOwnQuantity
    exact hcournot.1.symm
  have hownB : duopolyOwnQuantity θ wB (wA + z.uA) z.uB = z.qB := by
    unfold duopolyOwnQuantity
    exact hcournot.2.symm
  have hmonA : z.qA ≤ monopolyOwnQuantity wA z.uA := by
    unfold monopolyOwnQuantity
    have hθq : 0 ≤ θ * z.qB := mul_nonneg hθ.1 hqB.le
    linarith [hstage.1]
  have hmonB : z.qB ≤ monopolyOwnQuantity wB z.uB := by
    unfold monopolyOwnQuantity
    have hθq : 0 ≤ θ * z.qA := mul_nonneg hθ.1 hqA.le
    linarith [hstage.2]
  have heqA :
      fullScalarContinuationProfit R θ wA (wB + z.uB) z.uA =
        duopolyScalarProfit R θ wA (wB + z.uB) z.uA := by
    apply fullScalarContinuationProfit_eq_duopoly
    · rw [hownA]
      exact hqA.le
    · rw [hownA]
      exact hmonA
  have heqB :
      fullScalarContinuationProfit R θ wB (wA + z.uA) z.uB =
        duopolyScalarProfit R θ wB (wA + z.uA) z.uB := by
    apply fullScalarContinuationProfit_eq_duopoly
    · rw [hownB]
      exact hqB.le
    · rw [hownB]
      exact hmonB
  have hfocs := model_duopoly_scalar_focs
    (kx := kx) (kg := kg) (μ := μ) (θ := θ) (wA := wA) (wB := wB)
    hkx hkg hθ hR
  constructor
  · calc
      fullScalarContinuationProfit R θ wA (wB + z.uB) uA ≤
          duopolyScalarProfit R θ wA (wB + z.uB) uA :=
        fullScalarContinuationProfit_le_duopolyScalarProfit hwA huA
      _ ≤ duopolyScalarProfit R θ wA (wB + z.uB) z.uA :=
        duopoly_branch_max_of_foc hkx hkg hθ hR hfocs.1
      _ = fullScalarContinuationProfit R θ wA (wB + z.uB) z.uA := heqA.symm
  · calc
      fullScalarContinuationProfit R θ wB (wA + z.uA) uB ≤
          duopolyScalarProfit R θ wB (wA + z.uA) uB :=
        fullScalarContinuationProfit_le_duopolyScalarProfit hwB huB
      _ ≤ duopolyScalarProfit R θ wB (wA + z.uA) z.uB :=
        duopoly_branch_max_of_foc hkx hkg hθ hR hfocs.2
      _ = fullScalarContinuationProfit R θ wB (wA + z.uA) z.uB := heqB.symm

end SLGPC
