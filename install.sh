#!/usr/bin/env bash
# Universal installer for professoroakz/.github repository
# Supports: Linux, macOS, Windows (via Git Bash/WSL)

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() { echo -e "${GREEN}[INFO]${NC} $*"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $*"; }
log_error() { echo -e "${RED}[ERROR]${NC} $*"; }
log_step() { echo -e "${BLUE}[STEP]${NC} $*"; }

INSTALL_DIR="${INSTALL_DIR:-/usr/local}"
BIN_DIR="$INSTALL_DIR/bin"
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "========================================="
echo "  GitHub Config Repository Installer"
echo "========================================="
echo ""

# Check if running as root when needed
if [[ "$INSTALL_DIR" == "/usr/local" ]] || [[ "$INSTALL_DIR" == "/usr" ]]; then
    if [[ $EUID -ne 0 ]] && [[ ! -w "$INSTALL_DIR/bin" ]]; then
        log_warn "Installation to $INSTALL_DIR requires sudo"
        SUDO="sudo"
    else
        SUDO=""
    fi
fi

# Create bin directory if it doesn't exist
log_step "Creating installation directory..."
$SUDO mkdir -p "$BIN_DIR"

# Install CLI tool
log_step "Installing github-config CLI tool..."
$SUDO cp "$REPO_DIR/bin/github-config" "$BIN_DIR/github-config"
$SUDO chmod +x "$BIN_DIR/github-config"

# Install scripts
log_step "Installing utility scripts..."
$SUDO mkdir -p "$INSTALL_DIR/share/github-config"
$SUDO cp -r "$REPO_DIR/scripts" "$INSTALL_DIR/share/github-config/"
$SUDO chmod +x "$INSTALL_DIR/share/github-config/scripts/"*.sh 2>/dev/null || true
$SUDO chmod +x "$INSTALL_DIR/share/github-config/scripts/"*.py 2>/dev/null || true

# Copy templates and docs
log_step "Installing templates and documentation..."
$SUDO cp -r "$REPO_DIR/.github" "$INSTALL_DIR/share/github-config/"
$SUDO cp -r "$REPO_DIR/docs" "$INSTALL_DIR/share/github-config/"
$SUDO cp -r "$REPO_DIR/profile" "$INSTALL_DIR/share/github-config/"

# Copy community health files
for file in README.md CODE_OF_CONDUCT.md CONTRIBUTING.md SECURITY.md SUPPORT.md LICENSE CHANGELOG.md; do
    if [[ -f "$REPO_DIR/$file" ]]; then
        $SUDO cp "$REPO_DIR/$file" "$INSTALL_DIR/share/github-config/"
    fi
done

echo ""
log_info "Installation complete!"
echo ""
echo "Installed to: $INSTALL_DIR"
echo "  - CLI tool: $BIN_DIR/github-config"
echo "  - Scripts: $INSTALL_DIR/share/github-config/scripts/"
echo "  - Templates: $INSTALL_DIR/share/github-config/.github/"
echo "  - Docs: $INSTALL_DIR/share/github-config/docs/"
echo ""
echo "Usage:"
echo "  github-config help"
echo "  github-config validate"
echo "  github-config info"
echo ""
