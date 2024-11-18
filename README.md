# Docker Safe Shutdown

[![GitHub release (latest by date)](https://img.shields.io/github/v/release/PeterVinter/docker-safe-shutdown)](https://github.com/PeterVinter/docker-safe-shutdown/releases)
[![GitHub license](https://img.shields.io/github/license/PeterVinter/docker-safe-shutdown)](https://github.com/PeterVinter/docker-safe-shutdown/blob/main/LICENSE)
[![GitHub issues](https://img.shields.io/github/issues/PeterVinter/docker-safe-shutdown)](https://github.com/PeterVinter/docker-safe-shutdown/issues)
[![GitHub stars](https://img.shields.io/github/stars/PeterVinter/docker-safe-shutdown)](https://github.com/PeterVinter/docker-safe-shutdown/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/PeterVinter/docker-safe-shutdown)](https://github.com/PeterVinter/docker-safe-shutdown/network)
[![CI](../../actions/workflows/ci.yml/badge.svg)](../../actions/workflows/ci.yml)
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://github.com/PeterVinter/docker-safe-shutdown/graphs/commit-activity)
[![made-with-bash](https://img.shields.io/badge/Made%20with-Bash-1f425f.svg)](https://www.gnu.org/software/bash/)
[![Docker Pulls](https://img.shields.io/docker/pulls/PeterVinter/docker-safe-shutdown)](https://hub.docker.com/r/PeterVinter/docker-safe-shutdown)
[![Docker Image Size](https://img.shields.io/docker/image-size/PeterVinter/docker-safe-shutdown/latest)](https://hub.docker.com/r/PeterVinter/docker-safe-shutdown)
[![codecov](https://codecov.io/gh/PeterVinter/docker-safe-shutdown/branch/main/graph/badge.svg)](https://codecov.io/gh/PeterVinter/docker-safe-shutdown)
[![Shellcheck](https://github.com/PeterVinter/docker-safe-shutdown/workflows/ShellCheck/badge.svg)](https://github.com/PeterVinter/docker-safe-shutdown/actions?query=workflow%3AShellCheck)
[![Last Commit](https://img.shields.io/github/last-commit/PeterVinter/docker-safe-shutdown)](https://github.com/PeterVinter/docker-safe-shutdown/commits/main)
[![Contributors](https://img.shields.io/github/contributors/PeterVinter/docker-safe-shutdown)](https://github.com/PeterVinter/docker-safe-shutdown/graphs/contributors)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](https://makeapullrequest.com)
[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgithub.com%2FPeterVinter%2Fdocker-safe-shutdown&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com)

A robust solution for safely shutting down and starting up Docker containers on Linux systems.

## Features

- Safe shutdown of Docker containers with proper cleanup
- Automatic container startup on system boot
- Detailed logging of shutdown and startup processes
- Configurable shutdown timeouts
- Error handling and recovery

## Prerequisites

- Linux operating system
- Docker installed and running
- Bash shell
- Root or sudo privileges

## Installation

1. Clone the repository:
```bash
git clone https://github.com/PeterVinter/docker-safe-shutdown.git
cd docker-safe-shutdown
```

2. Make the scripts executable:
```bash
chmod +x *.sh
```

## Usage

### Starting Containers
```bash
./startup_docker_container.sh
```

### Shutting Down Containers
```bash
./docker_safe_shutdown.sh
```

## Configuration

The scripts can be configured by modifying the following variables in the respective scripts:

- `TIMEOUT`: Maximum time to wait for container shutdown
- `LOG_FILE`: Location of log files
- `CONTAINER_LIST`: List of containers to manage

## Logging

Logs are stored in:
- `startup_logs.txt`: Container startup logs
- `shutdowns_logs.txt`: Container shutdown logs
- `shutdowned.txt`: Status of shutdown containers

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

If you encounter any problems or have suggestions, please [open an issue](../../issues/new).
