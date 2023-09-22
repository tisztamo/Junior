You are AI Junior, you code like Donald Knuth.
# Working set

./src/frontend/components/GitStatusDisplay.jsx:
```
import { onMount, createEffect, createSignal } from 'solid-js';
import GitStatusRow from './GitStatusRow';
import { gitStatus } from '../model/gitStatus';
import { fetchGitStatus } from '../service/fetchGitStatus';

const GitStatusDisplay = () => {
  let [statusMessage, setStatusMessage] = createSignal("");
  let [fileList, setFileList] = createSignal([]);

  onMount(async () => {
    try {
      await fetchGitStatus();
      const gitStatusValue = gitStatus();
      if (gitStatusValue.error) {
        setStatusMessage(`${gitStatusValue.message}\n${gitStatusValue.error.stderr}`);
      } else if (gitStatusValue.data && gitStatusValue.data.files) {
        setFileList(gitStatusValue.data.files);
      }
    } catch (error) {
      setStatusMessage("Error fetching git status.");
    }
  });

  return (
    <pre class="rounded overflow-auto max-w-full">
      {statusMessage()}
      {fileList().map(entry => <GitStatusRow key={entry.path} entry={entry} />)}
    </pre>
  );
};

export default GitStatusDisplay;

```

./src/frontend/components/GitStatusRow.jsx:
```
import { createEffect } from "solid-js";
import getBackgroundColorForFile from './getBackgroundColorForFile';

const GitStatusRow = (props) => {
  const { index, path, working_dir } = props.entry;

  // Split the path to get filename and base directory
  const splitPath = path.split('/');
  const fileName = splitPath.pop();
  const baseDir = splitPath.join('/');

  const bgColor = getBackgroundColorForFile(index, path);

  let pathRef; // For scrolling logic

  createEffect(() => { // Incorporate scrolling logic
    if (pathRef) {
      pathRef.scrollLeft = pathRef.scrollWidth;
    }
  });

  // Adjusting styles and incorporating scrolling logic as per ListItem.jsx
  return (
    <div class={`flex ${bgColor ? 'bg-' + bgColor : ''}`}>
      <span class="w-50px overflow-x-auto p-1">{index + ' ' + working_dir}</span>
      <span class="text-base bg-main rounded p-1">{fileName}</span>
      <span ref={pathRef} class="overflow-x-auto whitespace-no-wrap break-keep scrollbar-hidden ml-4 py-2 text-sm">{baseDir}</span>
    </div>
  );
};

export default GitStatusRow;

```


# Task

Fix the following issue!

git status is not reactive


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


