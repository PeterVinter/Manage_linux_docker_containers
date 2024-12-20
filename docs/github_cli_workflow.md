# GitHub CLI Workflow Guide

This guide documents the GitHub CLI (`gh`) commands we use in our development workflow.

## Prerequisites

- [GitHub CLI](https://cli.github.com/) installed
- Authenticated with `gh auth login`
- Repository cloned locally

## Issue Management

### Create a New Issue
```bash
# Create a feature issue
gh issue create \
  --title "Feature: Your Feature Name" \
  --body "# Feature Description

## Description
Detailed description of the feature

## Features
- [ ] Feature item 1
- [ ] Feature item 2

## Benefits
- Benefit 1
- Benefit 2

## Technical Considerations
- Technical point 1
- Technical point 2

## Priority
High/Medium/Low

## Labels
enhancement, feature"

# List issues
gh issue list

# View issue details
gh issue view <issue-number>
```

## Project Management

### View Project
```bash
# List projects
gh project list

# View project items
gh project item-list <project-number>
```

## Release Management

### Create a New Release
```bash
# Create and push a new tag
git tag -a v1.x.x -m "Release message"
git push origin v1.x.x

# List releases
gh release list

# View release details
gh release view v1.x.x
```

## Repository Management

### Clone Repository
```bash
gh repo clone PeterVinter/linux_docker_container_shutdown
```

### View Repository
```bash
# View repository details
gh repo view

# View repository settings
gh repo edit
```

## Pull Request Workflow

### Create Pull Request
```bash
# Create PR from current branch
gh pr create \
  --title "Feature: Your Feature Name" \
  --body "Closes #<issue-number>

## Changes
- Change 1
- Change 2

## Testing
- [ ] Test case 1
- [ ] Test case 2"

# List pull requests
gh pr list

# Check out a pull request locally
gh pr checkout <pr-number>
```

## CI/CD Integration

### View Workflow Runs
```bash
# List workflow runs
gh run list

# View specific workflow run
gh run view <run-id>

# Watch workflow run in real-time
gh run watch <run-id>
```

## Automated Changelog Workflow

Our repository uses an automated changelog workflow that follows [Semantic Versioning](https://semver.org/) and [Keep a Changelog](https://keepachangelog.com/) standards.

### Version Increment Rules
- **Major Version (X.0.0)**: Breaking changes
  - Indicated by `feat!:` or `BREAKING CHANGE` in commit message
  - Example: `feat!: rename repository`
- **Minor Version (0.X.0)**: New features
  - Indicated by `feat:` in commit message
  - Example: `feat: add new logging system`
- **Patch Version (0.0.X)**: Bug fixes and small changes
  - All other commit types (`fix:`, `docs:`, etc.)
  - Example: `fix: resolve logging issue`

### Change Type Categories
- `feat:` → Added
- `fix:` → Fixed
- `docs:` → Documentation
- `refactor:` → Changed
- `security:` → Security
- `feat!:` or `BREAKING CHANGE` → Breaking Change

### Workflow Process
1. Create a PR with conventional commit message:
```bash
gh pr create --title "feat: add new feature" --body "Description of the feature"
```

2. After merge, the workflow automatically:
   - Determines change type from PR title
   - Increments version number
   - Updates CHANGELOG.md
   - Creates a new PR with changelog updates

3. Review and merge the changelog PR:
```bash
gh pr list  # Find the changelog PR
gh pr merge <number> --merge  # Merge the changelog PR
```

4. Verify the release:
```bash
gh release view <version>  # e.g., v2.0.0
```

## Common Workflows

### Feature Development Flow
1. Create issue:
```bash
gh issue create --title "Feature: New Feature" --body "..."
```

2. Create branch:
```bash
git checkout -b feature/new-feature
```

3. Make changes and commit:
```bash
git add .
git commit -m "feat: implement new feature"
```

4. Create PR:
```bash
gh pr create --title "Feature: New Feature" --body "Closes #<issue-number>"
```

### Release Flow
1. Create release tag:
```bash
git tag -a v1.x.x -m "Release message"
```

2. Push tag:
```bash
git push origin v1.x.x
```

3. Verify release:
```bash
gh release view v1.x.x
```

## Tips and Tricks

### Aliases
Add these to your `.gitconfig`:
```ini
[alias]
    ic = "!gh issue create"
    il = "!gh issue list"
    prc = "!gh pr create"
    prl = "!gh pr list"
```

### Environment Variables
```bash
# Set default editor
export GH_EDITOR=vim

# Set default browser
export GH_BROWSER=firefox
```

## Troubleshooting

### Authentication Issues
```bash
# Re-authenticate
gh auth login

# Check auth status
gh auth status
```

### API Rate Limiting
```bash
# Check API rate limits
gh api rate_limit
```
