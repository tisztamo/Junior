#!/bin/sh
set -e
goal="Refactor file list handler"
echo "Plan:"
echo "1. Create a new handler file for the file listing functionality."
echo "2. Move the file list handler function to the new handler file."
echo "3. Add error handling to the new handler."
echo "4. Modify the readFileList function to ignore .git."
echo "5. Update setupRoutes.js to use the new handler."

# Step 1: Create new handler file
cat > ./src/backend/handlers/fileListHandler.js <<EOF
import readFileList from '../fileutils/readFileList.js';

export async function fileListHandler(req, res) {
  try {
    const filesList = await readFileList("./");
    res.json(filesList);
  } catch (error) {
    res.status(500).json({ error: 'Failed to list files' });
  }
}
EOF
# Goal: Created new handler for file listing

# Step 2: Moved handling function to new file
# No change required as the function was moved during file creation.

# Step 3: Error handling added during file creation.

# Step 4: Modify readFileList function to ignore .git
cat > ./src/backend/fileutils/readFileList.js <<EOF
import fs from 'fs';
import path from 'path';

async function readFileList(dir, relativePath = "") {
  const items = await fs.promises.readdir(dir);
  const itemDetails = await Promise.all(
    items.map(async item => {
      if (item === ".git") return; // Ignore .git directory
      const fullPath = path.join(dir, item);
      const stats = await fs.promises.stat(fullPath);
      if (stats.isDirectory()) {
        if (item !== "node_modules" && item !== "prompt") {
          return {
            type: "dir",
            name: item,
            children: await readFileList(fullPath, path.join(relativePath, item))
          };
        }
      } else {
        return {
          type: "file",
          name: item,
          path: path.join(relativePath, item)
        };
      }
    })
  );

  return itemDetails.filter(Boolean);
}

export default readFileList;
EOF
# Goal: Updated readFileList to ignore .git directory

# Step 5: Update setupRoutes.js
cat > ./src/backend/setupRoutes.js <<EOF
import { setupGitRoutes } from './routes/setupGitRoutes.js';
import { setupPromptRoutes } from './routes/setupPromptRoutes.js';
import { executeHandler } from './handlers/executeHandler.js';
import { configHandler } from './handlers/configHandler.js';
import { fileListHandler } from './handlers/fileListHandler.js';

export function setupRoutes(app) {
  setupPromptRoutes(app);
  setupGitRoutes(app);
  app.post('/execute', executeHandler);
  app.get('/config', configHandler);
  app.get('/files/list/', fileListHandler); // Using the new handler function here
}
EOF
# Goal: Updated setupRoutes to use new handler

echo "\033[32mDone: $goal\033[0m\n"