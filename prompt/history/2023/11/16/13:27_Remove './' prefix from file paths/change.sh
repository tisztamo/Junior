#!/bin/sh
set -e
goal="Remove './' prefix from file paths"
echo "Plan:"
echo "1. Modify readFileList to remove './' prefix from paths."
echo "2. Ensure the solution adheres to ES6 standards and project constraints."

# Modifying readFileList.js
cat > src/backend/fileutils/readFileList.js << 'EOF'
import fs from 'fs';
import path from 'path';
import getIgnoreList from './getIgnoreList.js';

async function readFileList(dir, relativePath = "") {
  const items = await fs.promises.readdir(dir);
  const { nameIgnore, pathIgnore } = getIgnoreList();

  const itemDetails = await Promise.all(
    items.map(async item => {
      if (nameIgnore.includes(item)) return;
      const fullPath = path.join(dir, item);
      if (pathIgnore.includes(fullPath.replace(/^.\//, ''))) return;
      const stats = await fs.promises.stat(fullPath);
      if (stats.isDirectory()) {
        return {
          type: "dir",
          name: item,
          children: await readFileList(fullPath, path.join(relativePath, item))
        };
      } else {
        let filePath = path.join(relativePath, item);
        // Remove './' prefix if present
        if (filePath.startsWith('./')) {
          filePath = filePath.substring(2);
        }
        return {
          type: "file",
          name: item,
          path: filePath
        };
      }
    })
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
}

export default readFileList;
EOF

echo "\033[32mDone: $goal\033[0m\n"