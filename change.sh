#!/bin/bash

echo "Changing startInteractiveSession.js"
cat << 'JAVASCRIPT' > ./src/interactiveSession/startInteractiveSession.js
import processPrompt from '../prompt/promptProcessing.js';
import { saveAndSendPrompt } from './saveAndSendPrompt.js';

const startInteractiveSession = async (last_command_result = "", parent_message_id = null, rl, api) => {
  rl.question('Notes: ', async (task) => {
    const { prompt, parent_message_id: newParentMessageId } = await processPrompt(task, last_command_result);
    rl.question('Do you want to send this prompt? (yes/no): ', async (confirmation) => {
      if (confirmation.toLowerCase() === 'yes') {
        await saveAndSendPrompt(prompt, newParentMessageId, api, rl, last_command_result, startInteractiveSession);
      } else {
        startInteractiveSession(last_command_result, parent_message_id, rl, api);
      }
    });
  });
};

export { startInteractiveSession };
JAVASCRIPT

echo "Done."
