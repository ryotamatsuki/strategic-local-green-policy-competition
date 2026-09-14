import StrategicLocalGreenPolicyCompetition.GovernmentOutsideBranches

noncomputable section

open Set

namespace SLGPC

set_option maxRecDepth 100000

/-- Positive numerator of the subsidy composition that maximizes welfare on the
common A-kink/A-monopoly boundary. -/
def canonicalBoundarySPos (θ : ℝ) : ℝ :=
  -66632500000 * θ ^ 10 + 762130306250 * θ ^ 9 +
    2578340081250 * θ ^ 8 - 11650453927500 * θ ^ 7 -
    28637811814875 * θ ^ 6 + 63744391731025 * θ ^ 5 +
    134018361139600 * θ ^ 4 - 145468633143950 * θ ^ 3 -
    277636045799123 * θ ^ 2 + 113121041114400 * θ +
    206117647891507

def canonicalBoundarySPosBernstein (θ : ℝ) : ℝ :=
  206117647891507 * (1 - θ) ^ 10 +
    2174297520029470 * θ * (1 - θ) ^ 9 +
    10015747479348292 * θ ^ 2 * (1 - θ) ^ 8 +
    26439918227562306 * θ ^ 3 * (1 - θ) ^ 7 +
    44128802157582576 * θ ^ 4 * (1 - θ) ^ 6 +
    48460293146868951 * θ ^ 5 * (1 - θ) ^ 5 +
    35312391435588260 * θ ^ 6 * (1 - θ) ^ 4 +
    16788873914716552 * θ ^ 7 * (1 - θ) ^ 3 +
    4962520498651571 * θ ^ 8 * (1 - θ) ^ 2 +
    819145377463511 * θ ^ 9 * (1 - θ) +
    56882335078584 * θ ^ 10

lemma canonicalBoundarySPos_bernstein (θ : ℝ) :
    canonicalBoundarySPos θ = canonicalBoundarySPosBernstein θ := by
  unfold canonicalBoundarySPos canonicalBoundarySPosBernstein
  ring

/-- Positive numerator of the infrastructure composition on the same boundary. -/
def canonicalBoundaryHPos (θ : ℝ) : ℝ :=
  -1140021500000 * θ ^ 10 + 1001821656250 * θ ^ 9 +
    20037984768750 * θ ^ 8 - 15974610937500 * θ ^ 7 -
    137463088242375 * θ ^ 6 + 92991403458125 * θ ^ 5 +
    457238575659800 * θ ^ 4 - 213080384051500 * θ ^ 3 -
    737614738660114 * θ ^ 2 + 141199316181000 * θ +
    467376519484226

def canonicalBoundaryHPosBernstein (θ : ℝ) : ℝ :=
  467376519484226 * (1 - θ) ^ 10 +
    4814964511023260 * θ * (1 - θ) ^ 9 +
    21565122483759056 * θ ^ 2 * (1 - θ) ^ 8 +
    55054359427290708 * θ ^ 3 * (1 - θ) ^ 7 +
    88322274855707568 * θ ^ 4 * (1 - θ) ^ 6 +
    92625306176199993 * θ ^ 5 * (1 - θ) ^ 5 +
    64035410346428230 * θ ^ 6 * (1 - θ) ^ 4 +
    28690544674412486 * θ ^ 7 * (1 - θ) ^ 3 +
    7923046303721728 * θ ^ 8 * (1 - θ) ^ 2 +
    1203768519491023 * θ ^ 9 * (1 - θ) +
    74572777816662 * θ ^ 10

lemma canonicalBoundaryHPos_bernstein (θ : ℝ) :
    canonicalBoundaryHPos θ = canonicalBoundaryHPosBernstein θ := by
  unfold canonicalBoundaryHPos canonicalBoundaryHPosBernstein
  ring

private lemma boundaryBasePos {θ : ℝ} (hθ : θ ∈ Ioc (0 : ℝ) 1)
    (h1 : θ ≠ 1) : 0 < 1 - θ := by
  exact sub_pos.mpr (lt_of_le_of_ne hθ.2 h1)

theorem canonicalBoundarySPos_pos {θ : ℝ} (hθ : θ ∈ Ioc (0 : ℝ) 1) :
    0 < canonicalBoundarySPos θ := by
  by_cases h1 : θ = 1
  · subst θ
    norm_num [canonicalBoundarySPos]
  · have hbase : 0 < 1 - θ := boundaryBasePos hθ h1
    have hθ0 : 0 ≤ θ := hθ.1.le
    have h0 : 0 < 206117647891507 * (1 - θ) ^ 10 := by positivity
    have h1n : 0 ≤ 2174297520029470 * θ * (1 - θ) ^ 9 := by positivity
    have h2n : 0 ≤ 10015747479348292 * θ ^ 2 * (1 - θ) ^ 8 := by positivity
    have h3n : 0 ≤ 26439918227562306 * θ ^ 3 * (1 - θ) ^ 7 := by positivity
    have h4n : 0 ≤ 44128802157582576 * θ ^ 4 * (1 - θ) ^ 6 := by positivity
    have h5n : 0 ≤ 48460293146868951 * θ ^ 5 * (1 - θ) ^ 5 := by positivity
    have h6n : 0 ≤ 35312391435588260 * θ ^ 6 * (1 - θ) ^ 4 := by positivity
    have h7n : 0 ≤ 16788873914716552 * θ ^ 7 * (1 - θ) ^ 3 := by positivity
    have h8n : 0 ≤ 4962520498651571 * θ ^ 8 * (1 - θ) ^ 2 := by positivity
    have h9n : 0 ≤ 819145377463511 * θ ^ 9 * (1 - θ) := by positivity
    have h10n : 0 ≤ 56882335078584 * θ ^ 10 := by positivity
    rw [canonicalBoundarySPos_bernstein]
    unfold canonicalBoundarySPosBernstein
    nlinarith

theorem canonicalBoundaryHPos_pos {θ : ℝ} (hθ : θ ∈ Ioc (0 : ℝ) 1) :
    0 < canonicalBoundaryHPos θ := by
  by_cases h1 : θ = 1
  · subst θ
    norm_num [canonicalBoundaryHPos]
  · have hbase : 0 < 1 - θ := boundaryBasePos hθ h1
    have hθ0 : 0 ≤ θ := hθ.1.le
    have h0 : 0 < 467376519484226 * (1 - θ) ^ 10 := by positivity
    have h1n : 0 ≤ 4814964511023260 * θ * (1 - θ) ^ 9 := by positivity
    have h2n : 0 ≤ 21565122483759056 * θ ^ 2 * (1 - θ) ^ 8 := by positivity
    have h3n : 0 ≤ 55054359427290708 * θ ^ 3 * (1 - θ) ^ 7 := by positivity
    have h4n : 0 ≤ 88322274855707568 * θ ^ 4 * (1 - θ) ^ 6 := by positivity
    have h5n : 0 ≤ 92625306176199993 * θ ^ 5 * (1 - θ) ^ 5 := by positivity
    have h6n : 0 ≤ 64035410346428230 * θ ^ 6 * (1 - θ) ^ 4 := by positivity
    have h7n : 0 ≤ 28690544674412486 * θ ^ 7 * (1 - θ) ^ 3 := by positivity
    have h8n : 0 ≤ 7923046303721728 * θ ^ 8 * (1 - θ) ^ 2 := by positivity
    have h9n : 0 ≤ 1203768519491023 * θ ^ 9 * (1 - θ) := by positivity
    have h10n : 0 ≤ 74572777816662 * θ ^ 10 := by positivity
    rw [canonicalBoundaryHPos_bernstein]
    unfold canonicalBoundaryHPosBernstein
    nlinarith

/-- Exact welfare-maximizing policy composition on the common K/M boundary. -/
def canonicalBoundaryS (θ : ℝ) : ℝ :=
  24 * canonicalBoundarySPos θ /
    (94925 * θ * canonicalSymmetricDen θ)

def canonicalBoundaryH (θ : ℝ) : ℝ :=
  4 * canonicalBoundaryHPos θ /
    (56955 * θ * canonicalSymmetricDen θ)

theorem canonicalBoundaryPolicies_pos {θ : ℝ} (hθ : θ ∈ Ioc (0 : ℝ) 1) :
    0 < canonicalBoundaryS θ ∧ 0 < canonicalBoundaryH θ := by
  have hden := canonicalSymmetricDen_pos ⟨hθ.1.le, hθ.2⟩
  constructor
  · exact div_pos (mul_pos (by norm_num) (canonicalBoundarySPos_pos hθ))
      (mul_pos (mul_pos (by norm_num) hθ.1) hden)
  · exact div_pos (mul_pos (by norm_num) (canonicalBoundaryHPos_pos hθ))
      (mul_pos (mul_pos (by norm_num) hθ.1) hden)

/-- The boundary policy has exactly the reduced intercept required by
`theta*w_A=(2-R)w_B`. -/
theorem canonicalBoundary_intercept
    {θ : ℝ} (hθ : θ ∈ Ioc (0 : ℝ) 1) :
    θ * canonicalOwnW (canonicalBoundaryS θ) (canonicalBoundaryH θ) =
      (341 / 200 : ℝ) * canonicalSymmetricW θ := by
  have hden : canonicalSymmetricDen θ ≠ 0 :=
    (canonicalSymmetricDen_pos ⟨hθ.1.le, hθ.2⟩).ne'
  have ht : θ ≠ 0 := hθ.1.ne'
  unfold canonicalOwnW canonicalSymmetricW reducedW policyY
    canonicalBoundaryS canonicalBoundaryH canonicalSymmetricS canonicalSymmetricH
  field_simp [ht, hden]
  unfold canonicalBoundarySPos canonicalBoundaryHPos canonicalSymmetricDen
    canonicalSymmetricSNum canonicalSymmetricHNum
  ring

/-- Positive normal multiplier for the A-kink branch at the common boundary. -/
def canonicalKinkMultiplierPoly (θ : ℝ) : ℝ :=
  2935464500000 * θ ^ 10 + 3321402968750 * θ ^ 9 -
    39794185931250 * θ ^ 8 - 48750075262500 * θ ^ 7 +
    181152842043375 * θ ^ 6 + 249604246883875 * θ ^ 5 -
    277463147206400 * θ ^ 4 - 566950928327750 * θ ^ 3 -
    67692685950023 * θ ^ 2 + 515971224054000 * θ +
    296172410217607

def canonicalKinkMultiplierBernstein (θ : ℝ) : ℝ :=
  296172410217607 * (1 - θ) ^ 10 +
    3477695326230070 * θ * (1 - θ) ^ 9 +
    17903806790328292 * θ ^ 2 * (1 - θ) ^ 8 +
    53007160876128906 * θ ^ 3 * (1 - θ) ^ 7 +
    99396274114132176 * θ ^ 4 * (1 - θ) ^ 6 +
    122535887061202401 * θ ^ 5 * (1 - θ) ^ 5 +
    99894036736895360 * θ ^ 6 * (1 - θ) ^ 4 +
    52870839959598052 * θ ^ 7 * (1 - θ) ^ 3 +
    17336325725537171 * θ ^ 8 * (1 - θ) ^ 2 +
    3180603657440861 * θ ^ 9 * (1 - θ) +
    248506567989684 * θ ^ 10

lemma canonicalKinkMultiplier_bernstein (θ : ℝ) :
    canonicalKinkMultiplierPoly θ = canonicalKinkMultiplierBernstein θ := by
  unfold canonicalKinkMultiplierPoly canonicalKinkMultiplierBernstein
  ring

theorem canonicalKinkMultiplierPoly_pos {θ : ℝ} (hθ : θ ∈ Ioc (0 : ℝ) 1) :
    0 < canonicalKinkMultiplierPoly θ := by
  by_cases h1 : θ = 1
  · subst θ
    norm_num [canonicalKinkMultiplierPoly]
  · have hbase : 0 < 1 - θ := boundaryBasePos hθ h1
    have hθ0 : 0 ≤ θ := hθ.1.le
    have h0 : 0 < 296172410217607 * (1 - θ) ^ 10 := by positivity
    have h1n : 0 ≤ 3477695326230070 * θ * (1 - θ) ^ 9 := by positivity
    have h2n : 0 ≤ 17903806790328292 * θ ^ 2 * (1 - θ) ^ 8 := by positivity
    have h3n : 0 ≤ 53007160876128906 * θ ^ 3 * (1 - θ) ^ 7 := by positivity
    have h4n : 0 ≤ 99396274114132176 * θ ^ 4 * (1 - θ) ^ 6 := by positivity
    have h5n : 0 ≤ 122535887061202401 * θ ^ 5 * (1 - θ) ^ 5 := by positivity
    have h6n : 0 ≤ 99894036736895360 * θ ^ 6 * (1 - θ) ^ 4 := by positivity
    have h7n : 0 ≤ 52870839959598052 * θ ^ 7 * (1 - θ) ^ 3 := by positivity
    have h8n : 0 ≤ 17336325725537171 * θ ^ 8 * (1 - θ) ^ 2 := by positivity
    have h9n : 0 ≤ 3180603657440861 * θ ^ 9 * (1 - θ) := by positivity
    have h10n : 0 ≤ 248506567989684 * θ ^ 10 := by positivity
    rw [canonicalKinkMultiplier_bernstein]
    unfold canonicalKinkMultiplierBernstein
    nlinarith

def canonicalKinkMultiplier (θ : ℝ) : ℝ :=
  32 * canonicalKinkMultiplierPoly θ /
    (2016207 * θ * canonicalSymmetricDen θ)

theorem canonicalKinkMultiplier_pos {θ : ℝ} (hθ : θ ∈ Ioc (0 : ℝ) 1) :
    0 < canonicalKinkMultiplier θ := by
  have hden := canonicalSymmetricDen_pos ⟨hθ.1.le, hθ.2⟩
  exact div_pos (mul_pos (by norm_num) (canonicalKinkMultiplierPoly_pos hθ))
    (mul_pos (mul_pos (by norm_num) hθ.1) hden)

/-- Positive polynomial whose negative multiple is the monopoly normal multiplier. -/
def canonicalMonopolyMultiplierPos (θ : ℝ) : ℝ :=
  -80192819500000 * θ ^ 10 + 3833382593750 * θ ^ 9 +
    1276260988368750 * θ ^ 8 - 108685145512500 * θ ^ 7 -
    7718191619977125 * θ ^ 6 + 1018656759391375 * θ ^ 5 +
    22001519671728400 * θ ^ 4 - 2390520826174250 * θ ^ 3 -
    29673693497424137 * θ ^ 2 + 15942009725177833

def canonicalMonopolyMultiplierBernstein (θ : ℝ) : ℝ :=
  15942009725177833 * (1 - θ) ^ 10 +
    159420097251778330 * θ * (1 - θ) ^ 9 +
    687716744135578348 * θ ^ 2 * (1 - θ) ^ 8 +
    1673261098215772614 * θ ^ 3 * (1 - θ) ^ 7 +
    2522226498247977744 * θ ^ 4 * (1 - θ) ^ 6 +
    2438486452329164769 * θ ^ 5 * (1 - θ) ^ 5 +
    1514393155804462340 * θ ^ 6 * (1 - θ) ^ 4 +
    586881611652550288 * θ ^ 7 * (1 - θ) ^ 3 +
    131176500857275649 * θ ^ 8 * (1 - θ) ^ 2 +
    13756838759378009 * θ ^ 9 * (1 - θ) +
    270996618672096 * θ ^ 10

lemma canonicalMonopolyMultiplier_bernstein (θ : ℝ) :
    canonicalMonopolyMultiplierPos θ = canonicalMonopolyMultiplierBernstein θ := by
  unfold canonicalMonopolyMultiplierPos canonicalMonopolyMultiplierBernstein
  ring

theorem canonicalMonopolyMultiplierPos_pos {θ : ℝ} (hθ : θ ∈ Ioc (0 : ℝ) 1) :
    0 < canonicalMonopolyMultiplierPos θ := by
  by_cases h1 : θ = 1
  · subst θ
    norm_num [canonicalMonopolyMultiplierPos]
  · have hbase : 0 < 1 - θ := boundaryBasePos hθ h1
    have hθ0 : 0 ≤ θ := hθ.1.le
    have h0 : 0 < 15942009725177833 * (1 - θ) ^ 10 := by positivity
    have h1n : 0 ≤ 159420097251778330 * θ * (1 - θ) ^ 9 := by positivity
    have h2n : 0 ≤ 687716744135578348 * θ ^ 2 * (1 - θ) ^ 8 := by positivity
    have h3n : 0 ≤ 1673261098215772614 * θ ^ 3 * (1 - θ) ^ 7 := by positivity
    have h4n : 0 ≤ 2522226498247977744 * θ ^ 4 * (1 - θ) ^ 6 := by positivity
    have h5n : 0 ≤ 2438486452329164769 * θ ^ 5 * (1 - θ) ^ 5 := by positivity
    have h6n : 0 ≤ 1514393155804462340 * θ ^ 6 * (1 - θ) ^ 4 := by positivity
    have h7n : 0 ≤ 586881611652550288 * θ ^ 7 * (1 - θ) ^ 3 := by positivity
    have h8n : 0 ≤ 131176500857275649 * θ ^ 8 * (1 - θ) ^ 2 := by positivity
    have h9n : 0 ≤ 13756838759378009 * θ ^ 9 * (1 - θ) := by positivity
    have h10n : 0 ≤ 270996618672096 * θ ^ 10 := by positivity
    rw [canonicalMonopolyMultiplier_bernstein]
    unfold canonicalMonopolyMultiplierBernstein
    nlinarith

def canonicalMonopolyMultiplier (θ : ℝ) : ℝ :=
  -32 * canonicalMonopolyMultiplierPos θ /
    (58264965 * θ * canonicalSymmetricDen θ)

theorem canonicalMonopolyMultiplier_neg {θ : ℝ} (hθ : θ ∈ Ioc (0 : ℝ) 1) :
    canonicalMonopolyMultiplier θ < 0 := by
  have hden := canonicalSymmetricDen_pos ⟨hθ.1.le, hθ.2⟩
  exact div_neg_of_neg_of_pos
    (mul_neg_of_neg_of_pos (by norm_num) (canonicalMonopolyMultiplierPos_pos hθ))
    (mul_pos (mul_pos (by norm_num) hθ.1) hden)

/-- The kink branch gradient is an outward positive normal at the common K/M boundary. -/
theorem canonicalBoundary_kink_gradient
    {θ : ℝ} (hθ : θ ∈ Ioc (0 : ℝ) 1) :
    canonicalKinkGradS θ (canonicalSymmetricW θ)
        (canonicalBoundaryS θ) (canonicalBoundaryH θ) =
        (1 / 20 : ℝ) * canonicalKinkMultiplier θ ∧
    canonicalKinkGradH θ (canonicalSymmetricW θ)
        (canonicalBoundaryS θ) (canonicalBoundaryH θ) =
        (6 / 5 : ℝ) * canonicalKinkMultiplier θ := by
  have ht : θ ≠ 0 := hθ.1.ne'
  have hden : canonicalSymmetricDen θ ≠ 0 :=
    (canonicalSymmetricDen_pos ⟨hθ.1.le, hθ.2⟩).ne'
  constructor <;>
    unfold canonicalKinkGradS canonicalKinkGradH canonicalSymmetricW
      reducedW policyY canonicalSymmetricS canonicalSymmetricH
      canonicalBoundaryS canonicalBoundaryH canonicalKinkMultiplier <;>
    field_simp [ht, hden] <;>
    unfold canonicalBoundarySPos canonicalBoundaryHPos canonicalKinkMultiplierPoly
      canonicalSymmetricDen canonicalSymmetricSNum canonicalSymmetricHNum <;>
    ring

/-- The monopoly branch gradient is an inward negative normal at the common boundary. -/
theorem canonicalBoundary_monopoly_gradient
    {θ : ℝ} (hθ : θ ∈ Ioc (0 : ℝ) 1) :
    canonicalMonopolyGradS (canonicalBoundaryS θ) (canonicalBoundaryH θ) =
        (1 / 20 : ℝ) * canonicalMonopolyMultiplier θ ∧
    canonicalMonopolyGradH (canonicalBoundaryS θ) (canonicalBoundaryH θ) =
        (6 / 5 : ℝ) * canonicalMonopolyMultiplier θ := by
  have ht : θ ≠ 0 := hθ.1.ne'
  have hden : canonicalSymmetricDen θ ≠ 0 :=
    (canonicalSymmetricDen_pos ⟨hθ.1.le, hθ.2⟩).ne'
  constructor <;>
    unfold canonicalMonopolyGradS canonicalMonopolyGradH
      canonicalBoundaryS canonicalBoundaryH canonicalMonopolyMultiplier <;>
    field_simp [ht, hden] <;>
    unfold canonicalBoundarySPos canonicalBoundaryHPos canonicalMonopolyMultiplierPos
      canonicalSymmetricDen <;>
    ring

end SLGPC
