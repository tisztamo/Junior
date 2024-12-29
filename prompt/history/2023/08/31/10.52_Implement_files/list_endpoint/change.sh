#!/bin/sh
set -e
goal="Implement files/list endpoint"
echo "Plan:"
echo "1. Implement the function in readFileList.js to recursively list all files and directories excluding node_modules and prompt."
echo "2. Implement the new route GET files/list/ in setupRoutes.js to use the above function."
echo "3. Update necessary handler functions."

# 1. Implement the function in readFileList.js
cat > ./src/backend/fileutils/readFileList.js << 'EOF'
import fs from 'fs';
import path from 'path';

async function readFileList(dir, relativePath = "") {
  const items = await fs.promises.readdir(dir);
  const itemDetails = await Promise.all(
    items.map(async item => {
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

# 2. Implement the new route GET files/list/
cat > ./src/backend/setupRoutes.js << 'EOF'
import { setupGitRoutes } from './routes/setupGitRoutes.js';
import { setupPromptRoutes } from './routes/setupPromptRoutes.js';
import { executeHandler } from './handlers/executeHandler.js';
import { configHandler } from './handlers/configHandler.js';
import readFileList from './fileutils/readFileList.js';

export function setupRoutes(app) {
  setupPromptRoutes(app);
  setupGitRoutes(app);
  app.post('/execute', executeHandler);
  app.get('/config', configHandler);

  app.get('/files/list/', async (req, res) => {
    const filesList = await readFileList("./");
    res.json(filesList);
  });
}
EOF

echo "\033[32mDone: $goal\033[0m\n"