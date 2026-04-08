IMAGE_NAME     := PROJECT_NAME-dev
CONTAINER_NAME := PROJECT_NAME-dev
WORKSPACE      := /workspaces/PROJECT_NAME
HOST_DIR       := $(PWD)

.DEFAULT_GOAL  := help

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}'

.PHONY: init
init: setup scaffold

.PHONY: scaffold
scaffold:
	@echo "▶ Scaffolding backend..."
	docker exec $(CONTAINER_NAME) bash -c "\
		mkdir -p $(WORKSPACE)/backend && \
		cd $(WORKSPACE)/backend && \
		uv init && \
		uv add fastapi uvicorn"
	@echo "▶ Scaffolding frontend..."
	docker exec $(CONTAINER_NAME) bash -c "\
		mkdir -p $(WORKSPACE)/frontend && \
		cd $(WORKSPACE)/frontend && \
		pnpm dlx create-next-app@latest . --typescript --tailwind --eslint --app --no-git"
	@echo "✅ Scaffold complete!"

.PHONY: setup
setup: build start post-create

.PHONY: build
build:
	docker build -t $(IMAGE_NAME) -f .devcontainer/Dockerfile .

.PHONY: start
start:
	docker run -d \
		--name $(CONTAINER_NAME) \
		-v $(HOST_DIR):$(WORKSPACE) \
		-w $(WORKSPACE) \
		-p 3000:3000 \
		-p 8000:8000 \
		--entrypoint sleep \
		$(IMAGE_NAME) infinity

.PHONY: post-create
post-create:
	docker exec $(CONTAINER_NAME) bash .devcontainer/post-create.sh

.PHONY: backend
backend:
	docker exec $(CONTAINER_NAME) bash -c "cd backend && uv run uvicorn main:app --reload --host 0.0.0.0 --port 8000"

.PHONY: frontend
frontend:
	docker exec $(CONTAINER_NAME) bash -c "cd frontend && pnpm dev"

.PHONY: shell
shell:
	docker exec -it $(CONTAINER_NAME) bash

.PHONY: down
down:
	docker stop $(CONTAINER_NAME) && docker rm $(CONTAINER_NAME)

.PHONY: rebuild
rebuild: down build start post-create
