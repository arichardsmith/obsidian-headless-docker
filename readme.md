# obsidian-headless Docker

Runs [obsidian-headless](https://github.com/obsidianmd/obsidian-headless) in a container for continuous Obsidian Sync without the desktop app.

## Requirements

- Docker with the Compose plugin
- An [Obsidian Sync](https://obsidian.md/sync) subscription

## Setup

### 1. Configure your environment

Create a `.env` file in the same directory as `compose.yaml`:

```sh
VAULT_PATH=/absolute/path/to/your/vault
CONFIG_PATH=/absolute/path/to/config
UID=1000
GID=1000
```

Replace `UID` and `GID` with the output of `id -u` and `id -g` for your user. `CONFIG_PATH` is where login credentials and sync configuration will be stored.

### 2. Build the image

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

- Login credentials and sync configuration are stored at `CONFIG_PATH`. This directory will be created if it does not exist and should be added to `.gitignore` if inside your project directory.
- You only need to run the setup steps once as long as `CONFIG_PATH` is preserved.
- If you need to log out and log back in, run `docker compose run --rm --entrypoint ob obsidian-headless logout` before repeating step 3.
