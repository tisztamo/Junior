#!/bin/sh
set -e
goal="Fix the terminal WebSocket implementation"
echo "Plan:"
echo "1. Modify startServer.js to call terminalRoutes for the terminal WebSocket."
echo "2. Update the WebSocket event name in setupTerminalServer.js."
echo "3. Add debugging console logs in setupTerminalServer.js."

# 1. Modify startServer.js
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

# 2. Update WebSocket event name and add logs in setupTerminalServer.js
cat > ./src/backend/terminal/setupTerminalServer.js << 'EOF'
import { spawn } from 'child_process';

export default function setupTerminalServer(socket) {
  console.log("Setting up terminal server...");

  const shell = spawn('/bin/sh');

  socket.on('message', (data) => {
    console.log("Received message:", data.toString());
    shell.stdin.write(data);
  });

  shell.stdout.on('data', (data) => {
    console.log("Shell output:", data.toString());
    socket.send(data);
  });

  shell.stderr.on('data', (data) => {
    console.log("Shell error output:", data.toString());
    socket.send(data);
  });

  shell.on('exit', () => {
    console.log("Shell exited");
    socket.close();
  });
}
EOF

echo "\033[32mDone: $goal\033[0m\n"