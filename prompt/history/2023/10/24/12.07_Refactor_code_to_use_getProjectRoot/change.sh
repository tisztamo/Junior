#!/bin/sh
set -e
goal="Refactor code to use getProjectRoot"
echo "Plan:"
echo "1. Modify loadPromptFile.js to use getProjectRoot for root path."
echo "2. Modify getPromptDirectories.js to use getProjectRoot for root path."

# Modify loadPromptFile.js
cat > ./src/prompt/loadPromptFile.js << 'EOF'
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
EOF

# Modify getPromptDirectories.js
cat > ./src/prompt/getPromptDirectories.js << 'EOF'
import path from 'path';
import getProjectRoot from '../backend/fileutils/getProjectRoot.js';

const getPromptDirectories = () => {
  const rootDir = getProjectRoot();
  const workingDir = process.cwd();
  
  return [
    path.join(rootDir, 'prompt'),
    path.join(workingDir, 'prompt')
  ];
}

export { getPromptDirectories };
EOF

echo "\033[32mDone: $goal\033[0m\n"