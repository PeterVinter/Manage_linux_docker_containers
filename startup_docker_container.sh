#!/bin/bash

# Setup logging
LOG_FILE="startup_logs.txt"
SHUTDOWN_LIST="shutdowned.txt"

log_message() {
    local message="$1"
    local level="${2:-INFO}"  # Default level is INFO
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] [$level] $message" | tee -a "$LOG_FILE"
}

# Function to check container status
check_container() {
    local name=$1
    local exists=$(docker ps -a --filter "name=^/${name}$" --format '{{.Names}}')
    local is_running=$(docker ps --filter "name=^/${name}$" --format '{{.Names}}')
    
    if [ ! -z "$is_running" ]; then
        echo "running"
    elif [ ! -z "$exists" ]; then
        echo "stopped"
    else
        echo "none"
    fi
}

# Function to get container details
get_container_details() {
    local name=$1
    local details=$(docker inspect "$name" 2>/dev/null)
    if [ $? -eq 0 ]; then
        local ip=$(echo "$details" | grep -m 1 '"IPAddress":' | cut -d '"' -f 4)
        local created=$(echo "$details" | grep -m 1 '"Created":' | cut -d '"' -f 4)
        echo "IP: $ip, Created: $created"
    else
        echo "No details available"
    fi
}

# Function to reverse file content (compatible with both macOS and Linux)
reverse_file() {
    if command -v tac >/dev/null 2>&1; then
        tac "$1"
    else
        tail -r "$1"
    fi
}

# Check if shutdown list exists
if [ ! -f "$SHUTDOWN_LIST" ]; then
    log_message "No shutdown list found at $SHUTDOWN_LIST. Nothing to start." "WARNING"
    exit 1
fi

log_message "Starting Docker containers from shutdown list..." "INFO"

# Read the shutdown list in reverse order (to respect dependencies)
while IFS='|' read -r name image cmd ports networks; do
    log_message "Processing container: $name" "INFO"
    
    # Check container status
    container_status=$(check_container "$name")
    
    case "$container_status" in
        "running")
            log_message "Container $name is already running" "INFO"
            details=$(get_container_details "$name")
            log_message "Container details - $details" "INFO"
            ;;
        "stopped")
            log_message "Starting stopped container: $name" "INFO"
            if docker start "$name"; then
                details=$(get_container_details "$name")
                log_message "Successfully started container $name" "SUCCESS"
                log_message "Container details - $details" "INFO"
            else
                log_message "Failed to start container $name" "ERROR"
            fi
            ;;
        "none")
            log_message "Creating new container: $name" "INFO"
            # Create and start the container
            if [ -z "$networks" ]; then
                if docker run -d --name "$name" $ports "$image" $cmd; then
                    details=$(get_container_details "$name")
                    log_message "Successfully created and started container $name" "SUCCESS"
                    log_message "Container details - $details" "INFO"
                else
                    log_message "Failed to create container $name" "ERROR"
                fi
            else
                if docker run -d --name "$name" $ports --network "$networks" "$image" $cmd; then
                    details=$(get_container_details "$name")
                    log_message "Successfully created and started container $name with network $networks" "SUCCESS"
                    log_message "Container details - $details" "INFO"
                else
                    log_message "Failed to create container $name with network $networks" "ERROR"
                fi
            fi
            ;;
    esac
done < <(reverse_file "$SHUTDOWN_LIST")

log_message "Container startup process completed" "INFO"
