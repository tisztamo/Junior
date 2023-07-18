export const createWebSocket = () => {
  const ws = new WebSocket('ws://localhost:3000');
  return ws;
};
