PROJECT_NAME := $(notdir $(CURDIR))

IMAGE_NAME     := $(PROJECT_NAME)-dev
CONTAINER_NAME := $(PROJECT_NAME)-dev
WORKSPACE      := /workspaces/$(PROJECT_NAME)

.DEFAULT_GOAL := help

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}'

.PHONY: init
init: up scaffold post-create

.PHONY: up
up: build start 

.PHONY: rebuild
rebuild: down build start post-create

.PHONY: build
build:
	docker build -t $(IMAGE_NAME) -f .devcontainer/Dockerfile .

.PHONY: start
start:
	@if [ "$$(docker ps -aq -f name=$(CONTAINER_NAME))" ]; then \
		echo "▶ Container exists. Starting..."; \
		docker start $(CONTAINER_NAME); \
	else \
		echo "▶ Creating container..."; \
		docker run -d \
			--name $(CONTAINER_NAME) \
			-v $(HOST_DIR):$(WORKSPACE) \
			-w $(WORKSPACE) \
			-p 3000:3000 \
			-p 8000:8000 \
			--entrypoint sleep \
			$(IMAGE_NAME) infinity; \
	fi

.PHONY: down
down: 
	-@docker stop $(CONTAINER_NAME)
	-@docker rm $(CONTAINER_NAME)

.PHONY: scaffold
scaffold:
	@echo "▶ Scaffolding backend..."
	docker exec $(CONTAINER_NAME) bash -c '\
		if [ ! -d backend ]; then \
			mkdir backend && cd backend && \
			uv init && \
			uv add fastapi uvicorn; \
		else \
			echo "  → backend already exists"; \
		fi'

	@echo "▶ Scaffolding frontend..."
	docker exec $(CONTAINER_NAME) bash -c '\
		if [ ! -d frontend ]; then \
			mkdir frontend && cd frontend && \
			pnpm dlx create-next-app@latest . --typescript --tailwind --eslint --app --no-git; \
		else \
			echo "  → frontend already exists"; \
		fi'

	@echo "✅ Scaffold complete!"

.PHONY: post-create
post-create:
	docker exec $(CONTAINER_NAME) bash .devcontainer/post-create.sh

.PHONY: backend
backend:
	docker exec -it $(CONTAINER_NAME) bash -c "cd backend && uv run uvicorn main:app --reload --host 0.0.0.0 --port 8000"

.PHONY: frontend
frontend:
	docker exec -it $(CONTAINER_NAME) bash -c "cd frontend && pnpm dev"

.PHONY: dev
dev:
	@echo "Run 'make backend' and 'make frontend' in separate terminals"

.PHONY: shell
shell:
	docker exec -it $(CONTAINER_NAME) bash
	