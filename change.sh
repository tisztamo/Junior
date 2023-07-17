#!/bin/sh
# Goal: Refactor code to fix file loading error
# Plan:
# 1. Create src/prompt/loadPromptFile.js and extract the file loading logic from loadFormatTemplate.js to this new file
# 2. Modify loadFormatTemplate.js and loadTaskTemplate.js to use the new loadPromptFile function
# 3. Move getSystemPrompt function to src/prompt/
# 4. Modify getSystemPrompt to use the new loadPromptFile function
# 5. Update imports in getSystemPromptIfNeeded.js and config.js to reflect the changes

# Step 1: Create src/prompt/loadPromptFile.js
cat << 'EOF' > ./src/prompt/loadPromptFile.js
import util from 'util';
import fs from 'fs';
import path from 'path';
import ejs from 'ejs';

const readFile = util.promisify(fs.readFile);

const loadPromptFile = async (filePath, templateVars) => {
  try {
    // Try to read the file relative to the current directory
    return await ejs.renderFile(filePath, templateVars, {async: true});
  } catch (err) {
    // If the file doesn't exist, try reading it from the project root directory
    const rootPath = path.resolve(__dirname, '../../', filePath);
    return await ejs.renderFile(rootPath, templateVars, {async: true});
  }
};

export { loadPromptFile };
EOF

# Step 2: Modify loadFormatTemplate.js and loadTaskTemplate.js to use the new loadPromptFile function
cat << 'EOF' > ./src/prompt/loadFormatTemplate.js
import { loadPromptFile } from './loadPromptFile.js';

const loadFormatTemplate = async (formatTemplatePath, templateVars) => {
  return await loadPromptFile(formatTemplatePath, templateVars);
};

export { loadFormatTemplate };
EOF

cat << 'EOF' > ./src/prompt/loadTaskTemplate.js
import { loadPromptFile } from './loadPromptFile.js';

const loadTaskTemplate = async (taskTemplatePath, templateVars) => {
  return await loadPromptFile(taskTemplatePath, templateVars);
};

export { loadTaskTemplate };
EOF

# Step 3: Move getSystemPrompt function to src/prompt/
# Step 4: Modify getSystemPrompt to use the new loadPromptFile function
cat << 'EOF' > ./src/prompt/getSystemPrompt.js
import fs from 'fs/promises';
import { loadPromptFile } from './loadPromptFile.js';

async function getSystemPrompt() {
  return (await loadPromptFile("prompt/system.md", {})).toString();
}

export { getSystemPrompt };
EOF

# Step 5: Update imports in getSystemPromptIfNeeded.js and config.js to reflect the changes
cat << 'EOF' > ./src/prompt/getSystemPromptIfNeeded.js
import { getSystemPrompt } from "./getSystemPrompt.js";

async function getSystemPromptIfNeeded() {
  if (process.argv.includes("--system-prompt") || process.argv.includes("-s")) {
    return `${await getSystemPrompt()}\n`;
  }
  return "";
}

export { getSystemPromptIfNeeded };
EOF

cat << 'EOF' > ./src/config.js
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
EOF

# Update imports in src/main.js
cat << 'EOF' > ./src/main.js
#!/usr/bin/env node

import { startInteractiveSession } from './interactiveSession/startInteractiveSession.js';
import { api, get_model, rl } from './config.js';
import { getSystemPrompt } from './prompt/getSystemPrompt.js';

console.log("Welcome to Contributor. Model: " + get_model() + "\n");
console.log("System prompt:", await getSystemPrompt())

startInteractiveSession("", null, rl, api);

export { startInteractiveSession };
EOF

# Update imports in src/prompt/createPrompt.js
cat << 'EOF' > ./src/prompt/createPrompt.js
import { readAttention } from "../attention/readAttention.js"
import util from 'util';
import fs from 'fs';
import yaml from 'js-yaml';
import ejs from 'ejs';
import { getPromptFlag } from './getPromptFlag.js';
import { getSystemPromptIfNeeded } from './getSystemPromptIfNeeded.js';
import { resolveTemplateVariables } from './resolveTemplateVariables.js';
import { extractTemplateVars } from './extractTemplateVars.js';
import { loadPromptDescriptor } from './loadPromptDescriptor.js';
import { loadTaskTemplate } from './loadTaskTemplate.js';
import { loadFormatTemplate } from './loadFormatTemplate.js';
const readFile = util.promisify(fs.readFile);

const createPrompt = async (userInput) => {
  const promptDescriptor = yaml.load(await loadPromptDescriptor());
  let templateVars = extractTemplateVars(promptDescriptor);

  templateVars = await resolveTemplateVariables(templateVars);

  const attention = await readAttention(promptDescriptor.attention);
  const task = await loadTaskTemplate(promptDescriptor.task, templateVars);
  const format = await loadFormatTemplate(promptDescriptor.format, templateVars);
  const system = await getSystemPromptIfNeeded();
  const saveto = promptDescriptor.saveto;
  return {
    prompt: `# Working set\n\n${attention.join("\n")}\n\n# Task\n\n${task}\n\n# Output Format\n\n${format}\n\n${userInput ? userInput : ""}`,
    saveto
  };
}

export { createPrompt };
EOF

cat << 'EOF' > ./src/prompt/createPrompt.js
import { readAttention } from "../attention/readAttention.js"
import util from 'util';
import fs from 'fs';
import yaml from 'js-yaml';
import ejs from 'ejs';
import { getPromptFlag } from './getPromptFlag.js';
import { getSystemPromptIfNeeded } from './getSystemPromptIfNeeded.js';
import { resolveTemplateVariables } from './resolveTemplateVariables.js';
import { extractTemplateVars } from './extractTemplateVars.js';
import { loadPromptDescriptor } from './loadPromptDescriptor.js';
import { loadTaskTemplate } from './loadTaskTemplate.js';
import { loadFormatTemplate } from './loadFormatTemplate.js';
const readFile = util.promisify(fs.readFile);

const createPrompt = async (userInput) => {
  const promptDescriptor = yaml.load(await loadPromptDescriptor());
  let templateVars = extractTemplateVars(promptDescriptor);

  templateVars = await resolveTemplateVariables(templateVars);

  const attention = await readAttention(promptDescriptor.attention);
  const task = await loadTaskTemplate(promptDescriptor.task, templateVars);
  const format = await loadFormatTemplate(promptDescriptor.format, templateVars);
  const system = await getSystemPromptIfNeeded();
  const saveto = promptDescriptor.saveto;
  return {
    prompt: `${system}# Working set\n\n${attention.join("\n")}\n\n# Task\n\n${task}\n\n# Output Format\n\n${format}\n\n${userInput ? userInput : ""}`,
    saveto
  };
}

export { createPrompt };
EOF

cat << 'EOF' > ./src/prompt/loadPromptFile.js
import fs from 'fs';
import path from 'path';
import ejs from 'ejs';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));

const loadPromptFile = async (filePath, templateVars) => {
  try {
    // Try to read the file relative to the current directory
    return await ejs.renderFile(filePath, templateVars, {async: true});
  } catch (err) {
    // If the file doesn't exist, try reading it from the project root directory
    const rootPath = path.resolve(__dirname, '../../', filePath);
    return await ejs.renderFile(rootPath, templateVars, {async: true});
  }
};

export { loadPromptFile };
EOF
