You are AI Junior, you code like Donald Knuth.
# Working set

./src/backend/terminal/setupTerminalServer.js:
```
import os from 'os';
import pty from 'node-pty';

export default function setupTerminalServer(socket) {
  console.log("Setting up terminal server...");

  const defaultShell = process.env.SHELL || '/bin/sh';
  const shell = os.platform() === 'win32' ? 'powershell.exe' : defaultShell;
  const terminal = pty.spawn(shell, [], {
    name: 'xterm-color',
    env: process.env,
  });

  socket.on('message', (data) => {
    console.log("Received message:", data.toString());
    terminal.write(data);
  });

  terminal.on('data', (data) => {
    console.log("Shell output:", data.toString());
    socket.send(data);
  });

  terminal.on('exit', () => {
    console.log("Shell exited");
    socket.close();
  });
}

```

./src/backend/terminal/terminalRoutes.js:
```
import setupTerminalServer from './setupTerminalServer.js';

export default function terminalRoutes(wss) {
  wss.on('connection', (socket) => {
    setupTerminalServer(socket);
  }, { path: '/terminal' });
}

```


# Task

Refactor!

Remove console.logs from terminal backend


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


