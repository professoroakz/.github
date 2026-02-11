#!/usr/bin/env bash
# Deployment script for publishing packages

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log_info() { echo -e "${GREEN}[INFO]${NC} $*"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $*"; }
log_error() { echo -e "${RED}[ERROR]${NC} $*"; }

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"

show_help() {
    cat << EOF
Deployment Script

Usage: deploy.sh [options] <target>

Targets:
  npm              Deploy to NPM registry
  docker           Build and push Docker image
  github-release   Create GitHub release
  all              Deploy all targets

Options:
  -h, --help       Show this help
  -v, --version    Specify version (default: from package.json)
  -d, --dry-run    Dry run (don't actually deploy)

Examples:
  ./deploy.sh npm
  ./deploy.sh --dry-run docker
  ./deploy.sh --version 1.0.0 all
EOF
}

DRY_RUN=false
VERSION=""

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            show_help
            exit 0
            ;;
        -d|--dry-run)
            DRY_RUN=true
            shift
            ;;
        -v|--version)
            VERSION="$2"
            shift 2
            ;;
        *)
            TARGET="$1"
            shift
            ;;
    esac
done

# Get version from package.json if not specified
if [[ -z "$VERSION" ]] && [[ -f "$ROOT_DIR/package.json" ]]; then
    VERSION=$(node -p "require('$ROOT_DIR/package.json').version")
fi

log_info "Deployment target: ${TARGET:-none}"
log_info "Version: ${VERSION:-unknown}"
[[ "$DRY_RUN" == "true" ]] && log_warn "DRY RUN MODE - No actual deployment"

deploy_npm() {
    log_info "Deploying to NPM..."
    
    if [[ "$DRY_RUN" == "true" ]]; then
        log_info "Would run: npm publish --dry-run"
        npm publish --dry-run
    else
        log_info "Running: npm publish"
        npm publish
    fi
}

deploy_docker() {
    log_info "Building and pushing Docker image..."
    
    IMAGE_NAME="ghcr.io/professoroakz/github-config"
    
    if [[ "$DRY_RUN" == "true" ]]; then
        log_info "Would build: docker build -t ${IMAGE_NAME}:${VERSION}"
        log_info "Would tag: docker tag ${IMAGE_NAME}:${VERSION} ${IMAGE_NAME}:latest"
        log_info "Would push: docker push ${IMAGE_NAME}:${VERSION}"
        log_info "Would push: docker push ${IMAGE_NAME}:latest"
    else
        docker build -t "${IMAGE_NAME}:${VERSION}" .
        docker tag "${IMAGE_NAME}:${VERSION}" "${IMAGE_NAME}:latest"
        docker push "${IMAGE_NAME}:${VERSION}"
        docker push "${IMAGE_NAME}:latest"
    fi
}

deploy_github_release() {
    log_info "Creating GitHub release..."
    
    if ! command -v gh &>/dev/null; then
        log_error "GitHub CLI (gh) not found. Please install it first."
        return 1
    fi
    
    if [[ "$DRY_RUN" == "true" ]]; then
        log_info "Would create release: v${VERSION}"
    else
        gh release create "v${VERSION}" --generate-notes
    fi
}

case "${TARGET:-}" in
    npm)
        deploy_npm
        ;;
    docker)
        deploy_docker
        ;;
    github-release)
        deploy_github_release
        ;;
    all)
        deploy_npm
        deploy_docker
        deploy_github_release
        ;;
    *)
        log_error "Invalid target: ${TARGET:-none}"
        show_help
        exit 1
        ;;
esac

log_info "Deployment complete!"
