#!/bin/sh
set -e
goal="Refactor readFileList with external ignore lists"
echo "Plan:"
echo "1. Update processItem to accept ignore lists as parameters"
echo "2. Modify readFileList to retrieve ignore lists once and pass them to processItem"
echo "3. Ensure code adheres to ES6 standards and async/await usage"

# Step 1: Update processItem.js to accept ignore lists as parameters
cat > src/backend/fileutils/processItem.js << 'EOF'
import fs from 'fs';
import path from 'path';

async function processItem(readFileList, dir, relativePath, item, nameIgnore, pathIgnore) {
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
}

export default processItem;
EOF

# Step 2: Modify readFileList.js to pass ignore lists to processItem
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
    if (error.code === 'ENOENT') {
      if (!relativePath) {
        return {
          type: "dir",
          name: ".",
          children: []
        };
      }
      throw error;
    }
    throw error;
  }
}

export default readFileList;
EOF

echo "\033[32mDone: $goal\033[0m\n"