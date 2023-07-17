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
./src/prompt/loadFormatTemplate.js:
```
import util from 'util';
import fs from 'fs';
import path from 'path';
import ejs from 'ejs';

const readFile = util.promisify(fs.readFile);

const loadFormatTemplate = async (formatTemplatePath, templateVars) => {
  try {
    // Try to read the file relative to the current directory
    return await ejs.renderFile(formatTemplatePath, templateVars, {async: true});
  } catch (err) {
    // If the file doesn't exist, try reading it from the project root directory
    const rootPath = path.resolve(__dirname, '../../', formatTemplatePath);
    return await ejs.renderFile(rootPath, templateVars, {async: true});
  }
};

export { loadFormatTemplate };


```

./src/prompt/loadTaskTemplate.js:
```
import util from 'util';
import fs from 'fs';
import path from 'path';
import ejs from 'ejs';

const readFile = util.promisify(fs.readFile);

const loadTaskTemplate = async (taskTemplatePath, templateVars) => {
  try {
    // Try to read the file relative to the current directory
    return await ejs.renderFile(taskTemplatePath, templateVars, {async: true});
  } catch (err) {
    // If the file doesn't exist, try reading it from the project root directory
    const rootPath = path.resolve(__dirname, '../../', taskTemplatePath);
    return await ejs.renderFile(rootPath, templateVars, {async: true});
  }
};

export { loadTaskTemplate };


```

./src/config.js:
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

src/prompt/getSystemPromptIfNeeded.js:
```
import { getSystemPrompt } from "../config.js";

async function getSystemPromptIfNeeded() {
  if (process.argv.includes("--system-prompt") || process.argv.includes("-s")) {
    return `${await getSystemPrompt()}\n`;
  }
  return "";
}

export { getSystemPromptIfNeeded };

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!
- Every js file should only export a single function!
- Use ES6 imports!

Requirements:

When running from another dir, I get [Error: ENOENT: no such file or directory, open &#39;prompt/system.md&#39;]
The system prompt should be loaded using the same logic that is used for the format prompt.
Refactor the code so that 1. this logic is extracted to src/prompt/loadPromptFile.js and 2. getSystemPrompt is extracted to src/prompt/



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

