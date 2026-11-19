#!/usr/bin/env python3
"""Bounded manuscript-process language regressions, not an independent prose peer review."""
from pathlib import Path
root=Path(__file__).resolve().parents[1]
sec={p.name:p.read_text(encoding="utf-8") for p in (root/"sections").glob("*.tex")}
bad={
 "introduction.tex":["surviving theorem-level distinction","contribution is deliberately narrower"],
 "equilibrium.tex":["hostile-audit","qualification bridge"],
 "related_literature.tex":["surviving contribution","repaired model","for our equilibrium repair"],
 "global_equilibrium_appendix.tex":["hostile-audit","regression test"],
 "appendix.tex":["continuous integration"],
 "declarations.tex":["independently reviewed and verified by the author"],
}
for file,items in bad.items():
 for phrase in items:
  assert phrase not in sec[file].lower(), (file,phrase)
assert "In Stage 1" in sec["model.tex"]  # correct economic-game timing
assert "not necessary for every possible reversal" in sec["main_results.tex"]
assert "nonempty open" in sec["equilibrium.tex"]
assert "no-$x$" in sec["global_equilibrium_appendix.tex"]
assert "0.000237" in sec["main_results.tex"]
assert "OpenAI ChatGPT" in sec["declarations.tex"]
print("STAGE 13 PROSE REGRESSION PASS (synthetic controls only)")
