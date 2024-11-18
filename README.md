# Docker Container Manager

A set of shell scripts to manage Docker containers with proper shutdown and startup handling, including dependency management.

## Requirements

- Docker installed and running
- Bash shell
- Works on both Ubuntu and macOS

## Installation

1. Clone or download these scripts to your server
2. Make the scripts executable:
   ```bash
   chmod +x start.sh docker_safe_shutdown.sh startup_docker_container.sh
   ```

## Usage

Run the main menu script:
```bash
./start.sh
```

The menu provides the following options:

1. **Shutdown Docker Containers**
   - Safely stops all running containers
   - Preserves container configuration for restart
   - Handles dependencies in correct order

2. **Start Docker Containers**
   - Starts previously shutdown containers
   - Restores original configuration
   - Handles containers in correct dependency order

3. **View Shutdown Log**
   - Shows the shutdown_logs.txt file
   - Contains timestamps and container shutdown information

4. **View Startup Log**
   - Shows the startup_logs.txt file
   - Contains timestamps and container startup information

5. **List Running Containers**
   - Shows all currently running containers
   - Displays names, images, and status

6. **List Stopped Containers**
   - Shows all stopped containers
   - Displays names, images, and when they were stopped

7. **Exit**
   - Exits the program

## Files

- `start.sh`: Main menu script
- `docker_safe_shutdown.sh`: Handles container shutdown
- `startup_docker_container.sh`: Handles container startup
- `shutdowns_logs.txt`: Log file for shutdown operations
- `startup_logs.txt`: Log file for startup operations
- `shutdowned.txt`: Stores container configurations for restart

## Notes

- The scripts automatically detect the operating system (Ubuntu/macOS) and use appropriate commands
- All operations are logged with timestamps
- Container configurations are preserved during shutdown
- Dependencies are handled automatically based on network connections
