FROM node:25-alpine

RUN npm install -g obsidian-headless

ARG UID=1000
ARG GID=1000

RUN deluser --remove-home node \
    && addgroup -g $GID obsidian \
    && adduser -D -u $UID -G obsidian obsidian

USER obsidian

ENV VAULT_PATH=/vault

ENTRYPOINT ["sh", "-c", "exec ob sync --path \"$VAULT_PATH\" --continuous"]
