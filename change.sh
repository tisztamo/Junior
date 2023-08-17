#!/bin/sh
set -e
goal="Implement updated descriptor feature"
echo "Plan:"
echo "1. Rename updateRequirementsHandler.js to updateDescriptorHandler.js and update its contents to manage both requirements and attention sections."
echo "2. Rename postRequirements.js to postDescriptor.js and update its contents to match the updated backend route."
echo "3. Update setupPromptRoutes.js to rename the requirements route to descriptor."
echo "4. Update CommitButton.jsx to call the renamed postDescriptor function and clear the attention section of the prompt descriptor after commit."

# Step 1: Rename and Update updateRequirementsHandler.js
mv src/backend/handlers/updateRequirementsHandler.js src/backend/handlers/updateDescriptorHandler.js
cat << 'EOF' > src/backend/handlers/updateDescriptorHandler.js
import yaml from 'js-yaml';
import { loadPromptDescriptor } from "../../prompt/loadPromptDescriptor.js";
import { savePromptDescriptor } from "../../prompt/savePromptDescriptor.js";

const updateDescriptorHandler = async (req, res) => {
  const { requirements, attention } = req.body;
  
  try {
    const fileContent = await loadPromptDescriptor();
    const document = yaml.load(fileContent);

    if (requirements) {
      document.requirements = requirements;
    }
    
    if (attention) {
      document.attention = attention;
    }
    
    const newYamlStr = yaml.dump(document);
    await savePromptDescriptor(newYamlStr);
    
    res.status(200).json({ message: "Descriptor updated successfully" });
  } catch (error) {
    console.log(error);
    res.status(500).json({ message: "Internal server error" });
  }
};

export default updateDescriptorHandler;
EOF

# Step 2: Rename and Update postRequirements.js
mv src/frontend/service/postRequirements.js src/frontend/service/postDescriptor.js
cat << 'EOF' > src/frontend/service/postDescriptor.js
import { getBaseUrl } from '../getBaseUrl';

const postDescriptor = async (descriptor) => {
  const baseUrl = getBaseUrl();
  const response = await fetch(`${baseUrl}/descriptor`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(descriptor),
  });

  return await response.json();
};

export default postDescriptor;
EOF

# Step 3: Update setupPromptRoutes.js
cat << 'EOF' > src/backend/routes/setupPromptRoutes.js
import { generateHandler } from '../handlers/generateHandler.js';
import { servePromptDescriptor } from '../handlers/servePromptDescriptor.js';
import { listTasks } from '../handlers/listTasks.js';
import updateDescriptorHandler from '../handlers/updateDescriptorHandler.js';
import { updateTaskHandler } from '../handlers/updateTaskHandler.js';

export function setupPromptRoutes(app) {
  app.get('/descriptor', servePromptDescriptor);
  app.get('/tasks', (req, res) => res.json({ tasks: listTasks() }));
  app.post('/generate', generateHandler);
  app.post('/descriptor', updateDescriptorHandler);
  app.post('/updatetask', updateTaskHandler);
}
EOF

# Step 4: Update CommitButton.jsx
cat << 'EOF' > src/frontend/components/CommitButton.jsx
import { postCommit } from '../service/postCommit';
import postDescriptor from '../service/postDescriptor';
import { commitMessage } from '../model/commitMessage';
import { fetchGitStatus } from '../service/fetchGitStatus';
import clearState from '../service/clearState';

const CommitButton = () => {
  const handleCommit = async () => {
    const response = await postCommit(commitMessage());
    console.log(response.message);
    
    await postDescriptor({ requirements: '', attention: '' });
    
    const status = await fetchGitStatus();
    console.log(status);
    clearState();
  };

  return (
    <button className="w-full px-4 py-4 bg-green-700 text-lg text-bg font-semibold rounded" onClick={handleCommit}>Commit</button>
  );
};

export default CommitButton;
EOF

echo "\033[32mDone: $goal\033[0m\n"