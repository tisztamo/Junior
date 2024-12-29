#!/bin/sh
set -e

goal="Enhance WebSocket creation with optional path"
echo "Plan:"
echo "1. Update createWebSocket.js to handle an optional path argument and export it as a named const."
echo "2. Modify terminalConnection.js to utilize the new path argument for /terminal."

# Step 1: Update createWebSocket.js to handle an optional path argument and export it as a named const
cat > ./src/frontend/service/createWebSocket.js << 'EOF'
import { getBaseUrl } from '../getBaseUrl.js';

export const createWebSocket = (path = '/') => {
  const baseUrl = getBaseUrl();
  const wsUrl = baseUrl.replace(/^http/, 'ws') + path;
  const ws = new WebSocket(wsUrl);
  return ws;
};
EOF

# Step 2: Modify terminalConnection.js to utilize the new path argument for /terminal
cat > ./src/frontend/service/terminal/terminalConnection.js << 'EOF'
import { createWebSocket } from '../createWebSocket';

const socket = createWebSocket('/terminal');

const sendDataToTerminal = (data) => {
  if (socket.readyState === WebSocket.OPEN) {
    socket.send(data);
  }
};

const setOnDataReceived = (callback) => {
  socket.onmessage = (event) => {
    callback(event.data);
  };
};

const closeConnection = () => {
  if (socket.readyState === WebSocket.OPEN) {
    socket.close();
  }
};

export default {
  sendDataToTerminal,
  setOnDataReceived,
  closeConnection,
};
EOF

echo "\033[32mDone: $goal\033[0m\n"