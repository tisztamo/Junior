You are AI Junior, you code like Donald Knuth.

# Task

Refactor!

- Modify listTasks to be used directly as a handler (async, with args req, res), and deduplicate the task list before returning from it.
- Make readDirRecursively async



## Project Specifics

- Every js file should *only export a single function or signal*! eg.: in createGitRepo.js: export function createGitRepo ( ....
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs* and Tailwind, edit .jsx files accordingly!

Write concise, self-documenting and idiomatic ES6 code!

# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Avoid using sed. Always heredoc full files.

OS: OSX

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

src/backend/handlers/listTasks.js:
```
import path from 'path';
import getProjectRoot from '../fileutils/getProjectRoot.js';
import { readDirRecursively } from '../fileutils/readDirRecursively.js';

export const listTasks = () => {
    const projectRoot = getProjectRoot();
    const tasksDirRoot = path.join(projectRoot, 'prompt/task');
    let tasksFromRoot = [];

    try {
        tasksFromRoot = readDirRecursively(tasksDirRoot).map(file => path.relative(tasksDirRoot, file));
    } catch (error) {
        // Ignore error and use empty list for tasksFromRoot
    }

    const cwd = process.cwd();
    const tasksDirCwd = path.join(cwd, 'prompt/task');
    const tasksFromCwd = readDirRecursively(tasksDirCwd).map(file => path.relative(tasksDirCwd, file));

    return tasksFromCwd.concat(tasksFromRoot);
};

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
  app.get('/tasks', (req, res) => res.json({ tasks: listTasks() }));
  app.post('/generate', generateHandler);
  app.post('/descriptor', updateDescriptorHandler);
  app.post('/updatetask', updateTaskHandler);
  app.get('/promptstotry', promptstotryHandler);
}

```
src/backend/fileutils/readDirRecursively.js:
```
import fs from 'fs';
import path from 'path';

export const readDirRecursively = (dir) => {
    const files = [];

    fs.readdirSync(dir).forEach(file => {
        const filePath = path.join(dir, file);

        if (fs.statSync(filePath).isDirectory()) {
            files.push(...readDirRecursively(filePath));
        } else {
            files.push(filePath);
        }
    });

    return files;
};

```