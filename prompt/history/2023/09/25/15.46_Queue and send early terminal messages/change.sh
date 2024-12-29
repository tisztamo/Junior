#!/bin/sh
set -e
goal="Queue and send early terminal messages"
echo "Plan:"
echo "1. Update 'terminalConnection.js' to introduce a message queuing functionality."
echo "2. Implement an event handler for the WebSocket's 'onopen' event to flush the queue and send all messages when the connection opens."

# 1. Update 'terminalConnection.js' to introduce a message queuing functionality
cat > ./src/frontend/service/terminal/terminalConnection.js << 'EOF'
import { createWebSocket } from '../createWebSocket';

const socket = createWebSocket('/terminal');
const messageQueue = [];

const sendDataToTerminal = (data) => {
  if (socket.readyState === WebSocket.OPEN) {
    socket.send(data);
  } else {
    messageQueue.push(data);
  }
};

const flushQueue = () => {
  while (messageQueue.length > 0) {
    const message = messageQueue.shift();
    socket.send(message);
  }
};

// Event handler to flush the queue when WebSocket connection opens
socket.onopen = () => {
  flushQueue();
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