You are AI Junior, you code like Donald Knuth.

# Working set

./src/frontend/components/GitStatusRow.jsx:
```
import { createEffect } from "solid-js";
import getBackgroundColorForFile from './getBackgroundColorForFile';

const GitStatusRow = (props) => {
  const { index, path, working_dir } = props.entry;
  const { onClick } = props;

  const splitPath = path.split('/');
  const fileName = splitPath.pop();
  const baseDir = splitPath.join('/');

  const bgColor = getBackgroundColorForFile(index, path);

  let pathRef;

  createEffect(() => {
    if (pathRef) {
      pathRef.scrollLeft = pathRef.scrollWidth;
    }
  });

  return (
    <div class={`flex ${bgColor ? 'bg-' + bgColor : ''}`} onClick={() => onClick(path)}>
      <span class="w-50px overflow-x-auto p-1">{index + ' ' + working_dir}</span>
      <span class="text-base bg-main rounded p-1">{fileName}</span>
      <span ref={pathRef} class="overflow-x-auto whitespace-no-wrap break-keep scrollbar-hidden ml-4 py-2 text-sm">{baseDir}</span>
    </div>
  );
};

export default GitStatusRow;

```
./src/frontend/components/getBackgroundColorForFile.jsx:
```
export default function getBackgroundColorForFile(index, path) {
  if (index === 'M') { // Modified files
    return 'rgb(34 197 94)';
  } else if (index === 'A' && !path.includes('prompt/history')) { // New files excluding ones with 'prompt/history' in path
    return 'rgb(253 186 116)';
  }
  return ''; // Default no background color
}

```

# Task

Fix the following issue!

In git status, file background color values are rgb, set them as background color styles, not classes in git status
Also rename the file and fn to file getStyleForFileStatus


## Project Specifics

- Every js file should *only export a single function or signal*! eg.: in createGitRepo.js: export function createGitRepo ( ....
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs* and Tailwind, edit .jsx files accordingly!

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

