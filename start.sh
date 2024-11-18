#!/bin/bash

# ANSI color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to display the menu
show_menu() {
    clear
    echo -e "${BLUE}╔═══════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║         Docker Container Manager          ║${NC}"
    echo -e "${BLUE}╠═══════════════════════════════════════════╣${NC}"
    echo -e "${BLUE}║${NC}1. Shutdown Docker Containers              ${BLUE}║${NC}"
    echo -e "${BLUE}║${NC}2. Start Docker Containers                 ${BLUE}║${NC}"
    echo -e "${BLUE}║${NC}3. View Shutdown Log                       ${BLUE}║${NC}"
    echo -e "${BLUE}║${NC}4. View Startup Log                        ${BLUE}║${NC}"
    echo -e "${BLUE}║${NC}5. List Running Containers                 ${BLUE}║${NC}"
    echo -e "${BLUE}║${NC}6. List Stopped Containers                 ${BLUE}║${NC}"
    echo -e "${BLUE}║${NC}7. Exit                                    ${BLUE}║${NC}"
    echo -e "${BLUE}╚═══════════════════════════════════════════╝${NC}"
}

# Function to check if script exists
check_script() {
    local script=$1
    if [ ! -f "$script" ]; then
        echo -e "${RED}Error: $script not found!${NC}"
        return 1
    elif [ ! -x "$script" ]; then
        echo -e "${RED}Error: $script is not executable!${NC}"
        return 1
    fi
    return 0
}

# Function to view log file
view_log() {
    local log_file=$1
    if [ -f "$log_file" ]; then
        echo -e "${GREEN}Contents of $log_file:${NC}"
        echo "----------------------------------------"
        cat "$log_file"
        echo "----------------------------------------"
    else
        echo -e "${RED}Log file $log_file does not exist yet.${NC}"
    fi
}

# Function to list running containers
list_running_containers() {
    echo -e "${GREEN}Currently Running Containers:${NC}"
    echo "----------------------------------------"
    if [ "$(docker ps -q)" ]; then
        docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}"
    else
        echo -e "${YELLOW}No containers are currently running.${NC}"
    fi
    echo "----------------------------------------"
}

# Function to list stopped containers
list_stopped_containers() {
    echo -e "${YELLOW}Stopped Containers:${NC}"
    echo "----------------------------------------"
    if [ "$(docker ps -f "status=exited" -f "status=created" -q)" ]; then
        docker ps -f "status=exited" -f "status=created" --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}"
    else
        echo -e "${GREEN}No stopped containers found.${NC}"
    fi
    echo "----------------------------------------"
}

# Main loop
while true; do
    show_menu
    read -p "Enter your choice (1-7): " choice
    echo

    case $choice in
        1)
            if check_script "./docker_safe_shutdown.sh"; then
                echo -e "${GREEN}Executing shutdown script...${NC}"
                ./docker_safe_shutdown.sh
            fi
            ;;
        2)
            if check_script "./startup_docker_container.sh"; then
                echo -e "${GREEN}Executing startup script...${NC}"
                ./startup_docker_container.sh
            fi
            ;;
        3)
            view_log "shutdowns_logs.txt"
            ;;
        4)
            view_log "startup_logs.txt"
            ;;
        5)
            list_running_containers
            ;;
        6)
            list_stopped_containers
            ;;
        7)
            echo -e "${GREEN}Goodbye!${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}Invalid option. Please try again.${NC}"
            ;;
    esac

    echo
    read -p "Press Enter to continue..."
done
