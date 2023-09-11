You are AI Junior, you code like Donald Knuth.
# Working set

```
./
├── .git/...
├── .github/...
├── .gitignore
├── .vscode/...
├── LICENSE.txt
├── README.md
├── change.sh
├── cypress/...
├── cypress.config.js
├── docs/...
├── integrations/...
├── node_modules/...
├── package-lock.json
├── package.json
├── prompt/...
├── prompt.md
├── prompt.yaml
├── scripts/...
├── src/...

```
```
src/backend/
├── fileutils/...
├── getServerPort.js
├── handlers/...
├── notifyOnFileChange.js
├── routes/...
├── serverConfig.js
├── setupRoutes.js
├── startServer.js
├── watchPromptDescriptor.js

```
src/backend/setupRoutes.js:
```
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

```

```
src/backend/fileutils/
├── readDirRecursively.js

```
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


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

Create a new endpoint GET files/list/ that lists all files in the
project recursively, like:

{
  "type": "dir",
  "name": "src"
  "children": [
    { 
      "type": "file"
      "name": "main.js"
    }
  ]
}

exclude dirs: node_modules and prompt
Implement the fs-related part in src/backend/fileutils/readFileList.js 



## Project Specifics

- Every js file should *only export a single function*!
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs* and Tailwind, edit .jsx files accordingly!
- Remove _all existing comments_ from the code!
- Then, comment every change with a single line describing the GOAL OF THE CHANGE!


# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, avoid using sed in favor of heredoc-ing full files using 'EOF' to prevent substitution.

OS: OSX

Installed tools: npm, jq


Do NOT write any text outside the script!

EXAMPLE START

```sh
#!/bin/sh
set -e
goal=[Task description, max 7 words]
echo "Plan:"
echo "1. [...]"
[Commands solving the task]
echo "\033[32mDone: $goal\033[0m\n"
```

EXAMPLE END

Before starting, check if you need more files to solve the task.
Do not edit any file not provided in the working set!
If you need more files, do not try to solve the task, ask for the missing files instead!

EXAMPLE START

`filepath1` is needed to solve the task but is not in the working set.

EXAMPLE END

