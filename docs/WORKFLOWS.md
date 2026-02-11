# GitHub Actions Workflows

This document describes the GitHub Actions workflows included in this repository.

## CI Workflow

**File**: `.github/workflows/ci.yml`

### Purpose

Ensures repository hygiene by validating required files exist and checking markdown links.

### Trigger Events

- Pull requests to any branch
- Pushes to `main` branch

### Jobs

#### repo_hygiene

Validates the repository structure and content:

1. **Checkout**: Checks out the repository code
2. **Require core files**: Verifies all required community health files exist
3. **Markdown link check**: Validates all links in markdown files

### Required Files

The CI workflow checks for these files:

- `README.md`
- `CODE_OF_CONDUCT.md`
- `CONTRIBUTING.md`
- `SECURITY.md`
- `LICENSE`
- `.github/ISSUE_TEMPLATE/bug_report.md`
- `.github/ISSUE_TEMPLATE/feature_request.md`
- `.github/pull_request_template.md`

### Markdown Link Check Configuration

Links are checked using the configuration in `.github/mlc_config.json`:

- Ignores localhost URLs
- Ignores mailto links
- Retries on 429 (rate limit) errors
- Accepts various HTTP status codes (200, 201, 301, 302, etc.)

## Running Workflows Locally

### Validate Repository Structure

You can run the file validation locally:

```bash
./bin/github-config validate
```

Or using the test script:

```bash
./test/run-tests.sh
```

### Check Markdown Links

Install markdown-link-check:

```bash
npm install -g markdown-link-check
```

Run link checking:

```bash
find . -name '*.md' -not -path './node_modules/*' -exec markdown-link-check {} \;
```

## Adding New Workflows

To add a new workflow:

1. Create a new YAML file in `.github/workflows/`
2. Define trigger events (`on:`)
3. Define jobs and steps
4. Test locally if possible
5. Submit a pull request

### Example Workflow Template

```yaml
name: My Workflow

on:
  push:
    branches: [ main ]
  pull_request:

jobs:
  my_job:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4
      
      - name: Run my task
        run: echo "Hello, World!"
```

## Workflow Best Practices

1. **Use specific action versions**: Pin actions to specific versions or SHA
2. **Minimize workflow runs**: Use path filters to run only when relevant files change
3. **Use caching**: Cache dependencies to speed up workflow runs
4. **Add status checks**: Make important workflows required for pull requests
5. **Use secrets**: Never hardcode sensitive data; use GitHub secrets
6. **Keep workflows simple**: Break complex workflows into multiple jobs
7. **Add helpful names**: Use descriptive names for jobs and steps

## Troubleshooting

### Workflow Not Running

- Check trigger conditions (`on:` section)
- Verify branch protection rules
- Check workflow file syntax (YAML formatting)

### Workflow Failing

- Review the workflow logs in GitHub Actions tab
- Check file permissions for scripts
- Verify required dependencies are installed
- Test commands locally before adding to workflow

## Resources

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Workflow Syntax](https://docs.github.com/en/actions/reference/workflow-syntax-for-github-actions)
- [Action Marketplace](https://github.com/marketplace?type=actions)
