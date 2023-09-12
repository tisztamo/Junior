You are AI Junior, you code like Donald Knuth.
# Working set

./src/backend/handlers/fileListHandler.js:
```
import readFileList from '../fileutils/readFileList.js';

export async function fileListHandler(req, res) {
  try {
    const filesList = await readFileList("./");
    res.json(filesList);
  } catch (error) {
    res.status(500).json({ error: 'Failed to list files' });
  }
}

```

./src/backend/handlers/fileReadHandler.js:
```
import fs from 'fs';
import { promisify } from 'util';

const readFileAsync = promisify(fs.readFile);

export async function fileReadHandler(req, res) {
  const { filepath } = req.params;

  if (!filepath) {
    return res.status(400).send({ error: 'File path is required' });
  }

  try {
    const fileContent = await readFileAsync(filepath, 'utf8');
    res.send(fileContent);
  } catch (error) {
    res.status(500).send({ error: 'Unable to read file' });
  }
}

```

./src/backend/setupRoutes.js:
```
import { setupGitRoutes } from './routes/setupGitRoutes.js';
import { setupPromptRoutes } from './routes/setupPromptRoutes.js';
import { executeHandler } from './handlers/executeHandler.js';
import { configHandler } from './handlers/configHandler.js';
import { fileListHandler } from './handlers/fileListHandler.js';
import { fileReadHandler } from './handlers/fileReadHandler.js';  // Added this line

export function setupRoutes(app) {
  setupPromptRoutes(app);
  setupGitRoutes(app);
  app.post('/execute', executeHandler);
  app.get('/config', configHandler);
  app.get('/files/list/', fileListHandler);
  app.get('/files/read/:filepath', fileReadHandler); // Added this line
}

```


# Task

Refactor!

Move files-prefixed routes to setupFilesRoutes.js
Move the related handlers to handlers/files/ 
Create the dir.


## Project Specifics

- Every js file should *only export a single function or signal*!
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs* and Tailwind, edit .jsx files accordingly!

# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, avoid using sed in favor of heredoc-ing full files.

OS: OSX

Installed tools: npm, jq


Do NOT write any text outside the script!

EXAMPLE START
```sh
#!/bin/sh
set -e
goal=[Task description, max 9 words]
echo "Plan:"
echo "1. [...]"
cat > x.js << 'EOF'
[...]
'EOF'
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


