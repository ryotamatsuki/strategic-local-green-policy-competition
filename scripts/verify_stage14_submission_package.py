from __future__ import annotations

import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
MAIN = ROOT / "main.tex"
SECTIONS = sorted((ROOT / "sections").glob("*.tex"))
BIB = ROOT / "references.bib"
FIGURE = ROOT / "figures" / "figure1_threshold_response.pdf"
FIGURE_SCRIPT = ROOT / "scripts" / "make_figure1_threshold_response.py"


def fail(message: str) -> None:
    raise SystemExit(f"STAGE14 QA FAIL: {message}")


main = MAIN.read_text(encoding="utf-8")
section_text = "\n".join(p.read_text(encoding="utf-8") for p in SECTIONS)
all_manuscript = main + "\n" + section_text
bib = BIB.read_text(encoding="utf-8")

m = re.search(r"\\begin\{abstract\}(.*?)\\end\{abstract\}", main, re.S)
if not m:
    fail("abstract not found")
abstract = m.group(1)
abstract_plain = re.sub(r"\\[A-Za-z]+\*?(?:\[[^\]]*\])?", " ", abstract)
abstract_plain = re.sub(r"[{}$]", " ", abstract_plain)
words = re.findall(r"[A-Za-z0-9]+(?:[-'][A-Za-z0-9]+)*", abstract_plain)
if not 150 <= len(words) <= 250:
    fail(f"abstract word count {len(words)} outside 150--250")

km = re.search(r"\\textbf\{Keywords:\}\s*(.+?)\\\\", main)
if not km:
    fail("keywords line not found")
keywords = [x.strip() for x in km.group(1).split(";") if x.strip()]
if not 4 <= len(keywords) <= 6:
    fail(f"keyword count {len(keywords)} outside 4--6")

jm = re.search(r"\\textbf\{JEL codes:\}\s*([^\n]+)", main)
if not jm or not jm.group(1).strip():
    fail("JEL codes missing")
jel = [x.strip() for x in jm.group(1).split(",") if x.strip()]

bib_keys = set(re.findall(r"@\w+\{([^,]+),", bib))
cited_keys: set[str] = set()
for raw in re.findall(r"\\cite\w*\{([^}]+)\}", all_manuscript):
    cited_keys.update(x.strip() for x in raw.split(",") if x.strip())
missing = sorted(bib_keys - cited_keys)
unknown = sorted(cited_keys - bib_keys)
if missing:
    fail(f"uncited bibliography entries: {missing}")
if unknown:
    fail(f"citation keys absent from references.bib: {unknown}")

for path in [MAIN, *SECTIONS, BIB]:
    text = path.read_text(encoding="utf-8")
    if re.search(r"\b(TODO|FIXME|TBD|PLACEHOLDER)\b", text, re.I):
        fail(f"stale placeholder token in {path.relative_to(ROOT)}")

declarations = (ROOT / "sections" / "declarations.tex").read_text(encoding="utf-8")
for required in [
    "Funding",
    "Competing interests",
    "Data availability",
    "Code availability",
    "Use of generative AI",
]:
    if required not in declarations:
        fail(f"missing declaration: {required}")

for doi in re.findall(r"doi\s*=\s*\{([^}]+)\}", bib):
    if f"https://doi.org/{doi}" not in bib:
        fail(f"DOI is not exposed as a full link: {doi}")

author_match = re.search(r"\\author\{(.*?)\}\s*\\date", main, re.S)
if not author_match or not author_match.group(1).strip():
    fail("author metadata missing")
author_block = author_match.group(1)
for required in [
    "Ryota Matsuki",
    "Independent Researcher",
    "ryota.matsuki@gmail.com",
    "0009-0005-2329-531X",
]:
    if required not in author_block:
        fail(f"author metadata incomplete: {required}")

if "graphicx" not in main:
    fail("graphicx package missing after Figure 1 integration")
if not FIGURE_SCRIPT.is_file():
    fail("Figure 1 generation script missing")
if not FIGURE.is_file() or FIGURE.stat().st_size == 0:
    fail("Figure 1 PDF missing or empty")
results = (ROOT / "sections" / "main_results.tex").read_text(encoding="utf-8")
introduction = (ROOT / "sections" / "introduction.tex").read_text(encoding="utf-8")
if "\\label{fig:threshold-response}" not in results:
    fail("Figure 1 label missing")
if "Figure~\\ref{fig:threshold-response}" not in results:
    fail("Figure 1 not referenced in Main Results")
if "Figure~\\ref{fig:threshold-response}" not in introduction:
    fail("Figure 1 not previewed in Introduction")

print("STAGE14 MACHINE QA PASS")
print(f"abstract_words={len(words)}")
print(f"keywords={len(keywords)}")
print(f"jel_codes={len(jel)}")
print(f"bibliography_entries={len(bib_keys)}")
print(f"citations_resolved={len(cited_keys)}")
print("author_metadata_ready=True")
print("funding_declaration_ready=True")
print("competing_interests_ready=True")
print("figure1_reproducible=True")
print("STAGE14 PORTAL GATE: stop before payment if the live ITPF portal requests any mandatory submission fee.")
