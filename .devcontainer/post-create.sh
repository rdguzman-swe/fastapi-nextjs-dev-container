#!/usr/bin/env bash
set -e

echo "▶ Running post-create setup..."

if [ -d "backend" ]; then
  echo "▶ Setting up backend..."
  cd backend

  if [ ! -d ".venv" ]; then
    echo "  → Creating virtual environment..."
    uv venv
  fi

  echo "  → Syncing dependencies..."
  uv sync || true

  cd ..
else
  echo "⚠️  Skipping backend (not initialized yet)"
fi

if [ -d "frontend" ]; then
  echo "▶ Setting up frontend..."
  cd frontend

  echo "  → Installing dependencies..."
  pnpm install || true

  cd ..
else
  echo "⚠️  Skipping frontend (not initialized yet)"
fi

echo "✅ post-create complete!"
