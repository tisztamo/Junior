You are AI Junior, you code like Donald Knuth.

# Working set

./src/backend/startServer.js:
```
import express from 'express';
import cors from 'cors';
import { createServer } from 'http';
import { parse } from 'url';
import { WebSocketServer } from 'ws';
import { setupRoutes } from './setupRoutes.js';
import { notifyOnFileChange } from './notifyOnFileChange.js';
import { getServerPort } from './serverConfig.js';
import hostConfig from '../config/hostConfig.js';
import terminalRoutes from './terminal/terminalRoutes.js';

export function startServer() {
  const app = express();

  app.use(cors());
  app.use(express.json());

  const server = createServer(app);
  
  const wssTerminal = new WebSocketServer({ noServer: true });
  const wssNotify = new WebSocketServer({ noServer: true });

  notifyOnFileChange(wssNotify);
  
  terminalRoutes(wssTerminal);

  server.on('upgrade', function upgrade(request, socket, head) {
    const { pathname } = parse(request.url);
    if (pathname === '/terminal') {
      wssTerminal.handleUpgrade(request, socket, head, function done(ws) {
        wssTerminal.emit('connection', ws, request);
      });
    } else if (pathname === '/') {
      wssNotify.handleUpgrade(request, socket, head, function done(ws) {
        wssNotify.emit('connection', ws, request);
      });
    } else {
      socket.destroy();
    }
  });

  setupRoutes(app);

  const { enabled, ip } = hostConfig();
  const port = getServerPort();
  server.listen(port, ip || (enabled ? '0.0.0.0' : undefined), () => {
    console.log('Server is running on port', port);
  });
}

```
./src/backend/serverConfig.js:
```
import process from 'process';

export function getServerPort() {
  const portArg = process.argv.find(arg => arg.startsWith('--server-port='));
  if (portArg) {
    return Number(portArg.split('=')[1]);
  }
  
  if (process.env.JUNIOR_SERVER_PORT) {
    return Number(process.env.JUNIOR_SERVER_PORT);
  }
  
  return 10101;
}

```
./src/backend/getServerPort.js:
```
function getServerPort() {
  const portArg = process.argv.find(arg => arg.startsWith('--server-port='));
  if (portArg) {
    return parseInt(portArg.split('=')[1], 10);
  }
  return process.env.JUNIOR_SERVER_PORT || 10101;
}

export default getServerPort;

```

# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

Delete serverConfig.js and use getServerPort.js instead in startServer


## Project Specifics

- Every js file should *only export a single function or signal*! eg.: in createGitRepo.js: export function createGitRepo ( ....
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs* and Tailwind, edit .jsx files accordingly!

Write concise, self-documenting and idiomatic ES6 code!

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

