# Working set

```
./
├── .DS_Store
├── .git/...
├── .gitignore
├── README.md
├── babel.config.js
├── change.sh
├── doc/...
├── git/...
├── integrations/...
├── node_modules/...
├── package-lock.json
├── package.json
├── postcss.config.js
├── prompt/...
├── prompt.md
├── prompt.yaml
├── secret.sh
├── src/...
├── tailwind.config.js

```
src: err!

src/backend: err!

src/backend/setupRoutes.js:
```
import { generateHandler } from './handlers/generateHandler.js';
import { servePromptDescriptor } from './handlers/servePromptDescriptor.js';
import { updateTaskHandler } from './handlers/updateTaskHandler.js';
import { listTasks } from './handlers/listTasks.js';
import { executeHandler } from './handlers/executeHandler.js';

export function setupRoutes(app) {
  app.get('/descriptor', servePromptDescriptor);
  app.get('/tasks', (req, res) => res.json({ tasks: listTasks() }));

  app.post('/generate', generateHandler);
  app.post('/updatetask', updateTaskHandler);
app.post('/execute', executeHandler);
}

```

git/resetGit.js:
```
import git from 'simple-git';

export default async function resetGit() {
  const gitInstance = git();

  // Stash changes in prompt.yaml
  await gitInstance.add('./prompt.yaml');
  await gitInstance.stash();

  // Clean the repository and reset to the latest commit
  await gitInstance.clean('f', ['-d']);
  await gitInstance.reset('hard');

  // Apply stashed changes to prompt.yaml
  await gitInstance.stash(['pop']);
}

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!
- Every js file should only export a single function!
- Use ES6 imports!

Requirements:

Move the git directory to src/ !
Then create a new route that calls resetGit



# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, prefer heredoc-ing full files without substitution.
Assume OSX.
npm and jq are installed.
Do NOT write any text outside the script (the plan goes into it)!


EXAMPLE START

```sh
#!/bin/sh
# Goal: [Task description, max 7 words]
# Plan:
# 1. [...]

[Commands solving the task]
```

EXAMPLE END

