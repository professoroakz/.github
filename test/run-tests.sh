#!/usr/bin/env bash
# Test suite for github-config repository

set -euo pipefail

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"

test_count=0
pass_count=0
fail_count=0

run_test() {
    local test_name="$1"
    local test_cmd="$2"
    
    test_count=$((test_count + 1))
    
    if eval "$test_cmd" &>/dev/null; then
        echo -e "${GREEN}✓${NC} $test_name"
        pass_count=$((pass_count + 1))
        return 0
    else
        echo -e "${RED}✗${NC} $test_name"
        fail_count=$((fail_count + 1))
        return 1
    fi
}

echo "Running tests..."
echo ""

# Test required files exist
run_test "README.md exists" "test -f \"$ROOT_DIR/README.md\""
run_test "LICENSE exists" "test -f \"$ROOT_DIR/LICENSE\""
run_test "CODE_OF_CONDUCT.md exists" "test -f \"$ROOT_DIR/CODE_OF_CONDUCT.md\""
run_test "CONTRIBUTING.md exists" "test -f \"$ROOT_DIR/CONTRIBUTING.md\""
run_test "SECURITY.md exists" "test -f \"$ROOT_DIR/SECURITY.md\""
run_test "SUPPORT.md exists" "test -f \"$ROOT_DIR/SUPPORT.md\""
run_test "CHANGELOG.md exists" "test -f \"$ROOT_DIR/CHANGELOG.md\""

# Test .github directory structure
run_test ".github/CODEOWNERS exists" "test -f \"$ROOT_DIR/.github/CODEOWNERS\""
run_test ".github/FUNDING.yml exists" "test -f \"$ROOT_DIR/.github/FUNDING.yml\""
run_test ".github/dependabot.yml exists" "test -f \"$ROOT_DIR/.github/dependabot.yml\""
run_test ".github/SECURITY.md exists" "test -f \"$ROOT_DIR/.github/SECURITY.md\""
run_test ".github/pull_request_template.md exists" "test -f \"$ROOT_DIR/.github/pull_request_template.md\""

# Test issue templates
run_test "Bug report template exists" "test -f \"$ROOT_DIR/.github/ISSUE_TEMPLATE/bug_report.md\""
run_test "Feature request template exists" "test -f \"$ROOT_DIR/.github/ISSUE_TEMPLATE/feature_request.md\""
run_test "Issue template config exists" "test -f \"$ROOT_DIR/.github/ISSUE_TEMPLATE/config.yml\""

# Test workflows
run_test "CI workflow exists" "test -f '$ROOT_DIR/.github/workflows/ci.yml'"

# Test configuration files
run_test ".editorconfig exists" "test -f '$ROOT_DIR/.editorconfig'"
run_test ".gitignore exists" "test -f '$ROOT_DIR/.gitignore'"
run_test ".markdownlint.json exists" "test -f '$ROOT_DIR/.markdownlint.json'"

# Test build files
run_test "Makefile exists" "test -f '$ROOT_DIR/Makefile'"
run_test "package.json exists" "test -f '$ROOT_DIR/package.json'"
run_test "Dockerfile exists" "test -f '$ROOT_DIR/Dockerfile'"

# Test bin directory
run_test "bin/github-config exists" "test -f '$ROOT_DIR/bin/github-config'"
run_test "bin/github-config is executable" "test -x '$ROOT_DIR/bin/github-config'"

# Test package.json validity
if command -v node &>/dev/null; then
    run_test "package.json is valid JSON" "node -e \"require('$ROOT_DIR/package.json')\""
fi

# Summary
echo ""
echo "===================="
echo "Test Results"
echo "===================="
echo "Total:  $test_count"
echo -e "${GREEN}Passed: $pass_count${NC}"
if [ $fail_count -gt 0 ]; then
    echo -e "${RED}Failed: $fail_count${NC}"
    exit 1
else
    echo "All tests passed!"
    exit 0
fi
