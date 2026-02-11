# Scripts Directory

Utility scripts for repository management, deployment, and automation.

## Available Scripts

### setup.sh

Initial setup script for the repository.

```bash
./scripts/setup.sh
```

**What it does:**

- Checks prerequisites (Node.js, Docker, Make)
- Installs NPM dependencies
- Sets executable permissions
- Validates repository structure
- Runs test suite

### health-check.py

Python health check script for validating repository structure.

```bash
./scripts/health-check.py
```

**What it checks:**

- Required files exist
- JSON file syntax
- Directory structure
- File permissions

### deploy.sh

Deployment script for publishing to various targets.

```bash
# Deploy to NPM
./scripts/deploy.sh npm

# Build and push Docker image
./scripts/deploy.sh docker

# Create GitHub release
./scripts/deploy.sh github-release

# Deploy everything
./scripts/deploy.sh all

# Dry run
./scripts/deploy.sh --dry-run npm
```

**Targets:**

- `npm` - Publish to NPM registry
- `docker` - Build and push Docker image
- `github-release` - Create GitHub release
- `all` - Deploy all targets

**Options:**

- `-d, --dry-run` - Dry run mode
- `-v, --version <version>` - Specify version
- `-h, --help` - Show help

## Requirements

- Bash 4.0+ for shell scripts
- Python 3.6+ for Python scripts
- Node.js 14+ for NPM operations
- Docker for container operations
- GitHub CLI (`gh`) for GitHub releases

## Development

To add a new script:

1. Create the script file in this directory
2. Add execute permissions: `chmod +x script-name.sh`
3. Document it in this README
4. Add tests in `test/run-tests.sh` if applicable

## Best Practices

- Use `set -euo pipefail` in bash scripts
- Add color-coded logging functions
- Include help/usage information
- Handle errors gracefully
- Test scripts before committing
