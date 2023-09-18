You are AI Junior, you code like Donald Knuth.
# Working set

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

./src/backend/startServer.js:
```
import express from 'express';
import cors from 'cors';
import { createServer } from 'http';
import { WebSocketServer } from 'ws';
import { setupRoutes } from './setupRoutes.js';
import { notifyOnFileChange } from './notifyOnFileChange.js';
import { getServerPort } from './serverConfig.js';
import hostConfig from '../config/hostConfig.js';

export function startServer() {
  const app = express();

  app.use(cors());
  app.use(express.json());

  const server = createServer(app);
  const wss = new WebSocketServer({ server });

  notifyOnFileChange(wss);

  setupRoutes(app);

  const { enabled, ip } = hostConfig();

  const port = getServerPort();
  server.listen(port, ip || (enabled ? '0.0.0.0' : undefined), () => {
    console.log('Server is running on port', port);
  });
}

```


# Task

Answer the following question!

We need a terminal on the frontend. We already have a websocket server, we should use it.
What are the best tools on either side? We prefer not to install anything, but don't yet want to write much code. Write your answer to docs/design/terminal_dependency_selection.md

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


