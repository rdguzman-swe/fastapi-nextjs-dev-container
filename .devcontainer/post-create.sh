#!/bin/bash
set -e

echo "▶ Setting up Python backend..."
cd backend
uv sync
cd ..

echo "▶ Setting up Next.js frontend..."
cd frontend
pnpm install
cd ..

echo "✅ Dev container ready!"
