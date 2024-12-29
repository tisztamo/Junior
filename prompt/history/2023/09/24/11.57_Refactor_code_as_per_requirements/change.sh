#!/bin/sh
set -e
goal="Refactor code as per requirements"
echo "Plan:"
echo "1. Rename processPrompt.js to generatePrompt.js."
echo "2. Modify the content in the renamed file to change function name to generatePrompt."
echo "3. Update references in generateHandler.js and startInteractiveSession.js."
echo "4. Change task variable to notes in startInteractiveSession.js."

# Rename processPrompt.js to generatePrompt.js
mv ./src/prompt/processPrompt.js ./src/prompt/generatePrompt.js

# Modify generatePrompt.js content
cat > ./src/prompt/generatePrompt.js << 'EOF'
import { createPrompt } from './createPrompt.js';
import fs from 'fs/promises';

const generatePrompt = async (notes, forceSystemPrompt = false, saveto = 'prompt.md', parent_message_id = null) => {
  const { prompt, saveto: newSaveto } = await createPrompt(notes, forceSystemPrompt);
  await fs.writeFile(newSaveto || saveto, prompt);
  return { prompt, parent_message_id };
}

export default generatePrompt;
EOF

# Update generateHandler.js
cat > ./src/backend/handlers/generateHandler.js << 'EOF'
import generatePrompt from '../../prompt/generatePrompt.js';
import isRepoClean from '../../git/isRepoClean.js';

export const generateHandler = async (req, res) => {
  try {
    if (!await isRepoClean()) {
      throw new Error("Directory is not clean. Please commit or stash changes and try again.");
    }

    const { notes, systemPrompt } = req.body;
    const { prompt } = await generatePrompt(notes, systemPrompt);
    res.json({ prompt: prompt });
  } catch (error) {
    console.warn(error);
    res.status(500).json({ error: error.message });
  }
};
EOF

# Modify startInteractiveSession.js
cat > ./src/interactiveSession/startInteractiveSession.js << 'EOF'
import { saveAndSendPrompt } from './saveAndSendPrompt.js';
import generatePrompt from '../prompt/generatePrompt.js';
import { loadPromptDescriptor } from '../prompt/loadPromptDescriptor.js';
import watchPromptDescriptor from '../prompt/watchPromptDescriptor.js';
import { rl } from '../config.js';

const startInteractiveSession = async () => {
  await loadPromptDescriptor(console.log);
watchPromptDescriptor(console.log);
  rl.question('Notes: ', async (notes) => {
    let { prompt } = await generatePrompt(notes);
    console.log("Your prompt: ", prompt);
    rl.question('Do you want to send this prompt? (y/n): ', async (confirmation) => {
      if (confirmation.toLowerCase() === 'y') {
        await saveAndSendPrompt(prompt, notes);
      } else {
        startInteractiveSession();
      }
    });
  });
};

export { startInteractiveSession };
EOF

echo "\033[32mDone: $goal\033[0m\n"
