#!/bin/sh
set -e
goal="Implement /files/read/[filepath] route"
echo "Plan:"
echo "1. Create a handler for reading the file contents."
echo "2. Integrate the handler with the setupRoutes.js file."

# Creating the fileReadHandler
cat > ./src/backend/handlers/fileReadHandler.js << 'EOF'
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

# Integrating the handler into setupRoutes.js
cat > ./src/backend/setupRoutes.js << 'EOF'
import { setupGitRoutes } from './routes/setupGitRoutes.js';
import { setupPromptRoutes } from './routes/setupPromptRoutes.js';
import { executeHandler } from './handlers/executeHandler.js';
import { configHandler } from './handlers/configHandler.js';
import { fileListHandler } from './handlers/fileListHandler.js';
import { fileReadHandler } from './handlers/fileReadHandler.js';  // Added this line

export function setupRoutes(app) {
  setupPromptRoutes(app);
  setupGitRoutes(app);
  app.post('/execute', executeHandler);
  app.get('/config', configHandler);
  app.get('/files/list/', fileListHandler);
  app.get('/files/read/:filepath', fileReadHandler); // Added this line
}
EOF

echo "\033[32mDone: $goal\033[0m\n"