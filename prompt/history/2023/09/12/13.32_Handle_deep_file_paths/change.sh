#!/bin/sh
set -e
goal="Handle deep file paths"
echo "Plan:"
echo "1. Modify the file read route to handle deep paths."
echo "2. Adjust fileReadHandler to handle 404 status if file does not exist."

# Step 1: Modify the route in setupFilesRoutes.js to handle deep paths using regex in the route parameter
cat > ./src/backend/routes/setupFilesRoutes.js << 'EOF'
import { fileListHandler } from '../handlers/files/fileListHandler.js';
import { fileReadHandler } from '../handlers/files/fileReadHandler.js';

export function setupFilesRoutes(app) {
  app.get('/files/list/', fileListHandler);
  app.get('/files/read/:filepath(*)', fileReadHandler);  // (*) is used to capture everything including slashes
}
EOF

# Step 2: Update fileReadHandler.js to send a 404 status if the file does not exist
cat > ./src/backend/handlers/files/fileReadHandler.js << 'EOF'
import fs from 'fs';
import { promisify } from 'util';
import { sanitizeAndResolvePath } from '../../fileutils/sanitizeAndResolvePath.js';

const readFileAsync = promisify(fs.readFile);

export async function fileReadHandler(req, res) {
  const { filepath } = req.params;

  if (!filepath) {
    return res.status(400).send({ error: 'File path is required' });
  }

  try {
    const resolvedPath = sanitizeAndResolvePath(filepath);
    if (!fs.existsSync(resolvedPath)) {  // Check if file exists
      return res.status(404).send({ error: 'File not found' });
    }
    const fileContent = await readFileAsync(resolvedPath, 'utf8');
    res.send(fileContent);
  } catch (error) {
    res.status(500).send({ error: 'Unable to read file' });
  }
}
EOF

echo "\033[32mDone: $goal\033[0m\n"