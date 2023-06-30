You're the 'Contributor', an AI system aiding authors.

You are working on the source of a program, too large for your memory, so only part of it, the "Working Set" is provided here.

You will see a partial directory structure. Ask for the contents of subdirs marked with /... if needed.

Some files are printed in the working set.

Other files are only listed in their dir, so you know they exists, ask for the contents if needed.

# Working set

src/attention/
├── filesystem.js
├── printFolderStructure.js
├── processInterfaceSection.js
├── readAttention.js

src/attention/readAttention.js:
import { processFile } from './filesystem.js';
import { processInterfaceSection } from './processInterfaceSection.js';
import { printFolderStructure } from './printFolderStructure.js';

export const readAttention = async (attentionArray = [], attentionRootDir = '.') => {
  try {
    const processedLines = await Promise.all(attentionArray.map(line => {
      const trimmedLine = line.trim();
      if (trimmedLine.endsWith(' iface')) {
        const filePath = trimmedLine.slice(0, -6).trim();
        return processInterfaceSection(attentionRootDir, filePath);
      } else if (trimmedLine.endsWith('/')) {
        return printFolderStructure(attentionRootDir, trimmedLine.slice(0, -1).trim());
      } else {
        return processFile(attentionRootDir, trimmedLine);
      }
    }));
    return processedLines;
  } catch (error) {
    console.warn(error);
    throw new Error("Error processing attention lines!");
  }
};


src/attention/filesystem.js:
import fs from 'fs'
import path from 'path'
import util from 'util'

const readFile = util.promisify(fs.readFile)

export const processFile = async (root, p) => {
  const fullPath = path.join(root, p)
  try {
    const content = await readFile(fullPath, "utf8")
    return `${p}:\n${content}\n`
  } catch (error) {
    return `${p}: err!\n`
  }
}


src/attention/processInterfaceSection.js:
import fs from 'fs';
import path from 'path';
import util from 'util';

const readFile = util.promisify(fs.readFile);

export async function processInterfaceSection(attentionRootDir, filePath) {
  const fullPath = path.join(attentionRootDir, filePath);
  const fileData = await readFile(fullPath, "utf8");
  const sections = fileData.split("##");
  const interfaceSection = sections.find(section => section.toLowerCase().includes("interface"));

  if (interfaceSection) {
    return `${filePath} iface:\n${interfaceSection.trim().substring(10)}`;
  } else {
    return fileData;
  }
}


src/attention/printFolderStructure.js:
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



# Task

Clean the code by removing unused imports, functions, variables, files, etc!


# Output Format

Provide the new file(s) as code blocks, each prefixed with its path and a colon.
Avoid any explanatory text, as your output will be programmatically processed!

directories are now handled by printing them out. processPath should not process directories, only files, so it may be possible to completely eliminate it.