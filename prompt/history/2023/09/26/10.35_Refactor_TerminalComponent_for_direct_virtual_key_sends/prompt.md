You are AI Junior, you code like Donald Knuth.

# Working set

./src/frontend/components/terminal/TerminalComponent.jsx:
```
import { onCleanup, onMount } from 'solid-js';
import 'xterm/css/xterm.css';
import terminalConnection from '../../service/terminal/terminalConnection';
import { setupXTerm } from '../../service/terminal/setupXTerm';
import { sendTerminalResizeNotification } from '../../service/terminal/sendTerminalResizeNotification';
import DetailsComponent from '../DetailsComponent';
import VirtualButton from './VirtualButton';

const TerminalComponent = () => {
  let container;
  const { term, fitAddon } = setupXTerm();
  
  const sendVirtualKey = (key) => {
    term.write(key);
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
      localStorageKey="terminalState"
      generateHeader={() => "Terminal"}
      classes="rounded border p-2 w-full border-border bg-emphasize"
    >
      <div class="flex overflow-x-auto whitespace-nowrap">
        <VirtualButton label="Esc" action={() => sendVirtualKey('\x1B')} />
        <VirtualButton label="-" action={() => sendVirtualKey('-')} />
        <VirtualButton label=":" action={() => sendVirtualKey(':')} />
        <VirtualButton label="Ctrl-Z" action={() => sendVirtualKey('\x1A')} />
        <VirtualButton label="Ctrl-Y" action={() => sendVirtualKey('\x19')} />
        <VirtualButton label="Ctrl-X" action={() => sendVirtualKey('\x18')} />
        <VirtualButton label="Ctrl-V" action={() => sendVirtualKey('\x16')} />
        <VirtualButton label="F1" action={() => sendVirtualKey('\x1BOP')} />
        <VirtualButton label="F5" action={() => sendVirtualKey('\x1B[15~')} />
        <VirtualButton label="F6" action={() => sendVirtualKey('\x1B[17~')} />
        <VirtualButton label="F7" action={() => sendVirtualKey('\x1B[18~')} />
      </div>
      <div ref={container}>
        {/* The terminal will be rendered inside this div */}
      </div>
    </DetailsComponent>
  );
};

export default TerminalComponent;

```
./src/frontend/components/terminal/VirtualButton.jsx:
```
import { createSignal } from 'solid-js';

const VirtualButton = (props) => {
  const sendKey = () => {
    if (props.action) {
      props.action();
    }
  };

  return (
    <button
      className="m-1 bg-main hover:bg-blue-700 text-white font-bold py-1 px-2 rounded"
      onClick={sendKey}
    >
      {props.label}
    </button>
  );
};

export default VirtualButton;

```

# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

1. The terminal component should send virtual key  codes to the terminal connection, not to xterm.js.
2. Add text-text class to the virtual buttons


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

