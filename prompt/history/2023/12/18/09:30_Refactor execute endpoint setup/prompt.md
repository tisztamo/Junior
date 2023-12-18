You are AI Junior, you code like Donald Knuth.

# Task

Refactor!

Move the execute endpoint setup to the prompt routes


## Project Specifics

- Every js file should *only export a single function or signal*! eg.: in createGitRepo.js: export function createGitRepo ( ....
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs* and Tailwind, edit .jsx files accordingly!

Write concise, self-documenting and idiomatic ES6 code!

# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Avoid using sed. Always heredoc full files.

OS: Debian


Installed tools: npm, jq


Before your solution, write a short, very concise readme about the working set, your task, and most importantly its challanges, if any.


EXAMPLE START
```sh
#!/bin/sh
set -e
goal=[Task description, max 9 words]
echo "Plan:"
echo "1. [...]"

# Always provide the complete contents for the modified files without omitting any parts!
cat > x.js << EOF
  let i = 1
  console.log(\`i: \${i}\`)
EOF
echo "\033[32mDone: $goal\033[0m\n"
```
EXAMPLE END

Before starting, check if you need more files or info to solve the task.

If the task is not clear:

EXAMPLE START
I need more information to solve the task. [Description of the missing info]
EXAMPLE END

Do not edit files not provided in the working set!
If you need more files:

EXAMPLE START
`filepath1` is needed to solve the task but is not in the working set.
EXAMPLE END

# Working set

src/backend/handlers/executeHandler.js:
```
import { executeAndForwardOutput } from '../../execute/executeAndForwardOutput.js';
import { extractCode } from '../../execute/extractCode.js';

async function executeHandler(req, res) {
  let code = req.body.change;

  // Check if code starts with shebang
  if (!code.startsWith("#!")) {
    code = extractCode(code);
  }
  
  await executeAndForwardOutput(code, (code, output) => {
    res.json({ output });
  });
}

export { executeHandler };


```
src/backend/routes/setupRoutes.js:
```
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

```
src/backend/routes/setupPromptRoutes.js:
```
import { generateHandler } from '../handlers/generateHandler.js';
import { servePromptDescriptor } from '../handlers/servePromptDescriptor.js';
import { listTasks } from '../handlers/listTasks.js';
import updateDescriptorHandler from '../handlers/updateDescriptorHandler.js';
import { updateTaskHandler } from '../handlers/updateTaskHandler.js';
import { promptstotryHandler } from '../handlers/promptstotryHandler.js';

export function setupPromptRoutes(app) {
  app.get('/descriptor', servePromptDescriptor);
  app.get('/tasks', listTasks);
  app.post('/generate', generateHandler);
  app.post('/descriptor', updateDescriptorHandler);
  app.post('/updatetask', updateTaskHandler);
  app.get('/promptstotry', promptstotryHandler);
}

```