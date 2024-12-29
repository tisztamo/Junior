#!/bin/sh
set -e
goal="Modify error handling in processItem"
echo "Plan:"
echo "1. Update processItem.js to handle errors uniformly."

# Update processItem.js
cat > src/backend/fileutils/processItem.js << EOF
import fs from 'fs';
import path from 'path';

async function processItem(readFileList, dir, relativePath, item, nameIgnore, pathIgnore) {
  try {
    if (nameIgnore.includes(item)) return;
    const fullPath = path.join(dir, item);
    if (pathIgnore.includes(fullPath.replace(/^.\//, ''))) return;
    const stats = await fs.promises.stat(fullPath);
    if (stats.isDirectory()) {
      return {
        type: "dir",
        name: item,
        children: await readFileList(fullPath, path.join(relativePath, item), nameIgnore, pathIgnore)
      };
    } else {
      let filePath = path.join(relativePath, item);
      if (filePath.startsWith('./')) {
        filePath = filePath.substring(2);
      }
      return {
        type: "file",
        name: item,
        path: filePath
      };
    }
  } catch (error) {
    console.warn("Error while creating file list", error);
    return undefined;
  }
}

export default processItem;
EOF
echo "\033[32mDone: $goal\033[0m\n"