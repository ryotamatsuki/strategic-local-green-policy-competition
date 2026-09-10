import StrategicLocalGreenPolicyCompetition.FirmStage

noncomputable section

namespace SLGPC

/-- Interior conventional-investment loading on output. -/
def interiorChiX (kx θ : ℝ) : ℝ := 4 / (cournotD θ * kx)

/-- Interior green-investment loading on output. -/
def interiorChiG (kg μ θ : ℝ) : ℝ := 4 * μ / (cournotD θ * kg)

/-- Coefficient on `q_A^2` in active producer surplus after substituting the
interior firm-investment rules. -/
def producerRho (kx kg μ θ : ℝ) : ℝ :=
  1 - kx * interiorChiX kx θ ^ 2 / 2 - kg * interiorChiG kg μ θ ^ 2 / 2

lemma interiorX_eq_chi {kx θ q : ℝ} :
    interiorX kx θ q = interiorChiX kx θ * q := by
  unfold interiorX interiorChiX
  ring

lemma interiorG_eq_chi {kg μ s θ q : ℝ} :
    interiorG kg μ s θ q = interiorChiG kg μ θ * q + s / kg := by
  unfold interiorG interiorChiG
  ring

/-- Active-branch producer surplus, using the Cournot markup identity `p-c=q`. -/
def activeProducerSurplus (kx kg q x g : ℝ) : ℝ :=
  q ^ 2 - kx / 2 * x ^ 2 - kg / 2 * g ^ 2

/-- Substituting the interior firm-investment rules gives the quadratic producer-
surplus representation used in the symbolic government Hessian. -/
theorem activeProducerSurplus_reduction
    {kx kg μ s θ q : ℝ} (hkg : kg ≠ 0) :
    activeProducerSurplus kx kg q (interiorX kx θ q) (interiorG kg μ s θ q) =
      producerRho kx kg μ θ * q ^ 2 -
        interiorChiG kg μ θ * s * q - s ^ 2 / (2 * kg) := by
  rw [interiorX_eq_chi, interiorG_eq_chi]
  unfold activeProducerSurplus producerRho
  field_simp [hkg]
  ring

/-- One half of integrated-market consumer surplus, which is the consumer-surplus
term entering one jurisdiction's welfare objective. -/
def halfConsumerSurplus (θ qA qB : ℝ) : ℝ :=
  (qA ^ 2 + qB ^ 2) / 4 + θ * qA * qB / 2

/-- Active-branch territorial emissions after substituting the interior green-
investment rule. -/
def reducedEmissions (e β cg kg ξ q s h : ℝ) : ℝ :=
  (e - β * cg) * q - β / kg * s - ξ * h

/-- The primitive emissions expression collapses to the affine reduced expression. -/
theorem active_emissions_reduction
    {e β kg μ ξ s θ q h : ℝ} :
    e * q - β * interiorG kg μ s θ q - ξ * h =
      reducedEmissions e β (interiorChiG kg μ θ) kg ξ q s h := by
  rw [interiorG_eq_chi]
  unfold reducedEmissions
  ring

/-- Government welfare on the active interior firm branch after using the Cournot
markup identity but before eliminating the firms' investment choices.  The subsidy
argument is retained to mirror the policy vector, although the transfer cancels. -/
def activeGovernmentWelfare
    (kx kg κ d e β ξ Ebar θ qA qB xA gA _sA hA : ℝ) : ℝ :=
  halfConsumerSurplus θ qA qB + activeProducerSurplus kx kg qA xA gA -
    κ / 2 * hA ^ 2 - d / 2 * (e * qA - β * gA - ξ * hA - Ebar) ^ 2

/-- Fully reduced active-duopoly government objective.  `rho` and `cg` are kept as
explicit arguments so its quadratic structure can be certified independently of
how the firm stage generated those coefficients. -/
def reducedGovernmentWelfare
    (θ rho cg kg κ d e β ξ Ebar qA qB sA hA : ℝ) : ℝ :=
  ((1 : ℝ) / 4 + rho) * qA ^ 2 + (1 : ℝ) / 4 * qB ^ 2 +
    θ / 2 * qA * qB - cg * sA * qA - sA ^ 2 / (2 * kg) -
    κ / 2 * hA ^ 2 -
    d / 2 * (reducedEmissions e β cg kg ξ qA sA hA - Ebar) ^ 2

/-- Primitive active-branch welfare evaluated at the firms' interior investment
rules is exactly the reduced quadratic government objective. -/
theorem activeGovernmentWelfare_reduction
    {kx kg μ κ d e β ξ Ebar θ qA qB sA hA : ℝ} (hkg : kg ≠ 0) :
    activeGovernmentWelfare kx kg κ d e β ξ Ebar θ qA qB
        (interiorX kx θ qA) (interiorG kg μ sA θ qA) sA hA =
      reducedGovernmentWelfare θ (producerRho kx kg μ θ)
        (interiorChiG kg μ θ) kg κ d e β ξ Ebar qA qB sA hA := by
  unfold activeGovernmentWelfare
  rw [activeProducerSurplus_reduction hkg, active_emissions_reduction]
  unfold reducedGovernmentWelfare halfConsumerSurplus
  ring

/-- Slope of reduced territorial emissions along a policy direction whose induced
slopes are `(aq, es, eh)` for own output, own subsidy, and own infrastructure. -/
def reducedEmissionsSlope (e β cg kg ξ aq es eh : ℝ) : ℝ :=
  (e - β * cg) * aq - β / kg * es - ξ * eh

/-- Exact Hessian entry of the reduced government quadratic for two generic policy
directions.  The directions carry output slopes `(a_i,b_i)`, own-subsidy slope
`es_i`, and own-infrastructure slope `eh_i`. -/
def governmentHessianEntry
    (θ rho cg kg κ d e β ξ
      ai aj bi bj esi esj ehi ehj : ℝ) : ℝ :=
  2 * ((1 : ℝ) / 4 + rho) * ai * aj +
    (1 : ℝ) / 2 * bi * bj +
    θ / 2 * (ai * bj + bi * aj) -
    cg * (esi * aj + ai * esj) -
    (1 / kg) * esi * esj - κ * ehi * ehj -
    d * reducedEmissionsSlope e β cg kg ξ ai esi ehi *
      reducedEmissionsSlope e β cg kg ξ aj esj ehj

/-- For the reduced quadratic objective, the mixed second finite difference along
any two affine policy directions is exactly `t*r` times the Hessian entry.  This is
an algebraic Hessian certificate requiring no symbolic black box. -/
theorem reducedGovernmentWelfare_mixed_second_difference
    {θ rho cg kg κ d e β ξ Ebar qA qB sA hA
      ai aj bi bj esi esj ehi ehj t r : ℝ} :
    reducedGovernmentWelfare θ rho cg kg κ d e β ξ Ebar
        (qA + t * ai + r * aj) (qB + t * bi + r * bj)
        (sA + t * esi + r * esj) (hA + t * ehi + r * ehj) -
      reducedGovernmentWelfare θ rho cg kg κ d e β ξ Ebar
        (qA + t * ai) (qB + t * bi) (sA + t * esi) (hA + t * ehi) -
      reducedGovernmentWelfare θ rho cg kg κ d e β ξ Ebar
        (qA + r * aj) (qB + r * bj) (sA + r * esj) (hA + r * ehj) +
      reducedGovernmentWelfare θ rho cg kg κ d e β ξ Ebar qA qB sA hA =
        t * r * governmentHessianEntry θ rho cg kg κ d e β ξ
          ai aj bi bj esi esj ehi ehj := by
  unfold reducedGovernmentWelfare governmentHessianEntry
    reducedEmissions reducedEmissionsSlope
  ring

/-- The reduced government Hessian is symmetric. -/
theorem governmentHessianEntry_symm
    {θ rho cg kg κ d e β ξ
      ai aj bi bj esi esj ehi ehj : ℝ} :
    governmentHessianEntry θ rho cg kg κ d e β ξ
        ai aj bi bj esi esj ehi ehj =
      governmentHessianEntry θ rho cg kg κ d e β ξ
        aj ai bj bi esj esi ehj ehi := by
  unfold governmentHessianEntry reducedEmissionsSlope
  ring

/-- Four Stage-1 policy coordinates in the ordering used by the manuscript and the
symbolic verification: `(s_A,h_A,s_B,h_B)`. -/
inductive PolicyCoord
  | sA | hA | sB | hB
  deriving DecidableEq

/-- Output slope of firm A with respect to a Stage-1 policy coordinate on the
interior-duopoly continuation. -/
def qASlope (kg μ ν L θ : ℝ) : PolicyCoord → ℝ
  | .sA => reducedT0 L θ * (μ / kg)
  | .hA => reducedT0 L θ * ν
  | .sB => reducedT1 L θ * (μ / kg)
  | .hB => reducedT1 L θ * ν

/-- Output slope of firm B; local and rival coefficients are interchanged. -/
def qBSlope (kg μ ν L θ : ℝ) : PolicyCoord → ℝ
  | .sA => reducedT1 L θ * (μ / kg)
  | .hA => reducedT1 L θ * ν
  | .sB => reducedT0 L θ * (μ / kg)
  | .hB => reducedT0 L θ * ν

/-- Direct slope of jurisdiction A's own subsidy coordinate. -/
def ownSubsidySlope : PolicyCoord → ℝ
  | .sA => 1
  | _ => 0

/-- Direct slope of jurisdiction A's own infrastructure coordinate. -/
def ownInfrastructureSlope : PolicyCoord → ℝ
  | .hA => 1
  | _ => 0

/-- Model-specialized government Hessian entry after inserting the firm-stage
policy slopes from the reduced quantity system. -/
def modelGovernmentHessianEntry
    (kx kg μ ν κ d e β ξ L θ : ℝ) (i j : PolicyCoord) : ℝ :=
  governmentHessianEntry θ (producerRho kx kg μ θ) (interiorChiG kg μ θ)
    kg κ d e β ξ
    (qASlope kg μ ν L θ i) (qASlope kg μ ν L θ j)
    (qBSlope kg μ ν L θ i) (qBSlope kg μ ν L θ j)
    (ownSubsidySlope i) (ownSubsidySlope j)
    (ownInfrastructureSlope i) (ownInfrastructureSlope j)

/-- The manuscript's own-policy Hessian determinant. -/
def ownPolicyDet (hss hsh hhh : ℝ) : ℝ := hss * hhh - hsh ^ 2

/-- The cross-instrument numerator appearing in the infrastructure response. -/
def crossInstrumentNumerator (hsh hss hsCross hhCross : ℝ) : ℝ :=
  hsh * hsCross - hss * hhCross

/-- Pure 2x2 implicit-system algebra behind equation (BR-IFT): if the differentiated
FOCs are `H dz = -c`, the infrastructure component has the displayed numerator over
the own-policy Hessian determinant. -/
theorem two_policy_response_h_formula
    {hss hsh hhh cs ch ds dh : ℝ}
    (hs : hss * ds + hsh * dh = -cs)
    (hh : hsh * ds + hhh * dh = -ch)
    (hdet : ownPolicyDet hss hsh hhh ≠ 0) :
    dh = crossInstrumentNumerator hsh hss cs ch /
      ownPolicyDet hss hsh hhh := by
  apply (eq_div_iff hdet).2
  unfold ownPolicyDet crossInstrumentNumerator
  linear_combination hss * hh - hsh * hs

/-- Negative definiteness in the 2x2 Sylvester form supplies the positive
determinant used to sign the best-response formula. -/
theorem ownPolicyDet_pos
    {hss hsh hhh : ℝ}
    (_hss : hss < 0)
    (hminor : hsh ^ 2 < hss * hhh) :
    0 < ownPolicyDet hss hsh hhh := by
  unfold ownPolicyDet
  linarith

/-- The rival-infrastructure direction is a scalar multiple of the rival-subsidy
direction in the interior reduced quantity system. -/
theorem rival_policy_output_direction_proportional
    {kg μ ν L θ : ℝ} (hkg : kg ≠ 0) (hμ : μ ≠ 0) :
    qASlope kg μ ν L θ .hB = (ν * kg / μ) * qASlope kg μ ν L θ .sB ∧
    qBSlope kg μ ν L θ .hB = (ν * kg / μ) * qBSlope kg μ ν L θ .sB := by
  constructor <;> simp [qASlope, qBSlope] <;> field_simp [hkg, hμ]

/-- A Hessian entry is linear in its second policy direction. -/
theorem governmentHessianEntry_scale_second
    {θ rho cg kg κ d e β ξ
      ai aj bi bj esi esj ehi ehj scale : ℝ} :
    governmentHessianEntry θ rho cg kg κ d e β ξ
        ai (scale * aj) bi (scale * bj) esi (scale * esj) ehi (scale * ehj) =
      scale * governmentHessianEntry θ rho cg kg κ d e β ξ
        ai aj bi bj esi esj ehi ehj := by
  unfold governmentHessianEntry reducedEmissionsSlope
  ring

end SLGPC
