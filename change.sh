#!/bin/sh
set -e
goal="Respond with 500 status on file or directory reading error"
echo "Plan:"
echo "1. Modify generateHandler.js to respond with 500 error containing the erroneous path for any exception."
echo "2. Change printFolderStructure.js and processFile.js to include erroneous path in the error message."

# Step 1: Modify generateHandler.js
cat << 'EOF' > src/backend/handlers/generateHandler.js
import processPrompt from '../../prompt/processPrompt.js';

export const generateHandler = async (req, res) => {
  try {
    const { notes, systemPrompt } = req.body;
    const { prompt } = await processPrompt(notes, systemPrompt);
    res.json({ prompt: prompt });
  } catch (error) {
    console.warn(error);
    res.status(500).json({ error: error.message });
  }
};
EOF

# Step 2: Change printFolderStructure.js
cat << 'EOF' > src/attention/printFolderStructure.js
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
    return `\`\`\`\n${structure}\n\`\`\``;
  } catch (error) {
    console.warn(error);
    throw new Error("Error processing directory " + path.join(rootDir, dir) + " : " + error.message);
  }
};
EOF

# Step 3: Change processFile.js
cat << 'EOF' > src/attention/processFile.js
import fs from 'fs'
import path from 'path'
import util from 'util'

const readFile = util.promisify(fs.readFile)

export const processFile = async (root, p) => {
  const fullPath = path.join(root, p)
  try {
    const content = await readFile(fullPath, "utf8")
    return `${p}:\n\`\`\`\n${content}\n\`\`\`\n`
  } catch (error) {
    console.warn(error);
    throw new Error("Error processing file " + fullPath + " : " + error.message);
  }
}
EOF

echo "\033[32mDone: $goal\033[0m\n"
