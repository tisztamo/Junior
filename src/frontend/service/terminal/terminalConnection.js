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
