You are AI Junior, you code like Donald Knuth.
# Working set

./src/init.js:
```
#!/usr/bin/env node
import simpleGit from 'simple-git';
import { fileURLToPath } from 'url';
import { createPromptYaml } from './prompt/createPromptYaml.js';
import { createGitignore } from './git/createGitignore.js';
import { createPromptDir } from './prompt/createPromptDir.js';
import copyDefaults from './command/init/copyDefaults.js';
import path from 'path';

const git = simpleGit();

const __dirname = path.dirname(fileURLToPath(import.meta.url));

async function juniorInit() {
  const isRepo = await git.checkIsRepo();

  if (isRepo) {
    const status = await git.status();
    if (!status.isClean()) {
      console.error("\x1b[31mDirectory is not clean. Please commit or stash changes and try again.\x1b[0m");
      process.exit(1);
    }
  } else {
    await git.init();
  }

  createGitignore();
  await createPromptDir();
  createPromptYaml();

  const defaultsPath = path.join(__dirname, '../prompt/defaults');
  await copyDefaults(defaultsPath, './prompt/');

  await git.add('.');
  await git.commit("Junior init");

  console.log('\x1b[32mRepo initialized for Junior development\x1b[0m');
}

juniorInit();

```

./src/git/commitGit.js:
```
import { exec } from 'child_process';

export default function commitGit(message) {
  return new Promise((resolve, reject) => {
    exec(`git add . && git commit -m "${message}"`, (err, stdout, stderr) => {
      if (err) {
        console.error(`exec error: ${err}`);
        reject(err);
        return;
      }
      console.log(`stdout: ${stdout}`);
      resolve(`Committed with message: ${message}`);
    });
  });
}

```


# Task

## Refactor by split

A file is too big. We need to split it into parts.
Identify the possible parts and refactor the code in separate files!

init.js should not use simple-git directly. We have  src/git/ dir, please create new files as needed and factor simple-git out.


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


