#!/bin/sh
set -e
goal="Implement the commit endpoint to commit changes"
echo "Plan:"
echo "1. Create commitGit.js under src/git to handle the git commit command."
echo "2. Create commitGitHandler.js under src/backend/handlers to process the request."
echo "3. Update setupRoutes.js to add the new endpoint for committing changes."

# Step 1: Create commitGit.js to handle the git commit command
cat > src/git/commitGit.js << 'EOF'
import { exec } from 'child_process';

export default function commitGit(message) {
  return new Promise((resolve, reject) => {
    exec(`git add . && git commit -m "${message}"`, (err, stdout, stderr) => {
      if (err) {
        console.error(`exec error: ${err}`);
        reject(err);
        return;
      }
      console.log(`stdout: ${stdout}`);
      resolve(`Committed with message: ${message}`);
    });
  });
}
EOF

# Step 2: Create commitGitHandler.js to process the request
cat > src/backend/handlers/commitGitHandler.js << 'EOF'
import commitGit from '../../git/commitGit.js';

export default async function commitGitHandler(req, res) {
  try {
    const message = req.body.message;
    if (!message) {
      res.status(400).send({ message: 'Commit message is required' });
      return;
    }
    await commitGit(message);
    res.status(200).send({ message: `Successfully committed with message: ${message}` });
  } catch (error) {
    res.status(500).send({ message: 'Error in committing changes', error });
  }
}
EOF

# Step 3: Update setupRoutes.js to add the new endpoint for committing changes
cat > src/backend/setupRoutes.js << 'EOF'
import { generateHandler } from './handlers/generateHandler.js';
import { servePromptDescriptor } from './handlers/servePromptDescriptor.js';
import { updateTaskHandler } from './handlers/updateTaskHandler.js';
import { listTasks } from './handlers/listTasks.js';
import { executeHandler } from './handlers/executeHandler.js';
import resetGitHandler from './handlers/resetGitHandler.js';
import gitStatusHandler from './handlers/gitStatusHandler.js';
import commitGitHandler from './handlers/commitGitHandler.js';

export function setupRoutes(app) {
  app.get('/descriptor', servePromptDescriptor);
  app.get('/tasks', (req, res) => res.json({ tasks: listTasks() }));
  app.get('/status', gitStatusHandler);

  app.post('/generate', generateHandler);
  app.post('/updatetask', updateTaskHandler);
  app.post('/execute', executeHandler);
  app.post('/reset', resetGitHandler);
  app.post('/commit', commitGitHandler);
}
EOF

echo "\033[32mDone: $goal\033[0m\n"
