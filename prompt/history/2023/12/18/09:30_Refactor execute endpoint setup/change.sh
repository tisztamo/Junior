#!/bin/sh
set -e
goal="Refactor execute endpoint setup"
echo "Plan:"
echo "1. Modify 'setupPromptRoutes.js' to include executeHandler."
echo "2. Remove executeHandler import and setup from 'setupRoutes.js'."

# Refactoring 'setupPromptRoutes.js' to include executeHandler
cat > src/backend/routes/setupPromptRoutes.js << EOF
import { generateHandler } from '../handlers/generateHandler.js';
import { servePromptDescriptor } from '../handlers/servePromptDescriptor.js';
import { listTasks } from '../handlers/listTasks.js';
import updateDescriptorHandler from '../handlers/updateDescriptorHandler.js';
import { updateTaskHandler } from '../handlers/updateTaskHandler.js';
import { promptstotryHandler } from '../handlers/promptstotryHandler.js';
import { executeHandler } from '../handlers/executeHandler.js';  // Added line

export function setupPromptRoutes(app) {
  app.get('/descriptor', servePromptDescriptor);
  app.get('/tasks', listTasks);
  app.post('/generate', generateHandler);
  app.post('/descriptor', updateDescriptorHandler);
  app.post('/updatetask', updateTaskHandler);
  app.get('/promptstotry', promptstotryHandler);
  app.post('/execute', executeHandler);  // Added line
}
EOF

# Updating 'setupRoutes.js' to remove executeHandler setup
cat > src/backend/routes/setupRoutes.js << EOF
import { setupGitRoutes } from './setupGitRoutes.js';
import { setupPromptRoutes } from './setupPromptRoutes.js';
import { configHandler } from '../handlers/configHandler.js';
import { setupFilesRoutes } from './setupFilesRoutes.js';
import { setupStaticRoutes } from './setupStaticRoutes.js';

export function setupRoutes(app) {
  setupPromptRoutes(app);
  setupGitRoutes(app);
  setupFilesRoutes(app);
  app.get('/config', configHandler);
  setupStaticRoutes(app);
}
EOF

echo "\033[32mDone: $goal\033[0m\n"