#!/usr/bin/env bash
# Setup script for professoroakz/.github repository
# Installs dependencies and configures the environment

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() { echo -e "${GREEN}[INFO]${NC} $*"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $*"; }
log_error() { echo -e "${RED}[ERROR]${NC} $*"; }
log_step() { echo -e "${BLUE}[STEP]${NC} $*"; }

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"

echo "========================================"
echo "  GitHub Config Repository Setup"
echo "========================================"
echo ""

# Check prerequisites
log_step "Checking prerequisites..."

if ! command -v node &>/dev/null; then
    log_warn "Node.js not found. Some features will be unavailable."
else
    log_info "Node.js $(node --version) found"
fi

if ! command -v docker &>/dev/null; then
    log_warn "Docker not found. Docker features will be unavailable."
else
    log_info "Docker $(docker --version | cut -d' ' -f3 | tr -d ',') found"
fi

if ! command -v make &>/dev/null; then
    log_warn "Make not found. Makefile targets will be unavailable."
else
    log_info "Make found"
fi

# Install Node dependencies
if [[ -f "$ROOT_DIR/package.json" ]]; then
    log_step "Installing Node.js dependencies..."
    cd "$ROOT_DIR"
    
    if command -v npm &>/dev/null; then
        npm install
        log_info "Dependencies installed successfully"
    else
        log_warn "npm not available, skipping Node dependencies"
    fi
fi

# Make scripts executable
log_step "Setting up executable permissions..."
if [[ -d "$ROOT_DIR/bin" ]]; then
    chmod +x "$ROOT_DIR/bin/"* 2>/dev/null || true
    log_info "Executable permissions set for bin/ scripts"
fi

if [[ -d "$ROOT_DIR/scripts" ]]; then
    chmod +x "$ROOT_DIR/scripts/"*.sh 2>/dev/null || true
    log_info "Executable permissions set for scripts/"
fi

chmod +x "$ROOT_DIR/test/run-tests.sh" 2>/dev/null || true

# Validate repository structure
log_step "Validating repository structure..."
if [[ -x "$ROOT_DIR/bin/github-config" ]]; then
    "$ROOT_DIR/bin/github-config" validate
else
    log_warn "CLI tool not found, skipping validation"
fi

# Run tests
log_step "Running tests..."
if [[ -x "$ROOT_DIR/test/run-tests.sh" ]]; then
    "$ROOT_DIR/test/run-tests.sh"
else
    log_warn "Test script not found, skipping tests"
fi

# Summary
echo ""
echo "========================================"
log_info "Setup complete!"
echo "========================================"
echo ""
echo "Available commands:"
echo "  make help              - Show all make targets"
echo "  ./bin/github-config    - Run CLI tool"
echo "  ./test/run-tests.sh    - Run test suite"
echo "  npm test               - Test NPM package"
echo ""
echo "Next steps:"
echo "  1. Review the documentation in docs/"
echo "  2. Customize templates in .github/"
echo "  3. Update organization-specific information"
echo ""
