import { createEffect } from 'solid-js';

export const useWebsocket = (url, onMessage) => {
  let socket = new WebSocket(url);

  socket.onopen = () => console.log('WebSocket is connected');
  socket.onmessage = onMessage;
  socket.onerror = (error) => console.log('WebSocket error:', error);

  createEffect(() => {
    if (!socket || socket.readyState === WebSocket.CLOSED) {
      socket = new WebSocket(url);
      socket.onmessage = onMessage;
    }
  });

  return () => {
    if (socket && socket.readyState === WebSocket.OPEN) {
      socket.close();
    }
  };
};
