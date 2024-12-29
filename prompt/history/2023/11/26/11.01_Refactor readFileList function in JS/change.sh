#!/bin/sh
set -e
goal="Refactor readFileList function in JS"
echo "Plan:"
echo "1. Modify readFileList.js to merge if statements in catch block."
echo "2. Ensure code follows ES6 standards and project specifics."

cat > src/backend/fileutils/readFileList.js << 'EOF'
import fs from 'fs';
import path from 'path';
import processItem from './processItem.js';
import getIgnoreList from './getIgnoreList.js';

async function readFileList(dir, relativePath = "") {
  const { nameIgnore, pathIgnore } = getIgnoreList();
  try {
    const items = await fs.promises.readdir(dir);
    const itemDetails = await Promise.all(
      items.map(item => processItem(readFileList, dir, relativePath, item, nameIgnore, pathIgnore))
    );

    if (!relativePath) {
      return {
        type: "dir",
        name: ".",
        children: itemDetails.filter(Boolean)
      };
    } else {
      return itemDetails.filter(Boolean);
    }
  } catch (error) {
    if (error.code === 'ENOENT' && !relativePath) {
      return {
        type: "dir",
        name: ".",
        children: []
      };
    }
    throw error;
  }
}

export default readFileList;
EOF

echo "\033[32mDone: $goal\033[0m\n"