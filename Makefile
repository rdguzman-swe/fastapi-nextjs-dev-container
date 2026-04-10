PYTHON_VERSION := $(shell cat .python-version)
BASH := /bin/bash
.DEFAULT_GOAL := help

.PHONY: help
help: ## Show this help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}'

.PHONY: init
init: scaffold post-create ## Run full project setup (scaffold + post-create)

.PHONY: scaffold
scaffold: ## Create frontend (Next.js) and backend (FastAPI) if missing
	@echo "▶ Scaffolding frontend..."
	@if [ ! -d frontend ]; then \
		mkdir frontend && cd frontend && \
		bun create next-app@latest . --use-bun --typescript --tailwind --eslint --app --no-git && \
		bun add -d prettier && \
		jq '.scripts.format="prettier --write ." | .scripts["format:check"]="prettier --check ."' package.json > tmp.json && mv tmp.json package.json; \
	else \
		echo "  → frontend already exists"; \
	fi

	@echo "▶ Scaffolding backend..."
	@if [ ! -d backend ]; then \
		mkdir backend && cd backend && \
		uv init --no-readme && \
		uv venv --python $(PYTHON_VERSION) && \
		uv add fastapi uvicorn --link-mode=copy && \
		uv add --dev ruff ty pre-commit --link-mode=copy; \
	else \
		echo "  → backend already exists"; \
	fi

	@echo "✅ Scaffold complete!"

.PHONY: post-create
post-create: ## Run devcontainer post-create setup script
	$(BASH) .devcontainer/post-create.sh

.PHONY: frontend
frontend: ## Start frontend dev server (Next.js via Bun)
	cd frontend && bun dev

.PHONY: backend
backend: ## Start backend API server (FastAPI with uvicorn)
	cd backend && uv run uvicorn main:app --reload --host 0.0.0.0 --port 8000
