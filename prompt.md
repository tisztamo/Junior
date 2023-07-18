# Working set

```
./
├── .git/...
├── .gitignore
├── README.md
├── babel.config.js
├── change.sh
├── doc/...
├── node_modules/...
├── package-lock.json
├── package.json
├── prompt/...
├── prompt.md
├── prompt.yaml
├── secret.sh
├── src/...

```
src/main.js:
```
#!/usr/bin/env node

import { startInteractiveSession } from './interactiveSession/startInteractiveSession.js';
import { api, get_model, rl } from './config.js';
import { getSystemPrompt } from './prompt/getSystemPrompt.js';

console.log("Welcome to Contributor. Model: " + get_model() + "\n");
console.log("System prompt:", await getSystemPrompt())

startInteractiveSession("", null, rl, api);

export { startInteractiveSession };

```

```
src/interactiveSession/
├── handleApiResponse.js
├── printNewtext.js
├── saveAndSendPrompt.js
├── startInteractiveSession.js

```
src/interactiveSession/startInteractiveSession.js:
```
import { saveAndSendPrompt } from './saveAndSendPrompt.js';
import processPrompt from '../prompt/promptProcessing.js';
import { loadPromptDescriptor } from '../prompt/loadPromptDescriptor.js';

const startInteractiveSession = async (last_command_result = "", parent_message_id = null, rl, api) => {
  await loadPromptDescriptor(console.log);
  rl.question('Notes: ', async (task) => {
    let { prompt } = await processPrompt(task, last_command_result);
    console.log("Your prompt: ", prompt);
    rl.question('Do you want to send this prompt? (y/n): ', async (confirmation) => {
      if (confirmation.toLowerCase() === 'y') {
        await saveAndSendPrompt(prompt, task, last_command_result, api, rl, startInteractiveSession);
      } else {
        startInteractiveSession(last_command_result, parent_message_id, rl, api);
      }
    });
  });
};

export { startInteractiveSession };

```

src/interactiveSession/saveAndSendPrompt.js:
```
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

```

src/interactiveSession/handleApiResponse.js:
```
import { executeCode } from '../execute/executeCode.js';
import { extractCode } from '../execute/extractCode.js';
import { startInteractiveSession } from './startInteractiveSession.js';

const handleApiResponse = (msg, last_command_result, parent_message_id, rl, api) => {
  const cod = extractCode(msg);
  if (cod) {
    executeCode(cod, last_command_result, parent_message_id, rl, api);
  } else {
    last_command_result = "";
    startInteractiveSession(last_command_result, parent_message_id, rl, api);
  }
}

export { handleApiResponse };

```

src/execute/executeCode.js:
```
#!/usr/bin/env node

import { confirmAndWriteCode } from './confirmAndWriteCode.js';
import { executeAndForwardOutput } from './executeAndForwardOutput.js';

const executeCode = async (code, last_command_result, parent_message_id, rl) => {
  confirmAndWriteCode(code, rl, () => executeAndForwardOutput(code, last_command_result, parent_message_id, rl));
}

export { executeCode };

```

src/execute/executeAndForwardOutput.js:
```
import { spawn } from 'child_process';
import { startInteractiveSession } from "../interactiveSession/startInteractiveSession.js";

function executeAndForwardOutput(code, last_command_result, parent_message_id, rl) {
  const child = spawn(code, { shell: true });

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
    startInteractiveSession(last_command_result, parent_message_id, rl)
  });
}

export { executeAndForwardOutput };

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!
- Every js file should only export a single function!
- Use ES6 imports!

Requirements:

We do not need to send the result of previous command and the last message id to the api, so last_command_result and parent_message_id should be eliminated from function signatures.



# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, prefer heredoc-ing full files without substitution.
Assume OSX.
npm and jq are installed.
Do NOT write any text outside the script (the plan goes into it)!


EXAMPLE START

```sh
#!/bin/sh
# Goal: [Task description, max 7 words]
# Plan:
# 1. [...]

[Commands solving the task]
```

EXAMPLE END

