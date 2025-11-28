# .github

All my cool GitHub cool stuff + fixes and reaches everything I own and work on.

## NPM Package

[![npm version](https://img.shields.io/npm/v/@professoroakz/github.svg)](https://www.npmjs.com/package/@professoroakz/github)

This repository is available as an npm package:

```bash
npm install @professoroakz/github
```

### Usage

```javascript
const github = require('@professoroakz/github');

// Get package metadata
const metadata = github.getMetadata();
console.log(metadata.version);

// List profile files
const profileFiles = github.listProfileFiles();

// List settings files
const settingsFiles = github.listSettingsFiles();

// Get path to a specific profile file
const profilePath = github.getProfilePath('README.md');

// Get path to a specific settings file
const settingsPath = github.getSettingsPath('.actions');
```

## License

MIT
all my cool github cool stuff + fixes and reaches everything I own and work on.

## Docker Package

This repository is available as an official Docker package on GitHub Container Registry.

### Pulling the Image

```bash
# Pull the latest version
docker pull ghcr.io/professoroakz/github-config:latest

# Pull a specific version
docker pull ghcr.io/professoroakz/github-config:1.3.37
```

### Running the Container

```bash
# Run interactively
docker run -it ghcr.io/professoroakz/github-config:latest

# Run with custom volume mounts
docker run -it -v $(pwd)/profile:/app/profile:ro ghcr.io/professoroakz/github-config:latest
```

### Using Docker Compose

```bash
# Build and start
docker-compose up -d

# View logs
docker-compose logs -f

# Stop
docker-compose down
```

### Building Locally

```bash
# Build with default settings
docker build -t professoroakz/github-config:local .

# Build with custom version
docker build --build-arg VERSION=1.3.37 -t professoroakz/github-config:1.3.37 .
```

## NPM Package

This repository is also available as an npm package:

```bash
npm install @professoroakz/github
```

## Version

Current version: **1.3.37**
