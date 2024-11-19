# Docker Safe Shutdown

[![GitHub release (latest by date)](https://img.shields.io/github/v/release/PeterVinter/docker-safe-shutdown)
[![GitHub license](https://img.shields.io/github/license/PeterVinter/docker-safe-shutdown)](https://github.com/PeterVinter/docker-safe-shutdown/blob/main/LICENSE)
[![GitHub issues](https://img.shields.io/github/issues/PeterVinter/docker-safe-shutdown)](https://github.com/PeterVinter/docker-safe-shutdown/issues)
[![GitHub stars](https://img.shields.io/github/stars/PeterVinter/docker-safe-shutdown)](https://github.com/PeterVinter/docker-safe-shutdown/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/PeterVinter/docker-safe-shutdown)](https://github.com/PeterVinter/docker-safe-shutdown/network)
[![CI](../../actions/workflows/ci.yml/badge.svg)](../../actions/workflows/ci.yml)
[![Release](../../actions/workflows/release.yml/badge.svg)](../../actions/workflows/release.yml)
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

## Development

### Project Management

We use GitHub Projects to track the development of features and improvements. You can find our project board at:
[Docker Safe Shutdown Development](https://github.com/users/PeterVinter/projects/1/views/1)

For detailed GitHub CLI commands and workflows, see our [GitHub CLI Workflow Guide](docs/github_cli_workflow.md).

#### Development Workflow

1. **Issue Tracking**
   - All features and bugs are tracked as GitHub Issues
   - Features are versioned following semantic versioning:
     - v1.0.x: Bug fixes and minor improvements
     - v1.1.0: New features and functionality
     - v2.0.0: Breaking changes

2. **Project Board Columns**
   - 📋 Backlog: Planned features and improvements
   - 🎯 Priority: Selected for current development
   - 🏗️ In Progress: Currently being worked on
   - 👀 Review: Ready for code review
   - ✅ Done: Completed and merged

3. **Issue Classification**
   - Priority: 🔥 High, 🚀 Medium, 🌱 Low
   - Effort: 🐘 Large, 🦊 Medium, 🐇 Small
   - Target Version: Specified version for release
   - Assignees: Developer working on the issue

4. **Contributing**
   - Check the [Project Board](https://github.com/users/PeterVinter/projects/1/views/1) for available tasks
   - Read [CONTRIBUTING.md](CONTRIBUTING.md) for development guidelines
   - Follow the issue template when creating new issues
   - Reference issues in pull requests

### Automated Releases

This project uses GitHub Actions for automated releases. The workflow is triggered when a new tag is pushed and includes:

1. Automated Changelog Generation:
   - Generates changelog from commit messages
   - Includes commit hashes for reference
   - Groups changes by type

2. Quality Checks:
   - Runs ShellCheck on all scripts
   - Validates syntax and best practices
   - Ensures code quality before release

3. Release Creation:
   - Creates GitHub release automatically
   - Includes generated changelog
   - Adds feature list and installation instructions

To create a new release:

1. Make your changes and commit them:
```bash
git add .
git commit -m "feat: your feature description"
```

2. Create and push a new tag:
```bash
git tag -a v1.x.x -m "Release description"
git push origin v1.x.x
```

The workflow will automatically:
- Generate the changelog
- Run quality checks
- Create the release
- Update documentation

### Commit Messages

Follow the [Conventional Commits](https://www.conventionalcommits.org/) specification:
- `feat:` New features
- `fix:` Bug fixes
- `docs:` Documentation changes
- `chore:` Maintenance tasks
- `refactor:` Code improvements
- `test:` Test updates

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

If you encounter any problems or have suggestions, please [open an issue](../../issues/new).
