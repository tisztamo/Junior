#!/bin/sh
# Goal: Move generateHandler.js to a new handlers directory
# Plan:
# 1. Create a new directory named 'handlers' under 'src/backend/'.
# 2. Move 'generateHandler.js' to the 'handlers' directory.
# 3. Update the import statement in 'setupRoutes.js' to reflect the new location of 'generateHandler.js'.

mkdir -p src/backend/handlers

mv src/backend/generateHandler.js src/backend/handlers/

cat > src/backend/handlers/generateHandler.js << 'EOF'
import processPrompt from '../../prompt/promptProcessing.js';

export const generateHandler = async (req, res) => {
  const { notes } = req.body;
  const { prompt } = await processPrompt(notes);
  res.json({ prompt: prompt });
};
EOF

cat > src/backend/setupRoutes.js << 'EOF'
import { generateHandler } from './handlers/generateHandler.js';
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
