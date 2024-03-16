PYTHON?=python -X dev

all: help

help: 								## Show this help
	@echo -e "Specify a command. The choices are:\n"
	@grep -E '^[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[0;36m%-18s\033[m %s\n", $$1, $$2}'
	@echo ""
.PHONY: help

tags:								## Generate ctags for main codebase
	ctags -f tags \
		--recurse=yes \
		--tag-relative=yes \
		--fields=+l \
		--kinds-python=-i \
		--language-force=python \
		papis
.PHONY: tags

pytest:								## Run pytest tests and doctests
	$(PYTHON) -m pytest -v -s src tests

flake8:								## Run flake8 (style checks)
	$(PYTHON) -m flake8 src tests
.PHONY: flake8

mypy:								## Run mypy (type annotations)
	$(PYTHON) -m mypy src tests
.PHONY: mypy
