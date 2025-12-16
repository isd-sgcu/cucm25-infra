#!/usr/bin/env bash
set -e

echo "Starting update process..."
git reset --hard
git pull origin main

echo "Pulling latest Docker images..."
docker compose -f docker-compose.prod.yml pull
docker compose -f docker-compose.dev.yml pull

echo "Rebuilding and restarting containers..."
docker compose -f docker-compose.prod.yml up -d
docker compose -f docker-compose.dev.yml up -d

echo "Update process complete."
