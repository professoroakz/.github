# .github

All my cool github cool stuff + fixes and reaches everything I own and work on.

## NPM Package

[![npm version](https://img.shields.io/npm/v/@professoroakz/github.svg)](https://www.npmjs.com/package/@professoroakz/github)

This repository is available as an npm package:

```bash
npm install @professoroakz/github
```

### Usage

```javascript
const github = require('@professoroakz/github');

// Get package metadata
const metadata = github.getMetadata();
console.log(metadata.version);

// List profile files
const profileFiles = github.listProfileFiles();

// List settings files
const settingsFiles = github.listSettingsFiles();

// Get path to a specific profile file
const profilePath = github.getProfilePath('README.md');

// Get path to a specific settings file
const settingsPath = github.getSettingsPath('.actions');
```

## License

MIT
