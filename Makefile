PYTHON ?= python3

.PHONY: verify test paper clean

verify:
	$(PYTHON) scripts/verify_freeze.py

test:
	$(PYTHON) -m pytest -q

paper:
	latexmk -pdf -interaction=nonstopmode -halt-on-error main.tex

clean:
	latexmk -C
