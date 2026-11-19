#!/usr/bin/env python3
"""Machine-check ITPF Regular Article format; NOT a publication-readiness verdict."""
from __future__ import annotations
import re
import sys
import zipfile
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
MAIN = (ROOT/'main.tex').read_text(encoding='utf-8')
DECL = (ROOT/'sections/declarations.tex').read_text(encoding='utf-8')
RESULTS = (ROOT/'sections/main_results.tex').read_text(encoding='utf-8')
METADATA = (ROOT/'submission/itpf/metadata.md').read_text(encoding='utf-8')
AI_USE = ('Generative AI tools, including OpenAI ChatGPT, were used to assist with '
          'exploratory model development, literature organization, symbolic cross-checking, '
          'manuscript drafting, and language revision.')

assert r'\documentclass[11pt]{article}' in MAIN, 'Article class retained; Springer class recommended, not mandated'
assert r'\captionsetup[figure]{labelfont=bf,labelsep=space}' in MAIN
assert r'\renewcommand{\figurename}{Fig.}' in MAIN
assert r'\renewcommand{\thefootnote}{}' in MAIN, 'ITPF title-page AI footnote must be unnumbered'
assert r'\footnotetext{AI use disclosure:' in MAIN
assert MAIN.index(r'\maketitle') < MAIN.index(r'\footnotetext') < MAIN.index(r'\begin{abstract}')
assert AI_USE in MAIN and AI_USE in DECL and AI_USE in METADATA, 'Title, declarations, metadata AI-use activity mismatch'
assert r'\author{Ryota Matsuki' in MAIN
assert 'Independent Researcher' in MAIN and 'Matsuyama, Ehime, Japan' in MAIN
assert 'ryota.matsuki@gmail.com' in MAIN and '0009-0005-2329-531X' in MAIN

abstract = re.search(r'\\begin\{abstract\}(.*?)\\end\{abstract\}', MAIN, re.S)
assert abstract, 'Abstract not found'
words = re.findall(r"[A-Za-z0-9]+(?:[-'][A-Za-z0-9]+)*", abstract.group(1))
assert 150 <= len(words) <= 250, f'Abstract word count outside 150-250: {len(words)}'
assert 'subgame-perfect Nash equilibrium (SPNE)' in abstract.group(1), 'Undefined SPNE in abstract'
km = re.search(r'\\textbf\{Keywords:\}\s*(.+?)\\\\', MAIN, re.S)
assert km, 'Keywords missing'
keywords = [x.strip() for x in km.group(1).split(';') if x.strip()]
assert 4 <= len(keywords) <= 6, f'Keywords count outside 4-6: {len(keywords)}'
assert r'\textbf{JEL codes:}' in MAIN
assert r'\bibliographystyle{apalike}' in MAIN
assert r'\includegraphics[width=0.72\textwidth]{figures/Fig1.pdf}' in RESULTS
fig = re.search(r'\\begin\{figure\}.*?\\caption\{(.*?)\}\s*\\label\{fig:threshold-response\}.*?\\end\{figure\}', RESULTS, re.S)
assert fig, 'Missing Figure 1 caption or label'
assert not fig.group(1).strip().endswith('.'), 'Figure 1 caption must not end with punctuation'

for rel in ('figures/Fig1.pdf','figures/Fig1.eps','figures/figure1_threshold_response.pdf'):
    p = ROOT/rel
    assert p.is_file() and p.stat().st_size > 0, f'Missing plot {rel}'
assert (ROOT/'figures/Fig1.pdf').read_bytes() == (ROOT/'figures/figure1_threshold_response.pdf').read_bytes(), 'Fig1.pdf differs from canonical plot'
for statement in ('Funding','Competing interests','Data availability','Code availability','Use of generative AI'):
    assert statement in DECL, f'Missing declaration {statement}'
assert 'Author contributions' in METADATA
assert 'submission fee' in METADATA.lower()

if len(sys.argv) > 1:
    source = Path(sys.argv[1])
    with zipfile.ZipFile(source) as f:
        names = set(f.namelist())
    required = {'main.tex','references.bib','figures/Fig1.pdf','figures/Fig1.eps',
                'figures/figure1_threshold_response.pdf','scripts/make_figure1_threshold_response.py'}
    required.update('sections/'+p.name for p in (ROOT/'sections').glob('*.tex'))
    assert required.issubset(names), f'Source ZIP is missing: {sorted(required-names)}'
    assert not any(name.startswith(('.git/','.github/','docs/','submission/')) for name in names), 'Submission source ZIP contains internal project files'
    print('ITPF SOURCE ZIP PASS')

print(f'ITPF FORMAT PASS: abstract_words={len(words)} keywords={len(keywords)} unnumbered_title_AI=PASS Fig1_pdf_eps=PASS')
