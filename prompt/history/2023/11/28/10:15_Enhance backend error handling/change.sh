#!/bin/sh
set -e
goal="Enhance backend error handling"
echo "Plan:"
echo "1. Update processItem.js to handle EACCESS error."
echo "2. Update fileListHandler.js to log errors."

# Updating processItem.js
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
    if (error.code === 'EACCES') {
      console.warn(\`Access denied for \${fullPath}. Use --ignore=[directoryname] to exclude.\`);
      return undefined;
    }
    throw error;
  }
}

export default processItem;
EOF

# Updating fileListHandler.js
cat > src/backend/handlers/files/fileListHandler.js << EOF
import readFileList from '../../fileutils/readFileList.js';

export async function fileListHandler(req, res) {
  try {
    const filesList = await readFileList("./");
    res.json(filesList);
  } catch (error) {
    console.warn(\`Error in fileListHandler: \${error.message}\`);
    res.status(500).json({ error: 'Failed to list files' });
  }
}
EOF

echo "\033[32mDone: $goal\033[0m\n"