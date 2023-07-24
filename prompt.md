# Working set

```
./src/
├── .DS_Store
├── attention/...
├── backend/...
├── config.js
├── doc/...
├── execute/...
├── frontend/...
├── git/...
├── index.html
├── interactiveSession/...
├── llm/...
├── main.js
├── prompt/...
├── startVite.js
├── vite.config.js
├── web.js

```
```
./src/llm/
├── openai/...

```
```
./src/llm/openai/
├── createApi.js

```
src/config.js:
```
import readline from 'readline';
import createApi from './llm/openai/createApi.js';

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
    return {
      sendMessage: () => { return {id: 42, text: "DRY RUN, NOT SENT"}}
    };
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

src/llm/openai/createApi.js:
```
import fs from 'fs';
import { ChatGPTAPI } from 'chatgpt';
import { getSystemPrompt } from "../../prompt/getSystemPrompt.js";

export default async function createApi(model) {
  let apiKey = process.env.OPENAI_API_KEY;

  if (!apiKey) {
    if (fs.existsSync('./secret.sh')) {
      const secretFileContent = fs.readFileSync('./secret.sh', 'utf-8');
      const match = secretFileContent.match(/export OPENAI_API_KEY=(\S+)/);
      if (match) {
        apiKey = match[1];
      }
    }
  }

  if (!apiKey) {
    throw new Error('OPENAI_API_KEY not found');
  }

  const systemMessage = await getSystemPrompt();

  return new ChatGPTAPI({
    debug: true,
    apiKey,
    systemMessage,
    completionParams: {
      model,
      stream: true,
      temperature: 0.5,
      max_tokens: 2048,
    }
  });
}

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!
- Every js file should only export a single function!
- Use ES6 imports!

Requirements:

Factor out the dry-run fake api creation from config.js to llm/fake/createFakeApi.js (create dir) In openai/createApi.js, when the api key not found for openai, console.warn and return a fake api instance.



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

