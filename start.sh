#!/bin/bash
#Modifies permissions
chown 0:0 /PATH/TO/traefik
chmod 600 /PATH/TO/traefik/acme.json
echo "Starting traefik reverse proxy..."
#Launches docker-compose container in detached mode
docker-compose up -d
