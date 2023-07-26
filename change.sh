#!/bin/sh
set -e
goal="Implement git status endpoint"
echo "Plan:"
echo "1. Create a new handler gitStatusHandler.js to process the endpoint requests."
echo "2. Implement a new function gitStatus.js to execute git status command."
echo "3. Update setupRoutes.js to include the new endpoint '/status'."

# Step 1: Create gitStatusHandler.js
cat > src/backend/handlers/gitStatusHandler.js << 'EOF'
import gitStatus from '../../git/gitStatus.js';

export default async function gitStatusHandler(req, res) {
  try {
    const status = await gitStatus();
    res.status(200).send({ status });
  } catch (error) {
    res.status(500).send({ message: 'Error in getting Git status', error });
  }
}
EOF

# Step 2: Create gitStatus.js
cat > src/git/gitStatus.js << 'EOF'
import { promisify } from 'util';
import { exec } from 'child_process';

const execAsync = promisify(exec);

export default async function gitStatus() {
  try {
    const { stdout, stderr } = await execAsync('git status');
    return stdout;
  } catch (error) {
    console.error(`exec error: ${error}`);
    throw error;
  }
}
EOF

# Step 3: Update setupRoutes.js to include new endpoint
cat > src/backend/setupRoutes.js << 'EOF'
import { generateHandler } from './handlers/generateHandler.js';
import { servePromptDescriptor } from './handlers/servePromptDescriptor.js';
import { updateTaskHandler } from './handlers/updateTaskHandler.js';
import { listTasks } from './handlers/listTasks.js';
import { executeHandler } from './handlers/executeHandler.js';
import resetGitHandler from './handlers/resetGitHandler.js';
import gitStatusHandler from './handlers/gitStatusHandler.js';

export function setupRoutes(app) {
  app.get('/descriptor', servePromptDescriptor);
  app.get('/tasks', (req, res) => res.json({ tasks: listTasks() }));
  app.get('/status', gitStatusHandler);

  app.post('/generate', generateHandler);
  app.post('/updatetask', updateTaskHandler);
  app.post('/execute', executeHandler);
  app.post('/reset', resetGitHandler);
}
EOF

echo "\033[32mDone: $goal\033[0m\n"
