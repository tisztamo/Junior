You are AI Junior, you code like Donald Knuth.

# Working set

./scripts/web.js:
```
import fs from 'fs';
import { execSync } from 'child_process';
import { startServer } from '../src/backend/startServer.js';

async function main() {
    // Check for dist/ directory
    if (!fs.existsSync('./dist')) {
        console.log('Note: dist/ directory does not exist. Running npm run build...');
        execSync('npm run build', { stdio: 'inherit' });
    }

    // Start the server
    startServer();
}

main();

```

# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

1. In web.js, checking for the dist dir should not be relative to cwd but to the project root
2. When building, run the build from the project  root
3. startServer should be imported dynamically from dist/backend/startServer.js


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

