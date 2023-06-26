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
    return getSystemPrompt();
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
