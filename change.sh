#!/bin/sh
# Goal: Remove last_command_result and parent_message_id from function signatures
# Plan:
# 1. Start by removing last_command_result and parent_message_id from the function signature of startInteractiveSession in startInteractiveSession.js.
# 2. Remove the references to last_command_result and parent_message_id in the body of the startInteractiveSession function.
# 3. Remove last_command_result and parent_message_id from the function signature of saveAndSendPrompt in saveAndSendPrompt.js.
# 4. Remove the references to last_command_result and parent_message_id in the body of the saveAndSendPrompt function.
# 5. Remove last_command_result and parent_message_id from the function signature of handleApiResponse in handleApiResponse.js.
# 6. Remove the references to last_command_result and parent_message_id in the body of the handleApiResponse function.
# 7. Remove last_command_result and parent_message_id from the function signature of executeCode in executeCode.js.
# 8. Remove the references to last_command_result and parent_message_id in the body of the executeCode function.
# 9. Remove last_command_result and parent_message_id from the function signature of executeAndForwardOutput in executeAndForwardOutput.js.
# 10. Remove the references to last_command_result and parent_message_id in the body of the executeAndForwardOutput function.

cat << 'EOF' > ./src/interactiveSession/startInteractiveSession.js
import { saveAndSendPrompt } from './saveAndSendPrompt.js';
import processPrompt from '../prompt/promptProcessing.js';
import { loadPromptDescriptor } from '../prompt/loadPromptDescriptor.js';

const startInteractiveSession = async (rl, api) => {
  await loadPromptDescriptor(console.log);
  rl.question('Notes: ', async (task) => {
    let { prompt } = await processPrompt(task);
    console.log("Your prompt: ", prompt);
    rl.question('Do you want to send this prompt? (y/n): ', async (confirmation) => {
      if (confirmation.toLowerCase() === 'y') {
        await saveAndSendPrompt(prompt, task, api, rl, startInteractiveSession);
      } else {
        startInteractiveSession(rl, api);
      }
    });
  });
};

export { startInteractiveSession };
EOF

cat << 'EOF' > ./src/interactiveSession/saveAndSendPrompt.js
import { printNewText } from './printNewText.js';
import { handleApiResponse } from './handleApiResponse.js';

const saveAndSendPrompt = async (prompt, task, api, rl, startInteractiveSession) => {
  let lastTextLength = 0;
  const res = await api.sendMessage(prompt, { onProgress: printNewText(lastTextLength) });
  console.log("\x1b[0m");
  const msg = res.text.trim();
  console.log("");
  handleApiResponse(msg, rl, api);
}

export { saveAndSendPrompt };
EOF

cat << 'EOF' > ./src/interactiveSession/handleApiResponse.js
import { executeCode } from '../execute/executeCode.js';
import { extractCode } from '../execute/extractCode.js';
import { startInteractiveSession } from './startInteractiveSession.js';

const handleApiResponse = (msg, rl, api) => {
  const cod = extractCode(msg);
  if (cod) {
    executeCode(cod, rl, api);
  } else {
    startInteractiveSession(rl, api);
  }
}

export { handleApiResponse };
EOF

cat << 'EOF' > ./src/execute/executeCode.js
#!/usr/bin/env node

import { confirmAndWriteCode } from './confirmAndWriteCode.js';
import { executeAndForwardOutput } from './executeAndForwardOutput.js';

const executeCode = async (code, rl, api) => {
  confirmAndWriteCode(code, rl, () => executeAndForwardOutput(code, rl, api));
}

export { executeCode };
EOF

cat << 'EOF' > ./src/execute/executeAndForwardOutput.js
import { spawn } from 'child_process';
import { startInteractiveSession } from "../interactiveSession/startInteractiveSession.js";

function executeAndForwardOutput(code, rl, api) {
  const child = spawn(code, { shell: true });
  let last_command_result = '';

  child.stdout.on('data', (data) => {
    console.log(`${data}`);
    last_command_result += data;
  });

  child.stderr.on('data', (data) => {
    console.error(`${data}`);
    last_command_result += data;
  });

  child.on('close', (code) => {
    if (code !== 0) {
      console.log(`child process exited with code ${code}`);
      last_command_result = "Command failed. Output:\n" + last_command_result;
    } else {
      last_command_result = "Command executed. Output:\n" + last_command_result;
    }
    startInteractiveSession(rl, api)
  });
}

export { executeAndForwardOutput };
EOF
