#!/bin/bash
# Installation script for Linux/Unix/Mac systems
# professoroakz/.github repository

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Script info
SCRIPT_NAME="install.sh"
PACKAGE_NAME="@professoroakz/github"

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}  professoroakz/.github installer${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

# Detect OS
detect_os() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "linux"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
    elif [[ "$OSTYPE" == "freebsd"* ]]; then
        echo "freebsd"
    else
        echo "unknown"
    fi
}

OS=$(detect_os)
echo -e "${BLUE}Detected OS: ${GREEN}${OS}${NC}"

# Check for Node.js
check_node() {
    if command -v node &> /dev/null; then
        NODE_VERSION=$(node --version)
        echo -e "${GREEN}✓ Node.js found: ${NODE_VERSION}${NC}"
        return 0
    else
        echo -e "${RED}✗ Node.js not found${NC}"
        return 1
    fi
}

# Check for npm
check_npm() {
    if command -v npm &> /dev/null; then
        NPM_VERSION=$(npm --version)
        echo -e "${GREEN}✓ npm found: ${NPM_VERSION}${NC}"
        return 0
    else
        echo -e "${RED}✗ npm not found${NC}"
        return 1
    fi
}

# Install via npm
install_npm() {
    echo ""
    echo -e "${BLUE}Installing ${PACKAGE_NAME} via npm...${NC}"
    
    if npm install -g "${PACKAGE_NAME}"; then
        echo -e "${GREEN}✓ Successfully installed ${PACKAGE_NAME}${NC}"
        return 0
    else
        echo -e "${RED}✗ Failed to install ${PACKAGE_NAME}${NC}"
        return 1
    fi
}

# Install via local directory
install_local() {
    echo ""
    echo -e "${BLUE}Installing from local directory...${NC}"
    
    if [ -f "package.json" ]; then
        if npm install; then
            echo -e "${GREEN}✓ Dependencies installed successfully${NC}"
            return 0
        else
            echo -e "${RED}✗ Failed to install dependencies${NC}"
            return 1
        fi
    else
        echo -e "${RED}✗ package.json not found${NC}"
        return 1
    fi
}

# Main installation logic
main() {
    echo ""
    echo -e "${BLUE}Checking prerequisites...${NC}"
    
    # Check for Node.js and npm
    if ! check_node || ! check_npm; then
        echo ""
        echo -e "${YELLOW}Please install Node.js and npm first:${NC}"
        echo -e "  - Visit: https://nodejs.org/"
        
        if [ "$OS" == "macos" ]; then
            echo -e "  - Or use Homebrew: ${GREEN}brew install node${NC}"
        elif [ "$OS" == "linux" ]; then
            echo -e "  - Or use your package manager:"
            echo -e "    Ubuntu/Debian: ${GREEN}sudo apt-get install nodejs npm${NC}"
            echo -e "    Fedora: ${GREEN}sudo dnf install nodejs npm${NC}"
            echo -e "    Arch: ${GREEN}sudo pacman -S nodejs npm${NC}"
        fi
        
        exit 1
    fi
    
    # Choose installation method
    echo ""
    echo -e "${BLUE}Choose installation method:${NC}"
    echo -e "  1) Install globally via npm (recommended)"
    echo -e "  2) Install locally (development)"
    echo -e "  3) Exit"
    echo ""
    read -p "Enter choice [1-3]: " choice
    
    case $choice in
        1)
            install_npm
            ;;
        2)
            install_local
            ;;
        3)
            echo -e "${YELLOW}Installation cancelled${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}Invalid choice${NC}"
            exit 1
            ;;
    esac
    
    if [ $? -eq 0 ]; then
        echo ""
        echo -e "${GREEN}========================================${NC}"
        echo -e "${GREEN}  Installation complete!${NC}"
        echo -e "${GREEN}========================================${NC}"
    else
        echo ""
        echo -e "${RED}Installation failed${NC}"
        exit 1
    fi
}

# Run main function
main "$@"
