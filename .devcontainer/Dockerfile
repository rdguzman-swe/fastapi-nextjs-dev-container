FROM mcr.microsoft.com/devcontainers/base:debian-12

RUN apt-get update && apt-get install -y \
    curl git build-essential ca-certificates \
    && rm -rf /var/lib/apt/lists/*

COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /usr/local/bin/

RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g pnpm \
    && rm -rf /var/lib/apt/lists/


RUN uv python install 3.13

RUN SNIPPET="export PROMPT_COMMAND='history -a'" \
    && echo "$SNIPPET" >> /root/.bashrc
