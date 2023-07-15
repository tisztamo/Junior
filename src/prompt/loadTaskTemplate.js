import util from 'util';
import fs from 'fs';
import path from 'path';
import ejs from 'ejs';

const readFile = util.promisify(fs.readFile);

const loadTaskTemplate = async (taskTemplatePath, templateVars) => {
  try {
    // Try to read the file relative to the current directory
    return await ejs.renderFile(taskTemplatePath, templateVars, {async: true});
  } catch (err) {
    // If the file doesn't exist, try reading it from the project root directory
    const rootPath = path.resolve(__dirname, '../../', taskTemplatePath);
    return await ejs.renderFile(rootPath, templateVars, {async: true});
  }
};

export { loadTaskTemplate };

