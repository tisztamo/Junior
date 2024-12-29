#!/bin/sh
set -e
goal="Return object with root dir object"
echo "Plan:"
echo "1. Adjust the readFileList function to return an object with a root dir object."

# Adjusting the readFileList.js
cat > src/backend/fileutils/readFileList.js << 'EOF'
import fs from 'fs';
import path from 'path';
import getIgnoreList from './getIgnoreList.js';

async function readFileList(dir, relativePath = "") {
  const items = await fs.promises.readdir(dir);
  const ignoreList = getIgnoreList();

  const itemDetails = await Promise.all(
    items.map(async item => {
      if (ignoreList.includes(item)) return;
      const fullPath = path.join(dir, item);
      const stats = await fs.promises.stat(fullPath);
      if (stats.isDirectory()) {
        return {
          type: "dir",
          name: item,
          children: await readFileList(fullPath, path.join(relativePath, item))
        };
      } else {
        return {
          type: "file",
          name: item,
          path: path.join(relativePath, item)
        };
      }
    })
  );

  // GOAL OF THE CHANGE: Return the file list as an object with a root dir object named "."
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
