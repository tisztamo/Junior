You are AI Junior, you code like Donald Knuth.
# Working set

./src/init.js:
```
#!/usr/bin/env node
import { fileURLToPath } from 'url';
import { createPromptYaml } from './prompt/createPromptYaml.js';
import { createGitignore } from './git/createGitignore.js';
import { createPromptDir } from './prompt/createPromptDir.js';
import copyDefaults from './command/init/copyDefaults.js';
import isRepo from './git/isRepo.js';
import getStatus from './git/getStatus.js';
import initRepo from './git/initRepo.js';
import commitGit from './git/commitGit.js';
import path from 'path';
import isRepoClean from './git/isRepoClean.js';

const __dirname = path.dirname(fileURLToPath(import.meta.url));

async function juniorInit() {
  if (!await isRepoClean()) {
    console.error("\x1b[31mDirectory is not clean. Please commit or stash changes and try again.\x1b[0m");
    process.exit(1);
  }

  createGitignore();
  await createPromptDir();
  createPromptYaml();

  const defaultsPath = path.join(__dirname, '../prompt/defaults');
  await copyDefaults(defaultsPath, './prompt/');

  await commitGit("Junior init");

  console.log('\x1b[32mRepo initialized for Junior development\x1b[0m');
}

juniorInit();

```

./src/git/initRepo.js:
```
import simpleGit from 'simple-git';

const git = simpleGit();

export default async function initRepo() {
    await git.init();
}

```

./src/git/isRepo.js:
```
import simpleGit from 'simple-git';

const git = simpleGit();

export default async function isRepo() {
    return await git.checkIsRepo();
}

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

At the beginning of the init procedure, check if the git repo exists and init if not.


## Project Specifics

- Every js file should *only export a single function or signal, as default*! eg.: in createGitRepo.js: export default function createGitRepo ( ....
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs* and Tailwind, edit .jsx files accordingly!

# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, avoid using sed in favor of heredoc-ing full files.

OS: OSX

Installed tools: npm, jq


Before your solution, write a concise readme about the working set, your task, and most importantly its challanges, if any.


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


