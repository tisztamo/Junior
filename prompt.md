# Working set

```
./
├── .DS_Store
├── .git/...
├── .gitignore
├── .vscode/...
├── README.md
├── babel.config.js
├── change.sh
├── dist/...
├── doc/...
├── node_modules/...
├── package-lock.json
├── package.json
├── prompt/...
├── prompt.md
├── prompt.yaml
├── secret.sh
├── src/...
├── tmp/...

```
```
src/interactiveSession/
├── handleApiResponse.js
├── printNewtext.js
├── saveAndSendPrompt.js
├── startInteractiveSession.js

```
src/config.js:
```
import fs from 'fs/promises';
import readline from 'readline';
import { ChatGPTAPI } from 'chatgpt';

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
  console.log("modelArg", modelArg)
  console.log("argv", process.argv)
  if (modelArg) {
    return modelArg.split('=')[1];
  }
  return "gpt-4";
}

async function getSystemPrompt() {
  return (await fs.readFile("prompt/system.md", "utf8")).toString()
}
export { api, rl, get_model, getSystemPrompt};

```

src/interactiveSession/startInteractiveSession.js:
```
import processPrompt from '../prompt/promptProcessing.js';
import { saveAndSendPrompt } from './saveAndSendPrompt.js';

const startInteractiveSession = async (last_command_result = "", parent_message_id = null, rl, api) => {
  rl.question('$ ', async (task) => {
    const { prompt, parent_message_id: newParentMessageId } = await processPrompt(task, last_command_result);
    await saveAndSendPrompt(prompt, newParentMessageId, api, rl, last_command_result, startInteractiveSession);
  });
};

export { startInteractiveSession };

```

src/interactiveSession/saveAndSendPrompt.js:
```
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


# Task

Implement the following feature!

- Write a plan first, only implement after the plan is ready!
- Create new files when needed!
- Every js js file should only export a single function!

Requirements:

Instead of &#34;npm run cli 4&#34; we want to set the model with --model, like  &#34;npm run cli --model=gpt-4&#34;. The default model should be gpt-4.



# Output Format

./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files should be heredoc.
Assume OSX. npm and jq are installed.

# Working set

```
./
├── .DS_Store
├── .git/...
├── .gitignore
├── .vscode/...
├── README.md
├── babel.config.js
├── change.sh
├── dist/...
├── doc/...
├── node_modules/...
├── package-lock.json
├── package.json
├── prompt/...
├── prompt.md
├── prompt.yaml
├── secret.sh
├── src/...
├── tmp/...

```
```
src/interactiveSession/
├── handleApiResponse.js
├── printNewtext.js
├── saveAndSendPrompt.js
├── startInteractiveSession.js

```
src/config.js:
```
import fs from 'fs/promises';
import readline from 'readline';
import { ChatGPTAPI } from 'chatgpt';

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
  console.log("modelArg", modelArg)
  console.log("argv", process.argv)
  if (modelArg) {
    return modelArg.split('=')[1];
  }
  return "gpt-4";
}

async function getSystemPrompt() {
  return (await fs.readFile("prompt/system.md", "utf8")).toString()
}
export { api, rl, get_model, getSystemPrompt};

```

src/interactiveSession/startInteractiveSession.js:
```
import processPrompt from '../prompt/promptProcessing.js';
import { saveAndSendPrompt } from './saveAndSendPrompt.js';

const startInteractiveSession = async (last_command_result = "", parent_message_id = null, rl, api) => {
  rl.question('$ ', async (task) => {
    const { prompt, parent_message_id: newParentMessageId } = await processPrompt(task, last_command_result);
    await saveAndSendPrompt(prompt, newParentMessageId, api, rl, last_command_result, startInteractiveSession);
  });
};

export { startInteractiveSession };

```

src/interactiveSession/saveAndSendPrompt.js:
```
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


# Task

Implement the following feature!

- Write a plan first, only implement after the plan is ready!
- Create new files when needed!
- Every js js file should only export a single function!

Requirements:

Instead of &#34;npm run cli 4&#34; we want to set the model with --model, like  &#34;npm run cli --model=gpt-4&#34;. The default model should be gpt-4.



# Output Format

./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files should be heredoc.
Assume OSX. npm and jq are installed.

