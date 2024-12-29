#!/bin/sh
set -e
goal="Enhance File Handling for Prompts"

echo "Plan:"
echo "1. Modify readFileList.js to handle missing directories."
echo "2. Update promptstotryHandler.js to load prompts from different locations based on availability."

# Modifying readFileList.js
cat > src/backend/fileutils/readFileList.js << 'EOF'
import fs from 'fs';
import path from 'path';
import getIgnoreList from './getIgnoreList.js';

async function readFileList(dir, relativePath = "") {
  try {
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
  } catch (error) {
    if (error.code === 'ENOENT') {
      return [];
    }
    throw error;
  }
}

export default readFileList;
EOF

echo "Updated readFileList.js to handle missing directories."

# Updating promptstotryHandler.js
cat > src/backend/handlers/promptstotryHandler.js << 'EOF'
import readFileList from '../fileutils/readFileList.js';
import fs from 'fs';
import { fileURLToPath } from 'url';
import path from 'path';

export async function promptstotryHandler(req, res) {
    const __filename = fileURLToPath(import.meta.url);
    const __dirname = path.dirname(__filename);
    let dirPath = path.join(process.cwd(), 'prompt');
    let files = await readFileList(dirPath);
    
    if (!files.length) {
      dirPath = path.join(__dirname, '../../../prompt/totry');
      files = await readFileList(dirPath);
    }

    const fileContents = await Promise.all(files.children.map(async file => {
      const content = await fs.promises.readFile(path.join(dirPath, file.name), 'utf8');
      return { name: file.name, content };
    }));
    res.json(fileContents);
}
EOF

echo "Updated promptstotryHandler.js with new prompt loading logic."

echo "\033[32mDone: $goal\033[0m\n"