import { createEffect } from 'solid-js';
import { createWebSocket } from './createWebSocket.js';

export const useWebsocket = (onMessage) => {
  let socket = createWebSocket();

  socket.onopen = () => console.log('WebSocket is connected');
  socket.onmessage = onMessage;
  socket.onerror = (error) => console.log('WebSocket error:', error);

  createEffect(() => {
    if (!socket || socket.readyState === WebSocket.CLOSED) {
      socket = createWebSocket();
      socket.onmessage = onMessage;
    }
  });

  return () => {
    if (socket && socket.readyState === WebSocket.OPEN) {
      socket.close();
    }
  };
};
