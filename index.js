/**
 * @professoroakz/github
 * 
 * GitHub configuration repository containing profile settings, workflows, and project configurations.
 * 
 * This package exports paths and configuration metadata for the professoroakz GitHub profile.
 */

const path = require('path');
const fs = require('fs');

const packageRoot = __dirname;

/**
 * Get the path to a profile file
 * @param {string} filename - The filename within the profile directory
 * @returns {string} The absolute path to the file
 */
function getProfilePath(filename) {
  return path.join(packageRoot, 'profile', filename);
}

/**
 * Get the path to a settings file
 * @param {string} filename - The filename within the settings directory
 * @returns {string} The absolute path to the file
 */
function getSettingsPath(filename) {
  return path.join(packageRoot, 'settings', filename);
}

/**
 * Get package metadata
 * @returns {Object} Package metadata including version and paths
 */
function getMetadata() {
  return {
    version: require('./package.json').version,
    profilePath: path.join(packageRoot, 'profile'),
    settingsPath: path.join(packageRoot, 'settings'),
    root: packageRoot
  };
}

/**
 * List all files in the profile directory
 * @returns {string[]} Array of filenames in the profile directory
 */
function listProfileFiles() {
  const profileDir = path.join(packageRoot, 'profile');
  if (fs.existsSync(profileDir)) {
    return fs.readdirSync(profileDir);
  }
  return [];
}

/**
 * List all files in the settings directory
 * @returns {string[]} Array of filenames in the settings directory
 */
function listSettingsFiles() {
  const settingsDir = path.join(packageRoot, 'settings');
  if (fs.existsSync(settingsDir)) {
    return fs.readdirSync(settingsDir);
  }
  return [];
}

module.exports = {
  getProfilePath,
  getSettingsPath,
  getMetadata,
  listProfileFiles,
  listSettingsFiles
};
