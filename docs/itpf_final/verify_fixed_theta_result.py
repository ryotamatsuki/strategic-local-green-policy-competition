"""Exact rational regression of the bounded fixed-theta/two-target-discipline result.

Intended for repo root: python docs/itpf_final/verify_fixed_theta_result.py.
Uses the source-independent five-regime enumerator copied from PR #34.
All critical inequalities are exact SymPy rationals. A grid is NOT a proof.
"""
from sympy import Rational as Q
from exact_policy_slice import inspect, diagnostic_root, b, nu, m

def validate_pair():
    th = Q(31,40)
    out=[]
    for d,expected in [(Q(39,20),-1),(Q(41,20),1)]:
        status,pol,direct,slope,channels,margin,alt=inspect(th,d)
        assert status == "strict against exclusion", (d,status)
        assert pol[0]>0 and pol[1]>0
        assert margin is not None and margin>0
        assert direct>0
        assert expected*slope>0
        assert sum(channels)==slope
        assert alt[0] in ("own kink","own monopoly")
        assert abs(float(slope)-{-1:-.001502298691134273,1:.0014028910850954546}[expected])<1e-12
        assert abs(float(margin)-{ -1:1.2250418632593525,1:1.250984466509824}[expected])<1e-12
        print("PASS exact fixed theta", th, "d", d, "s", pol[0],
              "h",pol[1],"direct",direct,"profiled-slope",slope,
              "regime-gap",margin,"outside-branch",alt[0])
        out.append((status,pol,direct,slope,margin))
    assert out[0][3]<0<out[1][3]
    # This is an existence theorem with strict inequalities, not a full interval or
    # uniqueness-of-all-equilibria result. At each witness the implicit policy
    # FOC, open feasible branch and globally strict branch-gap persist locally.
    return out

def counterchecks():
    t0=Q(1)
    d0,sensitivity=diagnostic_root(t0)
    assert d0==Q(89308800,54845239)
    status,pol,direct,slope,parts,gap,alt=inspect(t0,d0)
    assert status=="failed or tied" and gap<0
    assert slope==0
    assert abs(float(-gap)-.2814095663973427)<1e-12
    assert alt[0]=="own monopoly"
    print("PASS off-branch falsification at theta=1,d=dstar(1):",
          "exact d",d0,"gain", -gap, "branch", alt[0])

    for d in [Q(3,2),Q(3)]:
        status,pol,direct,slope,parts,gap,alt=inspect(Q(9,10),d)
        if d==Q(3,2):
            assert status=="failed or tied" and gap<0
            assert abs(float(-gap)-.2956411290227331)<1e-12
        else:
            assert status=="infeasible" and pol[1]<0
        print("PASS excluded sensitivity",d,status)
if __name__=="__main__":
    validate_pair()
    counterchecks()
    print("EXACT FIXED-THETA + NEGATIVE FALSIFICATION CERTIFICATE: PASS")
