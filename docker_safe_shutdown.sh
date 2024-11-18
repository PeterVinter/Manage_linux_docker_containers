#!/bin/bash

# Setup logging
LOG_FILE="shutdowns_logs.txt"
SHUTDOWN_LIST="shutdowned.txt"

# Clear previous shutdown list
> "$SHUTDOWN_LIST"

log_message() {
    local message="$1"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] $message" | tee -a "$LOG_FILE"
}

# Function to get container dependencies using network connections
get_dependencies() {
    local container_id=$1
    # Get networks this container is connected to
    local networks=$(docker inspect --format='{{range $k, $v := .NetworkSettings.Networks}}{{$k}} {{end}}' "$container_id")
    local dependent_containers=""
    
    for network in $networks; do
        # Find other containers in the same network
        local connected_containers=$(docker network inspect "$network" --format='{{range .Containers}}{{.Name}} {{end}}')
        dependent_containers="$dependent_containers $connected_containers"
    done
    
    echo "$dependent_containers"
}

# Function to save container info
save_container_info() {
    local container_id=$1
    # Get container information with properly formatted port mappings
    local port_mappings=$(docker container inspect "$container_id" --format='{{range $p, $conf := .NetworkSettings.Ports}}{{if $conf}}{{$p}}:{{(index $conf 0).HostPort}};{{end}}{{end}}')
    local container_info=$(docker inspect --format='{{.Name}}|{{.Config.Image}}|{{range .Config.Cmd}}{{.}} {{end}}|'"$port_mappings"'|{{range $k, $v := .NetworkSettings.Networks}}{{$k}};{{end}}' "$container_id" | sed 's/\///')
    echo "$container_info" >> "$SHUTDOWN_LIST"
}

# Function to safely stop a container and its dependencies
safe_stop() {
    local container_id=$1
    local visited=($2)
    
    # Check if container was already processed
    for v in "${visited[@]}"; do
        if [ "$v" == "$container_id" ]; then
            return
        fi
    done
    
    # Get dependencies
    local deps=$(get_dependencies "$container_id")
    visited+=("$container_id")
    
    # Recursively stop dependencies first
    for dep in $deps; do
        if [ "$dep" != "$container_id" ]; then
            safe_stop "$dep" "${visited[*]}"
        fi
    done
    
    # Stop the container gracefully
    local container_name=$(docker inspect --format='{{.Name}}' "$container_id" | sed 's/\///')
    log_message "Stopping container: $container_name"
    if docker stop -t 30 "$container_id"; then
        save_container_info "$container_id"
        log_message "Successfully stopped and saved info for container: $container_name"
    else
        log_message "Warning: Failed to stop container $container_name ($container_id) gracefully, forcing shutdown..."
        if docker kill "$container_id"; then
            save_container_info "$container_id"
            log_message "Successfully killed and saved info for container: $container_name"
        fi
    fi
}

log_message "Starting safe Docker container shutdown process..."

# Get all running containers
containers=$(docker ps -q)

if [ -z "$containers" ]; then
    log_message "No running containers found."
    exit 0
fi

# Process each container
for container in $containers; do
    safe_stop "$container" ""
done

log_message "All containers have been shut down successfully."
