FROM mcr.microsoft.com/devcontainers/base:debian-12

RUN apt-get update && apt-get install -y \
    curl git build-essential ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /commandhistory \
    && touch /commandhistory/.zsh_history \
    && chown -R vscode:vscode /commandhistory

COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /usr/local/bin/
RUN uv python install $(shell cat .python-version)

USER vscode

RUN curl -fsSL https://bun.sh/install | bash

ENV BUN_INSTALL="/home/vscode/.bun"
ENV PATH="$BUN_INSTALL/bin:$PATH"

RUN echo 'export HISTFILE=/commandhistory/.zsh_history' >> /home/vscode/.zshrc \
    && echo 'export HISTSIZE=10000' >> /home/vscode/.zshrc \
    && echo 'export SAVEHIST=10000' >> /home/vscode/.zshrc \
    && echo 'setopt appendhistory' >> /home/vscode/.zshrc \
    && echo 'setopt sharehistory' >> /home/vscode/.zshrc \
    && echo 'setopt hist_ignore_dups' >> /home/vscode/.zshrc
