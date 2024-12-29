You are AI Junior, you code like Donald Knuth.

# Task

Refactor!

Merge the two ifs inside the catch


## Project Specifics

- Every js file should *only export a single function or signal*! eg.: in createGitRepo.js: export function createGitRepo ( ....
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs* and Tailwind, edit .jsx files accordingly!

Write concise, self-documenting and idiomatic ES6 code!

# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Avoid using sed. Always heredoc full files.

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

src/backend/fileutils/readFileList.js:
```
import fs from 'fs';
import path from 'path';
import processItem from './processItem.js';
import getIgnoreList from './getIgnoreList.js';

async function readFileList(dir, relativePath = "") {
  const { nameIgnore, pathIgnore } = getIgnoreList();
  try {
    const items = await fs.promises.readdir(dir);
    const itemDetails = await Promise.all(
      items.map(item => processItem(readFileList, dir, relativePath, item, nameIgnore, pathIgnore))
    );

    if (!relativePath) {
      return {
        type: "dir",
        name: ".",
        children: itemDetails.filter(Boolean)
      };
    } else {
      return itemDetails.filter(Boolean);
    }
  } catch (error) {
    if (error.code === 'ENOENT') {
      if (!relativePath) {
        return {
          type: "dir",
          name: ".",
          children: []
        };
      }
      throw error;
    }
    throw error;
  }
}

export default readFileList;

```