You are AI Junior, you code like Donald Knuth.

# Task

Refactor!

Instead of __dirname and dotdots use  getProjectRoot() in the second attempt to load the totry prompts. The correct dir relative to the project root is the same as in the first attempt: prompt/totry (use a const for this). The first attempt should remain relative to cwd.


## Project Specifics

- Every js file should *only export a single function or signal*! eg.: in createGitRepo.js: export function createGitRepo ( ....
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs* and Tailwind, edit .jsx files accordingly!

Write concise, self-documenting and idiomatic ES6 code!

# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Avoid using sed. Always heredoc full files.

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
[FULL content of the file]
EOF
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

# Working set

src/backend/handlers/promptstotryHandler.js:
```
import readFileList from '../fileutils/readFileList.js';
import fs from 'fs';
import { fileURLToPath } from 'url';
import path from 'path';

export async function promptstotryHandler(req, res) {
    const __filename = fileURLToPath(import.meta.url);
    const __dirname = path.dirname(__filename);
    let dirPath = path.join(process.cwd(), 'prompt/totry'); // Corrected directory path
    let files = await readFileList(dirPath);
    
    if (!files.children.length) { // Corrected check for empty result
      dirPath = path.join(__dirname, '../../../prompt/totry');
      files = await readFileList(dirPath);
    }

    const fileContents = await Promise.all(files.children.map(async file => {
      const content = await fs.promises.readFile(path.join(dirPath, file.name), 'utf8');
      return { name: file.name, content };
    }));
    res.json(fileContents);
}

```
src/backend/fileutils/getProjectRoot.js:
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