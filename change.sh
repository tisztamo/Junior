#!/bin/sh
# Goal: Print the contents of the prompt descriptor file (in its original format) to the console before asking for notes!
# Avoid "prompt.yaml" to be duplicated in the source code by creating a prompt descriptor loader function
# that takes an argument "rawPrinter" and if provided, prints the name, a colon, a newline and the content of the file using it!
# Plan:
# 1. Create a new file called loadPromptDescriptor.js that will be responsible for loading the prompt descriptor file.
# 2. In loadPromptDescriptor.js, create a function that accepts a "rawPrinter" argument. If "rawPrinter" is provided, the function should print the filename, a colon, a newline, and the content of the file.
# 3. Replace the direct call to readFile for prompt.yaml in createPrompt.js with the call to our new function.
# 4. Adjust startInteractiveSession.js to call the new function before asking for notes.

cat > src/prompt/loadPromptDescriptor.js << EOF
import fs from 'fs';
import util from 'util';

const readFile = util.promisify(fs.readFile);
const descriptorFileName = "prompt.yaml";

const loadPromptDescriptor = async (rawPrinter) => {
  const descriptorContent = await readFile(descriptorFileName, 'utf8');
  if (rawPrinter) {
    rawPrinter(descriptorFileName + ':\n' + descriptorContent);
  }
  return descriptorContent;
};

export { loadPromptDescriptor };
EOF

# Update createPrompt.js to use the new function
cat > src/prompt/createPrompt.js << EOF
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
const readFile = util.promisify(fs.readFile);

const createPrompt = async (userInput) => {
  const promptDescriptor = yaml.load(await loadPromptDescriptor());
  let templateVars = extractTemplateVars(promptDescriptor);

  templateVars = await resolveTemplateVariables(templateVars);

  const attention = await readAttention(promptDescriptor.attention);
  const task = await ejs.renderFile(promptDescriptor.task, templateVars, {async: true});
  const format = await ejs.renderFile(promptDescriptor.format, templateVars, {async: true});
  const system = await getSystemPromptIfNeeded();
  const saveto = promptDescriptor.saveto;
  return {
    prompt: \`${system}# Working set\n\n\${attention.join("\n")}\n\n# Task\n\n\${task}\n\n# Output Format\n\n\${format}\n\n\${userInput ? userInput : ""}\`,
    saveto
  };
}

export { createPrompt };
EOF

# Adjust startInteractiveSession.js to use new function
cat > src/interactiveSession/startInteractiveSession.js << EOF
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
EOF
