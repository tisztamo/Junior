#!/bin/sh
set -e
goal="Refactor code to use getServerPort.js"
echo "Plan:"
echo "1. Delete serverConfig.js"
echo "2. Modify startServer.js to use getServerPort.js instead of serverConfig.js"
echo "3. Ensure ES6 imports are used and the code adheres to the project specifics."

# Step 1: Delete serverConfig.js
rm ./src/backend/serverConfig.js
echo "Deleted serverConfig.js"

# Step 2: Modify startServer.js
cat > ./src/backend/startServer.js << 'EOF'
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
EOF
echo "Modified startServer.js to use getServerPort.js"

echo "\033[32mDone: $goal\033[0m\n"