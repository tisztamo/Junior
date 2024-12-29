You are AI Junior, you code like Donald Knuth.
# Working set

./src/frontend/components/GitStatusRow.jsx:
```
import getBackgroundColorForFile from './getBackgroundColorForFile';

const GitStatusRow = (props) => {
  const { index, path, working_dir } = props.entry;

  // Split the path to get filename and base directory
  const splitPath = path.split('/');
  const fileName = splitPath.pop();
  const baseDir = splitPath.join('/');

  const bgColor = getBackgroundColorForFile(index, path);
  return (
    <div class={`flex ${bgColor ? 'bg-' + bgColor : ''}`}>
      <span class="w-50px overflow-x-auto">{index + ' ' + working_dir}</span>
      <span class="flex-grow w-60% overflow-x-auto">{fileName}</span>
      <span class="flex-shrink overflow-x-auto">{baseDir}</span>
    </div>
  );
};

export default GitStatusRow;

```

./src/frontend/components/MultiSelect/ListItem.jsx:
```
import { createEffect } from "solid-js";
import useLongTap from "./LongTapDetector";

const ListItem = (props) => {
  let pathRef;
  const uniqueId = `item-${Math.random().toString(36).substr(2, 9)}`;
  const longTapActions = useLongTap(() => props.onLongTap(props.item));

  createEffect(() => {
    if (pathRef) {
      pathRef.scrollLeft = pathRef.scrollWidth;
    }
  });

  const handleClick = () => {
    if (typeof props.onItemClick === 'function') {
      props.onItemClick(props.item, uniqueId);
    }
  };

  const [filename, ...pathParts] = props.item.split('/').reverse();
  const directory = pathParts.reverse().join('/');

  return (
    <div id={uniqueId} onClick={handleClick} {...longTapActions} class="flex justify-between items-center w-full font-mono cursor-pointer">
      <span class="text-base bg-main rounded p-1">{filename}</span>
      <span ref={pathRef} class="overflow-x-auto whitespace-no-wrap break-keep scrollbar-hidden ml-4 py-2 text-sm">{directory}</span>
    </div>
  );
};

export default ListItem;

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

In git status, set styles for filename and dir exactly as in ListItem. The first column should use what it needs and p-1. Do not create new files.


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


