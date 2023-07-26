import { loadPromptFile } from './loadPromptFile.js';
import { getPromptDirectories } from './getPromptDirectories.js';
import fs from 'fs';
import path from 'path';

const promptDescriptorDefaults = async () => {
  let promptDescriptorDefaults = {};
  
  const promptDirs = getPromptDirectories();
  let uniqueFiles = new Set();

  // Store all unique file names
  for(let dir of promptDirs) {
    const files = fs.readdirSync(dir).filter(file => file.endsWith('.md'));
    files.forEach(file => uniqueFiles.add(file));
  }

  // Load only unique files
  for (let file of uniqueFiles) {
    const fileNameWithoutExtension = path.basename(file, '.md');
    promptDescriptorDefaults[fileNameWithoutExtension] = await loadPromptFile(`prompt/${file}`);
  }
  
  return promptDescriptorDefaults;
}

export default promptDescriptorDefaults;
