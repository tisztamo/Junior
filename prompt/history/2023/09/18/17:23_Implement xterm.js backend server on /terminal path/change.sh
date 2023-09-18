#!/bin/sh
set -e
goal="Implement xterm.js backend server on /terminal path"
echo "Plan:"
echo "1. Create backend/terminal/ directory."
echo "2. Set up xterm.js server functionalities."
echo "3. Design a communication protocol for the xterm.js server on the /terminal path."
echo "4. Modify the app initialization to start the xterm.js server automatically on the /terminal path."

# 1. Create backend/terminal/ directory
mkdir -p ./src/backend/terminal/

# 2. Set up xterm.js server functionalities

# Here we create a file that sets up the terminal server
cat > ./src/backend/terminal/setupTerminalServer.js << 'EOF'
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
EOF

# 3. Design a communication protocol for the xterm.js server

# Here we add routes to handle terminal communication on the /terminal path
cat > ./src/backend/terminal/terminalRoutes.js << 'EOF'
import setupTerminalServer from './setupTerminalServer.js';

export default function terminalRoutes(wss) {
  wss.on('connection', (socket) => {
    setupTerminalServer(socket);
  }, { path: '/terminal' });
}
EOF

# 4. Modify the app initialization to start the xterm.js server automatically

# We update the startServer.js to import terminalRoutes and set it up with the WebSocket server on the /terminal path
cat > ./src/backend/startServer.js << 'EOF'
import express from 'express';
import cors from 'cors';
import { createServer } from 'http';
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
  const wss = new WebSocketServer({ server });

  notifyOnFileChange(wss);
  setupRoutes(app);
  terminalRoutes(wss);

  const { enabled, ip } = hostConfig();

  const port = getServerPort();
  server.listen(port, ip || (enabled ? '0.0.0.0' : undefined), () => {
    console.log('Server is running on port', port);
  });
}
EOF

echo "\033[32mDone: $goal\033[0m\n"