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

console.log("Welcome to Contributor. Model: " + get_model() + "\n");

startInteractiveSession(rl, api);

export { startInteractiveSession };

```

src/config.js:
```
import readline from 'readline';
import { ChatGPTAPI } from 'chatgpt';
import { getSystemPrompt } from "./prompt/getSystemPrompt.js";

// test if -d or --dry-run cli arg is present
function isDryRun() {
  return process.argv.includes("-d") || process.argv.includes("--dry-run");
}

const api = isDryRun() ? {
    sendMessage: () => { return {id: 42, text: "DRY RUN, NOT SENT"}}
  } : new ChatGPTAPI({
  debug: true,
  apiKey: process.env.OPENAI_API_KEY,
  systemMessage: await getSystemPrompt(),
  completionParams: {
    model: get_model(),
    stream: true,
    temperature: 0.5,
    max_tokens: 2048,
  }
});

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function get_model() {
  const modelArg = process.argv.find(arg => arg.startsWith('--model='));
  if (modelArg) {
    return modelArg.split('=')[1];
  }
  return "gpt-4";
}

export { api, rl, get_model };

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

```

src/interactiveSession/saveAndSendPrompt.js:
```
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

```

src/interactiveSession/handleApiResponse.js:
```
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

```

src/execute/executeCode.js:
```
#!/usr/bin/env node

import { confirmAndWriteCode } from './confirmAndWriteCode.js';
import { executeAndForwardOutput } from './executeAndForwardOutput.js';

const executeCode = async (code, rl, api) => {
  confirmAndWriteCode(code, rl, () => executeAndForwardOutput(code, rl, api));
}

export { executeCode };

```

src/execute/executeAndForwardOutput.js:
```
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

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!
- Every js file should only export a single function!
- Use ES6 imports!

Requirements:

Do not pass rl, import from the config whenever needed.



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

