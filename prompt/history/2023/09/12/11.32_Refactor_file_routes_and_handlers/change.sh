#!/bin/sh
set -e
goal="Refactor file routes and handlers"
echo "Plan:"
echo "1. Create handlers/files directory"
echo "2. Move and refactor files-related handlers to handlers/files/"
echo "3. Create setupFilesRoutes.js to house files routes"
echo "4. Update setupRoutes.js to import setupFilesRoutes.js"
echo "5. Verify refactoring by listing changes"

# Step 1: Create handlers/files directory
mkdir -p ./src/backend/handlers/files

# Step 2: Move and refactor files-related handlers to handlers/files/
mv ./src/backend/handlers/fileListHandler.js ./src/backend/handlers/files/fileListHandler.js
mv ./src/backend/handlers/fileReadHandler.js ./src/backend/handlers/files/fileReadHandler.js

# Adjust imports in the moved files
cat > ./src/backend/handlers/files/fileListHandler.js << 'EOF'
import readFileList from '../../fileutils/readFileList.js';

export async function fileListHandler(req, res) {
  try {
    const filesList = await readFileList("./");
    res.json(filesList);
  } catch (error) {
    res.status(500).json({ error: 'Failed to list files' });
  }
}
EOF

cat > ./src/backend/handlers/files/fileReadHandler.js << 'EOF'
import fs from 'fs';
import { promisify } from 'util';

const readFileAsync = promisify(fs.readFile);

export async function fileReadHandler(req, res) {
  const { filepath } = req.params;

  if (!filepath) {
    return res.status(400).send({ error: 'File path is required' });
  }

  try {
    const fileContent = await readFileAsync(filepath, 'utf8');
    res.send(fileContent);
  } catch (error) {
    res.status(500).send({ error: 'Unable to read file' });
  }
}
EOF

# Step 3: Create setupFilesRoutes.js
cat > ./src/backend/routes/setupFilesRoutes.js << 'EOF'
import { fileListHandler } from '../handlers/files/fileListHandler.js';
import { fileReadHandler } from '../handlers/files/fileReadHandler.js';

export function setupFilesRoutes(app) {
  app.get('/files/list/', fileListHandler);
  app.get('/files/read/:filepath', fileReadHandler);
}
EOF

# Step 4: Update setupRoutes.js
cat > ./src/backend/setupRoutes.js << 'EOF'
import { setupGitRoutes } from './routes/setupGitRoutes.js';
import { setupPromptRoutes } from './routes/setupPromptRoutes.js';
import { executeHandler } from './handlers/executeHandler.js';
import { configHandler } from './handlers/configHandler.js';
import { setupFilesRoutes } from './routes/setupFilesRoutes.js';  // Added this line

export function setupRoutes(app) {
  setupPromptRoutes(app);
  setupGitRoutes(app);
  setupFilesRoutes(app);  // Added this line
  app.post('/execute', executeHandler);
  app.get('/config', configHandler);
}
EOF

# Step 5: List changes to verify refactoring
echo "\nChanges made:"
echo "- Created handlers/files directory"
echo "- Moved files-related handlers to handlers/files/ and adjusted imports"
echo "- Created setupFilesRoutes.js for files routes"
echo "- Updated setupRoutes.js to import and use setupFilesRoutes.js"

echo "\033[32mDone: $goal\033[0m\n"