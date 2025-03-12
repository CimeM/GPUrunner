#!/bin/bash

COMPOSE_FILE="/usr/local/bin/runner/docker-compose.yaml"
PROFILES=("runners" "monitoring")
LOG_FILE="/var/log/docker-compose-profiles.log"

for profile in "${PROFILES[@]}"; do
    echo "Stopping profile: $profile" >> "$LOG_FILE"
    docker-compose -f "$COMPOSE_FILE" --profile "$profile" down
    if [ $? -ne 0 ]; then
        echo "Error stopping profile: $profile" >> "$LOG_FILE"
    else
        echo "Successfully stopped profile: $profile" >> "$LOG_FILE"
    fi
done

echo "All profiles have been stopped" >> "$LOG_FILE"
