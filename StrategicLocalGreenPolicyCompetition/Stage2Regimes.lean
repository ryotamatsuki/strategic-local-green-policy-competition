import StrategicLocalGreenPolicyCompetition.FirmStage

noncomputable section

open Set

namespace SLGPC

/-- The monopoly-branch slope `M = 2 - R`. -/
def monopolyM (R : ℝ) : ℝ := 2 - R

/-- Five downstream regimes used by the full Stage-2 continuation for `θ > 0`. -/
inductive Stage2Regime
  | aMonopoly
  | aKink
  | duopoly
  | bKink
  | bMonopoly
  deriving DecidableEq, Repr

/-- Tie-broken region predicates. Monopoly receives the common monopoly/kink boundary;
the kink receives the common kink/duopoly boundary. -/
def aMonopolyRegion (R θ wA wB : ℝ) : Prop :=
  monopolyM R * wB ≤ θ * wA

def aKinkRegion (R L θ wA wB : ℝ) : Prop :=
  L * wB ≤ θ * wA ∧ θ * wA < monopolyM R * wB

def duopolyRegion (L θ wA wB : ℝ) : Prop :=
  θ * wA < L * wB ∧ θ * wB < L * wA

def bKinkRegion (R L θ wA wB : ℝ) : Prop :=
  L * wA ≤ θ * wB ∧ θ * wB < monopolyM R * wA

def bMonopolyRegion (R θ wA wB : ℝ) : Prop :=
  monopolyM R * wA ≤ θ * wB

/-- The five tie-broken predicates are algebraically exhaustive. Economic uniqueness
comes from the side-incompatibility theorem below. -/
theorem stage2_regions_exhaustive (R L θ wA wB : ℝ) :
    aMonopolyRegion R θ wA wB ∨
    aKinkRegion R L θ wA wB ∨
    duopolyRegion L θ wA wB ∨
    bKinkRegion R L θ wA wB ∨
    bMonopolyRegion R θ wA wB := by
  by_cases hAM : monopolyM R * wB ≤ θ * wA
  · exact Or.inl hAM
  · have hAMlt : θ * wA < monopolyM R * wB := lt_of_not_ge hAM
    by_cases hA : L * wB ≤ θ * wA
    · exact Or.inr (Or.inl ⟨hA, hAMlt⟩)
    · have hAlt : θ * wA < L * wB := lt_of_not_ge hA
      by_cases hBM : monopolyM R * wA ≤ θ * wB
      · exact Or.inr (Or.inr (Or.inr (Or.inr hBM)))
      · have hBMlt : θ * wB < monopolyM R * wA := lt_of_not_ge hBM
        by_cases hB : L * wA ≤ θ * wB
        · exact Or.inr (Or.inr (Or.inr (Or.inl ⟨hB, hBMlt⟩)))
        · have hBlt : θ * wB < L * wA := lt_of_not_ge hB
          exact Or.inr (Or.inr (Or.inl ⟨hAlt, hBlt⟩))

/-- If `L > θ > 0` and both reduced intercepts are positive, both firms cannot
simultaneously satisfy the dominance-side inequality. -/
theorem stage2_dominance_sides_incompatible
    {L θ wA wB : ℝ}
    (hθ : 0 < θ) (hL : θ < L) (_hwA : 0 < wA) (hwB : 0 < wB) :
    ¬ (L * wB ≤ θ * wA ∧ L * wA ≤ θ * wB) := by
  rintro ⟨hA, hB⟩
  have hLpos : 0 < L := lt_trans hθ hL
  have h1 : L * (L * wB) ≤ L * (θ * wA) :=
    mul_le_mul_of_nonneg_left hA hLpos.le
  have h2 : θ * (L * wA) ≤ θ * (θ * wB) :=
    mul_le_mul_of_nonneg_left hB hθ.le
  have hmid : L * (θ * wA) = θ * (L * wA) := by ring
  have hchain : L * (L * wB) ≤ θ * (θ * wB) := by
    calc
      L * (L * wB) ≤ L * (θ * wA) := h1
      _ = θ * (L * wA) := hmid
      _ ≤ θ * (θ * wB) := h2
  have hsq : θ ^ 2 < L ^ 2 := by nlinarith
  have hstrict : θ ^ 2 * wB < L ^ 2 * wB :=
    mul_lt_mul_of_pos_right hsq hwB
  nlinarith

/-- Under the model regularity assumptions, `M = 2-R` lies strictly above `θ`. -/
theorem monopolyM_gt_theta
    {kx kg μ θ : ℝ}
    (hθ : θ ∈ Icc (0 : ℝ) 1)
    (hR : investmentR kx kg μ < (3 / 4 : ℝ)) :
    θ < monopolyM (investmentR kx kg μ) := by
  unfold monopolyM
  linarith [hθ.2]

/-- For positive rivalry, the kink threshold is ordered strictly below the monopoly
threshold: `L < 2-R`. -/
theorem reducedL_lt_monopolyM
    {kx kg μ θ : ℝ}
    (hkx : 0 < kx) (hkg : 0 < kg)
    (hθ : θ ∈ Icc (0 : ℝ) 1) (hθpos : 0 < θ) :
    reducedL kx kg μ θ < monopolyM (investmentR kx kg μ) := by
  have hRpos : 0 < investmentR kx kg μ := investmentR_pos hkx hkg
  have hDpos : 0 < cournotD θ := cournotD_pos hθ
  have hDlt : cournotD θ < 4 := by
    unfold cournotD
    nlinarith [sq_pos_of_ne_zero hθpos.ne']
  have hratio : (1 : ℝ) < 4 / cournotD θ := by
    rw [lt_div_iff₀ hDpos]
    linarith
  have hmul : investmentR kx kg μ * 1 <
      investmentR kx kg μ * (4 / cournotD θ) :=
    mul_lt_mul_of_pos_left hratio hRpos
  have hlam : investmentR kx kg μ < investmentLambda kx kg μ θ := by
    unfold investmentLambda
    calc
      investmentR kx kg μ = investmentR kx kg μ * 1 := by ring
      _ < investmentR kx kg μ * (4 / cournotD θ) := hmul
      _ = 4 * investmentR kx kg μ / cournotD θ := by ring
  unfold reducedL monopolyM
  linarith

lemma monopolyM_pos
    {kx kg μ θ : ℝ}
    (hθ : θ ∈ Icc (0 : ℝ) 1)
    (hR : investmentR kx kg μ < (3 / 4 : ℝ)) :
    0 < monopolyM (investmentR kx kg μ) := by
  linarith [monopolyM_gt_theta hθ hR, hθ.1]

lemma investmentLambda_pos
    {kx kg μ θ : ℝ}
    (hkx : 0 < kx) (hkg : 0 < kg)
    (hθ : θ ∈ Icc (0 : ℝ) 1) :
    0 < investmentLambda kx kg μ θ := by
  unfold investmentLambda
  exact div_pos (mul_pos (by norm_num) (investmentR_pos hkx hkg)) (cournotD_pos hθ)

lemma reducedL_lt_two
    {kx kg μ θ : ℝ}
    (hkx : 0 < kx) (hkg : 0 < kg)
    (hθ : θ ∈ Icc (0 : ℝ) 1) :
    reducedL kx kg μ θ < 2 := by
  have hlam : 0 < investmentLambda kx kg μ θ :=
    investmentLambda_pos (kx := kx) (kg := kg) (μ := μ) (θ := θ) hkx hkg hθ
  unfold reducedL
  linarith

/-- Any A-side regime implies the A dominance-side inequality `L w_B ≤ θ w_A`. -/
lemma aMonopoly_implies_aSide
    {R L θ wA wB : ℝ}
    (hLM : L < monopolyM R) (hwB : 0 < wB)
    (hAM : aMonopolyRegion R θ wA wB) :
    L * wB ≤ θ * wA := by
  have hlt : L * wB < monopolyM R * wB :=
    mul_lt_mul_of_pos_right hLM hwB
  exact le_trans hlt.le hAM

lemma bMonopoly_implies_bSide
    {R L θ wA wB : ℝ}
    (hLM : L < monopolyM R) (hwA : 0 < wA)
    (hBM : bMonopolyRegion R θ wA wB) :
    L * wA ≤ θ * wB := by
  have hlt : L * wA < monopolyM R * wA :=
    mul_lt_mul_of_pos_right hLM hwA
  exact le_trans hlt.le hBM

/-- An A-side regime and a B-side regime are mutually exclusive under the model's
strict threshold ordering. -/
theorem aSide_bSide_regions_incompatible
    {R L θ wA wB : ℝ}
    (hθ : 0 < θ) (hL : θ < L) (hLM : L < monopolyM R)
    (hwA : 0 < wA) (hwB : 0 < wB)
    (hA : aMonopolyRegion R θ wA wB ∨ aKinkRegion R L θ wA wB)
    (hB : bMonopolyRegion R θ wA wB ∨ bKinkRegion R L θ wA wB) : False := by
  have haSide : L * wB ≤ θ * wA := by
    rcases hA with hAM | hAK
    · exact aMonopoly_implies_aSide hLM hwB hAM
    · exact hAK.1
  have hbSide : L * wA ≤ θ * wB := by
    rcases hB with hBM | hBK
    · exact bMonopoly_implies_bSide hLM hwA hBM
    · exact hBK.1
  exact stage2_dominance_sides_incompatible hθ hL hwA hwB ⟨haSide, hbSide⟩

/-- Closed-form Stage-2 continuation tuple `(q_A,q_B,u_A,u_B)`. -/
structure Stage2Continuation where
  qA : ℝ
  qB : ℝ
  uA : ℝ
  uB : ℝ

def aMonopolyContinuation (R wA : ℝ) : Stage2Continuation :=
  { qA := wA / monopolyM R
    qB := 0
    uA := R * (wA / monopolyM R)
    uB := 0 }

def aKinkContinuation (θ wA wB : ℝ) : Stage2Continuation :=
  { qA := wB / θ
    qB := 0
    uA := 2 * wB / θ - wA
    uB := 0 }

def duopolyQA (L θ wA wB : ℝ) : ℝ :=
  (L * wA - θ * wB) / (L ^ 2 - θ ^ 2)

def duopolyQB (L θ wA wB : ℝ) : ℝ :=
  (L * wB - θ * wA) / (L ^ 2 - θ ^ 2)

def duopolyContinuation (L θ wA wB : ℝ) : Stage2Continuation :=
  { qA := duopolyQA L θ wA wB
    qB := duopolyQB L θ wA wB
    uA := (2 - L) * duopolyQA L θ wA wB
    uB := (2 - L) * duopolyQB L θ wA wB }

def bKinkContinuation (θ wA wB : ℝ) : Stage2Continuation :=
  { qA := 0
    qB := wA / θ
    uA := 0
    uB := 2 * wA / θ - wB }

def bMonopolyContinuation (R wB : ℝ) : Stage2Continuation :=
  { qA := 0
    qB := wB / monopolyM R
    uA := 0
    uB := R * (wB / monopolyM R) }

/-- The duopoly formulas solve the reduced Stage-2 linear system exactly. -/
theorem duopolyContinuation_solves_reduced_system
    {L θ wA wB : ℝ} (hdet : L ^ 2 - θ ^ 2 ≠ 0) :
    L * duopolyQA L θ wA wB + θ * duopolyQB L θ wA wB = wA ∧
    θ * duopolyQA L θ wA wB + L * duopolyQB L θ wA wB = wB := by
  constructor
  · unfold duopolyQA duopolyQB
    field_simp [hdet]
    ring
  · unfold duopolyQA duopolyQB
    field_simp [hdet]
    ring

/-- Outputs are strictly positive in the interior-duopoly region. -/
theorem duopoly_outputs_pos
    {L θ wA wB : ℝ}
    (hdet : 0 < L ^ 2 - θ ^ 2)
    (hD : duopolyRegion L θ wA wB) :
    0 < duopolyQA L θ wA wB ∧ 0 < duopolyQB L θ wA wB := by
  constructor
  · unfold duopolyQA
    exact div_pos (sub_pos.mpr hD.2) hdet
  · unfold duopolyQB
    exact div_pos (sub_pos.mpr hD.1) hdet

/-- The A-monopoly formula satisfies the active firm's Stage-3 identity `v_A=2q_A`. -/
theorem aMonopoly_stage3_identity
    {R wA : ℝ} (hM : monopolyM R ≠ 0) :
    wA + (aMonopolyContinuation R wA).uA =
      2 * (aMonopolyContinuation R wA).qA := by
  simp [aMonopolyContinuation]
  unfold monopolyM at hM ⊢
  field_simp [hM]
  ring

/-- The A-kink formula lands exactly on the Stage-3 activity kink. -/
theorem aKink_stage3_identity
    {θ wA wB : ℝ} :
    wA + (aKinkContinuation θ wA wB).uA =
      2 * (aKinkContinuation θ wA wB).qA := by
  simp [aKinkContinuation]
  ring

/-- On the duopoly branch, the continuation tuple satisfies both active Stage-3 FOCs. -/
theorem duopoly_stage3_identities
    {L θ wA wB : ℝ} (hdet : L ^ 2 - θ ^ 2 ≠ 0) :
    wA + (duopolyContinuation L θ wA wB).uA =
      2 * (duopolyContinuation L θ wA wB).qA +
        θ * (duopolyContinuation L θ wA wB).qB ∧
    wB + (duopolyContinuation L θ wA wB).uB =
      θ * (duopolyContinuation L θ wA wB).qA +
        2 * (duopolyContinuation L θ wA wB).qB := by
  obtain ⟨hA, hB⟩ := duopolyContinuation_solves_reduced_system (L := L) (θ := θ)
    (wA := wA) (wB := wB) hdet
  simp only [duopolyContinuation]
  constructor <;> linarith

/-- At the A kink/monopoly boundary, the quantity formulas coincide. -/
theorem aKink_aMonopoly_boundary_q
    {R θ wA wB : ℝ}
    (hθ : θ ≠ 0) (hM : monopolyM R ≠ 0)
    (hb : θ * wA = monopolyM R * wB) :
    (aKinkContinuation θ wA wB).qA =
      (aMonopolyContinuation R wA).qA := by
  simp [aKinkContinuation, aMonopolyContinuation]
  field_simp [hθ, hM]
  nlinarith

/-- At the A kink/monopoly boundary, private cost reduction also coincides. -/
theorem aKink_aMonopoly_boundary_u
    {R θ wA wB : ℝ}
    (hθ : θ ≠ 0) (hM : monopolyM R ≠ 0)
    (hb : θ * wA = monopolyM R * wB) :
    (aKinkContinuation θ wA wB).uA =
      (aMonopolyContinuation R wA).uA := by
  have hq := aKink_aMonopoly_boundary_q hθ hM hb
  simp only [aKinkContinuation, aMonopolyContinuation] at hq ⊢
  calc
    2 * wB / θ - wA = 2 * (wB / θ) - wA := by ring
    _ = 2 * (wA / monopolyM R) - wA := by rw [hq]
    _ = R * (wA / monopolyM R) := by
      unfold monopolyM at hM ⊢
      field_simp [hM]
      ring

/-- At the A kink/duopoly boundary, the inactive firm's duopoly formula is zero. -/
theorem aKink_duopoly_boundary_qB
    {L θ wA wB : ℝ}
    (hb : θ * wA = L * wB) :
    duopolyQB L θ wA wB = 0 := by
  unfold duopolyQB
  have hnum : L * wB - θ * wA = 0 := by linarith
  rw [hnum]
  simp

/-- At the A kink/duopoly boundary, the active quantity formulas coincide. -/
theorem aKink_duopoly_boundary_qA
    {L θ wA wB : ℝ}
    (hθ : θ ≠ 0) (hdet : L ^ 2 - θ ^ 2 ≠ 0)
    (hb : θ * wA = L * wB) :
    duopolyQA L θ wA wB = (aKinkContinuation θ wA wB).qA := by
  simp [aKinkContinuation]
  unfold duopolyQA
  field_simp [hθ, hdet]
  linear_combination L * hb

/-- At the A kink/duopoly boundary, private cost reduction coincides as well. -/
theorem aKink_duopoly_boundary_uA
    {L θ wA wB : ℝ}
    (hθ : θ ≠ 0) (hdet : L ^ 2 - θ ^ 2 ≠ 0)
    (hb : θ * wA = L * wB) :
    (duopolyContinuation L θ wA wB).uA =
      (aKinkContinuation θ wA wB).uA := by
  have hq := aKink_duopoly_boundary_qA hθ hdet hb
  simp only [duopolyContinuation, aKinkContinuation]
  rw [hq]
  have hu : (2 - L) * (wB / θ) = 2 * wB / θ - wA := by
    field_simp [hθ]
    nlinarith [hb]
  exact hu

/-- Symmetric B kink/monopoly quantity matching. -/
theorem bKink_bMonopoly_boundary_q
    {R θ wA wB : ℝ}
    (hθ : θ ≠ 0) (hM : monopolyM R ≠ 0)
    (hb : θ * wB = monopolyM R * wA) :
    (bKinkContinuation θ wA wB).qB =
      (bMonopolyContinuation R wB).qB := by
  simp [bKinkContinuation, bMonopolyContinuation]
  field_simp [hθ, hM]
  nlinarith

/-- Symmetric B kink/monopoly private-reduction matching. -/
theorem bKink_bMonopoly_boundary_u
    {R θ wA wB : ℝ}
    (hθ : θ ≠ 0) (hM : monopolyM R ≠ 0)
    (hb : θ * wB = monopolyM R * wA) :
    (bKinkContinuation θ wA wB).uB =
      (bMonopolyContinuation R wB).uB := by
  have hq := bKink_bMonopoly_boundary_q hθ hM hb
  simp only [bKinkContinuation, bMonopolyContinuation] at hq ⊢
  calc
    2 * wA / θ - wB = 2 * (wA / θ) - wB := by ring
    _ = 2 * (wB / monopolyM R) - wB := by rw [hq]
    _ = R * (wB / monopolyM R) := by
      unfold monopolyM at hM ⊢
      field_simp [hM]
      ring

/-- Symmetric B kink/duopoly boundary: the A quantity is zero. -/
theorem bKink_duopoly_boundary_qA
    {L θ wA wB : ℝ}
    (hb : θ * wB = L * wA) :
    duopolyQA L θ wA wB = 0 := by
  unfold duopolyQA
  have hnum : L * wA - θ * wB = 0 := by linarith
  rw [hnum]
  simp

/-- Symmetric B kink/duopoly active-quantity matching. -/
theorem bKink_duopoly_boundary_qB
    {L θ wA wB : ℝ}
    (hθ : θ ≠ 0) (hdet : L ^ 2 - θ ^ 2 ≠ 0)
    (hb : θ * wB = L * wA) :
    duopolyQB L θ wA wB = (bKinkContinuation θ wA wB).qB := by
  simp [bKinkContinuation]
  unfold duopolyQB
  field_simp [hθ, hdet]
  linear_combination L * hb

/-- Symmetric B kink/duopoly private-reduction matching. -/
theorem bKink_duopoly_boundary_uB
    {L θ wA wB : ℝ}
    (hθ : θ ≠ 0) (hdet : L ^ 2 - θ ^ 2 ≠ 0)
    (hb : θ * wB = L * wA) :
    (duopolyContinuation L θ wA wB).uB =
      (bKinkContinuation θ wA wB).uB := by
  have hq := bKink_duopoly_boundary_qB hθ hdet hb
  simp only [duopolyContinuation, bKinkContinuation]
  rw [hq]
  have hu : (2 - L) * (wA / θ) = 2 * wA / θ - wB := by
    field_simp [hθ]
    nlinarith [hb]
  exact hu

end SLGPC