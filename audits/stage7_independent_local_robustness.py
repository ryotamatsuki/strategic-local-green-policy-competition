"""Independent local robustness calculation for Stage 7.
Constructs Bertrand and ownership-leakage government quadratic problems from
reduced direct product demand and their respective firm-investment FOCs.
All findings are INTERIOR local comparative statics, not global SPNE certificates.
Requires sympy (pinned in root requirements.txt).
"""
import sympy as S

sA, hA, sB, hB = S.symbols("sA hA sB hB")
kx, kg, mu, nu, kappa, d, e, beta, xi, m = map(
    S.Rational, ("4", "18", "0.9", "1.2", "0.8", "2", "1.1", "1.7", "0.1", "2")
)
R = 1 / kx + mu**2 / kg


def response(theta, market):
    t = S.Rational(theta)
    D = 4 - t**2
    yA = m + mu*sA/kg + nu*hA
    yB = m + mu*sB/kg + nu*hB
    if market == "Bertrand":
        # FOC in prices: 2p_i-theta*p_j = a(1-theta)+c_i
        # Direct-demand quantity response to effective cost intercepts.
        eta = 2 * (2 - t**2) / D
        a = (2 - t**2) / (D * (1 - t**2))
        b = -t / (D * (1 - t**2))
        M = S.Matrix([[1-a*eta*R, -b*eta*R],
                      [-b*eta*R, 1-a*eta*R]])
        quantities = M.inv() * S.Matrix([a*yA+b*yB, a*yB+b*yA])
        operating_multiplier = 1-t**2
        invest_coefficient = eta
    else:
        L = 2-4*R/D
        quantities = S.Matrix([[L,t],[t,L]]).inv() * S.Matrix([yA,yB])
        operating_multiplier = 1
        invest_coefficient = 4/D

    qA, qB = quantities
    xA = invest_coefficient*qA/kx
    gA = (sA+mu*invest_coefficient*qA)/kg
    CS = (qA**2+qB**2)/2+t*qA*qB
    PS = operating_multiplier*qA**2-kx*xA**2/2-kg*gA**2/2
    E = e*qA-beta*gA-xi*hA
    if market == "leakage":
        omega = S.Rational(9,10)
        WA = CS/2 + omega*PS+(omega-1)*sA*gA-kappa*hA**2/2-d*E**2/2
    else:
        WA = CS/2 + PS-kappa*hA**2/2-d*E**2/2
    H = S.hessian(WA,(sA,hA))
    cross = S.Matrix([S.diff(WA,sA,sB),S.diff(WA,hA,sB)])
    slopes = -H.inv()*cross
    return tuple(float(a) for a in slopes),float(H[0,0]),float(H.det())

checks = [
    ("Bertrand", "0.3", -0.001694484446836663),
    ("Bertrand", "0.5", +0.004012630093840069),
    ("leakage", "0.5", -0.00009679840633480625),
    ("leakage", "0.7", +0.0032462408598272798),
]
for setting,t,expected in checks:
    slopes,hss,det = response(t,setting)
    assert hss < 0 and det > 0, (setting,t,"not own-policy strictly concave")
    assert abs(slopes[1]-expected)<1e-11
    print(setting,t,"dsA/dsB=",slopes[0],"dhA/dsB=",slopes[1],"Hss=",hss,"detH=",det)
print("PASS: independent Bertrand and local-ownership sign changes; not global certificates")
