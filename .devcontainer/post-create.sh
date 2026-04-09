#!/usr/bin/env bash
set -e

echo "▶ Running post-create setup..."

if [ -d "frontend" ]; then
  echo "▶ Setting up frontend..."
  cd frontend

  echo "  → Installing dependencies..."
  bun install || true

  cd ..
else
  echo "⚠️  Skipping frontend (not initialized yet)"
fi

if [ -d "backend" ]; then
  echo "▶ Setting up backend..."
  cd backend

  echo "  → Recreating virtual environment..."
  rm -rf .venv
  uv venv

  echo "  → Syncing dependencies..."
  uv sync --link-mode=copy || true

  cd ..
else
  echo "⚠️  Skipping backend (not initialized yet)"
fi

if [[ -d "backend" && -d "frontend" ]]; then
  echo "  → Installing pre-commit hooks..."
  uv tool install pre-commit --link-mode=copy
  pre-commit install --install-hooks
else
  echo "⚠️  Skipping pre-commit hooks (not initialized yet)"
fi

echo "✅ post-create complete!"
