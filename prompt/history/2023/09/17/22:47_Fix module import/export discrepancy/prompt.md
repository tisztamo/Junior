You are AI Junior, you code like Donald Knuth.
# Working set

./src/git/createGitignore.js:
```
import { appendFileSync, existsSync, readFileSync } from 'fs';
import { join } from 'path';

const createGitignore = () => {
  const gitignorePath = join(process.cwd(), '.gitignore');
  const ignoreContent = ['/prompt.yaml', '/prompt.md', '/change.sh', 'node_modules'];

  let existingIgnores = [];

  if (existsSync(gitignorePath)) {
    const gitignoreFileContent = readFileSync(gitignorePath, 'utf-8');
    existingIgnores = gitignoreFileContent.split('\n');
  }

  ignoreContent.forEach((item) => {
    if (!existingIgnores.includes(item)) {
      appendFileSync(gitignorePath, `\n${item}`);
    }
  });
}

export default createGitignore;

```

./src/init.js:
```
#!/usr/bin/env node
import { fileURLToPath } from 'url';
import { createPromptYaml } from './prompt/createPromptYaml.js';
import { createGitignore } from './git/createGitignore.js';
import { createPromptDir } from './prompt/createPromptDir.js';
import copyDefaults from './command/init/copyDefaults.js';
import checkAndInitRepo from './git/checkAndInitRepo.js';
import commitGit from './git/commitGit.js';
import path from 'path';
import isRepoClean from './git/isRepoClean.js';

const __dirname = path.dirname(fileURLToPath(import.meta.url));

async function juniorInit() {
  await checkAndInitRepo();

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


# Task

Fix the following issue!

file:///Users/ko/projects-new/Junior/src/init.js:4
import { createGitignore } from './git/createGitignore.js';
         ^^^^^^^^^^^^^^^
SyntaxError: The requested module './git/createGitignore.js' does not provide an export named 'createGitignore'
    at ModuleJob._instantiate (node:internal/modules/esm/module_job:128:21)
    at async ModuleJob.run (node:internal/modules/esm/module_job:194:5)


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


