# Makefile for professoroakz/.github repository
# Cross-platform build and development automation

# Package information
PACKAGE_NAME := @professoroakz/github
VERSION := $(shell cat VERSION 2>/dev/null || echo "1.3.37")
REGISTRY := ghcr.io
IMAGE_NAME := professoroakz/github-config

# Directories
BUILD_DIR := build
DIST_DIR := dist
NODE_MODULES := node_modules

# Tools
NPM := npm
DOCKER := docker
DOCKER_COMPOSE := docker-compose
NODE := node

# Colors for output
RED := \033[0;31m
GREEN := \033[0;32m
YELLOW := \033[0;33m
BLUE := \033[0;34m
NC := \033[0m # No Color

.PHONY: help
help: ## Show this help message
	@echo "$(BLUE)Available targets:$(NC)"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  $(GREEN)%-20s$(NC) %s\n", $$1, $$2}'

.PHONY: all
all: clean install build test ## Run clean, install, build, and test

## Installation targets
.PHONY: install
install: ## Install npm dependencies
	@echo "$(BLUE)Installing dependencies...$(NC)"
	$(NPM) install

.PHONY: install-dev
install-dev: ## Install development dependencies
	@echo "$(BLUE)Installing development dependencies...$(NC)"
	$(NPM) install

## Build targets
.PHONY: build
build: ## Build the project
	@echo "$(BLUE)Building project...$(NC)"
	@echo "$(GREEN)✓ Build complete (no compilation needed for this package)$(NC)"

.PHONY: package
package: ## Create npm package
	@echo "$(BLUE)Creating npm package...$(NC)"
	$(NPM) pack

## Test targets
.PHONY: test
test: ## Run tests
	@echo "$(BLUE)Running tests...$(NC)"
	$(NPM) test

.PHONY: test-verbose
test-verbose: ## Run tests with verbose output
	@echo "$(BLUE)Running tests (verbose)...$(NC)"
	$(NPM) test -- --verbose

## Docker targets
.PHONY: docker-build
docker-build: ## Build Docker image
	@echo "$(BLUE)Building Docker image...$(NC)"
	$(DOCKER) build \
		--build-arg VERSION=$(VERSION) \
		--build-arg BUILD_DATE=$(shell date -u +'%Y-%m-%dT%H:%M:%SZ') \
		--build-arg VCS_REF=$(shell git rev-parse --short HEAD) \
		-t $(IMAGE_NAME):$(VERSION) \
		-t $(IMAGE_NAME):latest \
		.

.PHONY: docker-run
docker-run: ## Run Docker container
	@echo "$(BLUE)Running Docker container...$(NC)"
	$(DOCKER) run -it --rm $(IMAGE_NAME):latest

.PHONY: docker-shell
docker-shell: ## Open shell in Docker container
	@echo "$(BLUE)Opening shell in Docker container...$(NC)"
	$(DOCKER) run -it --rm $(IMAGE_NAME):latest /bin/sh

.PHONY: docker-push
docker-push: docker-build ## Push Docker image to registry
	@echo "$(BLUE)Pushing Docker image to $(REGISTRY)...$(NC)"
	$(DOCKER) tag $(IMAGE_NAME):$(VERSION) $(REGISTRY)/$(IMAGE_NAME):$(VERSION)
	$(DOCKER) tag $(IMAGE_NAME):latest $(REGISTRY)/$(IMAGE_NAME):latest
	$(DOCKER) push $(REGISTRY)/$(IMAGE_NAME):$(VERSION)
	$(DOCKER) push $(REGISTRY)/$(IMAGE_NAME):latest

.PHONY: docker-compose-up
docker-compose-up: ## Start services with docker-compose
	@echo "$(BLUE)Starting services with docker-compose...$(NC)"
	$(DOCKER_COMPOSE) up -d

.PHONY: docker-compose-down
docker-compose-down: ## Stop services with docker-compose
	@echo "$(BLUE)Stopping services with docker-compose...$(NC)"
	$(DOCKER_COMPOSE) down

.PHONY: docker-compose-logs
docker-compose-logs: ## View docker-compose logs
	$(DOCKER_COMPOSE) logs -f

## Publishing targets
.PHONY: publish
publish: test ## Publish package to npm
	@echo "$(BLUE)Publishing to npm...$(NC)"
	$(NPM) publish --access public

.PHONY: publish-dry-run
publish-dry-run: ## Dry run of npm publish
	@echo "$(BLUE)Dry run of npm publish...$(NC)"
	$(NPM) publish --dry-run

## Cleaning targets
.PHONY: clean
clean: ## Clean build artifacts
	@echo "$(BLUE)Cleaning build artifacts...$(NC)"
	rm -rf $(BUILD_DIR) $(DIST_DIR)
	rm -f *.tgz
	@echo "$(GREEN)✓ Clean complete$(NC)"

.PHONY: clean-all
clean-all: clean ## Clean all generated files including node_modules
	@echo "$(BLUE)Cleaning all generated files...$(NC)"
	rm -rf $(NODE_MODULES)
	@echo "$(GREEN)✓ Deep clean complete$(NC)"

## Version management
.PHONY: version
version: ## Display current version
	@echo "$(BLUE)Current version: $(GREEN)$(VERSION)$(NC)"

.PHONY: version-patch
version-patch: ## Bump patch version
	$(NPM) version patch

.PHONY: version-minor
version-minor: ## Bump minor version
	$(NPM) version minor

.PHONY: version-major
version-major: ## Bump major version
	$(NPM) version major

## Development utilities
.PHONY: format
format: ## Format code (if formatter is configured)
	@echo "$(YELLOW)No formatter configured$(NC)"

.PHONY: lint
lint: ## Lint code (if linter is configured)
	@echo "$(YELLOW)No linter configured$(NC)"

.PHONY: validate
validate: test ## Validate package configuration
	@echo "$(BLUE)Validating package...$(NC)"
	$(NPM) pack --dry-run
	@echo "$(GREEN)✓ Package validation complete$(NC)"

.PHONY: info
info: ## Display project information
	@echo "$(BLUE)Project Information:$(NC)"
	@echo "  Name:    $(PACKAGE_NAME)"
	@echo "  Version: $(VERSION)"
	@echo "  Node:    $(shell $(NODE) --version)"
	@echo "  NPM:     $(shell $(NPM) --version)"
	@echo "  Docker:  $(shell $(DOCKER) --version 2>/dev/null || echo 'Not installed')"

.PHONY: setup
setup: install ## Initial setup for development
	@echo "$(GREEN)✓ Setup complete$(NC)"
	@echo "$(BLUE)Run 'make help' to see available commands$(NC)"

## CI/CD helpers
.PHONY: ci
ci: install test validate ## Run CI pipeline locally
	@echo "$(GREEN)✓ CI pipeline complete$(NC)"

.PHONY: release
release: ci docker-build ## Prepare release
	@echo "$(GREEN)✓ Release preparation complete$(NC)"
	@echo "$(YELLOW)Remember to:$(NC)"
	@echo "  1. Update VERSION file"
	@echo "  2. Update package.json version"
	@echo "  3. Create git tag"
	@echo "  4. Push to trigger release workflow"
