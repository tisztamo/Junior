#!/bin/sh
set -e
goal="Handle filesystem-specific errors in loadPromptFile"
echo "Plan:"
echo "1. Modify loadPromptFile.js to correctly identify filesystem-specific errors and handle them."
echo "2. If it's a filesystem error, try loading from project root directory."
echo "3. If it's a non-filesystem error, log to the console and rethrow."

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
EOF

echo "\033[32mDone: $goal\033[0m\n"