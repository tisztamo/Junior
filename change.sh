#!/bin/sh

# Goal: Fix the issue where the prompt is not being sent to the api.
# Plan:
# 1. Update the `startInteractiveSession` function to pass the prompt to the `saveAndSendPrompt` function.
# 2. Update the `saveAndSendPrompt` function to use the passed prompt instead of the task in `api.sendMessage`.

# Update `startInteractiveSession.js`
cat << EOF > src/interactiveSession/startInteractiveSession.js
import { saveAndSendPrompt } from './saveAndSendPrompt.js';
import processPrompt from '../prompt/promptProcessing.js';

const startInteractiveSession = async (last_command_result = "", parent_message_id = null, rl, api) => {
  rl.question('Notes: ', async (task) => {
    let { prompt } = await processPrompt(task, last_command_result);
    console.log("Your prompt: ", prompt);
    rl.question('Do you want to send this prompt? (yes/no): ', async (confirmation) => {
      if (confirmation.toLowerCase() === 'yes') {
        await saveAndSendPrompt(prompt, task, last_command_result, api, rl, startInteractiveSession);
      } else {
        startInteractiveSession(last_command_result, parent_message_id, rl, api);
      }
    });
  });
};

export { startInteractiveSession };
EOF

# Update `saveAndSendPrompt.js`
cat << EOF > src/interactiveSession/saveAndSendPrompt.js
import { printNewText } from './printNewText.js';
import { handleApiResponse } from './handleApiResponse.js';

const saveAndSendPrompt = async (prompt, task, last_command_result, api, rl, startInteractiveSession) => {
  let lastTextLength = 0;
  const res = await api.sendMessage(prompt, { onProgress: printNewText(lastTextLength) });
  const parent_message_id = res.id;
  console.log("\x1b[0m");
  const msg = res.text.trim();
  console.log("");
  handleApiResponse(msg, last_command_result, parent_message_id, rl, api);
}

export { saveAndSendPrompt };
EOF
