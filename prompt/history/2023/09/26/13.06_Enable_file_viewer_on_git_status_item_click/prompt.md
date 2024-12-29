You are AI Junior, you code like Donald Knuth.

# Working set

./src/frontend/components/files/FileViewer.jsx:
```
import SourceFileDisplay from '../files/SourceFileDisplay';

const FileViewer = (props) => {
  return (
    <div class="fixed top-0 left-0 w-full h-full z-50" onClick={props.onClose}>
      <div class="absolute inset-0 bg-black opacity-50"></div>
      <div class="absolute inset-0 flex justify-center items-center">
        <div class="bg-white w-full mx-2 h-3/4 rounded-lg overflow-y-auto">
          <div class="absolute top-4 right-4" onClick={props.onClose}></div>
          <SourceFileDisplay path={props.path} />
        </div>
      </div>
    </div>
  );
};

export default FileViewer;

```
./src/frontend/components/GitStatusDisplay.jsx:
```
import { onCleanup, onMount, createEffect, createSignal } from 'solid-js';
import GitStatusRow from './GitStatusRow';
import { gitStatus } from '../model/gitStatus';
import { fetchGitStatus } from '../service/fetchGitStatus';

const GitStatusDisplay = () => {
  let [statusMessage, setStatusMessage] = createSignal("");
  let [fileList, setFileList] = createSignal([]);

  onMount(async () => {
    try {
      await fetchGitStatus();
    } catch (error) {
      setStatusMessage("Error fetching git status.");
    }
  });

  createEffect(() => {
    const gitStatusValue = gitStatus();
    if (gitStatusValue.error) {
      setStatusMessage(`${gitStatusValue.message}\n${gitStatusValue.error.stderr}`);
    } else if (gitStatusValue.data && gitStatusValue.data.files) {
      setFileList(gitStatusValue.data.files);
    }
  });

  onCleanup(() => {
    // Clean up any listeners or resources tied to this component.
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

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

Click on git status items should open the file viewer with the file.


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

