#!/bin/sh
set -e
goal="Setup static routes in a separate file"
echo "Plan:"
echo "1. Create setupStaticRoutes.js in ./src/backend/routes/ to serve static files."
echo "2. Move setupRoutes.js to ./src/backend/routes/."
echo "3. Update startServer.js and other imports accordingly."

# Creating the setupStaticRoutes.js in ./src/backend/routes/
cat > ./src/backend/routes/setupStaticRoutes.js << 'EOF'
import path from 'path';
import express from 'express';

export function setupStaticRoutes(app) {
    const projectRoot = path.resolve(new URL(import.meta.url).pathname, '..', '..', '..');
    const frontendDistPath = path.join(projectRoot, 'dist', 'frontend');
    app.use('/', express.static(frontendDistPath));
}
EOF

# Modifying setupRoutes.js and moving it to ./src/backend/routes/
cat > ./src/backend/routes/setupRoutes.js << 'EOF'
import { setupGitRoutes } from './setupGitRoutes.js';
import { setupPromptRoutes } from './setupPromptRoutes.js';
import { executeHandler } from '../handlers/executeHandler.js';
import { configHandler } from '../handlers/configHandler.js';
import { setupFilesRoutes } from './setupFilesRoutes.js';
import { setupStaticRoutes } from './setupStaticRoutes.js';  // Updated path

export function setupRoutes(app) {
  setupPromptRoutes(app);
  setupGitRoutes(app);
  setupFilesRoutes(app);
  app.post('/execute', executeHandler);
  app.get('/config', configHandler);
  setupStaticRoutes(app);
}
EOF

# Modifying startServer.js
cat > ./src/backend/startServer.js << 'EOF'
import express from 'express';
import cors from 'cors';
import { createServer } from 'http';
import { setupRoutes } from './routes/setupRoutes.js';  // Updated path
import { websocketSetup } from './websocketSetup.js';
import { serverSetup } from './serverSetup.js';

export function startServer() {
  const app = express();

  app.use(cors());
  app.use(express.json());

  const server = createServer(app);

  websocketSetup(server);

  setupRoutes(app);

  serverSetup(server);
}
EOF

echo "\033[32mDone: $goal\033[0m\n"