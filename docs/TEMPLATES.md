# Templates Guide

This document explains the issue and pull request templates available in this repository.

## Issue Templates

Issue templates help standardize bug reports, feature requests, and other contributions.

### Bug Report Template

**File**: `.github/ISSUE_TEMPLATE/bug_report.md`

Use this template when reporting bugs or unexpected behavior.

**Sections**:
- **Description**: Clear description of the bug
- **Steps to reproduce**: Detailed reproduction steps
- **Expected behavior**: What should happen
- **Actual behavior**: What actually happens
- **Environment**: OS, browser, version information
- **Additional context**: Logs, screenshots, etc.

### Feature Request Template

**File**: `.github/ISSUE_TEMPLATE/feature_request.md`

Use this template when suggesting new features or improvements.

**Sections**:
- **Problem**: What problem are you trying to solve?
- **Proposal**: What do you want to happen?
- **Alternatives**: Other approaches considered
- **Additional context**: Links, mockups, examples

### Template Configuration

**File**: `.github/ISSUE_TEMPLATE/config.yml`

Configures issue template behavior:
- Disables blank issues (forces template use)
- Provides contact links for security reports

## Pull Request Template

**File**: `.github/pull_request_template.md`

Used automatically when creating pull requests.

**Sections**:
- **Summary**: Brief description of changes
- **Changes**: Type checkboxes (bug fix, feature, docs, chore)
- **Validation**: How changes were tested
- **Checklist**: Pre-submission verification

## Using Templates

### Creating an Issue

1. Go to the repository's Issues tab
2. Click "New Issue"
3. Select the appropriate template
4. Fill in all sections
5. Submit the issue

### Creating a Pull Request

1. Create a branch and make changes
2. Push to GitHub
3. Open a pull request
4. The template appears automatically
5. Fill in all sections
6. Submit the pull request

## Customizing Templates

### Modifying Existing Templates

1. Edit the template file in `.github/ISSUE_TEMPLATE/` or `.github/`
2. Update frontmatter (YAML between `---` markers)
3. Modify template body
4. Test the template
5. Submit changes via pull request

### Adding New Templates

1. Create a new file in `.github/ISSUE_TEMPLATE/`
2. Add frontmatter with name, about, title, labels
3. Write template body
4. Update `config.yml` if needed
5. Test and submit

**Example**:

```markdown
---
name: Custom Template
about: Description of when to use this template
title: "[PREFIX] "
labels: custom-label
assignees: ''
---

## Section 1
Description...

## Section 2
More details...
```

## Template Best Practices

### For Issue Templates

1. **Be specific**: Ask for concrete information
2. **Use checkboxes**: Make it easy to fill out
3. **Include examples**: Show what good input looks like
4. **Keep it short**: Don't overwhelm contributors
5. **Update regularly**: Refine based on actual usage

### For Pull Request Templates

1. **Require testing info**: Ask how changes were validated
2. **Include checklists**: Remind contributors of requirements
3. **Link to guidelines**: Reference CONTRIBUTING.md
4. **Ask about breaking changes**: Highlight important information
5. **Request related issues**: Connect PRs to issues

## Template Variables

GitHub supports these variables in templates:

- `$BRANCH`: Current branch name
- `$AUTHOR`: Username of issue/PR creator
- `$REPOSITORY`: Repository name
- `$ORGANIZATION`: Organization name

## Conditional Sections

Use HTML comments for optional sections:

```markdown
<!-- Delete this section if not applicable -->
## Optional Section
...
```

## Multi-Language Support

For international projects, consider:
- Creating templates in multiple languages
- Using clear, simple English
- Providing translation guidance

## Resources

- [About issue templates](https://docs.github.com/en/communities/using-templates-to-encourage-useful-issues-and-pull-requests/about-issue-and-pull-request-templates)
- [Configuring issue templates](https://docs.github.com/en/communities/using-templates-to-encourage-useful-issues-and-pull-requests/configuring-issue-templates-for-your-repository)
- [Creating pull request template](https://docs.github.com/en/communities/using-templates-to-encourage-useful-issues-and-pull-requests/creating-a-pull-request-template-for-your-repository)
