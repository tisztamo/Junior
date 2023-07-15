# Working set

```
./
├── .DS_Store
├── .git/...
├── .gitignore
├── .vscode/...
├── README.md
├── babel.config.js
├── change.sh
├── dist/...
├── doc/...
├── node_modules/...
├── package-lock.json
├── package.json
├── prompt/...
├── prompt.md
├── prompt.yaml
├── secret.sh
├── src/...
├── tmp/...

```
src/backend/listTasks.js:
```
import path from 'path';

import { fileURLToPath } from 'url';
import { dirname } from 'path';

import { readDirRecursively } from './fileutils/readDirRecursively.js';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

export const listTasks = () => {
    const tasksDir = path.join(__dirname, '../../prompt/task');
    return readDirRecursively(tasksDir).map(file => path.relative(tasksDir, file));
};

```


# Task

## Refactor by split

A file is too big. We need to split it into parts.
Identify the possible parts and refactor the code in separate files!

Create backend/fileutils/readDirRecursively.js!



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

