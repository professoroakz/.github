# Installation Guide

Multiple installation methods are available for the professoroakz/.github repository tools.

## Quick Install

### Linux / macOS

```bash
# System-wide installation (requires sudo)
sudo make install-system

# User installation (no sudo required)
make install-user
```

### Using the install script directly

```bash
# System-wide
sudo ./install.sh

# Custom location
INSTALL_DIR=$HOME/.local ./install.sh
```

## Package Managers

### Homebrew (macOS / Linux)

```bash
# From formula in this repo
make brew-install

# Or directly
brew install --build-from-source Formula/github-config.rb
```

### NPM

```bash
# Global installation
npm install -g @professoroakz/github

# Local installation
npm install @professoroakz/github
```

### Docker

```bash
# Pull from GitHub Container Registry
docker pull ghcr.io/professoroakz/github-config:latest

# Or build locally
make docker-build
```

## Platform-Specific Instructions

### macOS

**Method 1: Homebrew (Recommended)**

```bash
make brew-install
```

**Method 2: Manual**

```bash
sudo make install-system
```

### Linux

**Debian/Ubuntu**

```bash
# Install dependencies
sudo apt-get update
sudo apt-get install -y nodejs npm python3

# Install github-config
sudo make install-system
```

**Fedora/RHEL/CentOS**

```bash
# Install dependencies
sudo dnf install -y nodejs npm python3

# Install github-config
sudo make install-system
```

**Arch Linux**

```bash
# Install dependencies
sudo pacman -S nodejs npm python

# Install github-config
sudo make install-system
```

### Windows

**Git Bash / WSL (Windows Subsystem for Linux)**

```bash
# Install to user directory
make install-user
```

**PowerShell (coming soon)**

```powershell
# Installation via PowerShell script (planned)
```

## Building Packages

### NPM Package

```bash
# Create .tgz package
make package-npm

# Install from package
npm install -g ./professoroakz-github-*.tgz
```

### Docker Image

```bash
# Build and save
make package-docker

# Load on another machine
docker load < github-config-docker.tar.gz
```

### Create .pkg (macOS)

```bash
# Install pkgbuild (usually pre-installed)
# Create package structure
mkdir -p package/usr/local
cp -r bin package/usr/local/
cp -r share package/usr/local/

# Build package
pkgbuild --root package \
         --identifier org.professoroakz.github-config \
         --version 1.3.37 \
         --install-location / \
         github-config.pkg
```

### Create .deb (Debian/Ubuntu)

```bash
# Install build tools
sudo apt-get install -y build-essential

# Create package structure
mkdir -p github-config_1.3.37/DEBIAN
mkdir -p github-config_1.3.37/usr/local

# Copy files
cp -r bin github-config_1.3.37/usr/local/
cp -r share github-config_1.3.37/usr/local/

# Create control file
cat > github-config_1.3.37/DEBIAN/control << EOF
Package: github-config
Version: 1.3.37
Section: utils
Priority: optional
Architecture: all
Depends: nodejs, python3
Maintainer: professoroakz
Description: GitHub community health files and configuration tools
EOF

# Build package
dpkg-deb --build github-config_1.3.37

# Install
sudo dpkg -i github-config_1.3.37.deb
```

### Create .rpm (Fedora/RHEL/CentOS)

```bash
# Install build tools
sudo dnf install -y rpm-build

# Create RPM build structure
mkdir -p ~/rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS}

# Create spec file (see docs/packaging/github-config.spec)
# Build RPM
rpmbuild -ba github-config.spec
```

### Create .apk (Alpine Linux)

```bash
# Install Alpine packaging tools
apk add alpine-sdk

# Create APKBUILD file
# Build package
abuild -r
```

### Create .exe (Windows - via Chocolatey)

```powershell
# Install Chocolatey packaging tools
choco install chocolatey.core.extension

# Create nuspec file
# Build package
choco pack
```

## Verification

After installation, verify it works:

```bash
# Check version
github-config version

# Validate installation
github-config validate

# Show info
github-config info
```

## Uninstallation

### System-wide

```bash
sudo make uninstall
```

### User installation

```bash
rm -rf ~/.local/bin/github-config
rm -rf ~/.local/share/github-config
```

### Homebrew

```bash
brew uninstall github-config
```

### NPM

```bash
npm uninstall -g @professoroakz/github
```

## Troubleshooting

### Permission denied

If you get permission errors:

```bash
# Make scripts executable
chmod +x bin/github-config
chmod +x install.sh
chmod +x scripts/*.sh
```

### Command not found

Add the installation directory to your PATH:

```bash
# For user installation
export PATH="$HOME/.local/bin:$PATH"

# Add to shell profile
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
# or ~/.zshrc for zsh
```

### Dependencies missing

Install required dependencies:

- Node.js 14+ (optional, for NPM features)
- Python 3.6+ (optional, for health checks)
- Bash 4+ (for scripts)
- Docker (optional, for containers)

## Support

For installation issues, see:

- [FAQ](docs/FAQ.md)
- [SUPPORT.md](SUPPORT.md)
- [GitHub Issues](https://github.com/professoroakz/.github/issues)
