.PHONY: run

run: install-dependencies
	venv/bin/python3 helios.py
	


install-dependencies: venv/installed

venv/installed: venv requirements.txt
	venv/bin/pip install -r requirements.txt
	touch venv/installed

venv:
	python3 -m venv venv
