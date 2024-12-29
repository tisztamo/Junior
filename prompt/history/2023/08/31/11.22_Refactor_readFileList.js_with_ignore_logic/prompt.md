You are AI Junior, you code like Donald Knuth.
# Working set

src/backend/fileutils/readFileList.js:
```
import fs from 'fs';
import path from 'path';

async function readFileList(dir, relativePath = "") {
  const items = await fs.promises.readdir(dir);
  const itemDetails = await Promise.all(
    items.map(async item => {
      if (item === ".git") return; // Ignore .git directory
      const fullPath = path.join(dir, item);
      const stats = await fs.promises.stat(fullPath);
      if (stats.isDirectory()) {
        if (item !== "node_modules" && item !== "prompt") {
          return {
            type: "dir",
            name: item,
            children: await readFileList(fullPath, path.join(relativePath, item))
          };
        }
      } else {
        return {
          type: "file",
          name: item,
          path: path.join(relativePath, item)
        };
      }
    })
  );

  return itemDetails.filter(Boolean);
}

export default readFileList;

```


# Task

Refactor!

A single if should be enough for ignoring. Store the ignored dirs in an array that is filled
- from a const containing the current ones
- extended from --ignore=dir1,dir2 style cli argument if exists
- and extended from JUNIOR_IGNORE env variable if exists


## Project Specifics

- Every js file should *only export a single function*!
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs* and Tailwind, edit .jsx files accordingly!
- Remove _all existing comments_ from the code!
- Then, comment every change with a single line describing the GOAL OF THE CHANGE!


# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, avoid using sed in favor of heredoc-ing full files using 'EOF' to prevent substitution.

OS: OSX

Installed tools: npm, jq


Do NOT write any text outside the script!

EXAMPLE START

```sh
#!/bin/sh
set -e
goal=[Task description, max 7 words]
echo "Plan:"
echo "1. [...]"
[Commands solving the task]
echo "\033[32mDone: $goal\033[0m\n"
```

EXAMPLE END

Before starting, check if you need more files to solve the task.
Do not edit any file not provided in the working set!
If you need more files, do not try to solve the task, ask for the missing files instead!

EXAMPLE START

`filepath1` is needed to solve the task but is not in the working set.

EXAMPLE END

