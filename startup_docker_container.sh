#!/bin/bash

# Setup logging
LOG_FILE="startup_logs.txt"
SHUTDOWN_LIST="shutdowned.txt"

log_message() {
    local message="$1"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] $message" | tee -a "$LOG_FILE"
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
    log_message "No shutdown list found at $SHUTDOWN_LIST. Nothing to start."
    exit 1
fi

log_message "Starting Docker containers from shutdown list..."

# Read the shutdown list in reverse order (to respect dependencies)
while IFS='|' read -r name image cmd ports networks; do
    log_message "Processing container: $name"
    
    # Check container status
    container_status=$(check_container "$name")
    
    case $container_status in
        "running")
            log_message "Container $name is already running, skipping..."
            continue
            ;;
        "stopped")
            log_message "Container $name exists but is stopped, starting it..."
            if docker start "$name"; then
                log_message "Successfully started existing container: $name"
            else
                log_message "Failed to start existing container: $name"
            fi
            continue
            ;;
        "none")
            # Process port mappings
            port_args=""
            if [ ! -z "$ports" ]; then
                # Convert semicolon-separated port mappings into multiple -p arguments
                for port_mapping in ${ports//;/ }; do
                    if [ ! -z "$port_mapping" ]; then
                        port_args="$port_args -p $port_mapping"
                    fi
                done
            fi
            
            # Process network
            network_arg=""
            if [ ! -z "$networks" ]; then
                # Get first network (before semicolon)
                network=$(echo "$networks" | cut -d';' -f1)
                if [ ! -z "$network" ]; then
                    network_arg="--network $network"
                fi
            fi
            
            # Create and start the container
            docker_cmd="docker run -d --name ${name} ${port_args} ${network_arg} ${image} ${cmd}"
            log_message "Creating new container: $docker_cmd"
            
            if eval "$docker_cmd"; then
                log_message "Successfully created and started container: $name"
            else
                log_message "Failed to create and start container: $name"
            fi
            ;;
    esac
done < <(reverse_file "$SHUTDOWN_LIST")

log_message "Finished starting all containers from shutdown list."
