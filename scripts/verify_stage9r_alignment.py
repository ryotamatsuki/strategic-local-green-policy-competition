from __future__ import annotations

from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

FREEZE_ID = "SLGPC-THEORY-FREEZE-2026-09-05-v2"
TITLE = "Strategic Local Green Policy Competition: Product-Market Rivalry and Instrument Switching"

PRODUCTION_TEXT_FILES = [
    ROOT / "main.tex",
    *sorted((ROOT / "sections").glob("*.tex")),
]

FORBIDDEN_PRODUCTION_STRINGS = [
    "Instrument Switching through Dual Investment",
    "conventional investment is necessary for switching",
    "dual-investment necessity",
    "h/(s+h)",
]

REQUIRED_FILES = [
    "docs/THEORY_FREEZE.md",
    "docs/THEORY_CHANGE_V1_TO_V2.md",
    "docs/STAGE4RG_GLOBAL_REPAIR.md",
    "docs/STAGE6_POST_REPAIR_NOVELTY_REKILL.md",
    "docs/STAGE7_POST_REPAIR_VALIDATION.md",
    "docs/STAGE7P5_REPEAT_POST_REPAIR.md",
    "docs/STAGE8_V2_STATUS.md",
    "scripts/verify_freeze.py",
    "scripts/verify_stage4rg_global.py",
    "scripts/verify_nox_global_counterexample.py",
    "scripts/verify_stage7_postrepair.py",
    "scripts/verify_stage10.py",
]


def read(relpath: str) -> str:
    return (ROOT / relpath).read_text(encoding="utf-8")


def verify_required_files() -> None:
    missing = [p for p in REQUIRED_FILES if not (ROOT / p).is_file()]
    assert not missing, f"Missing v2 provenance/verification files: {missing}"


def verify_canonical_identity() -> None:
    freeze = read("docs/THEORY_FREEZE.md")
    readme = read("README.md")
    stage8 = read("docs/STAGE8_V2_STATUS.md")
    main = read("main.tex")

    assert FREEZE_ID in freeze
    assert "CANONICAL — THEORY FROZEN" in freeze
    assert FREEZE_ID in readme
    assert FREEZE_ID in stage8
    assert TITLE in readme
    assert TITLE in main


def verify_production_claim_hygiene() -> None:
    violations: list[str] = []
    for path in PRODUCTION_TEXT_FILES:
        text = path.read_text(encoding="utf-8")
        lower = text.lower()
        for forbidden in FORBIDDEN_PRODUCTION_STRINGS:
            if forbidden.lower() in lower:
                violations.append(f"{path.relative_to(ROOT)}: {forbidden}")
    assert not violations, "Superseded v1 language in production manuscript: " + "; ".join(violations)


def verify_full_game_is_in_manuscript() -> None:
    equilibrium = read("sections/equilibrium.tex").lower()
    appendix = read("sections/global_equilibrium_appendix.tex").lower()
    model = read("sections/model.tex").lower()

    for token in ("nonnegative", "monopoly"):
        assert token in equilibrium or token in appendix
    assert "kink" in equilibrium or "kink" in appendix
    assert "nonnegative" in model


def verify_regression_guards_are_wired() -> None:
    workflow = read(".github/workflows/verify.yml")
    required_commands = [
        "python scripts/verify_stage9r_alignment.py",
        "python scripts/verify_stage4rg_global.py",
        "python scripts/verify_nox_global_counterexample.py",
        "python scripts/verify_stage7_postrepair.py",
        "python scripts/verify_stage10.py",
        "python -m pytest -q",
    ]
    for cmd in required_commands:
        assert cmd in workflow, f"CI missing required guard: {cmd}"


def main() -> None:
    verify_required_files()
    verify_canonical_identity()
    verify_production_claim_hygiene()
    verify_full_game_is_in_manuscript()
    verify_regression_guards_are_wired()
    print(f"canonical_freeze={FREEZE_ID}")
    print("STAGE 9R ALIGNMENT PASS")


if __name__ == "__main__":
    main()
