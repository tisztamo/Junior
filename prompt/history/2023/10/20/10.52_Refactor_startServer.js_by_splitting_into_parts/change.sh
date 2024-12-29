#!/bin/sh
set -e
goal="Refactor startServer.js by splitting into parts"
echo "Plan:"
echo "1. Split WebSocket setup logic, including WebSocket server instantiation, into websocketSetup.js"
echo "2. Split server startup and listening logic into serverSetup.js and let it fetch its own configurations"
echo "3. Update startServer.js to use new modules"

# 1. Split WebSocket setup logic, including WebSocket server instantiation, into websocketSetup.js
cat > ./src/backend/websocketSetup.js << 'EOF'
import { parse } from 'url';
import { WebSocketServer } from 'ws';
import { notifyOnFileChange } from './notifyOnFileChange.js';
import terminalRoutes from './terminal/terminalRoutes.js';

export function websocketSetup(server) {
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
}
EOF

# 2. Split server startup and listening logic into serverSetup.js and let it fetch its own configurations
cat > ./src/backend/serverSetup.js << 'EOF'
import getBackendPort from './getBackendPort.js';
import hostConfig from '../config/hostConfig.js';

export function serverSetup(server) {
  const { enabled, ip } = hostConfig();
  const port = getBackendPort();
  
  server.listen(port, ip || (enabled ? '0.0.0.0' : undefined), () => {
    console.log('Backend is running on port', port);
  });
}
EOF

# 3. Update startServer.js to use new modules
cat > ./src/backend/startServer.js << 'EOF'
import express from 'express';
import cors from 'cors';
import { createServer } from 'http';
import { setupRoutes } from './setupRoutes.js';
import { websocketSetup } from './websocketSetup.js';
import { serverSetup } from './serverSetup.js';

export function startServer() {
  const app = express();

  app.use(cors());
  app.use(express.json());

  const server = createServer(app);

  websocketSetup(server);

  setupRoutes(app);

  serverSetup(server);
}
EOF

echo "\033[32mDone: $goal\033[0m\n"