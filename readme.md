# obsidian-headless Docker

Runs [obsidian-headless](https://github.com/obsidianmd/obsidian-headless) in a container for continuous Obsidian Sync without the desktop app.

## Requirements

- Docker with the Compose plugin
- An [Obsidian Sync](https://obsidian.md/sync) subscription

## Setup

### 1. Build the image

```sh
docker compose build
```

### 3. Log in to Obsidian

```sh
docker compose run --rm --entrypoint ob obsidian-headless login
```

You will be prompted for your email, password, and MFA code if enabled.

### 4. Find your vault name

```sh
docker compose run --rm --entrypoint ob obsidian-headless sync-list-remote
```

### 5. Set up sync

```sh
docker compose run --rm --entrypoint ob obsidian-headless sync-setup --vault "My Vault" --path /vault
```

Replace `"My Vault"` with the name or ID from the previous step.

### 6. Start the sync service

```sh
docker compose up -d
```

## Usage

```sh
# Start
docker compose up -d

# Stop
docker compose down

# View logs
docker compose logs -f
```

## Notes

- The vault defaults to `./vault` relative to `compose.yaml`. To use a different path, set `VAULT_PATH` in a `.env` file or in your environment before running any `docker compose` commands.
- Login credentials and sync configuration are persisted in a named Docker volume (`obsidian-config`). You only need to run the setup steps once.
- If you need to log out and log back in, run `docker compose run --rm --entrypoint ob obsidian-headless logout` before repeating step 3.
