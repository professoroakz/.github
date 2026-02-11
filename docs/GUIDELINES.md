# Guidelines for professoroakz Repositories

General guidelines that apply to all repositories under the professoroakz organization.

## Code of Conduct

All repositories follow the Contributor Covenant Code of Conduct. See
[CODE_OF_CONDUCT.md](../CODE_OF_CONDUCT.md).

Key principles:

- Be respectful and inclusive
- Welcome newcomers
- Accept constructive criticism
- Focus on what's best for the community

## Contributing

See [CONTRIBUTING.md](../CONTRIBUTING.md) for detailed contribution guidelines.

## Security

Report security vulnerabilities privately. See [SECURITY.md](../SECURITY.md).

## Git Workflow

### Branch Naming

Use descriptive branch names with prefixes:

- `feat/` - New features
- `fix/` - Bug fixes
- `docs/` - Documentation changes
- `chore/` - Maintenance tasks
- `refactor/` - Code refactoring
- `test/` - Test additions or changes

Examples:

- `feat/add-user-authentication`
- `fix/resolve-memory-leak`
- `docs/update-installation-guide`

### Commit Messages

Follow conventional commits format:

```
<type>(<scope>): <subject>

<body>

<footer>
```

**Types**:

- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation
- `style`: Formatting
- `refactor`: Code restructuring
- `test`: Tests
- `chore`: Maintenance

**Examples**:

```
feat(auth): add OAuth2 support

Implement OAuth2 authentication flow using passport.js

Closes #123
```

```
fix(api): resolve timeout issue in user endpoint

Increased timeout from 5s to 30s for slow connections

Fixes #456
```

### Pull Requests

1. Create an issue first for non-trivial changes
2. Fork or create a branch
3. Make focused changes
4. Write tests
5. Update documentation
6. Submit PR with template filled
7. Address review feedback
8. Wait for approval
9. Squash and merge

## Code Quality

### Style Guidelines

- Follow existing code style
- Use linters and formatters
- Keep functions small and focused
- Write self-documenting code
- Add comments for complex logic

### Testing

- Write tests for new features
- Maintain test coverage
- Test edge cases
- Run tests before committing

### Documentation

- Update README for user-facing changes
- Document APIs and interfaces
- Include code examples
- Keep docs in sync with code

## File Organization

```
repository/
├── .github/           # GitHub configuration
│   ├── ISSUE_TEMPLATE/
│   ├── workflows/
│   ├── CODEOWNERS
│   ├── FUNDING.yml
│   └── pull_request_template.md
├── docs/              # Documentation
├── src/               # Source code
├── test/              # Tests
├── bin/               # Executable scripts
├── .editorconfig      # Editor configuration
├── .gitignore         # Git ignore rules
├── README.md          # Project overview
├── LICENSE            # License file
├── CHANGELOG.md       # Version history
├── CONTRIBUTING.md    # Contribution guide
└── package.json       # Dependencies (if applicable)
```

## Versioning

Use Semantic Versioning (SemVer):

- **Major** (X.0.0): Breaking changes
- **Minor** (0.X.0): New features (backward compatible)
- **Patch** (0.0.X): Bug fixes

## Releases

1. Update CHANGELOG.md
2. Bump version in relevant files
3. Create git tag
4. Push tag to GitHub
5. Create GitHub release
6. Publish to package registries (if applicable)

## Dependencies

- Keep dependencies minimal
- Use specific versions
- Update regularly
- Check for security vulnerabilities
- Document why each dependency is needed

## Continuous Integration

- All PRs must pass CI checks
- Tests must pass
- Linting must pass
- No decrease in code coverage
- Build must succeed

## Review Process

- At least one approval required
- Address all review comments
- Resolve all conversations
- No force-pushing after review starts
- Squash commits before merging

## Communication

- Be clear and concise
- Provide context
- Link to relevant issues/PRs
- Use templates
- Be patient and respectful

## License

All repositories should include a LICENSE file. MIT License is preferred for open source projects.

## Accessibility

- Write inclusive documentation
- Use clear language
- Provide alternative text for images
- Ensure tools work with assistive technologies

## Internationalization

- Use English for code and primary docs
- Support i18n where appropriate
- Accept translations via PRs
- Use Unicode (UTF-8)

## Performance

- Optimize for common use cases
- Profile before optimizing
- Document performance characteristics
- Include benchmarks for critical paths

## Privacy

- Never commit secrets or credentials
- Use environment variables
- Follow GDPR/privacy guidelines
- Document data handling

## Support

See [SUPPORT.md](../SUPPORT.md) for getting help.

## Updates to Guidelines

These guidelines may evolve. Check back periodically for updates.

Last updated: 2026-02-11
