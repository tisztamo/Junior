#!/bin/sh
set -e
goal="Rename server port config to backend port"
echo "Plan:"
echo "1. Rename getServerPort.js to getBackendPort.js"
echo "2. Modify getBackendPort.js content"
echo "3. Update documentation in env_or_cli.md"
echo "4. Update startServer.js imports and function calls"
echo "5. Finish"

# Rename getServerPort.js to getBackendPort.js
mv ./src/backend/getServerPort.js ./src/backend/getBackendPort.js

# Modify the content of getBackendPort.js
cat > ./src/backend/getBackendPort.js << 'EOF'
function getBackendPort() {
  const portArg = process.argv.find(arg => arg.startsWith('--backend-port='));
  if (portArg) {
    return parseInt(portArg.split('=')[1], 10);
  }
  return process.env.JUNIOR_BACKEND_PORT || 10101;
}

export default getBackendPort;
EOF

# Update documentation in env_or_cli.md
cat > ./docs/config/env_or_cli.md << 'EOF'
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

- **--backend-port, JUNIOR_BACKEND_PORT**
  - The port for the backend.
  - Default: 10101
  - Example: --backend-port=8080

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

`junior-web --host=192.168.1.2`

### Ignoring a Directory from Attention Scan

`junior-cli --ignore=./myDirectory`
EOF

# Update startServer.js imports and function calls
cat > ./src/backend/startServer.js << 'EOF'
import express from 'express';
import cors from 'cors';
import { createServer } from 'http';
import { parse } from 'url';
import { WebSocketServer } from 'ws';
import { setupRoutes } from './setupRoutes.js';
import { notifyOnFileChange } from './notifyOnFileChange.js';
import getBackendPort from './getBackendPort.js';
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
  const port = getBackendPort();
  server.listen(port, ip || (enabled ? '0.0.0.0' : undefined), () => {
    console.log('Backend is running on port', port);
  });
}
EOF

echo "\033[32mDone: $goal\033[0m\n"