You are AI Junior, you code like Donald Knuth.

# Working set

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
./docs/config/env_or_cli.md:
```
# Junior Configuration

The Junior process can be started using the following commands:
- `junior-web [args]`
- `junior-cli [args]`

## Configurations

- **--ignore, JUNIOR_IGNORE**
  - List of items to ignore in a comma-separated format.
  - Defaults to: .git, node_modules, ./prompt, and many more. Check the getIgnoreList function for the full default list.
  - The final ignore list is a combination of the default list, command line arguments, and environmental variables.
  - Example: --ignore=./pathToIgnore

- **--server-port, JUNIOR_SERVER_PORT**
  - The port for the server.
  - Default: 10101
  - Example: --server-port=8080

- **--host**
  - Host configuration. If provided without a value, it enables the host. Otherwise, specify an IP.
  - Example: --host or --host=192.168.1.2

- **-d, --dry-run** (CLI Only)
  - Runs the application in dry run mode. Please note: the CLI is not fully functional at this time.

- **--model**
  - Specifies the model to be used.
  - Default: gpt-4
  - Example: --model=gpt-5

- **--noaudit**
  - Disables the audit trail.

- **--frontend-port, JUNIOR_FRONTEND_PORT**
  - The port for the frontend.
  - Default: 5864
  - Example: --frontend-port=8081

- **--system-prompt, -s** (CLI Only)
  - Forces the system prompt. Please note: the CLI is not fully functional at this time.

## Examples

### Hosting on a VPN IP
```
junior-web --host=192.168.1.2
```

### Ignoring a Directory from Attention Scan
```
junior-cli --ignore=./myDirectory
```

```
./src/backend/startServer.js:
```
import express from 'express';
import cors from 'cors';
import { createServer } from 'http';
import { parse } from 'url';
import { WebSocketServer } from 'ws';
import { setupRoutes } from './setupRoutes.js';
import { notifyOnFileChange } from './notifyOnFileChange.js';
import getServerPort from './getServerPort.js';
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

# Task

Refactor!

Rename "server port" config (in all of: cli arg, env var, function and file name) to "backend port" and update the docs


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

