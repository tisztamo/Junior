You are AI Junior, you code like Donald Knuth.

# Working set

./src/frontend/styles/colors.css:
```
:root {
  --text-color: #1a202c;
  --background-color: #f7fafc;
  --emphasize-color: #16181f;
  --background-emphasize-color: #f2f4f6;
  --border-color: #d1d5db;
  --color-blue: rgb(59, 130, 246);
  --color-orange: rgb(253, 186, 116);
  --color-red: rgb(239, 68, 68);
  --color-green: rgb(34, 197, 94);
}

.dark {
  --text-color: #f7fafc;
  --background-color: #1a202c;
  --emphasize-color: #f2f4f6;
  --background-emphasize-color: #141618;
  --border-color: #4a5568;
}

```
./src/frontend/components/GitStatusDisplay.jsx:
```
import { onCleanup, onMount, createEffect, createSignal } from 'solid-js';
import GitStatusRow from './GitStatusRow';
import FileViewer from './files/FileViewer';
import { gitStatus } from '../model/gitStatus';
import { fetchGitStatus } from '../service/fetchGitStatus';

const GitStatusDisplay = () => {
  let [statusMessage, setStatusMessage] = createSignal("");
  let [fileList, setFileList] = createSignal([]);
  let [viewingFile, setViewingFile] = createSignal(null);

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

  const handleFileClick = (path) => {
    setViewingFile(path);
  };

  const closeFileViewer = () => {
    setViewingFile(null);
  };

  return (
    <div class="max-w-full">
      <pre class="rounded overflow-auto max-w-full">
        {statusMessage()}
        {fileList().map(entry => <GitStatusRow key={entry.path} entry={entry} onClick={handleFileClick} />)}
      </pre>
      {viewingFile() && <FileViewer path={viewingFile()} onClose={closeFileViewer} />}
    </div>
  );
};

export default GitStatusDisplay;

```
./src/frontend/components/terminal/TerminalComponent.jsx:
```
import { onCleanup, onMount } from 'solid-js';
import 'xterm/css/xterm.css';
import terminalConnection from '../../service/terminal/terminalConnection';
import { setupXTerm } from '../../service/terminal/setupXTerm';
import { sendTerminalResizeNotification } from '../../service/terminal/sendTerminalResizeNotification';
import DetailsComponent from '../DetailsComponent';
import VirtualKey from './VirtualKey';
import terminalVirtualKeyBindings from '../../config/terminalVirtualKeyBindings';

const TerminalComponent = () => {
  let container;
  const { term, fitAddon } = setupXTerm();

  const sendVirtualKey = (key) => {
    terminalConnection.sendDataToTerminal(JSON.stringify({ type: 'input', data: key }));
    term.focus();
  };

  onMount(() => {
    term.open(container);
    fitAddon.fit();

    const { rows, cols } = term;
    sendTerminalResizeNotification(rows, cols);

    terminalConnection.setOnDataReceived((data) => {
      term.write(data);
    });

    term.onData((data) => {
      terminalConnection.sendDataToTerminal(JSON.stringify({ type: 'input', data }));
    });

    term.onResize(({ newRows, newCols }) => {
      sendTerminalResizeNotification(newRows, newCols);
    });
  });
  
  onCleanup(() => {
    term.dispose();
    terminalConnection.closeConnection();
  });

  return (
    <DetailsComponent 
      defaultState="closed"
      localStorageKey="Junior.terminal.isOpen"
      generateHeader={() => "Terminal"}
      classes="rounded border p-2 w-full border-border bg-emphasize"
    >
      <div ref={container}></div>
      <div class="flex overflow-x-auto whitespace-nowrap">
        {terminalVirtualKeyBindings().map(({ label, action }) => (
          <VirtualKey label={label} action={() => sendVirtualKey(action)} />
        ))}
      </div>
    </DetailsComponent>
  );
};

export default TerminalComponent;

```

# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

- Use the details component in git status! The terminal is for your reference.
- Storage key: "Junior.gitStatus.isOpen"
- Header: "Directory clean"  text, or "N Files changed" - Remove comments and empty functions



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

