from __future__ import annotations

from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
TITLE = "Strategic Local Green Policy Competition: Product-Market Rivalry and Instrument Switching"

REQUIRED_INPUTS = [
    "sections/introduction",
    "sections/model",
    "sections/equilibrium",
    "sections/main_results",
    "sections/welfare",
    "sections/robustness",
    "sections/institutional_bridge",
    "sections/related_literature",
    "sections/discussion",
    "sections/conclusion",
    "sections/appendix",
    "sections/global_equilibrium_appendix",
]


def read(relpath: str) -> str:
    return (ROOT / relpath).read_text(encoding="utf-8")


def production_text() -> str:
    paths = [ROOT / "main.tex", *sorted((ROOT / "sections").glob("*.tex"))]
    return "\n".join(p.read_text(encoding="utf-8") for p in paths)


def verify_manuscript_identity_and_structure() -> None:
    main = read("main.tex")
    assert TITLE in main
    assert "true SPNE of the full nonnegative-action game" in main
    for section in REQUIRED_INPUTS:
        assert f"\\input{{{section}}}" in main, f"main.tex missing {section}"


def verify_headline_results_are_formalized() -> None:
    equilibrium = read("sections/equilibrium.tex")
    results = read("sections/main_results.tex")
    assert "\\label{prop:global-spne}" in equilibrium
    assert "Canonical global-SPNE bridge" in equilibrium
    assert "\\label{prop:threshold}" in results
    assert "Unique instrument-switching threshold" in results
    assert "\\label{prop:no-x}" in results
    assert "Matched no-conventional-investment benchmark" in results
    assert "not necessary for every possible reversal" in results
    assert "rival-subsidy shock" in results
    assert "not a uniquely identified transmission channel" in results


def verify_welfare_and_robustness_scope() -> None:
    welfare = read("sections/welfare.tex")
    robustness = read("sections/robustness.tex")
    assert "\\max_{s_A,h_A,s_B,h_B\\geq0}" in welfare
    assert "\\frac{\\kappa h^2/2}{s g+\\kappa h^2/2}" in welfare
    assert "not a separate global-equilibrium theorem" in welfare
    assert "does not establish a global Bertrand-SPNE theorem" in robustness
    assert "not claimed for arbitrary $\\omega$" in robustness
    assert "does not imply that conventional investment is necessary for every possible reversal" in robustness


def verify_appendix_matches_compact_reduced_system() -> None:
    appendix = read("sections/appendix.tex")
    assert "eigenvalues $L-\\theta$ and $L+\\theta$" in appendix
    assert "equivalently, $L>\\theta$" in appendix


def verify_no_unresolved_markers() -> None:
    text = production_text().lower()
    for marker in ("todo", "tbd", "fixme", "xxx"):
        assert marker not in text, f"unresolved manuscript marker: {marker}"


def main() -> None:
    verify_manuscript_identity_and_structure()
    verify_headline_results_are_formalized()
    verify_welfare_and_robustness_scope()
    verify_appendix_matches_compact_reduced_system()
    verify_no_unresolved_markers()
    print("STAGE 10R MANUSCRIPT PASS")


if __name__ == "__main__":
    main()
