import { getBaseUrl } from '../getBaseUrl.js';

export const createWebSocket = (path = '/') => {
  const baseUrl = getBaseUrl();
  const wsUrl = baseUrl.replace(/^http/, 'ws') + path;
  const ws = new WebSocket(wsUrl);
  return ws;
};
