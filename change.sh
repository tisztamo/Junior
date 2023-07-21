#!/bin/sh
# Goal: Move git to src and create route to resetGit
# Plan:
# 1. Move the git directory to the src directory.
# 2. Update the file paths in resetGit.js to reflect this change.
# 3. In setupRoutes.js, create a new route '/reset' that calls resetGit.
# 4. Create a new file resetGitHandler.js in src/backend/handlers which exports a function that calls resetGit.

mv ./git ./src/git

cat > ./src/git/resetGit.js <<- 'EOF'
import git from 'simple-git';

export default async function resetGit() {
  const gitInstance = git();

  // Stash changes in prompt.yaml
  await gitInstance.add('./src/prompt.yaml');
  await gitInstance.stash();

  // Clean the repository and reset to the latest commit
  await gitInstance.clean('f', ['-d']);
  await gitInstance.reset('hard');

  // Apply stashed changes to prompt.yaml
  await gitInstance.stash(['pop']);
}
EOF

cat > ./src/backend/handlers/resetGitHandler.js <<- 'EOF'
import resetGit from '../../git/resetGit.js';

export default async function resetGitHandler(req, res) {
  try {
    await resetGit();
    res.status(200).send({ message: 'Git successfully reset' });
  } catch (error) {
    res.status(500).send({ message: 'Error in resetting Git', error });
  }
}
EOF

cat > ./src/backend/setupRoutes.js <<- 'EOF'
import { generateHandler } from './handlers/generateHandler.js';
import { servePromptDescriptor } from './handlers/servePromptDescriptor.js';
import { updateTaskHandler } from './handlers/updateTaskHandler.js';
import { listTasks } from './handlers/listTasks.js';
import { executeHandler } from './handlers/executeHandler.js';
import resetGitHandler from './handlers/resetGitHandler.js';

export function setupRoutes(app) {
  app.get('/descriptor', servePromptDescriptor);
  app.get('/tasks', (req, res) => res.json({ tasks: listTasks() }));

  app.post('/generate', generateHandler);
  app.post('/updatetask', updateTaskHandler);
  app.post('/execute', executeHandler);
  app.post('/reset', resetGitHandler);
}
EOF
