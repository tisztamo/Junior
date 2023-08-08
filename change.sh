#!/bin/sh
set -e
goal="Rename file, move files, eliminate variable"
echo "Plan:"
echo "1. Rename promptProcessing.js to processPrompt.js."
echo "2. Change the import statements in files depending on the renamed file."
echo "3. Eliminate the 'last_command_result' variable and the corresponding arguments from the function in processPrompt.js."
echo "4. Change the calls to the function accordingly in other files to maintain coherence."

# Renaming the promptProcessing.js file to processPrompt.js
mv src/prompt/promptProcessing.js src/prompt/processPrompt.js

# Modifying the generateHandler.js to update the import statement
cat > src/backend/handlers/generateHandler.js <<- 'EOF'
import processPrompt from '../../prompt/processPrompt.js';

export const generateHandler = async (req, res) => {
  const { notes } = req.body;
  const { prompt } = await processPrompt(notes);
  res.json({ prompt: prompt });
};
EOF

# Modifying the startInteractiveSession.js to update the import statement
cat > src/interactiveSession/startInteractiveSession.js <<- 'EOF'
import { saveAndSendPrompt } from './saveAndSendPrompt.js';
import processPrompt from '../prompt/processPrompt.js';
import { loadPromptDescriptor } from '../prompt/loadPromptDescriptor.js';
import watchPromptDescriptor from '../prompt/watchPromptDescriptor.js';
import { rl } from '../config.js';

const startInteractiveSession = async () => {
  await loadPromptDescriptor(console.log);
watchPromptDescriptor(console.log);
  rl.question('Notes: ', async (task) => {
    let { prompt } = await processPrompt(task);
    console.log("Your prompt: ", prompt);
    rl.question('Do you want to send this prompt? (y/n): ', async (confirmation) => {
      if (confirmation.toLowerCase() === 'y') {
        await saveAndSendPrompt(prompt, task);
      } else {
        startInteractiveSession();
      }
    });
  });
};

export { startInteractiveSession };

EOF

# Modifying processPrompt.js to eliminate last_command_result and update function accordingly
cat > src/prompt/processPrompt.js <<- 'EOF'
import { createPrompt } from './createPrompt.js';
import fs from 'fs/promises';

const processPrompt = async (task, saveto = 'prompt.md', parent_message_id = null) => {
  const { prompt, saveto: newSaveto } = await createPrompt(task);
  await fs.writeFile(newSaveto || saveto, prompt);
  return { prompt, parent_message_id };
}

export default processPrompt;

EOF

echo "\033[32mDone: $goal\033[0m\n"
