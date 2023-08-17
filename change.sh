#!/bin/sh
set -e
goal="Refactor git routes and handlers"
echo "Plan:"
echo "1. Create git folder inside handlers."
echo "2. Move git related handler files to handlers/git/"
echo "3. Update the paths in setupRoutes.js for git related handlers."
echo "4. Update the relative imports in the git handlers."

mkdir -p src/backend/handlers/git

mv src/backend/handlers/gitStatusHandler.js src/backend/handlers/git/gitStatusHandler.js
mv src/backend/handlers/commitGitHandler.js src/backend/handlers/git/commitGitHandler.js
mv src/backend/handlers/resetGitHandler.js src/backend/handlers/git/resetGitHandler.js

cat > src/backend/setupRoutes.js << 'EOF'
import { generateHandler } from './handlers/generateHandler.js';
import { servePromptDescriptor } from './handlers/servePromptDescriptor.js';
import { updateTaskHandler } from './handlers/updateTaskHandler.js';
import { listTasks } from './handlers/listTasks.js';
import { executeHandler } from './handlers/executeHandler.js';
import gitStatusHandler from './handlers/git/gitStatusHandler.js';
import commitGitHandler from './handlers/git/commitGitHandler.js';
import resetGitHandler from './handlers/git/resetGitHandler.js';

export function setupRoutes(app) {
  app.get('/descriptor', servePromptDescriptor);
  app.get('/tasks', (req, res) => res.json({ tasks: listTasks() }));
  app.get('/git/status', gitStatusHandler);
  app.post('/generate', generateHandler);
  app.post('/updatetask', updateTaskHandler);
  app.post('/execute', executeHandler);
  app.post('/git/reset', resetGitHandler);
  app.post('/git/commit', commitGitHandler);
}
EOF

cat > src/backend/handlers/git/gitStatusHandler.js << 'EOF'
import gitStatus from '../../../git/gitStatus.js';

export default async function gitStatusHandler(req, res) {
  try {
    const status = await gitStatus();
    res.status(200).send({ message: status });
  } catch (error) {
    let errorMessage = 'Error in getting Git status';
    if (error.stderr && error.stderr.includes('Not a git repository')) {
      errorMessage = 'Not a git repo. Run \'npx junior-init\' to initialize!';
    }
    res.status(500).send({ message: errorMessage, error });
  }
}
EOF

cat > src/backend/handlers/git/commitGitHandler.js << 'EOF'
import commitGit from '../../../git/commitGit.js';

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

cat > src/backend/handlers/git/resetGitHandler.js << 'EOF'
import resetGit from '../../../git/resetGit.js';

export default async function resetGitHandler(req, res) {
  try {
    await resetGit();
    res.status(200).send({ message: 'Git successfully reset' });
  } catch (error) {
    res.status(500).send({ message: 'Error in resetting Git', error });
  }
}
EOF

echo "\033[32mDone: $goal\033[0m\n"
