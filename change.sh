#!/bin/sh
# Goal: Use getBaseUrl and derive ws protocol for WebSocket URL
# Plan:
# 1. Modify "createWebSocket.js" to import the "getBaseUrl" function from "getBaseUrl.js".
# 2. Replace the hardcoded WebSocket URL with a dynamic one, created using "getBaseUrl" and replacing "http" with "ws".

cat > src/frontend/service/createWebSocket.js << 'EOF'
import { getBaseUrl } from '../getBaseUrl.js';

export const createWebSocket = () => {
  const baseUrl = getBaseUrl();
  const wsUrl = baseUrl.replace(/^http/, 'ws');
  const ws = new WebSocket(wsUrl);
  return ws;
};
EOF
