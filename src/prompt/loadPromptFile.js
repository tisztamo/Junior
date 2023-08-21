import fs from 'fs';
import path from 'path';
import ejs from 'ejs';
import { fileURLToPath } from 'url';
import ejsConfig from './ejsConfig.js';

const __dirname = path.dirname(fileURLToPath(import.meta.url));

const loadPromptFile = async (filePath, templateVars) => {
  try {
    // Try to read the file relative to the current directory
    return await ejs.renderFile(filePath, templateVars, ejsConfig);
  } catch (err) {
    // If the file doesn't exist, try reading it from the project root directory
    const rootPath = path.resolve(__dirname, '../../', filePath);
    return await ejs.renderFile(rootPath, templateVars, ejsConfig);
  }
};

export { loadPromptFile };
