#!/bin/sh
set -e

goal="Fix WebSocket initialization for multiple paths"
echo "Plan:"
echo "1. Modify startServer.js to initialize multiple WebSocket servers."
echo "2. Use server's 'upgrade' event to delegate WebSocket connections based on pathname."

# Modifying startServer.js to handle multiple WebSocket connections on different paths
cat > ./src/backend/startServer.js << 'EOF'
import express from 'express';
import cors from 'cors';
import { createServer } from 'http';
import { parse } from 'url';
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
  
  const wssTerminal = new WebSocketServer({ noServer: true });
  const wssNotify = new WebSocketServer({ noServer: true });

  notifyOnFileChange(wssNotify);
  
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

echo "\033[32mDone: $goal\033[0m\n"