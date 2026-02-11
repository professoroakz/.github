# Makefile for professoroakz/.github repository
# Provides build, test, and installation targets

.PHONY: help install test clean build run docker-build docker-run

# Default target
help:
	@echo "Available targets:"
	@echo "  make install       - Install dependencies (npm)"
	@echo "  make test          - Run tests"
	@echo "  make build         - Build the project"
	@echo "  make clean         - Clean build artifacts"
	@echo "  make run           - Run the application"
	@echo "  make docker-build  - Build Docker image"
	@echo "  make docker-run    - Run Docker container"
	@echo "  make lint          - Lint source files"
	@echo "  make format        - Format source files"

# Install dependencies
install:
	@echo "Installing dependencies..."
	npm install

# Run tests
test:
	@echo "Running tests..."
	npm test

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
	rm -f *.log

# Run the application
run:
	@echo "Running application..."
	node index.js

# Build Docker image
docker-build:
	@echo "Building Docker image..."
	docker build -t professoroakz/github-config:latest .

# Run Docker container
docker-run: docker-build
	@echo "Running Docker container..."
	docker run -it --rm professoroakz/github-config:latest

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
