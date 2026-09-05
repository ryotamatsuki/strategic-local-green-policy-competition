from scripts.verify_freeze import (
    derive_firm_stage,
    verify_no_competitive_investment_benchmark,
    verify_threshold,
)


def test_firm_stage_closed_forms():
    derive_firm_stage()


def test_unique_switching_threshold():
    theta_star, bernstein = verify_threshold()
    assert 0 < theta_star < 1
    assert all(float(b) < 0 for b in bernstein)


def test_no_competitive_investment_benchmark():
    coeffs = verify_no_competitive_investment_benchmark()
    assert all(c > 0 for c in coeffs)
