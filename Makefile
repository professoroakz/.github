# Makefile for professoroakz/.github repository
# Provides build, test, and installation targets for multiple platforms

.PHONY: help install test clean build run docker-build docker-run install-system brew-install

# Variables
PREFIX ?= /usr/local
BINDIR = $(PREFIX)/bin
SHAREDIR = $(PREFIX)/share/github-config

# Default target
help:
	@echo "Available targets:"
	@echo "  make install         - Install NPM dependencies"
	@echo "  make install-system  - Install CLI tools system-wide"
	@echo "  make install-user    - Install for current user only"
	@echo "  make brew-install    - Install via Homebrew formula"
	@echo "  make test            - Run test suite"
	@echo "  make build           - Build the project"
	@echo "  make clean           - Clean build artifacts"
	@echo "  make run             - Run the application"
	@echo "  make docker-build    - Build Docker image"
	@echo "  make docker-run      - Run Docker container"
	@echo "  make lint            - Lint source files"
	@echo "  make format          - Format source files"
	@echo "  make package-npm     - Create NPM package"
	@echo "  make package-docker  - Build Docker image for distribution"
	@echo "  make uninstall       - Remove installed files"

# Install NPM dependencies
install:
	@echo "Installing NPM dependencies..."
	npm install

# Install system-wide (requires sudo)
install-system:
	@echo "Installing github-config system-wide to $(PREFIX)..."
	./install.sh

# Install for current user
install-user:
	@echo "Installing github-config for current user..."
	INSTALL_DIR=$$HOME/.local ./install.sh
	@echo ""
	@echo "Add $$HOME/.local/bin to your PATH if not already done:"
	@echo '  export PATH="$$HOME/.local/bin:$$PATH"'

# Homebrew installation
brew-install:
	@echo "Installing via Homebrew..."
	@if command -v brew >/dev/null 2>&1; then \
		brew install --build-from-source Formula/github-config.rb; \
	else \
		echo "Error: Homebrew not found. Install from https://brew.sh"; \
		exit 1; \
	fi

# Run tests
test:
	@echo "Running test suite..."
	@chmod +x test/run-tests.sh
	@chmod +x bin/github-config
	@./test/run-tests.sh
	@echo ""
	@echo "Running NPM tests..."
	@npm test

# Build project
build:
	@echo "Building project..."
	@if [ -f package.json ]; then npm run build --if-present; fi

# Clean build artifacts
clean:
	@echo "Cleaning build artifacts..."
	rm -rf node_modules/
	rm -rf dist/
	rm -rf build/
	rm -rf coverage/
	rm -f *.log
	rm -f *.tgz
	@echo "Clean complete."

# Uninstall system files
uninstall:
	@echo "Uninstalling github-config..."
	rm -f $(BINDIR)/github-config
	rm -rf $(SHAREDIR)
	@echo "Uninstall complete."

# Run the application
run:
	@echo "Running application..."
	node index.js

# Build Docker image
docker-build:
	@echo "Building Docker image..."
	docker build -t ghcr.io/professoroakz/github-config:latest .
	docker tag ghcr.io/professoroakz/github-config:latest professoroakz/github-config:latest

# Run Docker container
docker-run: docker-build
	@echo "Running Docker container..."
	docker run -it --rm ghcr.io/professoroakz/github-config:latest

# Package for NPM
package-npm:
	@echo "Creating NPM package..."
	npm pack
	@echo "Package created: $$(ls -t *.tgz | head -1)"

# Package Docker image
package-docker: docker-build
	@echo "Saving Docker image..."
	docker save ghcr.io/professoroakz/github-config:latest | gzip > github-config-docker.tar.gz
	@echo "Docker image saved: github-config-docker.tar.gz"

# Lint files
lint:
	@echo "Linting files..."
	@if command -v markdownlint >/dev/null 2>&1; then \
		markdownlint '**/*.md' --ignore node_modules; \
	else \
		echo "markdownlint not installed, skipping..."; \
	fi

# Format files
format:
	@echo "Formatting files..."
	@if command -v prettier >/dev/null 2>&1; then \
		prettier --write '**/*.{json,md,yml,yaml}' --ignore-path .gitignore; \
	else \
		echo "prettier not installed, skipping..."; \
	fi

# Version bump
version-patch:
	npm version patch

version-minor:
	npm version minor

version-major:
	npm version major
