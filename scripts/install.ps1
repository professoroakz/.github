# Installation script for Windows PowerShell
# professoroakz/.github repository

$ErrorActionPreference = "Stop"

# Colors
function Write-ColorOutput($ForegroundColor, $Message) {
    Write-Host $Message -ForegroundColor $ForegroundColor
}

# Script info
$PackageName = "@professoroakz/github"

Write-ColorOutput Cyan "========================================"
Write-ColorOutput Cyan "  professoroakz/.github installer"
Write-ColorOutput Cyan "========================================"
Write-Host ""

# Check for Node.js
function Test-Node {
    try {
        $nodeVersion = & node --version
        Write-ColorOutput Green "✓ Node.js found: $nodeVersion"
        return $true
    }
    catch {
        Write-ColorOutput Red "✗ Node.js not found"
        return $false
    }
}

# Check for npm
function Test-Npm {
    try {
        $npmVersion = & npm --version
        Write-ColorOutput Green "✓ npm found: $npmVersion"
        return $true
    }
    catch {
        Write-ColorOutput Red "✗ npm not found"
        return $false
    }
}

# Install via npm
function Install-NpmGlobal {
    Write-Host ""
    Write-ColorOutput Cyan "Installing $PackageName via npm..."
    
    try {
        & npm install -g $PackageName
        Write-ColorOutput Green "✓ Successfully installed $PackageName"
        return $true
    }
    catch {
        Write-ColorOutput Red "✗ Failed to install $PackageName"
        return $false
    }
}

# Install via local directory
function Install-Local {
    Write-Host ""
    Write-ColorOutput Cyan "Installing from local directory..."
    
    if (Test-Path "package.json") {
        try {
            & npm install
            Write-ColorOutput Green "✓ Dependencies installed successfully"
            return $true
        }
        catch {
            Write-ColorOutput Red "✗ Failed to install dependencies"
            return $false
        }
    }
    else {
        Write-ColorOutput Red "✗ package.json not found"
        return $false
    }
}

# Main installation logic
function Main {
    Write-Host ""
    Write-ColorOutput Cyan "Checking prerequisites..."
    
    # Check for Node.js and npm
    if (-not (Test-Node) -or -not (Test-Npm)) {
        Write-Host ""
        Write-ColorOutput Yellow "Please install Node.js and npm first:"
        Write-Host "  - Visit: https://nodejs.org/"
        Write-Host "  - Or use Chocolatey: choco install nodejs"
        Write-Host "  - Or use Scoop: scoop install nodejs"
        exit 1
    }
    
    # Choose installation method
    Write-Host ""
    Write-ColorOutput Cyan "Choose installation method:"
    Write-Host "  1) Install globally via npm (recommended)"
    Write-Host "  2) Install locally (development)"
    Write-Host "  3) Exit"
    Write-Host ""
    $choice = Read-Host "Enter choice [1-3]"
    
    switch ($choice) {
        "1" {
            $success = Install-NpmGlobal
        }
        "2" {
            $success = Install-Local
        }
        "3" {
            Write-ColorOutput Yellow "Installation cancelled"
            exit 0
        }
        default {
            Write-ColorOutput Red "Invalid choice"
            exit 1
        }
    }
    
    if ($success) {
        Write-Host ""
        Write-ColorOutput Green "========================================"
        Write-ColorOutput Green "  Installation complete!"
        Write-ColorOutput Green "========================================"
    }
    else {
        Write-Host ""
        Write-ColorOutput Red "Installation failed"
        exit 1
    }
}

# Run main function
Main
