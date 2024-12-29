You are AI Junior, you code like Donald Knuth.

# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

- Create dir &#34;./prompt/totry/&#34; 
- Create a route &#34;promptstotry&#34; which reads the list of files and their contents from dir &#34;./prompt/totry/&#34; and returns a flattened array with objects {name, content}
- To read the files, use readFileList, then go through it and read the files.


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
cat > x.js << 'EOF'
[FULL content of the file]
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

src/backend/routes/setupPromptRoutes.js:
```
import { generateHandler } from '../handlers/generateHandler.js';
import { servePromptDescriptor } from '../handlers/servePromptDescriptor.js';
import { listTasks } from '../handlers/listTasks.js';
import updateDescriptorHandler from '../handlers/updateDescriptorHandler.js';
import { updateTaskHandler } from '../handlers/updateTaskHandler.js';

export function setupPromptRoutes(app) {
  app.get('/descriptor', servePromptDescriptor);
  app.get('/tasks', (req, res) => res.json({ tasks: listTasks() }));
  app.post('/generate', generateHandler);
  app.post('/descriptor', updateDescriptorHandler);
  app.post('/updatetask', updateTaskHandler);
}

```
src/backend/fileutils/readFileList.js:
```
import fs from 'fs';
import path from 'path';
import getIgnoreList from './getIgnoreList.js';

async function readFileList(dir, relativePath = "") {
  const items = await fs.promises.readdir(dir);
  const { nameIgnore, pathIgnore } = getIgnoreList();

  const itemDetails = await Promise.all(
    items.map(async item => {
      if (nameIgnore.includes(item)) return;
      const fullPath = path.join(dir, item);
      if (pathIgnore.includes(fullPath.replace(/^.\//, ''))) return;
      const stats = await fs.promises.stat(fullPath);
      if (stats.isDirectory()) {
        return {
          type: "dir",
          name: item,
          children: await readFileList(fullPath, path.join(relativePath, item))
        };
      } else {
        let filePath = path.join(relativePath, item);
        // Remove './' prefix if present
        if (filePath.startsWith('./')) {
          filePath = filePath.substring(2);
        }
        return {
          type: "file",
          name: item,
          path: filePath
        };
      }
    })
  );

  if (!relativePath) {
    return {
      type: "dir",
      name: ".",
      children: itemDetails.filter(Boolean)
    };
  } else {
    return itemDetails.filter(Boolean);
  }
}

export default readFileList;

```