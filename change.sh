#!/bin/sh
# Goal: Refactor server.js, add port configuration
# Plan:
# 1. Create a new file `serverConfig.js` that exports a function to get the server port, either from environment variable JUNIOR_SERVER_PORT, or from command line argument --server-port=, or default to 10101 if neither are provided.
# 2. Modify the `startServer()` function in `server.js` to use this new function to get the port number.
# 3. Create a new file `startServer.js` in `backend` that imports `serverConfig.js` and implements the logic that was previously in `server.js`.
# 4. Update `web.js` to import `startServer.js` from `backend` instead of `server.js`.
# 5. Remove the `startServer.js` in `src` folder.
# 6. Remove the `server.js` in `backend` folder.

cat > src/backend/serverConfig.js << 'EOF'
import process from 'process';

export function getServerPort() {
  const portArg = process.argv.find(arg => arg.startsWith('--server-port='));
  if (portArg) {
    return Number(portArg.split('=')[1]);
  }
  
  if (process.env.JUNIOR_SERVER_PORT) {
    return Number(process.env.JUNIOR_SERVER_PORT);
  }
  
  return 10101;
}
EOF

cat > src/backend/startServer.js << 'EOF'
import express from 'express';
import cors from 'cors';
import { createServer } from 'http';
import { WebSocketServer } from 'ws';
import { setupRoutes } from './setupRoutes.js';
import { notifyOnFileChange } from './notifyOnFileChange.js';
import { getServerPort } from './serverConfig.js';

export function startServer() {
  const app = express();

  app.use(cors());
  app.use(express.json());

  const server = createServer(app);
  const wss = new WebSocketServer({ server });

  notifyOnFileChange(wss);

  setupRoutes(app);

  const port = getServerPort();
  server.listen(port, () => {
    console.log('Server is running on port', port);
  });
}
EOF

sed -i.bak 's/\.\/startServer\.js/\.\/backend\/startServer\.js/' src/web.js && rm src/web.js.bak

rm src/startServer.js
rm src/backend/server.js
