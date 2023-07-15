#!/bin/sh
# Goal: Load task file relative to current or project root directory
# Plan:
# 1. Extract existing `createPrompt` function from `createPrompt.js` file to a new `loadTaskTemplate.js` file
# 2. Update the `createPrompt` function in `createPrompt.js` to import the new `loadTaskTemplate` function
# 3. Update `loadTaskTemplate` function to first try loading the file relative to the current directory, if not found, load it from the project root directory

# Step 1: Extract existing `createPrompt` function to a new `loadTaskTemplate.js` file
cat << 'EOF' > ./src/prompt/loadTaskTemplate.js
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

EOF

# Step 2: Update `createPrompt` function in `createPrompt.js` to import the new `loadTaskTemplate` function
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
const readFile = util.promisify(fs.readFile);

const createPrompt = async (userInput) => {
  const promptDescriptor = yaml.load(await loadPromptDescriptor());
  let templateVars = extractTemplateVars(promptDescriptor);

  templateVars = await resolveTemplateVariables(templateVars);

  const attention = await readAttention(promptDescriptor.attention);
  const task = await loadTaskTemplate(promptDescriptor.task, templateVars);
  const format = await ejs.renderFile(promptDescriptor.format, templateVars, {async: true});
  const system = await getSystemPromptIfNeeded();
  const saveto = promptDescriptor.saveto;
  return {
    prompt: `# Working set\n\n${attention.join("\n")}\n\n# Task\n\n${task}\n\n# Output Format\n\n${format}\n\n${userInput ? userInput : ""}`,
    saveto
  };
}

export { createPrompt };

EOF

#!/bin/sh
# Goal: Load task and format files relative to current or project root directory
# Plan:
# 1. Create new `loadFormatTemplate.js` file with similar logic as `loadTaskTemplate.js`
# 2. Update `createPrompt` function in `createPrompt.js` to import and use the new `loadFormatTemplate` function

# Step 1: Create new `loadFormatTemplate.js` file with similar logic as `loadTaskTemplate.js`
cat << 'EOF' > ./src/prompt/loadFormatTemplate.js
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

EOF

# Step 2: Update `createPrompt` function in `createPrompt.js` to import and use the new `loadFormatTemplate` function
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
