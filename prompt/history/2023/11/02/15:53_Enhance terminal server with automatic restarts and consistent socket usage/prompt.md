You are AI Junior, you code like Donald Knuth.

# Working set

./src/backend/terminal/setupTerminalServer.js:
```
import os from 'os';
import pty from 'node-pty';

const terminals = {};

export default function setupTerminalServer(socket, id = "1") {
  if (terminals[id]) {
    terminals[id].socket.send('\x1b[33mThis terminal was disconnected in favor of another connection. Reload Junior to take it back.\x1b[0m ');
    terminals[id].socket.close();
    console.log(`Reusing terminal for id: ${id}`);

    // Update terminal data event handler to send data to the new socket
    terminals[id].terminal.removeAllListeners('data');
    terminals[id].terminal.on('data', (data) => {
      socket.send(data);
    });

    // Send notice to the newly connected socket after a short delay and reset color after dollar sign
    setTimeout(() => {
      socket.send('\x1b[33mTerminal is reused, history is not copied.  \x1b[0m\x1b[33munknown shell $ \x1b[0m');
    }, 100);
  } else {
    const defaultShell = process.env.SHELL || '/bin/sh';
    const shell = os.platform() === 'win32' ? 'powershell.exe' : defaultShell;
    const terminal = pty.spawn(shell, [], {
      name: 'xterm-color',
      env: process.env,
    });

    terminal.on('data', (data) => {
      socket.send(data);
    });

    terminal.on('exit', () => {
      socket.close();
      delete terminals[id];
    });

    terminals[id] = { terminal, socket };
    console.log(`Created new terminal for id: ${id}`);
  }

  socket.on('message', (data) => {
    const parsedData = JSON.parse(data);

    if (parsedData.type === 'resize') {
      terminals[id].terminal.resize(parsedData.cols, parsedData.rows);
    } else if (parsedData.type === 'input') {
      terminals[id].terminal.write(parsedData.data);
    }
  });

  // Update the socket reference in the terminals dictionary
  terminals[id].socket = socket;
}

```

# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

- Restart the shell after exit and update the dict
- At every send and close: get the socket from the dict, not from the argument.


## Project Specifics

- Every js file should *only export a single function or signal*! eg.: in createGitRepo.js: export function createGitRepo ( ....
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs* and Tailwind, edit .jsx files accordingly!

Write concise, self-documenting and idiomatic ES6 code!

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

