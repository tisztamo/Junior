#!/bin/sh
set -e
goal="Implement updateRequirements endpoint and refactor routes"
echo "Plan:"
echo "1. Group git routes together in setupRoutes.js for readability."
echo "2. Create a new handler for updating the requirements section of the prompt descriptor."
echo "3. Create and export this handler in its own file."
echo "4. Add the new endpoint to setupRoutes.js."

# Step 1: Refactor setupRoutes.js for git routes
cat <<EOF >src/backend/setupRoutes.js
import { generateHandler } from './handlers/generateHandler.js';
import { servePromptDescriptor } from './handlers/servePromptDescriptor.js';
import { updateTaskHandler } from './handlers/updateTaskHandler.js';
import { listTasks } from './handlers/listTasks.js';
import { executeHandler } from './handlers/executeHandler.js';
import gitStatusHandler from './handlers/git/gitStatusHandler.js';
import commitGitHandler from './handlers/git/commitGitHandler.js';
import resetGitHandler from './handlers/git/resetGitHandler.js';
import updateRequirementsHandler from './handlers/updateRequirementsHandler.js';

export function setupRoutes(app) {
  app.get('/descriptor', servePromptDescriptor);
  app.get('/tasks', (req, res) => res.json({ tasks: listTasks() }));
  app.post('/generate', generateHandler);
  app.post('/updatetask', updateTaskHandler);
  app.post('/execute', executeHandler);

  // Git routes grouped
  app.get('/git/status', gitStatusHandler);
  app.post('/git/reset', resetGitHandler);
  app.post('/git/commit', commitGitHandler);

  // New endpoint for updating requirements
  app.post('/requirements/update', updateRequirementsHandler);
}
EOF

# Step 2 and 3: Create and export the handler for updating requirements
cat <<EOF >src/backend/handlers/updateRequirementsHandler.js
import yaml from 'js-yaml';
import { loadPromptDescriptor } from "../../prompt/loadPromptDescriptor.js";
import { savePromptDescriptor } from "../../prompt/savePromptDescriptor.js";

export const updateRequirementsHandler = async (req, res) => {
  const requirements = req.body.requirements;
  
  try {
    const fileContent = await loadPromptDescriptor();
    const document = yaml.load(fileContent);
    document.requirements = requirements;
    
    const newYamlStr = yaml.dump(document);
    await savePromptDescriptor(newYamlStr);
    
    res.status(200).json({ message: "Requirements updated successfully" });
  } catch (error) {
    console.log(error);
    res.status(500).json({ message: "Internal server error" });
  }
};
EOF

echo "\033[32mDone: $goal\033[0m\n"
