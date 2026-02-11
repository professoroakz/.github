# API Documentation

Documentation for using the professoroakz/.github repository as a package.

## NPM Package

### Installation

```bash
npm install @professoroakz/github
```

### Usage

```javascript
const github = require('@professoroakz/github');

// Get package metadata
const metadata = github.getMetadata();
console.log(metadata.version); // "1.3.37"
console.log(metadata.name); // "@professoroakz/github"
console.log(metadata.description); // Package description

// List profile files
const profileFiles = github.listProfileFiles();
// Returns: ['README.md', ...]

// List settings files
const settingsFiles = github.listSettingsFiles();
// Returns: ['.actions', ...]

// Get path to a specific profile file
const profilePath = github.getProfilePath('README.md');
// Returns: "/path/to/node_modules/@professoroakz/github/profile/README.md"

// Get path to a specific settings file
const settingsPath = github.getSettingsPath('.actions');
// Returns: "/path/to/node_modules/@professoroakz/github/settings/.actions"
```

## CLI Tool

### Installation

```bash
# From repository
cd .github
chmod +x bin/github-config
sudo ln -s $(pwd)/bin/github-config /usr/local/bin/github-config

# Or use the installer
./bin/github-config install
```

### Commands

#### validate

Validate repository structure and required files.

```bash
github-config validate
```

**Output:**

```
[INFO] Validating repository structure...
[INFO] ✓ README.md
[INFO] ✓ CODE_OF_CONDUCT.md
...
[INFO] All required files present!
```

#### info

Show repository information.

```bash
github-config info
```

**Output:**

```
[INFO] Repository Information:
  Location: /path/to/.github
  Version: 1.3.37
  NPM Package: @professoroakz/github
  Docker Image: professoroakz/github-config
```

#### version

Show version information.

```bash
github-config version
```

**Output:**

```
github-config version 1.3.37
```

#### help

Show help message.

```bash
github-config help
```

## Docker Image

### Pull Image

```bash
docker pull ghcr.io/professoroakz/github-config:latest
```

### Run Container

```bash
# Interactive mode
docker run -it ghcr.io/professoroakz/github-config:latest

# Run specific command
docker run --rm ghcr.io/professoroakz/github-config:latest node --version

# Mount volume
docker run -v $(pwd):/workspace ghcr.io/professoroakz/github-config:latest
```

### Build Locally

```bash
docker build -t professoroakz/github-config:local .
```

## Makefile

### Targets

#### install

Install dependencies.

```bash
make install
```

#### test

Run test suite.

```bash
make test
```

#### build

Build the project.

```bash
make build
```

#### clean

Clean build artifacts.

```bash
make clean
```

#### run

Run the application.

```bash
make run
```

#### docker-build

Build Docker image.

```bash
make docker-build
```

#### docker-run

Build and run Docker container.

```bash
make docker-run
```

#### lint

Lint source files.

```bash
make lint
```

#### format

Format source files.

```bash
make format
```

#### version-patch/minor/major

Bump version.

```bash
make version-patch  # 1.0.0 -> 1.0.1
make version-minor  # 1.0.0 -> 1.1.0
make version-major  # 1.0.0 -> 2.0.0
```

## Scripts

### setup.sh

Setup the repository environment.

```bash
./scripts/setup.sh
```

### health-check.py

Run health checks on repository.

```bash
./scripts/health-check.py
```

### deploy.sh

Deploy to various targets.

```bash
# NPM
./scripts/deploy.sh npm

# Docker
./scripts/deploy.sh docker

# GitHub Release
./scripts/deploy.sh github-release

# All targets
./scripts/deploy.sh all

# Dry run
./scripts/deploy.sh --dry-run all
```

## Environment Variables

### NPM_TOKEN

NPM authentication token for publishing.

```bash
export NPM_TOKEN=your_token_here
```

### GITHUB_TOKEN

### GITHUB_TOKEN

GitHub token for API access, releases, and GHCR authentication.

```bash
export GITHUB_TOKEN=your_token_here
```

Note: This repository uses GitHub Container Registry (ghcr.io) for Docker images, which uses
GITHUB_TOKEN for authentication.

## Error Handling

All tools use exit codes to indicate success or failure:

- `0` - Success
- `1` - General error
- `2` - Invalid arguments

Example:

```bash
if github-config validate; then
    echo "Validation passed"
else
    echo "Validation failed"
    exit 1
fi
```

## Versioning

This package follows [Semantic Versioning](https://semver.org/).

- **MAJOR**: Breaking changes
- **MINOR**: New features (backward compatible)
- **PATCH**: Bug fixes

## Support

For API questions or issues:

- Check [SUPPORT.md](../SUPPORT.md)
- Open an issue on GitHub
- Review [CONTRIBUTING.md](../CONTRIBUTING.md)
