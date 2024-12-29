You are AI Junior, you code like Donald Knuth.
# Working set

./src/backend/terminal/setupTerminalServer.js:
```
import { spawn } from 'child_process';

export default function setupTerminalServer(socket) {
  const shell = spawn('/bin/sh');

  socket.on('data', (data) => {
    shell.stdin.write(data);
  });

  shell.stdout.on('data', (data) => {
    socket.write(data);
  });

  shell.stderr.on('data', (data) => {
    socket.write(data);
  });

  shell.on('exit', () => {
    socket.end();
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

./src/frontend/service/createWebSocket.js:
```
import { getBaseUrl } from '../getBaseUrl.js';

export const createWebSocket = () => {
  const baseUrl = getBaseUrl();
  const wsUrl = baseUrl.replace(/^http/, 'ws');
  const ws = new WebSocket(wsUrl);
  return ws;
};

```

./src/frontend/service/useWebsocket.js:
```
import { createEffect } from 'solid-js';
import { createWebSocket } from './createWebSocket.js';

export const useWebsocket = (onMessage) => {
  let socket = createWebSocket();

  socket.onopen = () => console.log('WebSocket is connected');
  socket.onmessage = onMessage;
  socket.onerror = (error) => console.log('WebSocket error:', error);

  createEffect(() => {
    if (!socket || socket.readyState === WebSocket.CLOSED) {
      socket = createWebSocket();
      socket.onmessage = onMessage;
    }
  });

  return () => {
    if (socket && socket.readyState === WebSocket.OPEN) {
      socket.close();
    }
  };
};

```

./src/frontend/components/PromptDescriptor.jsx:
```
import { onMount, onCleanup } from 'solid-js';
import { fetchDescriptor } from '../service/fetchDescriptor';
import { fetchGitStatus } from '../service/fetchGitStatus';
import { useWebsocket } from '../service/useWebsocket';
import { promptDescriptor, setPromptDescriptor } from '../model/promptDescriptor';
import { descriptorFileName } from '../../prompt/promptDescriptorConfig';

const PromptDescriptor = () => {

  onMount(async () => {
    const text = await fetchDescriptor();
    setPromptDescriptor(text);
  });

  useWebsocket(async (e) => {
    if (e.data === 'update') {
      const text = await fetchDescriptor();
      setPromptDescriptor(text);
      // Fetch git status when an update event is received
      fetchGitStatus();
    }
  });

  onCleanup(() => {
    setPromptDescriptor('');
  });

  return (
    <details class="w-full max-w-screen overflow-x-auto whitespace-normal">
      <summary class="font-mono">{descriptorFileName}</summary>
      <div class="mt-4 overflow-auto max-w-full">
        <div class="whitespace-pre-wrap overflow-x-scroll overflow-y-auto font-mono">
          {promptDescriptor()}
        </div>
      </div>
    </details>
  );
};

export default PromptDescriptor;

```

./src/frontend/components/terminal/TerminalComponent.jsx:
```
import { onCleanup, onMount } from 'solid-js';
import { Terminal } from 'xterm';
import 'xterm/css/xterm.css';

const XtermComponent = () => {
  let container;
  const term = new Terminal();
  
  onMount(() => {
    term.open(container);
  });
  
  // Ensure terminal instance gets destroyed on component cleanup
  onCleanup(() => {
    term.dispose();
  });

  return (
    <div class="rounded border p-4" ref={container}>
      {/* The terminal will be rendered inside this div */}
    </div>
  );
};

export default XtermComponent;

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

- create frontent/service/terminal/
- in it, create terminalConnection.js that connects
to /terminal on websocket, and speaks with the server
- Update the terminal component to use this new service
- PromptDescriptor is for your reference only


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


Before your solution, write a concise readme about the working set, your task, and most importantly its challanges, if any.


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


