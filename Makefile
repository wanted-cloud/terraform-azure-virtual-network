-include .env

CHDIR ?= $(shell pwd)

DOCS_OUTPUT  ?= README.md
DOCS_CONTEXT ?= .

.PHONY: all format docs valid package plan apply

plan:
	@terraform -chdir="$(CHDIR)" plan

apply:
	@terraform -chdir="$(CHDIR)" apply

format:
	@terraform -chdir="$(CHDIR)" fmt

valid:
	@terraform -chdir="$(CHDIR)" validate

docs:
	@terraform-docs markdown document --output-file $(DOCS_OUTPUT) --output-mode inject $(DOCS_CONTEXT)

package:
	@make format
	@make docs
