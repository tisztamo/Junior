You're the 'Contributor', an AI system aiding authors.

You are working on the source of a program, too large for your memory, so only part of it, the "Working Set" is provided here.

You will see a partial directory structure. Ask for the contents of subdirs marked with /... if needed.

Some files are printed in the working set.

Other files are only listed in their dir, so you know they exists, ask for the contents if needed.

# Working set

src/interactiveSession/startInteractiveSession.js:
import { createPrompt } from '../prompt/createPrompt.js';
import { saveAndSendPrompt } from './saveAndSendPrompt.js';

const startInteractiveSession = async (last_command_result = "", parent_message_id = null, rl, api) => {
  rl.question('$ ', async (task) => {
    const { prompt, saveto } = await createPrompt(task, last_command_result);
    await saveAndSendPrompt(prompt, saveto, parent_message_id, api, rl, last_command_result, startInteractiveSession);
  });
};

export { startInteractiveSession };


src/prompt/createPrompt.js:
// Returns an object containing the AI prompt and the save location. 
// The AI prompt is composed of the current attention, task description, and output format.

import { readAttention } from "../attention/readAttention.js"
import util from 'util';
import fs from 'fs';
import yaml from 'js-yaml';
import ejs from 'ejs';
import { getSystemPrompt } from "../config.js";
const readFile = util.promisify(fs.readFile);

// Get the value of the --prompt flag, if it exists
function getPromptFlag() {
  const promptFlag = process.argv.find(arg => arg.startsWith("--prompt="));
  if (promptFlag) {
    return promptFlag.split("=")[1];
  }
}

// return the system prompt if the --system-prompt or -s flag is present
async function getSystemPromptIfNeeded() {
  if (process.argv.includes("--system-prompt") || process.argv.includes("-s")) {
    return `${await getSystemPrompt()}\n`;
  }
  return "";
}

const createPrompt = async (userInput) => {
  const promptDescriptor = yaml.load(await readFile(getPromptFlag() || "prompt/prompt-list.yaml", "utf8"));
  const templateVars = Object.keys(promptDescriptor)
    .filter(key => ['task', 'format', 'attention', 'saveto'].indexOf(key) < 0)
    .reduce((obj, key) => {
      obj[key] = promptDescriptor[key];
      return obj;
    }, {});

  const attention = await readAttention(promptDescriptor.attention);
  const task = await ejs.renderFile(promptDescriptor.task, templateVars, {async: true});
  const format = await ejs.renderFile(promptDescriptor.format, templateVars, {async: true});
  const system = await getSystemPromptIfNeeded();
  const saveto = promptDescriptor.saveto;
  return {
    prompt: `${system}# Working set\n\n${attention.join("\n")}\n\n# Task\n\n${task}\n\n# Output Format\n\n${format}\n\n${userInput ? userInput : ""}`,
    saveto
  };
}

export { createPrompt };


current_prompt.yaml:
task: prompt/task/feature/implement.md
format: prompt/format/new_file_version.md
attention:
  - src/interactiveSession/startInteractiveSession.js  
  - src/prompt/createPrompt.js
  - current_prompt.yaml
saveto: current_prompt.md
requirements: requirements.md



# Task

Implement the following feature!

- Write a plan before the implementation!
- Create new files when needed!
- When a file is larger than 25 lines or can be splitted logically, split it!

Requirements:

When creating prompts from the yaml descriptor, injecting arbitrary values into the
markdown files would be great! E.g. the "requirements" key is not parsed currently,
but it would be nice for the implement.md (This markdown file injected into the current prompt) to allow us simply write ${requirements}
in ES6 style.

Notes:

Idea: ejs is what we need. All uknown keys in the yaml should be made available for a ejs template.
This template is used instead of the markdown files. The template, when filled out, reveals a markdown, which will be injected to the prompt.

Test: requirements.md

# Output Format

Provide the new file(s) as code blocks, each prefixed with its path and a colon.
Avoid any explanatory text, as your output will be programmatically processed!

