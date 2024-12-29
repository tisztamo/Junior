#!/bin/sh
set -e
goal="Setup static file serving after other routes"
echo "Plan:"
echo "1. Update startServer.js to serve static files from the current directory after setting up other routes."

cat > ./src/backend/startServer.js << 'EOF'
import express from 'express';
import cors from 'cors';
import { createServer } from 'http';
import { setupRoutes } from './setupRoutes.js';
import { websocketSetup } from './websocketSetup.js';
import { serverSetup } from './serverSetup.js';

export function startServer() {
  const app = express();

  app.use(cors());
  app.use(express.json());

  const server = createServer(app);

  websocketSetup(server);

  setupRoutes(app);
  
  // Serve static files from current directory after other routes
  app.use('/', express.static('.'));

  serverSetup(server);
}
EOF

echo "\033[32mDone: $goal\033[0m\n"