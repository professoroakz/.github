# Contributing to professoroakz/.github

Thank you for your interest in contributing to this project! This document provides guidelines and instructions for contributing.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [How to Contribute](#how-to-contribute)
- [Development Setup](#development-setup)
- [Coding Standards](#coding-standards)
- [Commit Guidelines](#commit-guidelines)
- [Pull Request Process](#pull-request-process)
- [Reporting Bugs](#reporting-bugs)
- [Suggesting Enhancements](#suggesting-enhancements)

## Code of Conduct

This project and everyone participating in it is governed by our Code of Conduct. By participating, you are expected to uphold this code. Please report unacceptable behavior to the project maintainers.

## Getting Started

1. Fork the repository
2. Clone your fork: `git clone https://github.com/YOUR_USERNAME/.github.git`
3. Add upstream remote: `git remote add upstream https://github.com/professoroakz/.github.git`
4. Create a new branch: `git checkout -b feature/your-feature-name`

## How to Contribute

### Development Setup

1. **Install Dependencies**
   ```bash
   npm install
   # or
   make install
   ```

2. **Run Tests**
   ```bash
   npm test
   # or
   make test
   ```

3. **Build the Project**
   ```bash
   make build
   ```

### Types of Contributions

We welcome various types of contributions:

- 🐛 Bug fixes
- ✨ New features
- 📝 Documentation improvements
- 🎨 Code style improvements
- ♻️ Code refactoring
- ✅ Adding tests
- 🔧 Configuration improvements

## Coding Standards

### JavaScript/Node.js

- Use consistent indentation (2 spaces)
- Follow existing code style
- Add comments for complex logic
- Keep functions small and focused

### Documentation

- Use clear, concise language
- Include examples where appropriate
- Update README.md if adding new features
- Keep documentation in sync with code

### File Organization

- Keep related files together
- Use meaningful file and directory names
- Follow existing project structure

## Commit Guidelines

### Commit Message Format

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Types

- **feat**: A new feature
- **fix**: A bug fix
- **docs**: Documentation changes
- **style**: Code style changes (formatting, etc.)
- **refactor**: Code refactoring
- **test**: Adding or updating tests
- **chore**: Maintenance tasks

### Examples

```
feat(workflows): add CodeQL security scanning

Add CodeQL workflow for automated security scanning
of JavaScript code. This helps identify potential
security vulnerabilities early.

Closes #123
```

```
fix(docker): correct healthcheck command

Update Docker healthcheck to properly verify
container health status.
```

## Pull Request Process

1. **Update Documentation**
   - Update README.md with details of changes if needed
   - Update any relevant documentation

2. **Add Tests**
   - Add tests for new features
   - Ensure all tests pass: `make test`

3. **Update Version**
   - Follow semantic versioning (major.minor.patch)
   - Update VERSION file if necessary

4. **Create Pull Request**
   - Use a clear, descriptive title
   - Reference related issues
   - Provide detailed description of changes
   - Include screenshots for UI changes

5. **Code Review**
   - Address review feedback promptly
   - Keep discussions professional and constructive
   - Be open to suggestions

6. **Merge Requirements**
   - All tests must pass
   - At least one approval from maintainers
   - No merge conflicts
   - Documentation is updated

## Reporting Bugs

### Before Submitting a Bug Report

- Check existing issues to avoid duplicates
- Verify the bug in the latest version
- Collect relevant information

### How to Submit a Bug Report

Use the bug report template and include:

- Clear, descriptive title
- Steps to reproduce
- Expected behavior
- Actual behavior
- Environment details (OS, Node version, etc.)
- Screenshots or logs if applicable

### Bug Report Template

```markdown
**Describe the bug**
A clear description of what the bug is.

**To Reproduce**
Steps to reproduce the behavior:
1. Go to '...'
2. Run '...'
3. See error

**Expected behavior**
What you expected to happen.

**Actual behavior**
What actually happened.

**Environment:**
- OS: [e.g., macOS 12.0]
- Node.js: [e.g., 18.0.0]
- npm: [e.g., 8.0.0]
- Version: [e.g., 1.3.37]

**Additional context**
Any other relevant information.
```

## Suggesting Enhancements

### Before Submitting an Enhancement

- Check if the enhancement already exists
- Consider if it fits the project scope
- Think about backward compatibility

### How to Submit an Enhancement

Use the feature request template and include:

- Clear, descriptive title
- Detailed description of the proposed feature
- Use cases and benefits
- Possible implementation approach
- Examples or mockups if applicable

## Development Workflow

1. **Branch Naming**
   - `feature/description` - New features
   - `fix/description` - Bug fixes
   - `docs/description` - Documentation
   - `refactor/description` - Code refactoring

2. **Local Development**
   ```bash
   # Create feature branch
   git checkout -b feature/my-feature
   
   # Make changes
   # ...
   
   # Run tests
   make test
   
   # Commit changes
   git commit -m "feat: add my feature"
   
   # Push to your fork
   git push origin feature/my-feature
   ```

3. **Staying Updated**
   ```bash
   # Fetch upstream changes
   git fetch upstream
   
   # Rebase your branch
   git rebase upstream/main
   ```

## Testing

- Write tests for new features
- Ensure existing tests pass
- Aim for good code coverage
- Test on multiple platforms if possible

## Release Process

(For maintainers only)

1. Update VERSION file
2. Update package.json version
3. Update CHANGELOG.md
4. Create git tag
5. Push tag to trigger release workflows
6. Verify npm and Docker releases

## Getting Help

- Open an issue for bugs or questions
- Check existing documentation
- Review closed issues for similar problems

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

## Recognition

Contributors will be recognized in:
- GitHub contributors page
- Release notes for significant contributions
- Project README (for major contributions)

## Thank You!

Your contributions help make this project better for everyone. We appreciate your time and effort!
