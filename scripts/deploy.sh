#!/usr/bin/env bash
set -euo pipefail

DOMAINS=( 
  "coin.cucm25.me"
  "dev-coin.cucm25.me"
)

echo "Deploying NGINX configuration files..."
sudo cp -r nginx/* /etc/nginx/

echo "Enabling sites..."
for site in nginx/sites-available/*; do
    site_name=$(basename "$site")
    sudo ln -sf /etc/nginx/sites-available/"$site_name" /etc/nginx/sites-enabled/"$site_name"
done

echo "Testing and reloading NGINX..."
sudo nginx -t && sudo systemctl reload nginx

echo "Setting up SSL certificates with Certbot..."
sudo certbot --nginx --expand\
  --non-interactive --agree-tos \
  --email "abuse@isd.sgcu.in.th" \
  $(printf -- "-d %s " "${DOMAINS[@]}")

echo "Deployment complete."
