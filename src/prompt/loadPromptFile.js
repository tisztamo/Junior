import fs from 'fs';
import ejs from 'ejs';
import getProjectRoot from '../backend/fileutils/getProjectRoot.js';
import ejsConfig from './ejsConfig.js';

const loadPromptFile = async (filePath, templateVars) => {
  try {
    // Try to read the file relative to the current directory
    return await ejs.renderFile(filePath, templateVars, ejsConfig);
  } catch (err) {
    // If the file doesn't exist, try reading it from the project root directory
    const rootPath = `${getProjectRoot()}/${filePath}`;
    return await ejs.renderFile(rootPath, templateVars, ejsConfig);
  }
};

export { loadPromptFile };
