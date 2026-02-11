# Frequently Asked Questions (FAQ)

## General

### What is this repository?

This is the `.github` repository for the professoroakz organization. It contains default community health files, issue templates, workflows, and configurations that apply to all repositories in the organization.

### How does the `.github` repository work?

GitHub automatically uses files from a special `.github` repository as defaults for all public repositories in an organization that don't have their own versions of these files.

### Which files are shared across repositories?

The following files are shared as defaults:
- Issue templates (`.github/ISSUE_TEMPLATE/*`)
- Pull request template (`.github/pull_request_template.md`)
- CODE_OF_CONDUCT.md
- CONTRIBUTING.md
- SECURITY.md
- SUPPORT.md
- FUNDING.yml

## Installation & Setup

### How do I install this as an NPM package?

```bash
npm install @professoroakz/github
```

### How do I use the CLI tool?

```bash
# Clone the repository
git clone https://github.com/professoroakz/.github.git
cd .github

# Install
./bin/github-config install

# Or create a symlink manually
sudo ln -s $(pwd)/bin/github-config /usr/local/bin/github-config
```

### How do I run the setup script?

```bash
./scripts/setup.sh
```

This will:
- Check prerequisites
- Install dependencies
- Set permissions
- Validate structure
- Run tests

## Usage

### How do I validate my repository structure?

```bash
# Using CLI tool
./bin/github-config validate

# Using test script
./test/run-tests.sh

# Using Python health check
./scripts/health-check.py
```

### How do I run tests?

```bash
# NPM test
npm test

# Test script
./test/run-tests.sh

# Using Make
make test
```

### How do I build the Docker image?

```bash
# Using Make
make docker-build

# Using Docker directly
docker build -t professoroakz/github-config:latest .

# Using deployment script
./scripts/deploy.sh docker
```

## Customization

### Can I override these files in my repository?

Yes! If you create the same file in your repository, it will override the default from this `.github` repository.

### How do I customize issue templates for my repository?

1. Create `.github/ISSUE_TEMPLATE/` directory in your repository
2. Copy the templates you want to customize
3. Modify them for your needs
4. The customized templates will be used instead of the defaults

### How do I add custom workflows?

Workflows in this repository serve as templates and documentation. To use them:

1. Copy the workflow to your repository's `.github/workflows/` directory
2. Customize as needed for your project
3. Commit and push

Note: Workflows from the `.github` repository do NOT run automatically in other repositories.

## Troubleshooting

### The CLI tool isn't found

Make sure it's executable and in your PATH:

```bash
chmod +x bin/github-config
echo $PATH | grep -q "/usr/local/bin" || export PATH="/usr/local/bin:$PATH"
```

### NPM install fails

Check your Node.js version:

```bash
node --version  # Should be >= 14.0.0
npm --version
```

Update if needed:

```bash
nvm install 20
nvm use 20
```

### Docker build fails

Common issues:

1. **Docker not running**: Start Docker daemon
2. **Permission denied**: Add user to docker group
3. **Out of disk space**: Clean up with `docker system prune`

### Tests are failing

Run the test suite:

```bash
./test/run-tests.sh
```

Check for missing files:

```bash
./bin/github-config validate
```

### Workflows aren't running

Remember:
- Workflows in `.github` repository are templates/documentation
- They don't run automatically in other repositories
- Copy them to your repository's `.github/workflows/` to use

## Development

### How do I contribute?

See [CONTRIBUTING.md](../CONTRIBUTING.md) for detailed guidelines.

Quick steps:
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Run tests
5. Submit a pull request

### How do I add a new feature?

1. Open an issue first to discuss
2. Follow coding standards
3. Add tests for new functionality
4. Update documentation
5. Submit PR with all checks passing

### How do I report a bug?

Use the bug report template:
1. Go to Issues tab
2. Click "New Issue"
3. Select "Bug report"
4. Fill in all sections
5. Submit

## Security

### How do I report a security vulnerability?

**DO NOT** open a public issue. Instead:

1. Use GitHub's "Report a vulnerability" feature
2. Or email: security@professoroakz.org

See [SECURITY.md](../SECURITY.md) for details.

### Are dependencies kept up to date?

Yes, through:
- Dependabot (automated PRs for updates)
- Renovate (optional, more advanced automation)
- Regular security audits

## Performance

### Is this package lightweight?

Yes:
- Minimal dependencies
- Small package size
- Fast installation
- Efficient Docker images

### What are the system requirements?

**Minimum:**
- Node.js 14+ (for NPM package)
- Bash 4+ (for scripts)
- Python 3.6+ (for Python scripts)

**Recommended:**
- Node.js 20+
- Docker (for containerization)
- Make (for build automation)

## Integration

### Can I use this with GitHub Actions?

Yes! The repository includes several workflow templates you can copy to your repository.

### Can I use this with other CI/CD systems?

Yes, the scripts and tools work independently of GitHub Actions and can be integrated with:
- GitLab CI
- Jenkins
- CircleCI
- Travis CI
- Any CI/CD system that supports Bash/Node.js

### Can I deploy to other registries?

Yes, modify the deployment script or workflows to target:
- Private NPM registries
- Docker registries (Docker Hub, AWS ECR, etc.)
- Other package managers

## Support

### Where can I get help?

1. Check this FAQ
2. Read documentation in `docs/`
3. Search existing issues
4. Open a new issue
5. See [SUPPORT.md](../SUPPORT.md)

### How do I request a feature?

1. Check if it's already requested
2. Use the feature request template
3. Explain the use case
4. Provide examples

### Is there a community chat?

Check the organization's main page for:
- Discussions (if enabled)
- Chat links
- Community resources

## Licensing

### What license is this under?

MIT License - see [LICENSE](../LICENSE) file.

### Can I use this in commercial projects?

Yes, the MIT license allows commercial use.

### Do I need to give attribution?

Attribution is appreciated but not required by the MIT license.

## Updates

### How often is this updated?

- Security updates: As needed
- Dependency updates: Weekly (automated)
- Feature updates: As developed
- Documentation: Ongoing

### How do I stay informed about updates?

- Watch the repository
- Enable notifications
- Check CHANGELOG.md
- Follow releases

### Will updates break my code?

We follow semantic versioning:
- PATCH: Bug fixes (safe)
- MINOR: New features (safe, backward compatible)
- MAJOR: Breaking changes (review before upgrading)

## Additional Resources

- [Installation Guide](INSTALLATION.md)
- [Workflows Documentation](WORKFLOWS.md)
- [Templates Guide](TEMPLATES.md)
- [Guidelines](GUIDELINES.md)
- [API Documentation](API.md)
