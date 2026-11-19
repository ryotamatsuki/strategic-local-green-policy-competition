PYTHON ?= python3

.PHONY: verify test paper ci clean

verify:
	$(PYTHON) scripts/verify_stage9r_alignment.py
	$(PYTHON) scripts/verify_stage10r_manuscript.py
	$(PYTHON) scripts/verify_freeze.py
	$(PYTHON) scripts/verify_stage4rg_global.py
	$(PYTHON) scripts/verify_nox_global_counterexample.py
	$(PYTHON) scripts/verify_stage7_postrepair.py
	$(PYTHON) scripts/verify_stage10.py
	$(PYTHON) scripts/verify_stage11r_target_scope.py
	$(PYTHON) docs/stage11_v3/recompute_stage6_target_boundary.py
	$(PYTHON) docs/itpf_final/verify_fixed_theta_result.py

test:
	$(PYTHON) -m pytest -q

paper:
	$(PYTHON) scripts/make_figure1_threshold_response.py
	latexmk -pdf -interaction=nonstopmode -halt-on-error main.tex

ci: verify test paper

clean:
	latexmk -C
