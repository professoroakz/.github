#!/usr/bin/env python3
"""
Health check script for GitHub repository
Validates repository structure, files, and configuration
"""

import sys
import json
from pathlib import Path
from typing import Tuple

# ANSI color codes
GREEN = '\033[0;32m'
RED = '\033[0;31m'
YELLOW = '\033[1;33m'
NC = '\033[0m'

def check_file_exists(file_path: Path) -> bool:
    """Check if a file exists"""
    return file_path.exists() and file_path.is_file()

def check_dir_exists(dir_path: Path) -> bool:
    """Check if a directory exists"""
    return dir_path.exists() and dir_path.is_dir()

def validate_json_file(file_path: Path) -> Tuple[bool, str]:
    """Validate JSON file syntax"""
    try:
        with open(file_path, 'r') as f:
            json.load(f)
        return True, "Valid JSON"
    except json.JSONDecodeError as e:
        return False, f"Invalid JSON: {e}"
    except Exception as e:
        return False, f"Error: {e}"

def main():
    """Main health check function"""
    root_dir = Path(__file__).parent.parent
    
    print("=" * 50)
    print("GitHub Repository Health Check")
    print("=" * 50)
    print()
    
    # Required files
    required_files = [
        "README.md",
        "LICENSE",
        "CODE_OF_CONDUCT.md",
        "CONTRIBUTING.md",
        "SECURITY.md",
        "SUPPORT.md",
        "CHANGELOG.md",
        ".github/CODEOWNERS",
        ".github/FUNDING.yml",
        ".github/pull_request_template.md",
        ".github/ISSUE_TEMPLATE/bug_report.md",
        ".github/ISSUE_TEMPLATE/feature_request.md",
        ".github/ISSUE_TEMPLATE/config.yml",
        ".github/workflows/ci.yml",
        "Makefile",
        "package.json",
    ]
    
    # Check required files
    print("Checking required files...")
    missing_files = []
    for file_path_str in required_files:
        file_path = root_dir / file_path_str
        if check_file_exists(file_path):
            print(f"{GREEN}✓{NC} {file_path_str}")
        else:
            print(f"{RED}✗{NC} {file_path_str} (missing)")
            missing_files.append(file_path_str)
    
    print()
    
    # Check JSON files
    print("Validating JSON files...")
    json_files = [
        "package.json",
        ".markdownlint.json",
        ".github/mlc_config.json",
    ]
    
    for json_file_str in json_files:
        json_file = root_dir / json_file_str
        if json_file.suffix == '.json' and check_file_exists(json_file):
            valid, msg = validate_json_file(json_file)
            if valid:
                print(f"{GREEN}✓{NC} {json_file_str}: {msg}")
            else:
                print(f"{RED}✗{NC} {json_file_str}: {msg}")
        elif check_file_exists(json_file):
            print(f"{GREEN}✓{NC} {json_file_str}: Exists")
    
    print()
    
    # Check directories
    print("Checking directory structure...")
    required_dirs = [
        ".github",
        ".github/ISSUE_TEMPLATE",
        ".github/workflows",
        "bin",
        "docs",
        "test",
        "scripts",
        "profile",
    ]
    
    for dir_path_str in required_dirs:
        dir_path = root_dir / dir_path_str
        if check_dir_exists(dir_path):
            print(f"{GREEN}✓{NC} {dir_path_str}/")
        else:
            print(f"{YELLOW}⚠{NC} {dir_path_str}/ (missing)")
    
    print()
    
    # Summary
    print("=" * 50)
    if missing_files:
        print(f"{RED}Health Check: FAILED{NC}")
        print(f"Missing {len(missing_files)} required file(s)")
        return 1
    else:
        print(f"{GREEN}Health Check: PASSED{NC}")
        print("All required files and directories present")
        return 0

if __name__ == "__main__":
    sys.exit(main())
