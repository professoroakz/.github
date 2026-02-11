# Security Policy

## Supported Versions

We release patches for security vulnerabilities for the following versions:

| Version | Supported          |
| ------- | ------------------ |
| 1.3.x   | :white_check_mark: |
| < 1.3   | :x:                |

## Reporting a Vulnerability

We take the security of our project seriously. If you believe you have found a security vulnerability, please report it to us as described below.

### Reporting Process

**Please do not report security vulnerabilities through public GitHub issues.**

Instead, please report them via one of the following methods:

1. **GitHub Security Advisories** (Preferred)
   - Go to the [Security tab](https://github.com/professoroakz/.github/security/advisories)
   - Click "Report a vulnerability"
   - Fill out the form with details about the vulnerability

2. **Email**
   - Send an email to the repository owner
   - Include "SECURITY" in the subject line
   - Provide a detailed description of the vulnerability

### What to Include

Please include the following information in your report:

- Type of vulnerability (e.g., SQL injection, XSS, authentication bypass)
- Full paths of source file(s) related to the manifestation of the vulnerability
- The location of the affected source code (tag/branch/commit or direct URL)
- Any special configuration required to reproduce the issue
- Step-by-step instructions to reproduce the issue
- Proof-of-concept or exploit code (if possible)
- Impact of the issue, including how an attacker might exploit it

### Response Timeline

- **Initial Response**: Within 48 hours
- **Status Update**: Within 7 days
- **Fix Timeline**: Depends on severity and complexity

### What to Expect

After you submit a report, we will:

1. Confirm receipt of your vulnerability report
2. Investigate and validate the vulnerability
3. Work on a fix for confirmed vulnerabilities
4. Release a security patch
5. Credit you in the security advisory (unless you prefer to remain anonymous)

## Security Best Practices

When using this package:

1. **Keep Dependencies Updated**: Regularly update to the latest version
2. **Review Configurations**: Ensure all settings files are properly configured
3. **Access Control**: Limit access to sensitive configuration files
4. **Code Review**: Review any custom configurations before deployment
5. **Secrets Management**: Never commit secrets or credentials to the repository

## Security Updates

Security updates will be released as:

- **Critical**: Immediate patch release
- **High**: Patch within 7 days
- **Medium**: Patch within 30 days
- **Low**: Included in next scheduled release

## Disclosure Policy

When we receive a security bug report, we will:

1. Confirm the problem and determine affected versions
2. Audit code to find similar problems
3. Prepare fixes for all supported versions
4. Release new versions as quickly as possible

We aim to disclose vulnerabilities in a coordinated manner with the reporter, typically after a fix is available.

## Comments on This Policy

If you have suggestions on how this process could be improved, please submit a pull request or open an issue.

## Attribution

This security policy is adapted from industry best practices and inspired by other open-source projects.
