# Installation Guide

This guide covers different ways to install and use the professoroakz/.github repository.

## Prerequisites

- Git
- Node.js (>= 14.0.0) for NPM package
- Docker (optional, for Docker image)
- Make (optional, for Makefile targets)

## Installation Methods

### 1. Clone the Repository

```bash
git clone https://github.com/professoroakz/.github.git
cd .github
```

### 2. Install as NPM Package

```bash
npm install @professoroakz/github
```

Usage in Node.js:

```javascript
const github = require('@professoroakz/github');

// Get package metadata
const metadata = github.getMetadata();
console.log(metadata.version);

// List profile files
const profileFiles = github.listProfileFiles();

// List settings files
const settingsFiles = github.listSettingsFiles();
```

### 3. Use Docker Image

Pull the image:

```bash
docker pull ghcr.io/professoroakz/github-config:latest
```

Run the container:

```bash
docker run -it ghcr.io/professoroakz/github-config:latest
```

Build locally:

```bash
docker build -t professoroakz/github-config:local .
```

### 4. Install CLI Tool

From the cloned repository:

```bash
cd .github
chmod +x bin/github-config
sudo ln -s $(pwd)/bin/github-config /usr/local/bin/github-config
```

Or use the built-in installer:

```bash
./bin/github-config install
```

## Usage

### CLI Commands

```bash
# Show version
github-config version

# Validate repository structure
github-config validate

# Show repository information
github-config info

# Show help
github-config help
```

### Makefile Targets

```bash
# Install dependencies
make install

# Run tests
make test

# Build project
make build

# Clean build artifacts
make clean

# Run application
make run

# Build Docker image
make docker-build

# Run Docker container
make docker-run

# Lint files
make lint

# Format files
make format
```

## Development Setup

1. Clone the repository:

```bash
git clone https://github.com/professoroakz/.github.git
cd .github
```

2. Install dependencies:

```bash
npm install
# or
make install
```

3. Run tests:

```bash
npm test
# or
make test
# or
./test/run-tests.sh
```

## Configuration

### EditorConfig

The repository includes `.editorconfig` for consistent coding styles across editors.

### Markdown Linting

Markdown files are linted using markdownlint with rules defined in `.markdownlint.json`.

### Git Ignore

The `.gitignore` file excludes:
- Build artifacts
- Node modules
- OS-specific files
- Editor configuration files
- Temporary files

## Troubleshooting

### NPM Package Not Found

Make sure you have the correct registry configured:

```bash
npm config get registry
```

### Docker Build Fails

Ensure you have the latest Docker version:

```bash
docker --version
```

Clean Docker cache and rebuild:

```bash
docker system prune -a
docker build --no-cache -t professoroakz/github-config:latest .
```

### CLI Tool Not in PATH

Make sure `/usr/local/bin` is in your PATH:

```bash
echo $PATH
```

Add it if missing (in `~/.bashrc` or `~/.zshrc`):

```bash
export PATH="/usr/local/bin:$PATH"
```

## Uninstallation

### Remove NPM Package

```bash
npm uninstall @professoroakz/github
```

### Remove Docker Image

```bash
docker rmi ghcr.io/professoroakz/github-config:latest
```

### Remove CLI Tool

```bash
sudo rm /usr/local/bin/github-config
```

## Support

For issues and questions:
- Open an issue on GitHub
- Check [SUPPORT.md](../SUPPORT.md)
- Read [CONTRIBUTING.md](../CONTRIBUTING.md)
