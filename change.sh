#!/bin/bash

# Updating startInteractiveSession.js file
cat << EOF > ./src/interactiveSession/startInteractiveSession.js
import { saveAndSendPrompt } from './saveAndSendPrompt.js';

const startInteractiveSession = async (last_command_result = "", parent_message_id = null, rl, api) => {
  rl.question('Notes: ', async (task) => {
    rl.question('Do you want to send this prompt? (yes/no): ', async (confirmation) => {
      if (confirmation.toLowerCase() === 'yes') {
        await saveAndSendPrompt(task, last_command_result, api, rl, startInteractiveSession);
      } else {
        startInteractiveSession(last_command_result, parent_message_id, rl, api);
      }
    });
  });
};

export { startInteractiveSession };
EOF

# Updating saveAndSendPrompt.js file
cat << EOF > ./src/interactiveSession/saveAndSendPrompt.js
import { printNewText } from './printNewText.js';
import { handleApiResponse } from './handleApiResponse.js';
import processPrompt from '../prompt/promptProcessing.js';

const saveAndSendPrompt = async (task, last_command_result, api, rl, startInteractiveSession) => {
  let { prompt, parent_message_id } = await processPrompt(task, last_command_result);
  let lastTextLength = 0;
  console.log("\x1b[2m");
  console.debug("Query:", prompt);
  const res = await api.sendMessage(prompt, { parentMessageId: parent_message_id, onProgress: printNewText(lastTextLength) });
  parent_message_id = res.id;
  console.log("\x1b[0m");
  const msg = res.text.trim();
  console.log("");
  handleApiResponse(msg, last_command_result, parent_message_id, rl, api);
}

export { saveAndSendPrompt };
EOF

# Verify changes
echo "Changes have been made in 'startInteractiveSession.js' and 'saveAndSendPrompt.js'"
