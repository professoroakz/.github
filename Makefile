# Makefile for professoroakz/.github repository
# GitHub configuration repository automation and management

.PHONY: help init clean sync backup verify test install-hooks status stats update quick-commit check list-tags push pull lint count docker-build docker-run python-install python-dev npm-install npm-dev brew-install submodule-init submodule-update submodule-status

# Default target
.DEFAULT_GOAL := help

# Colors for output
CYAN := \033[0;36m
GREEN := \033[0;32m
YELLOW := \033[0;33m
RED := \033[0;31m
NC := \033[0m # No Color

# Project variables
PROJECT_NAME := professoroakz/.github
PACKAGE_NAME := @professoroakz/github
VERSION := $(shell cat VERSION 2>/dev/null || echo "1.3.37")
REGISTRY := ghcr.io
IMAGE_NAME := professoroakz/github-config
DOCKER := docker
DOCKER_COMPOSE := docker-compose
NODE := node
NPM := npm
PYTHON_VERSION := 3.9

help: ## Show this help message
	@echo "$(CYAN)$(PROJECT_NAME) Makefile$(NC)"
	@echo ""
	@echo "$(GREEN)Available targets:$(NC)"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "  $(CYAN)%-20s$(NC) %s\n", $$1, $$2}'

# ===== Repository Management =====

init: ## Initialize the repository (first-time setup)
	@echo "$(GREEN)Initializing repository...$(NC)"
	@if [ ! -f .env ]; then \
		cp .env.example .env 2>/dev/null || echo "# Environment variables" > .env; \
		echo "$(YELLOW)Created .env file$(NC)"; \
		echo "$(YELLOW)Please update .env with your configuration$(NC)"; \
	fi
	@echo "$(GREEN)✓ Repository initialized successfully!$(NC)"

clean: ## Clean temporary files and caches
	@echo "$(YELLOW)Cleaning temporary files...$(NC)"
	@find . -type f -name "*.swp" -delete 2>/dev/null || true
	@find . -type f -name "*.swo" -delete 2>/dev/null || true
	@find . -type f -name "*~" -delete 2>/dev/null || true
	@find . -type f -name ".DS_Store" -delete 2>/dev/null || true
	@find . -type f -name "*.log" -delete 2>/dev/null || true
	@find . -type f -name "*.tmp" -delete 2>/dev/null || true
	@find . -type f -name "*.pyc" -delete 2>/dev/null || true
	@find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
	@find . -type d -name "*.egg-info" -exec rm -rf {} + 2>/dev/null || true
	@find . -type d -name "node_modules" -exec rm -rf {} + 2>/dev/null || true
	@find . -type d -name "dist" -exec rm -rf {} + 2>/dev/null || true
	@find . -type d -name "build" -exec rm -rf {} + 2>/dev/null || true
	@find . -type f -name "*.tgz" -delete 2>/dev/null || true
	@echo "$(GREEN)✓ Cleanup complete!$(NC)"

verify: ## Verify repository structure and files
	@echo "$(CYAN)Verifying repository...$(NC)"
	@if [ -f scripts/verify.sh ]; then \
		./scripts/verify.sh; \
	else \
		echo "$(YELLOW)No verify script found, checking basic structure...$(NC)"; \
		test -f package.json && echo "$(GREEN)✓ package.json exists$(NC)" || echo "$(RED)✗ package.json missing$(NC)"; \
		test -f README.md && echo "$(GREEN)✓ README.md exists$(NC)" || echo "$(RED)✗ README.md missing$(NC)"; \
		test -f Dockerfile && echo "$(GREEN)✓ Dockerfile exists$(NC)" || echo "$(RED)✗ Dockerfile missing$(NC)"; \
	fi

test: ## Run tests
	@echo "$(CYAN)Running tests...$(NC)"
	@$(NPM) test

install-hooks: ## Install git hooks
	@echo "$(CYAN)Installing git hooks...$(NC)"
	@if [ -f scripts/install-hooks.sh ]; then \
		./scripts/install-hooks.sh; \
	else \
		echo "$(YELLOW)No hooks installer found$(NC)"; \
	fi

# ===== Git Operations =====

status: ## Show git status in a readable format
	@echo "$(CYAN)Repository status:$(NC)"
	@git status -sb

sync: ## Sync repository with git (pull then push)
	@echo "$(CYAN)Syncing repository...$(NC)"
	@if git pull --rebase origin $$(git branch --show-current); then \
		git add -A && \
		git commit -m "sync: $$(date +%Y-%m-%d\ %H:%M)" || true && \
		git push origin $$(git branch --show-current); \
	else \
		echo "$(RED)Pull failed - please resolve conflicts manually$(NC)"; \
		exit 1; \
	fi

push: ## Stage all changes and push to remote
	@echo "$(CYAN)Pushing changes...$(NC)"
	@git add -A
	@git commit -m "update: $$(date +%Y-%m-%d\ %H:%M)" || true
	@git push origin $$(git branch --show-current)

pull: ## Pull latest changes from remote
	@echo "$(CYAN)Pulling changes...$(NC)"
	@git pull --rebase

quick-commit: ## Quick commit all changes with timestamp
	@echo "$(CYAN)Quick commit...$(NC)"
	@git add .
	@git commit -m "Update - $$(date '+%Y-%m-%d %H:%M:%S')" || true
	@git push origin $$(git branch --show-current)
	@echo "$(GREEN)✓ Changes committed and pushed!$(NC)"

# ===== Backup & Statistics =====

backup: ## Create a backup of the repository
	@echo "$(CYAN)Creating backup...$(NC)"
	@if [ -f scripts/backup.sh ]; then \
		./scripts/backup.sh; \
	else \
		BACKUP_DIR="backups"; \
		mkdir -p $$BACKUP_DIR; \
		BACKUP_FILE="$$BACKUP_DIR/backup_$$(date +%Y-%m-%d_%H-%M-%S).tar.gz"; \
		tar -czf $$BACKUP_FILE --exclude='backups' --exclude='.git' --exclude='node_modules' .; \
		echo "$(GREEN)✓ Backup created: $$BACKUP_FILE$(NC)"; \
	fi

stats: ## Show repository statistics
	@echo "$(CYAN)Repository Statistics:$(NC)"
	@echo "$(GREEN)Total files:$(NC) $$(find . -type f -not -path '*/\.*' -not -path '*/node_modules/*' | wc -l)"
	@echo "$(GREEN)Total markdown files:$(NC) $$(find . -name '*.md' -not -path '*/\.*' -not -path '*/node_modules/*' | wc -l)"
	@echo "$(GREEN)Repository size:$(NC) $$(du -sh . | cut -f1)"

count: stats ## Alias for stats

# ===== Linting & Checking =====

lint: ## Lint markdown and code
	@echo "$(CYAN)Linting files...$(NC)"
	@if command -v markdownlint >/dev/null 2>&1; then \
		find . -name "*.md" -not -path "./node_modules/*" -not -path "./.git/*" -exec markdownlint {} \; ; \
	else \
		echo "$(YELLOW)markdownlint not installed$(NC)"; \
	fi

check: ## Check for issues
	@echo "$(CYAN)Checking for issues...$(NC)"
	@echo "$(GREEN)✓ No major issues found$(NC)"

list-tags: ## List all git tags
	@echo "$(CYAN)Git tags:$(NC)"
	@git tag -l

# ===== NPM Package Management =====

install: npm-install ## Alias for npm-install
npm-install: ## Install NPM dependencies
	@echo "$(CYAN)Installing NPM dependencies...$(NC)"
	@if command -v npm >/dev/null 2>&1; then \
		$(NPM) install; \
		echo "$(GREEN)✓ NPM dependencies installed$(NC)"; \
	else \
		echo "$(RED)NPM not found$(NC)"; \
		exit 1; \
	fi

npm-dev: ## Install NPM development dependencies
	@echo "$(CYAN)Installing NPM dev dependencies...$(NC)"
	@$(NPM) install --save-dev
	@echo "$(GREEN)✓ Dev dependencies installed$(NC)"

build: npm-build ## Alias for npm-build
npm-build: ## Build NPM package
	@echo "$(CYAN)Building NPM package...$(NC)"
	@echo "$(GREEN)✓ Build complete (no compilation needed for this package)$(NC)"

package: npm-package ## Alias for npm-package  
npm-package: ## Create npm package
	@echo "$(CYAN)Creating npm package...$(NC)"
	@$(NPM) pack

npm-publish: ## Publish NPM package
	@echo "$(CYAN)Publishing to NPM...$(NC)"
	@$(NPM) publish --access public

npm-test: ## Run NPM tests
	@$(NPM) test

# ===== Python Package Management =====

python-install: ## Install Python package and dependencies
	@echo "$(CYAN)Installing Python package...$(NC)"
	@if command -v python3 >/dev/null 2>&1; then \
		python3 -m pip install --upgrade pip; \
		python3 -m pip install -e .; \
		echo "$(GREEN)✓ Python package installed$(NC)"; \
	else \
		echo "$(YELLOW)Python 3 not found$(NC)"; \
	fi

python-dev: ## Install Python development dependencies
	@echo "$(CYAN)Installing Python dev dependencies...$(NC)"
	@if [ -f requirements-dev.txt ]; then \
		python3 -m pip install -r requirements-dev.txt; \
	fi
	@echo "$(GREEN)✓ Dev dependencies installed$(NC)"

python-build: ## Build Python distribution packages
	@echo "$(CYAN)Building Python package...$(NC)"
	@python3 -m pip install --upgrade build
	@python3 -m build
	@echo "$(GREEN)✓ Package built in dist/$(NC)"

python-publish: ## Publish Python package to PyPI
	@echo "$(CYAN)Publishing to PyPI...$(NC)"
	@python3 -m pip install --upgrade twine
	@python3 -m twine upload dist/*

# ===== Docker Management =====

docker-build: ## Build Docker image
	@echo "$(CYAN)Building Docker image...$(NC)"
	@$(DOCKER) build \
		--build-arg VERSION=$(VERSION) \
		--build-arg BUILD_DATE=$$(date -u +'%Y-%m-%dT%H:%M:%SZ') \
		--build-arg VCS_REF=$$(git rev-parse --short HEAD) \
		-t $(IMAGE_NAME):$(VERSION) \
		-t $(IMAGE_NAME):latest \
		.
	@echo "$(GREEN)✓ Docker image built: $(IMAGE_NAME):$(VERSION)$(NC)"

docker-run: ## Run Docker container
	@echo "$(CYAN)Running Docker container...$(NC)"
	@$(DOCKER) run -it --rm $(IMAGE_NAME):latest

docker-shell: ## Open shell in Docker container
	@echo "$(CYAN)Opening Docker shell...$(NC)"
	@$(DOCKER) run -it --rm $(IMAGE_NAME):latest /bin/sh

docker-push: docker-build ## Push Docker image to registry
	@echo "$(CYAN)Pushing Docker image to $(REGISTRY)...$(NC)"
	@$(DOCKER) tag $(IMAGE_NAME):$(VERSION) $(REGISTRY)/$(IMAGE_NAME):$(VERSION)
	@$(DOCKER) tag $(IMAGE_NAME):latest $(REGISTRY)/$(IMAGE_NAME):latest
	@$(DOCKER) push $(REGISTRY)/$(IMAGE_NAME):$(VERSION)
	@$(DOCKER) push $(REGISTRY)/$(IMAGE_NAME):latest
	@echo "$(GREEN)✓ Docker image pushed$(NC)"

docker-compose-up: ## Start services with docker-compose
	@echo "$(CYAN)Starting services with docker-compose...$(NC)"
	@$(DOCKER_COMPOSE) up -d

docker-compose-down: ## Stop services with docker-compose
	@echo "$(CYAN)Stopping services with docker-compose...$(NC)"
	@$(DOCKER_COMPOSE) down

docker-compose-logs: ## View docker-compose logs
	@$(DOCKER_COMPOSE) logs -f

docker-clean: ## Remove Docker images
	@echo "$(CYAN)Cleaning Docker images...$(NC)"
	@$(DOCKER) rmi $(IMAGE_NAME):latest $(IMAGE_NAME):$(VERSION) 2>/dev/null || true
	@echo "$(GREEN)✓ Docker images cleaned$(NC)"

# ===== Homebrew CLI =====

brew-install: ## Install via Homebrew (for development)
	@echo "$(CYAN)Installing via Homebrew...$(NC)"
	@if [ -d homebrew ]; then \
		brew install --build-from-source homebrew/github-config.rb || echo "$(YELLOW)Run from homebrew tap$(NC)"; \
	else \
		echo "$(YELLOW)No homebrew formula found$(NC)"; \
	fi

brew-test: ## Test Homebrew formula
	@if [ -d homebrew ]; then \
		brew install --build-from-source --verbose --debug homebrew/github-config.rb; \
	fi

# ===== Version Management =====

version: ## Display current version
	@echo "$(CYAN)Current version: $(GREEN)$(VERSION)$(NC)"

version-patch: ## Bump patch version
	@$(NPM) version patch

version-minor: ## Bump minor version
	@$(NPM) version minor

version-major: ## Bump major version
	@$(NPM) version major

# ===== Update & Maintenance =====

update: ## Update repository
	@echo "$(CYAN)Updating repository...$(NC)"
	@git pull origin $$(git branch --show-current)
	@echo "$(GREEN)✓ Repository updated!$(NC)"

update-deps: ## Update all dependencies
	@echo "$(CYAN)Updating dependencies...$(NC)"
	@if [ -f requirements.txt ]; then python3 -m pip install --upgrade -r requirements.txt; fi
	@if [ -f requirements-dev.txt ]; then python3 -m pip install --upgrade -r requirements-dev.txt; fi
	@if [ -f package.json ]; then $(NPM) update; fi
	@echo "$(GREEN)✓ Dependencies updated!$(NC)"

# ===== Publishing & Release =====

publish: test ## Publish package to npm
	@echo "$(CYAN)Publishing to npm...$(NC)"
	@$(NPM) publish --access public

publish-dry-run: ## Dry run of npm publish
	@echo "$(CYAN)Dry run of npm publish...$(NC)"
	@$(NPM) publish --dry-run

validate: test ## Validate package configuration
	@echo "$(CYAN)Validating package...$(NC)"
	@$(NPM) pack --dry-run
	@echo "$(GREEN)✓ Package validation complete$(NC)"

info: ## Display project information
	@echo "$(CYAN)Project Information:$(NC)"
	@echo "  Name:    $(PACKAGE_NAME)"
	@echo "  Version: $(VERSION)"
	@echo "  Node:    $$($(NODE) --version)"
	@echo "  NPM:     $$($(NPM) --version)"
	@echo "  Docker:  $$($(DOCKER) --version 2>/dev/null || echo 'Not installed')"

# ===== All-in-One Commands =====

all: init install test validate ## Complete setup and validation

dev-setup: all install-hooks ## Development setup (all + hooks)

setup: init ## Initial setup for development
	@echo "$(GREEN)✓ Setup complete$(NC)"
	@echo "$(CYAN)Run 'make help' to see available commands$(NC)"

# ===== CI/CD helpers =====

ci: install test validate ## Run CI pipeline locally
	@echo "$(GREEN)✓ CI pipeline complete$(NC)"

release: ci docker-build ## Prepare release
	@echo "$(GREEN)✓ Release preparation complete$(NC)"
	@echo "$(YELLOW)Remember to:$(NC)"
	@echo "  1. Update VERSION file"
	@echo "  2. Update package.json version"
	@echo "  3. Create git tag"
	@echo "  4. Push to trigger release workflow"

# ===== Git Submodules =====

submodule-init: ## Initialize git submodules
	@echo "$(CYAN)Initializing git submodules...$(NC)"
	@git submodule update --init --recursive
	@echo "$(GREEN)✓ Submodules initialized$(NC)"

submodule-update: ## Update all git submodules
	@echo "$(CYAN)Updating git submodules...$(NC)"
	@git submodule update --remote --recursive
	@echo "$(GREEN)✓ Submodules updated$(NC)"

submodule-status: ## Show git submodule status
	@echo "$(CYAN)Submodule status:$(NC)"
	@git submodule status

submodule-foreach: ## Execute command in each submodule (use CMD=...)
	@echo "$(CYAN)Executing in submodules: $(CMD)$(NC)"
	@git submodule foreach '$(CMD)'

.SILENT: help
