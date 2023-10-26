You are AI Junior, you code like Donald Knuth.

# Working set

./src/backend/fileutils/getProjectRoot.js:
```
import path from 'path';
import fs from 'fs';

let memoizedRoot = null;

function getProjectRoot() {
    if (memoizedRoot) {
        return memoizedRoot;
    }

    let currentDir = path.dirname(new URL(import.meta.url).pathname);
    
    while (currentDir !== path.parse(currentDir).root) {
        if (fs.existsSync(path.join(currentDir, 'package.json'))) {
            memoizedRoot = currentDir;
            return memoizedRoot;
        }
        currentDir = path.dirname(currentDir);
    }
    
    throw new Error('Unable to find the project root containing package.json');
}

export default getProjectRoot;

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

const __dirname = path.dirname(fileURLToPath(import.meta.url));

export async function juniorInit() {
  await checkAndInitRepo();

  if (!await isRepoClean()) {
    console.error("\x1b[31mDirectory is not clean. Please commit or stash changes and try again.\x1b[0m");
    process.exit(1);
  }

  createGitignore();
  await createPromptDir();
  createPromptYaml();

  const defaultsPath = path.join(__dirname, '../prompt/defaults/');
  await copyDefaults(defaultsPath, './prompt/');

  await commitGit("Junior init");

  console.log('\x1b[32mRepo initialized for Junior development\x1b[0m');
}

```

# Task

Fix the following issue!

Eliminate dirname, use getprojectroot in juniorinit! The correct defaults path is [project root]/prompt/defaults/


## Project Specifics

- Every js file should *only export a single function or signal*! eg.: in createGitRepo.js: export function createGitRepo ( ....
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs* and Tailwind, edit .jsx files accordingly!

Write concise, self-documenting and idiomatic ES6 code!

# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, avoid using sed in favor of heredoc-ing full files.

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

