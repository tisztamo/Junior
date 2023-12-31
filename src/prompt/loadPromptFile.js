import fs from 'fs';
import ejs from 'ejs';
import getProjectRoot from '../backend/fileutils/getProjectRoot.js';
import ejsConfig from './ejsConfig.js';

const loadPromptFile = async (filePath, templateVars) => {
  try {
    // Try to read the file relative to the current directory
    return await ejs.renderFile(filePath, templateVars, ejsConfig);
  } catch (err) {
    if (err.code && ["ENOENT", "EACCES", "EBADF"].includes(err.code)) {
      // If the error is filesystem-related, try reading from the project root directory
      const rootPath = `${getProjectRoot()}/${filePath}`;
      return await ejs.renderFile(rootPath, templateVars, ejsConfig);
    } else {
      // If it's a non-filesystem error, log and rethrow
      console.error("Error rendering file:", err);
      throw err;
    }
  }
};

export { loadPromptFile };
