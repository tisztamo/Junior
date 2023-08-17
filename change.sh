#!/bin/sh
set -e
goal="Refactor routes into separate files"
echo "Plan:"
echo "1. Create routes directory."
echo "2. Create setupGitRoutes.js inside routes for git-related routes."
echo "3. Create setupPromptRoutes.js inside routes for prompt-related routes."
echo "4. Refactor the setupRoutes.js to use the separated routes."

# Step 1: Create routes directory.
mkdir -p src/backend/routes

# Step 2: Create setupGitRoutes.js inside routes for git-related routes.
cat > src/backend/routes/setupGitRoutes.js << 'EOF'
import gitStatusHandler from '../handlers/git/gitStatusHandler.js';
import commitGitHandler from '../handlers/git/commitGitHandler.js';
import resetGitHandler from '../handlers/git/resetGitHandler.js';

export function setupGitRoutes(app) {
  app.get('/git/status', gitStatusHandler);
  app.post('/git/reset', resetGitHandler);
  app.post('/git/commit', commitGitHandler);
}
EOF

# Step 3: Create setupPromptRoutes.js inside routes for prompt-related routes.
cat > src/backend/routes/setupPromptRoutes.js << 'EOF'
import { generateHandler } from '../handlers/generateHandler.js';
import { servePromptDescriptor } from '../handlers/servePromptDescriptor.js';
import { listTasks } from '../handlers/listTasks.js';
import updateRequirementsHandler from '../handlers/updateRequirementsHandler.js';
import { updateTaskHandler } from '../handlers/updateTaskHandler.js';

export function setupPromptRoutes(app) {
  app.get('/descriptor', servePromptDescriptor);
  app.get('/tasks', (req, res) => res.json({ tasks: listTasks() }));
  app.post('/generate', generateHandler);
  app.post('/requirements', updateRequirementsHandler);
  app.post('/updatetask', updateTaskHandler);
}
EOF

# Step 4: Refactor the setupRoutes.js to use the separated routes.
cat > src/backend/setupRoutes.js << 'EOF'
import { setupGitRoutes } from './routes/setupGitRoutes.js';
import { setupPromptRoutes } from './routes/setupPromptRoutes.js';
import { executeHandler } from './handlers/executeHandler.js';

export function setupRoutes(app) {
  setupPromptRoutes(app);
  setupGitRoutes(app);
  app.post('/execute', executeHandler);
}
EOF

echo "\033[32mDone: $goal\033[0m\n"
