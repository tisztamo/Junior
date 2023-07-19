import { getBaseUrl } from '../getBaseUrl.js';

export const createWebSocket = () => {
  const baseUrl = getBaseUrl();
  const wsUrl = baseUrl.replace(/^http/, 'ws');
  const ws = new WebSocket(wsUrl);
  return ws;
};
