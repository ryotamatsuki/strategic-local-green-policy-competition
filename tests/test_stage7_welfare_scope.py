"""Regression guard for Stage 7 welfare-benchmark scope.

Keep the displayed planner feasible set aligned with the symmetric-policy
restriction actually used to calculate the cooperative welfare table.
This is distinct from any claim that the unrestricted global planner has
been solved.
"""
from pathlib import Path
import runpy

ROOT = Path(__file__).resolve().parents[1]

def test_symmetric_coordination_not_unrestricted_planner():
    text = (ROOT / "sections/welfare.tex").read_text(encoding="utf-8")
    assert r"\max_{s,h\geq0}" in text
    assert r"\left[W_A(s,h,s,h)+W_B(s,h,s,h)\right]" in text
    assert r"\max_{s_A,h_A,s_B,h_B\geq0}" not in text
    assert "not the solution to the unrestricted four-policy planner problem" in text

def test_exact_asymmetric_policy_beats_restricted_comparator():
    runpy.run_path(str(ROOT / "audits/stage7_exact_planner_counterexample.py"))
