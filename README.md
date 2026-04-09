# nextjs-fastapi-dev-container

[![Next.js](https://img.shields.io/badge/%E2%80%8B-Next%2Ejs-000000?logo=Next%2Ejs)](https://github.com/vercel/next.js)
[![Tailwind CSS](https://img.shields.io/badge/%E2%80%8B-Tailwind%20CSS-06B6D4?logo=Tailwind%20CSS)](https://github.com/tailwindlabs/tailwindcss)
[![React](https://img.shields.io/badge/%E2%80%8B-React-61DAFB?logo=React)](https://github.com/facebook/react)
[![TypeScript](https://img.shields.io/badge/%E2%80%8B-TypeScript-3178C6?logo=TypeScript)](https://github.com/microsoft/Typescript)
[![ESLint](https://img.shields.io/badge/%E2%80%8B-ESLint-4B32C3?logo=ESLint)](https://github.com/eslint/eslint)
[![Prettier](https://img.shields.io/badge/%E2%80%8B-Prettier-F7B93E?logo=Prettier)](https://github.com/prettier/prettier)
[![Bun](https://img.shields.io/badge/%E2%80%8B-Bun-000000?logo=Bun)](https://github.com/oven-sh/bun)
[![FastAPI](https://img.shields.io/badge/%E2%80%8B-FastAPI-009688?logo=FastAPI)](https://github.com/fastapi/fastapi)
[![Python](https://img.shields.io/badge/%E2%80%8B-Python-3776AB?logo=Python)](https://github.com/python/cpython)
[![uv](https://img.shields.io/badge/%E2%80%8B-uv-DE5FE9?logo=uv)](https://github.com/astral-sh/uv)
[![ruff](https://img.shields.io/badge/%E2%80%8B-ruff-D7FF64?logo=ruff)](https://github.com/astral-sh/ruff)
[![ty](https://img.shields.io/badge/%E2%80%8B-ty-45ebe0?logo=ty)](https://github.com/astral-sh/ty)
[![pre-commit](https://img.shields.io/badge/%E2%80%8B-pre--commit-FAB040?logo=pre-commit)](https://github.com/pre-commit/pre-commit)

A minimal, batteries-included dev container for building full-stack apps with Next.js and FastAPI—no local setup required.

---

## ✨ Features

- ⚡️ Fast tooling via `Bun` and `uv`
- 🧠 Linting with `ESLint` and `ruff`
- 🎨 Formatting with `Prettier` and `ruff`
- 🔍 Static type checking with `TypeScript` and `ty`
- 🪝 Automatic checks via `pre-commit` hooks
- 🛠️ Simple developer workflow via `Makefile`
- 🐳 Docker-in-Docker support
- 🔁 Persistent shell history across container rebuilds

---

## 🚀 Getting Started

### Prerequisites

Make sure you have the following dependencies installed:

- Docker
- VS Code with the "Dev Containers" extension

> **Note:** This dev container is made specifically for VS Code, but it should work with any IDE that has a "Dev Containers" plugin.

### Setup

1.  Clone the repo

```bash
git clone https://github.com/rdguzman-swe/fastapi-nextjs-dev-container.git <your-project>
```

2. Open in VS Code

```bash
code <your-project>
```

3. Reopen in container
   - `Cmd/Ctrl + Shift + P`
   - Select `Dev Containers: Reopen in Container`

4. Initialize project

```bash
make init
```

This will scaffold the backend and frontend and ainstall all dependencies.

5. Edit `frontend/` and `backend/` files as needed

---

## 📁 Project Structure

```diff
.
├── .devcontainer/           # Dev container config
├── backend/                 # FastAPI app (created on scaffold)
├── frontend/                # Next.js app (created on scaffold)
├── .gitignore
├── .pre-commit-config.yaml  # pre-commit hooks
├── .python-version
├── LICENSE.txt
├── Makefile                 # Developer commands
└── README.md
```

---

## 🛠️ Developer Commands

Run `make help` to see a list of all available commands:

```bash
make help
```

| Command            | Description                                    |
| ------------------ | ---------------------------------------------- |
| `make init`        | Full setup (scaffold + install)                |
| `make scaffold`    | Create backend & frontend if missing           |
| `make frontend`    | Run Next.js dev server (http://localhost:3000) |
| `make backend`     | Run FastAPI server (http://localhost:8000)     |
| `make post-create` | Re-run container setup script                  |

---

## 🪝 Pre-commit Hooks
This dev container includes `pre-commit` hooks to automatically run checks before each commit:
- `eslint` (TypeScript linting)
- `prettier` (TypeScript formatting)
- `ruff check` (Python linting)
- `ruff format` (Python formatting)
- `ty` (Python type checking)

> Hooks are automatically installed when the dev container is created.

---

## ⚙️ Dev Container Details

### Preinstalled Tools

- `Zsh` (Z shell)
- `Git`
- `curl`
- Build tools
- `Bun`
- `uv`
- `Python`

### VS Code Extensions

- `Tailwind CSS`
- `ESLint`
- `Prettier`
- `Python`
- `Pylance`
- `Ruff`
- `ty`
- `Docker`

---

## 🐍 Python Version
The default Python version for this dev container is Python 3.13. To use a different version, modify the `.python-version` file as follows:

```diff
3.13 -> <your-version>
```

Make sure to rebuild the dev container to see the changes.

---

## 📄 License
This project is licensed under the MIT License.
