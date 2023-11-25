#!/bin/sh
set -e
goal="Implement 'promptstotry' route with ES6-compliant path handling"
echo "Plan:"
echo "1. Create './prompt/totry/' directory"
echo "2. Create a new handler file with directory path handling for 'promptstotry' route"
echo "3. Update 'setupPromptRoutes.js' to use the new handler"

mkdir -p ./prompt/totry/

cat > src/backend/handlers/promptstotryHandler.js << 'EOF'
import readFileList from '../fileutils/readFileList.js';
import fs from 'fs';
import { fileURLToPath } from 'url';
import path from 'path';

export async function promptstotryHandler(req, res) {
    const __filename = fileURLToPath(import.meta.url);
    const __dirname = path.dirname(__filename);
    const dirPath = path.join(__dirname, '../../../prompt/totry');
    const files = await readFileList(dirPath);
    const fileContents = await Promise.all(files.children.map(async file => {
      const content = await fs.promises.readFile(path.join(dirPath, file.name), 'utf8');
      return { name: file.name, content };
    }));
    res.json(fileContents);
}
EOF

cat > src/backend/routes/setupPromptRoutes.js << 'EOF'
import { generateHandler } from '../handlers/generateHandler.js';
import { servePromptDescriptor } from '../handlers/servePromptDescriptor.js';
import { listTasks } from '../handlers/listTasks.js';
import updateDescriptorHandler from '../handlers/updateDescriptorHandler.js';
import { updateTaskHandler } from '../handlers/updateTaskHandler.js';
import { promptstotryHandler } from '../handlers/promptstotryHandler.js';

export function setupPromptRoutes(app) {
  app.get('/descriptor', servePromptDescriptor);
  app.get('/tasks', (req, res) => res.json({ tasks: listTasks() }));
  app.post('/generate', generateHandler);
  app.post('/descriptor', updateDescriptorHandler);
  app.post('/updatetask', updateTaskHandler);
  app.get('/promptstotry', promptstotryHandler);
}
EOF

echo "\033[32mDone: $goal\033[0m\n"
