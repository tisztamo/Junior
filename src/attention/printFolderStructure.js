import fs from 'fs';
import path from 'path';
import util from 'util';

const readdir = util.promisify(fs.readdir);
const stat = util.promisify(fs.stat);

export const printFolderStructure = async (rootDir, dir) => {
  let structure = dir + '/\n';
  try {
    const entries = await readdir(path.join(rootDir, dir));
    for (let i = 0; i < entries.length; i++) {
      const entry = entries[i];
      const entryStat = await stat(path.join(rootDir, dir, entry));
      if (entryStat.isDirectory()) {
        structure += '├── ' + entry + '/...\n';
      } else {
        structure += '├── ' + entry + '\n';
      }
    }
    return structure;
  } catch (error) {
    console.warn(error);
    throw new Error("Error processing directory structure!");
  }
};
