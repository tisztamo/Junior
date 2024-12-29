You are AI Junior, you code like Donald Knuth.

# Working set

./src/frontend/components/DetailsComponent.jsx:
```
import { createSignal, onCleanup, onMount } from 'solid-js';

const DetailsComponent = (props) => {
  const [isOpen, setIsOpen] = createSignal(props.defaultState || 'open');

  // On mount, check local storage and set state accordingly
  onMount(() => {
    const savedState = localStorage.getItem(props.localStorageKey);
    if (savedState) {
      setIsOpen(savedState === 'open');
    }
  });

  // Update local storage whenever isOpen changes
  const updateLocalStorage = () => {
    localStorage.setItem(props.localStorageKey, isOpen() ? 'open' : 'closed');
  };

  const classes = props.classes || "";

  return (
    <details class={classes} open={isOpen()} onToggle={updateLocalStorage}>
      <summary>{props.generateHeader()}</summary>
      {props.children}
    </details>
  );
};

export default DetailsComponent;

```
./src/frontend/components/terminal/TerminalComponent.jsx:
```
import { onCleanup, onMount } from 'solid-js';
import 'xterm/css/xterm.css';
import terminalConnection from '../../service/terminal/terminalConnection';
import { initializeXTerm } from '../../service/terminal/setupXTerm';
import DetailsComponent from '../DetailsComponent';

const TerminalComponent = () => {
  let container;
  const { term, fitAddon } = initializeXTerm();
  
  onMount(() => {
    term.open(container);
    fitAddon.fit();

    terminalConnection.setOnDataReceived((data) => {
      term.write(data);
    });

    term.onData((data) => {
      terminalConnection.sendDataToTerminal(data);
    });
  });
  
  // Ensure terminal instance gets destroyed and WebSocket connection gets closed on component cleanup
  onCleanup(() => {
    term.dispose();
    terminalConnection.closeConnection();
  });

  return (
    <DetailsComponent 
      defaultState="closed"
      localStorageKey="terminalState"
      generateHeader={() => "Terminal"}
      classes="rounded border p-2 w-full"
    >
      <div ref={container}>
        {/* The terminal will be rendered inside this div */}
      </div>
    </DetailsComponent>
  );
};

export default TerminalComponent;

```

# Task

Fix the following issue!

- The detail component fails to save the state on change. Set the signal based on the state of the details tag before saving!
- Set the storage key to "Junior.terminal.isOpen" with values "true" and "false"


## Project Specifics

- Every js file should *only export a single function or signal*! eg.: in createGitRepo.js: export function createGitRepo ( ....
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs* and Tailwind, edit .jsx files accordingly!

# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, avoid using sed in favor of heredoc-ing full files.

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

