#!/bin/sh
set -e
goal="Update interactive session behavior and logging"
echo "Plan:"
echo "1. Implement a wrapped console.log function in startInteractiveSession.js."
echo "2. Modify rl.question for default 'y' in startInteractiveSession.js."
echo "3. Update watchPromptDescriptor.js to use the new function."

# Updating startInteractiveSession.js
cat > src/interactiveSession/startInteractiveSession.js << EOF
import { saveAndSendPrompt } from './saveAndSendPrompt.js';
import generatePrompt from '../prompt/generatePrompt.js';
import { loadPromptDescriptor } from '../prompt/loadPromptDescriptor.js';
import watchPromptDescriptor from '../prompt/watchPromptDescriptor.js';
import { rl } from '../config.js';

const enhancedConsoleLog = (message) => {
  console.log(message);
  console.log("\x1b[32mPress Enter to generate prompt\x1b[0m");
};

const startInteractiveSession = async () => {
  await loadPromptDescriptor(enhancedConsoleLog);
  watchPromptDescriptor(enhancedConsoleLog);

  rl.question('', async () => {
    let { prompt } = await generatePrompt('');
    console.log("Your prompt: ", prompt);
    rl.question('Do you want to send this prompt? (y/n) [y]: ', async (confirmation) => {
      confirmation = confirmation.toLowerCase().trim() || 'y';
      if (confirmation === 'y') {
        await saveAndSendPrompt(prompt, '');
      } else {
        startInteractiveSession();
      }
    });
  });
};

export { startInteractiveSession };
EOF

# watchPromptDescriptor.js remains unchanged as it now uses the enhancedConsoleLog from startInteractiveSession.js

echo "\033[32mDone: $goal\033[0m\n"