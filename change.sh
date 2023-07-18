#!/bin/sh
# Goal: Refactor code by splitting into separate files
# Plan:
# 1. Create a new file setupRoutes.js and move all the routing logic from server.js to this new file.
# 2. Delete handlers.js file as it's no longer needed.
# 3. Create a new file generateHandler.js and move the generateHandler function from handlers.js to this new file.

# Step 1: Create setupRoutes.js and move routing logic
cat << EOF > src/backend/setupRoutes.js
import { generateHandler } from './generateHandler.js';
import { servePromptDescriptor } from './servePromptDescriptor.js';
import { updateTaskHandler } from './updateTaskHandler.js';
import { listTasks } from './listTasks.js';

export function setupRoutes(app) {
  app.get('/descriptor', servePromptDescriptor);
  app.get('/tasks', (req, res) => res.json({ tasks: listTasks() }));

  app.post('/generate', generateHandler);
  app.post('/updatetask', updateTaskHandler);
}
EOF

# Step 2: Delete handlers.js
rm src/backend/handlers.js

# Step 3: Create generateHandler.js and move generateHandler function
cat << EOF > src/backend/generateHandler.js
import processPrompt from '../prompt/promptProcessing.js';

export const generateHandler = async (req, res) => {
  const { notes } = req.body;
  const { prompt } = await processPrompt(notes);
  res.json({ prompt: prompt });
};
EOF

# Update server.js to use setupRoutes.js
cat << EOF > src/backend/server.js
import express from 'express';
import cors from 'cors';
import { createServer } from 'http';
import { WebSocketServer } from 'ws';
import { setupRoutes } from './setupRoutes.js';
import { notifyOnFileChange } from './notifyOnFileChange.js';

export function startServer() {
  console.log(process.cwd())
  const app = express();

  app.use(cors());
  app.use(express.json());

  const server = createServer(app);
  const wss = new WebSocketServer({ server });

  notifyOnFileChange(wss);

  setupRoutes(app);

  server.listen(3000, () => {
    console.log('Server is running on port 3000');
  });
}
EOF
