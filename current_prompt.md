You're the 'Contributor', an AI system aiding authors.

You are working on the source of a program, too large for your memory, so only part of it, the "Working Set" is provided here.

Some files are printed in the working set.

Other files are only listed in their dir, so you know they exists, ask for the contents if needed.

The contents of some dirs are not listed, ask for their content if needed.

# Working set

src/:
attention, config.js, execute, main.js, prompt, utils

src/main.js:
#!/usr/bin/env node

import createPrompt from './prompt/createPrompt.js';
import fs from 'fs/promises';
import { api, get_model, getSystemPrompt, rl } from './config.js';
import executeCode from './execute/executeCode.js';
import extractCode from './execute/extractCode.js';

console.log("Welcome to Contributor. Model: " + get_model() + "\n");
console.log("System prompt:", await getSystemPrompt())

const main = async (last_command_result = "", parent_message_id = null, rl) => {
  rl.question('$ ', async (task) => {
    let lastTextLength = 0;
    console.log("\x1b[2m");
    const prompt = await createPrompt(task, last_command_result)
    console.debug("Query:", prompt)
    await fs.writeFile("current_prompt.md", prompt)
    const res = await api.sendMessage(prompt, {
      parentMessageId: parent_message_id,
      onProgress: (partialResponse) => {
        // Print only the new text added to the partial response
        const newText = partialResponse.text.slice(lastTextLength);
        process.stdout.write(newText);
        lastTextLength = partialResponse.text.length;
      }
    });
    parent_message_id = res.id;
    console.log("\x1b[0m");
    const msg = res.text.trim();
    console.log("");
    const cod = extractCode(msg);
    if (cod) {
      await executeCode(cod, last_command_result, parent_message_id, rl);
    } else {
      last_command_result = "";
      main(last_command_result, parent_message_id, rl);
    }
  });
}

main("", null, rl);

export default main;


src/prompt/createPrompt.js:
// Returns a string to be used as AI prompt, composed of the current attention, task description, and output format

import { readAttention } from "../attention/readAttention.js"
import fs from 'fs';
import util from 'util';
import yaml from 'js-yaml';
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
  const attention = await readAttention(promptDescriptor.attention);
  const task = await readFile(promptDescriptor.task, "utf8");
  const format = await readFile(promptDescriptor.format, "utf8");
  const system = await getSystemPromptIfNeeded();
  return `${system}# Working set\n\n${attention}\n\n# Task\n\n${task}\n\n# Output Format\n\n${format}\n\n${userInput ? userInput : ""}`;
}

export default createPrompt


current_prompt.yaml:
task: prompt/task/feature/implement.md
format: prompt/format/new_file_version.md
attention: attention.txt
saveto: current_prompt.md



# Task

Implement the following new feature!

- Write a small synopsis about the implementation!
- Create new files when needed! Target line count: 20

# Output Format

Provide the new file(s) as code blocks, each prefixed with its path and a colon.
Avoid any explanatory text, as your output will be programmatically processed!

current_prompt.yaml now optionally contains a "saveto" line, pointing to the path where the full prompt should be saved.