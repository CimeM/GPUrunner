#!/bin/bash

COMPOSE_FILE="/usr/local/bin/runner/docker-compose.yaml"
PROFILES=("runners" "monitoring")
LOG_FILE="/var/log/runner-service-docker-compose-profiles.log"

for profile in "${PROFILES[@]}"; do
    echo "Starting profile: $profile" >> "$LOG_FILE"
    docker-compose -f "$COMPOSE_FILE" --profile "$profile" up -d
    if [ $? -ne 0 ]; then
        echo "Error starting profile: $profile" >> "$LOG_FILE"
    else
        echo "Successfully started profile: $profile" >> "$LOG_FILE"
    fi
done

echo "All profiles have been processed" >> "$LOG_FILE"
