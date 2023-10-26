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
./bin/web.js:
```
#!/usr/bin/env node

import fs from 'fs';
import { execSync } from 'child_process';
import path from 'path';

async function main() {
    // Determine the project root based on the current script location using import.meta
    const scriptDir = path.dirname(import.meta.url).replace('file://', '');
    const projectRoot = path.join(scriptDir, '..');

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

# Task

Fix the following issue!

Use getprojectroot in web.js


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

