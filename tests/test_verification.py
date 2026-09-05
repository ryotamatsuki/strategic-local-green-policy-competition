from scripts.verify_freeze import (
    derive_firm_stage,
    verify_no_competitive_investment_benchmark,
    verify_threshold,
)
from scripts.verify_stage9r_alignment import (
    verify_canonical_identity,
    verify_full_game_is_in_manuscript,
    verify_production_claim_hygiene,
    verify_regression_guards_are_wired,
    verify_required_files,
)
from scripts.verify_stage10r_manuscript import (
    verify_appendix_matches_compact_reduced_system,
    verify_headline_results_are_formalized,
    verify_manuscript_identity_and_structure,
    verify_no_unresolved_markers,
    verify_welfare_and_robustness_scope,
)


def test_firm_stage_closed_forms():
    derive_firm_stage()


def test_unique_switching_threshold():
    theta_star, bernstein = verify_threshold()
    assert 0 < theta_star < 1
    assert all(float(b) < 0 for b in bernstein)


def test_matched_no_competitive_investment_benchmark():
    coeffs = verify_no_competitive_investment_benchmark()
    assert all(c > 0 for c in coeffs)


def test_stage9r_canonical_identity():
    verify_required_files()
    verify_canonical_identity()


def test_stage9r_manuscript_hygiene_and_full_game():
    verify_production_claim_hygiene()
    verify_full_game_is_in_manuscript()


def test_stage9r_ci_regression_guards():
    verify_regression_guards_are_wired()


def test_stage10r_structure_and_headline_results():
    verify_manuscript_identity_and_structure()
    verify_headline_results_are_formalized()


def test_stage10r_scope_and_appendix_consistency():
    verify_welfare_and_robustness_scope()
    verify_appendix_matches_compact_reduced_system()
    verify_no_unresolved_markers()
