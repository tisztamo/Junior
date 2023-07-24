# Working set

src/config.js:
```
import readline from 'readline';
import createApi from './llm/openai/createApi.js';
import createFakeApi from './llm/fake/createFakeApi.js';

function isDryRun() {
  return process.argv.includes("-d") || process.argv.includes("--dry-run");
}

function get_model() {
  const modelArg = process.argv.find(arg => arg.startsWith('--model='));
  if (modelArg) {
    return modelArg.split('=')[1];
  }
  return "gpt-4";
}

async function getApi() {
  if (isDryRun()) {
    return createFakeApi();
  } else {
    return await createApi(get_model());
  }
}

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

export { getApi, rl, get_model };

```

src/interactiveSession/saveAndSendPrompt.js:
```
import { printNewText } from './printNewText.js';
import { handleApiResponse } from './handleApiResponse.js';
import { api, rl } from '../config.js';

const saveAndSendPrompt = async (prompt, task) => {
  let lastTextLength = 0;
  const res = await api.sendMessage(prompt, { onProgress: printNewText(lastTextLength) });
  console.log("\x1b[0m");
  const msg = res.text.trim();
  console.log("");
  handleApiResponse(msg);
}

export { saveAndSendPrompt };

```

src/main.js:
```
#!/usr/bin/env node

import { startInteractiveSession } from './interactiveSession/startInteractiveSession.js';
import { api, get_model, rl } from './config.js';

console.log("Welcome to Junior. Model: " + get_model() + "\n");

startInteractiveSession(rl, api);

export { startInteractiveSession };

```


# Task

Fix the following issue!

file:///Users/ko/projects-new/Junior/src/interactiveSession/saveAndSendPrompt.js:3 import { api, rl } from &#39;../config.js&#39;;
       ^^^
SyntaxError: The requested module &#39;../config.js&#39; does not provide an export named &#39;api&#39;
  at ModuleJob._instantiate

api was changed to getApi() in config.js Also fix main.js to use getApi()


# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, prefer heredoc-ing full files using 'EOF' to prevent substitution.
OS: OSX
Installed tools: npm, jq
Do NOT write any text outside the script!

EXAMPLE START

```sh
#!/bin/sh
set -e
goal=[Task description, max 7 words]
echo "Plan:"
echo "1. [...]"
[Commands solving the task]
echo "\033[32mDone: $goal\033[0m\n"
```

EXAMPLE END

