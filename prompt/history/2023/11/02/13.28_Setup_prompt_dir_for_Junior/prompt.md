You are AI Junior, you code like Donald Knuth.

# Working set

./bin/web.js:
```
#!/usr/bin/env node

import fs from 'fs';
import path from 'path';
import { execSync } from 'child_process';
import getProjectRoot from '../src/backend/fileutils/getProjectRoot.js';

async function main() {
    // Determine the project root based on the getProjectRoot function
    const projectRoot = getProjectRoot();

    // Check for dist/ directory
    const distDir = path.join(projectRoot, 'dist');
    if (!fs.existsSync(distDir)) {
        console.log('Note: dist/ directory does not exist. Running npm run build...');
        execSync('npm run build', { stdio: 'inherit', cwd: projectRoot });
    }

    // Dynamically import startServer from dist/backend/startServer.js
    const { startServer } = await import(path.join(distDir, 'backend/startServer.js'));
    startServer();
}

main();

```
./src/prompt/createPromptYaml.js:
```
import { writeFileSync } from 'fs';

export function createPromptYaml() {
  const yamlContent = `task: prompt/task/feature/implement.md
attention:
  - ./
requirements: |
  1. Create the src/ dir
  2. Create src/main.js with a Hello World in Node.js
  3. Update package.json to enable running it
  4. Print instructions on how to run it`;

  writeFileSync('prompt.yaml', yamlContent);
}

```
./src/git/juniorInit.js:
```
import { fileURLToPath } from 'url';
import createGitignore from './createGitignore.js';
import { createPromptYaml } from '../prompt/createPromptYaml.js';
import { createPromptDir } from '../prompt/createPromptDir.js';
import copyDefaults from '../command/init/copyDefaults.js';
import checkAndInitRepo from './checkAndInitRepo.js';
import commitGit from './commitGit.js';
import path from 'path';
import isRepoClean from './isRepoClean.js';
import getProjectRoot from '../backend/fileutils/getProjectRoot.js';

export async function juniorInit() {
  await checkAndInitRepo();

  if (!await isRepoClean()) {
    console.error("\x1b[31mDirectory is not clean. Please commit or stash changes and try again.\x1b[0m");
    process.exit(1);
  }

  createGitignore();
  await createPromptDir();
  createPromptYaml();

  const projectRoot = getProjectRoot();
  const defaultsPath = path.join(projectRoot, 'prompt/defaults/');
  await copyDefaults(defaultsPath, './prompt/');

  await commitGit("Junior init");

  console.log('\x1b[32mRepo initialized for Junior development\x1b[0m');
}

```

# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

- When the ./prompt/ dir does not exists relative to the current working dir (not the project root), we should log a yellow warning and call juniorInit before starting the server in web.js
- If ./prompt/ exists but ./prompt.yaml does not (also relative to cwd), call createPromptYaml
Put these checks and actions to src/prompt/prepareDirForJunior.js


## Project Specifics

- Every js file should *only export a single function or signal*! eg.: in createGitRepo.js: export function createGitRepo ( ....
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs* and Tailwind, edit .jsx files accordingly!

Write concise, self-documenting and idiomatic ES6 code!

# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, avoid using sed in favor of heredoc-ing full files.

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

