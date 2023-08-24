#!/bin/sh
set -e
goal="Implement /config endpoint for cliArgs"
echo "Plan:"
echo "1. Create a handler function for the /config endpoint."
echo "2. Integrate the handler in the setupRoutes file to register the /config endpoint."
echo "3. Use the process.argv array to fetch CLI arguments and return them as cliArgs."

# Step 1: Create a handler function for the /config endpoint
cat > src/backend/handlers/configHandler.js <<EOF
async function configHandler(req, res) {
  // Extract CLI arguments, skipping the first two elements (node path & script name)
  const cliArgs = process.argv.slice(2);
  res.json({ cliArgs });
}

export { configHandler };
EOF

# Step 2: Integrate the handler in the setupRoutes file
cat > src/backend/setupRoutes.js <<EOF
import { setupGitRoutes } from './routes/setupGitRoutes.js';
import { setupPromptRoutes } from './routes/setupPromptRoutes.js';
import { executeHandler } from './handlers/executeHandler.js';
import { configHandler } from './handlers/configHandler.js';

export function setupRoutes(app) {
  setupPromptRoutes(app);
  setupGitRoutes(app);
  app.post('/execute', executeHandler);
  app.get('/config', configHandler);
}
EOF

echo "\033[32mDone: $goal\033[0m\n"