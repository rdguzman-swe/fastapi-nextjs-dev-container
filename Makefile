SHELL := /bin/bash
.DEFAULT_GOAL := help

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}'

.PHONY: init
init: scaffold post-create

.PHONY: scaffold
scaffold:
	@echo "▶ Scaffolding backend..."
	@if [ ! -d backend ]; then \
		mkdir backend && cd backend && \
		uv init && \
		uv venv --python 3.13 && \
		uv add fastapi uvicorn; \
	else \
		echo "  → backend already exists"; \
	fi

	@echo "▶ Scaffolding frontend..."
	@if [ ! -d frontend ]; then \
		mkdir frontend && cd frontend && \
		bun create next-app@latest . --use-bun --typescript --tailwind --eslint --app --no-git; \
	else \
		echo "  → frontend already exists"; \
	fi

	@echo "✅ Scaffold complete!"

.PHONY: post-create
post-create:
	$(SHELL) .devcontainer/post-create.sh

.PHONY: backend
backend:
	cd backend && uv run uvicorn main:app --reload --host 0.0.0.0 --port 8000

.PHONY: frontend
frontend:
	cd frontend && bun dev

.PHONY: dev
dev:
	@echo "Run 'make backend' and 'make frontend' in separate terminals"

.PHONY: shell
shell:
	zsh
