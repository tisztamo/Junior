#!/bin/sh
set -e
goal="Handle missing prompt folder silently"
echo "Plan:"
echo "1. Add a check for existence of directory before trying to read its content."
echo "2. Skip to the next iteration of the loop if directory does not exist."

cat > ./src/prompt/promptDescriptorDefaults.js << 'EOF'
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
    // Check if directory exists before trying to read its content
    if (fs.existsSync(dir)) {
      const files = fs.readdirSync(dir).filter(file => file.endsWith('.md'));
      files.forEach(file => uniqueFiles.add(file));
    }
  }

  // Load only unique files
  for (let file of uniqueFiles) {
    const fileNameWithoutExtension = path.basename(file, '.md');
    promptDescriptorDefaults[fileNameWithoutExtension] = await loadPromptFile(`prompt/${file}`);
  }
  
  return promptDescriptorDefaults;
}

export default promptDescriptorDefaults;
EOF

echo "\033[32mDone: $goal\033[0m\n"
