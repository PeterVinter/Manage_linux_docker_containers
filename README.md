# Docker Container Management

![License](https://img.shields.io/github/license/PeterVinter/Manage_linux_docker_containers)
![Last Commit](https://img.shields.io/github/last-commit/PeterVinter/Manage_linux_docker_containers)
![Stars](https://img.shields.io/github/stars/PeterVinter/Manage_linux_docker_containers)
![Issues](https://img.shields.io/github/issues/PeterVinter/Manage_linux_docker_containers)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat&logo=docker&logoColor=white)
![Bash](https://img.shields.io/badge/Bash-4EAA25?style=flat&logo=gnu-bash&logoColor=white)
[![CI](https://github.com/PeterVinter/Manage_linux_docker_containers/actions/workflows/ci.yml/badge.svg)](https://github.com/PeterVinter/Manage_linux_docker_containers/actions/workflows/ci.yml)
[![Release](https://github.com/PeterVinter/Manage_linux_docker_containers/actions/workflows/release.yml/badge.svg)](https://github.com/PeterVinter/Manage_linux_docker_containers/actions/workflows/release.yml)
[![Maintenance](https://img.shields.io/maintenance/yes/2024)](https://github.com/PeterVinter/Manage_linux_docker_containers/graphs/commit-activity)
![Tests](https://img.shields.io/badge/Tests-Passing-success)
[![made-with-bash](https://img.shields.io/badge/Made%20with-Bash-1f425f.svg)](https://www.gnu.org/software/bash/)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](https://makeapullrequest.com)
[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgithub.com%2FPeterVinter%2FManage_linux_docker_containers&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com)
[![Changelog Update](https://github.com/PeterVinter/Manage_linux_docker_containers/actions/workflows/update-changelog.yml/badge.svg)](https://github.com/PeterVinter/Manage_linux_docker_containers/actions/workflows/update-changelog.yml)

A comprehensive solution for managing Docker containers on Linux systems, including safe shutdown, startup, and monitoring capabilities.

## Features

- Safely shuts down Docker containers
- Handles graceful termination of processes
- Supports custom shutdown scripts
- Automated changelog generation
- Comprehensive documentation

## Features

- Safe shutdown of Docker containers with proper cleanup
- Automatic container startup on system boot
- Detailed logging of all operations
- Error handling and recovery
- Container status monitoring
- Performance optimization

## Prerequisites

- Linux operating system
- Docker installed and running
- Bash shell (version 4.0+)
- Root or sudo privileges

## Installation

1. Clone the repository:
```bash
git clone https://github.com/PeterVinter/Manage_linux_docker_containers.git
cd Manage_linux_docker_containers
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

The scripts can be configured by modifying the following variables:

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

This project uses GitHub's project management features to track issues, pull requests, and milestones. We follow a structured workflow:

1. **Issues**: Used to track bugs, feature requests, and tasks
2. **Pull Requests**: Follow our [contribution guidelines](CONTRIBUTING.md)
3. **Milestones**: Group related issues and PRs for releases
4. **Project Board**: Visual kanban board for task tracking
5. **Automated Changelog**: Updates via GitHub Actions on PR merges

Our changelog follows the [Keep a Changelog](https://keepachangelog.com/) format and is automatically updated when PRs are merged.

### Changelog Management

This repository uses automated changelog generation through GitHub Actions. When you create a PR:

1. Use conventional commit format in PR titles:
   - `feat:` for new features (increments minor version)
   - `fix:` for bug fixes (increments patch version)
   - `feat!:` or include `BREAKING CHANGE` for breaking changes (increments major version)
   - `docs:` for documentation changes
   - `refactor:` for code changes that neither fix bugs nor add features

2. The workflow will automatically:
   - Skip changelog updates for changelog-only PRs
   - Create a new changelog entry based on your PR title and description
   - Increment version number according to semantic versioning
   - Create a new PR with the changelog update

### Automated Changelog

This project uses an automated changelog workflow that:
- Updates CHANGELOG.md when PRs are merged to main
- Follows [Semantic Versioning](https://semver.org/) for version numbers:
  - Major (X.0.0): Breaking changes (feat! or BREAKING CHANGE)
  - Minor (0.X.0): New features (feat)
  - Patch (0.0.X): Bug fixes and small changes
- Determines change type from PR title:
  - `feat:` → Added (new features)
  - `fix:` → Fixed (bug fixes)
  - `docs:` → Documentation
  - `refactor:` → Changed
  - `security:` → Security
  - `feat!:` or `BREAKING CHANGE` → Breaking Change
- Creates a new PR with changelog updates
- Follows [Keep a Changelog](https://keepachangelog.com/) format

For detailed workflow documentation, see [GitHub CLI Workflow Guide](docs/github_cli_workflow.md).

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

If you encounter any problems or have suggestions, please [open an issue](https://github.com/PeterVinter/Manage_linux_docker_containers/issues/new).
