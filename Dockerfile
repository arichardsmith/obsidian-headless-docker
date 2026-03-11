FROM node:25-alpine

RUN npm install -g obsidian-headless

ENV VAULT_PATH=/vault

ENTRYPOINT ["sh", "-c", "exec ob sync --path \"$VAULT_PATH\" --continuous"]
