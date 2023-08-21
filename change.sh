#!/bin/sh
set -e
goal="Fix html encoding in generated prompt"
echo "Plan:"
echo "1. Set up a consistent EJS configuration object"
echo "2. Adjust the loadPromptFile function to use this configuration"

# Step 1: Set up a consistent EJS configuration object

cat <<EOF > src/prompt/ejsConfig.js
const ejsConfig = {
    async: true,
    escape: str => str
};

export default ejsConfig;
EOF

# Step 2: Adjust the loadPromptFile function to use this configuration

cat <<EOF > src/prompt/loadPromptFile.js
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
EOF

echo "\033[32mDone: $goal\033[0m\n"
