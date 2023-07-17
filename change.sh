#!/bin/sh
# Goal: Implement server and vite start as a single script.
# Plan:
# 1. Create new js files: startServer.js and startVite.js under the src directory.
# 2. In startServer.js, move the code from server.js that starts the server.
# 3. In startVite.js, add a code to start vite.
# 4. Create a new js file web.js under the src directory, which requires startServer.js and startVite.js, thus starting both processes when run.
# 5. Update the "start" script in package.json to use the new web.js file.

# Step 1: Create startServer.js and startVite.js files under the src directory.

cat << EOF > ./src/startServer.js
import { startServer as startBackendServer } from './backend/server.js';

export function startServer() {
  startBackendServer();
}
EOF

cat << EOF > ./src/startVite.js
import { exec } from 'child_process';

export function startVite() {
  const vite = exec('vite src --open');
  vite.stdout.pipe(process.stdout);
  vite.stderr.pipe(process.stderr);

  process.on('exit', () => vite.kill());
}
EOF

# Step 2: Modify server.js to export startServer function.

cat << EOF > ./src/backend/server.js
import express from 'express';
import cors from 'cors';
import { generateHandler, descriptorHandler, taskUpdateHandler } from './handlers.js';
import { listTasks } from './listTasks.js';

export function startServer() {
  const app = express();

  app.use(cors());
  app.use(express.json());

  app.get('/descriptor', descriptorHandler);
  app.get('/tasks', (req, res) => res.json({ tasks: listTasks() }));

  app.post('/generate', generateHandler);
  app.post('/updatetask', taskUpdateHandler);

  app.listen(3000, () => {
    console.log('Server is running on port 3000');
  });
}
EOF

# Step 3: Create web.js file that starts both the server and vite.

cat << EOF > ./src/web.js
import { startServer } from './startServer.js';
import { startVite } from './startVite.js';

startServer();
startVite();
EOF

# Step 4: Update "start" script in package.json to use new web.js file.

jq '.scripts.start = "node src/web.js"' package.json > package.tmp.json && mv package.tmp.json package.json
