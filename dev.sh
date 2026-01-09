#!/bin/bash

# Function to detect local IP address
get_local_ip(){
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        ipconfig getifaddr en0 || ipconfig getifaddr en1
    else
        # Linux
        hostname -I | awk '{print $1}'
    fi
}

echo "--- Bearfit Development Launcher (LAN Mode) ---"

IP=$(get_local_ip)

if [ -z "$IP" ]; then
    echo "Could not detect local IP. Falling back to localhost."
    export REACT_NATIVE_PACKAGER_HOSTNAME=localhost
    export EXPO_START_ARGS=""
else
    echo "Detected LAN IP: $IP"
    export REACT_NATIVE_PACKAGER_HOSTNAME=$IP
    export EXPO_START_ARGS="--lan"
fi

echo "Starting Docker containers..."
docker-compose up --build