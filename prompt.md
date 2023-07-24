# Working set

src/config.js:
```
import readline from 'readline';
import { ChatGPTAPI } from 'chatgpt';
import { getSystemPrompt } from "./prompt/getSystemPrompt.js";

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


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!
- Every js file should only export a single function!
- Use ES6 imports!

Requirements:

When no OPENAI_API_KEY env var presents, try to open ./secret.sh
and parse it to get the key.
Move this logic and the &#34;new ChatGPTAPI&#34; call to a function in src/llm/openai/createApi.js (create the dir).



# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, prefer heredoc-ing full files using 'EOF' to prevent substitution.
OS: Debian
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

