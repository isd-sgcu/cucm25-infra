#!/usr/bin/env bash
set -e

echo "Starting update process..."
git reset --hard
git pull origin main

echo "Pulling latest Docker images..."
docker compose -f compose.prod.yml pull
docker compose -f compose.dev.yml pull

echo "Rebuilding and restarting containers..."
docker compose -f compose.prod.yml up -d
docker compose -f compose.dev.yml up -d

echo "Update process complete."
