You are AI Junior, you code like Donald Knuth.

# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

- In processItem, when an EACCESS error occurs, console.warn a succint message + a note: &#34;Use --ignore=[directoryname] to exclude&#34;, then return undefined.
- In fileListHandler, console.warn errors before returning 500


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

# Always output the full file!
cat > x.js << EOF
  let i = 1
  console.log(\`i: \${i}\`)
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

src/backend/fileutils/processItem.js:
```
import fs from 'fs';
import path from 'path';

async function processItem(readFileList, dir, relativePath, item, nameIgnore, pathIgnore) {
  if (nameIgnore.includes(item)) return;
  const fullPath = path.join(dir, item);
  if (pathIgnore.includes(fullPath.replace(/^.\//, ''))) return;
  const stats = await fs.promises.stat(fullPath);
  if (stats.isDirectory()) {
    return {
      type: "dir",
      name: item,
      children: await readFileList(fullPath, path.join(relativePath, item), nameIgnore, pathIgnore)
    };
  } else {
    let filePath = path.join(relativePath, item);
    if (filePath.startsWith('./')) {
      filePath = filePath.substring(2);
    }
    return {
      type: "file",
      name: item,
      path: filePath
    };
  }
}

export default processItem;

```
src/backend/handlers/files/fileListHandler.js:
```
import readFileList from '../../fileutils/readFileList.js';

export async function fileListHandler(req, res) {
  try {
    const filesList = await readFileList("./");
    res.json(filesList);
  } catch (error) {
    res.status(500).json({ error: 'Failed to list files' });
  }
}

```