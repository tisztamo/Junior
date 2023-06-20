// Returns a string to be used as AI prompt, composed of the current attention, task description, and output format

import { readAttention } from "../attention/readAttention.js"
import fs from 'fs';
import util from 'util';
import yaml from 'js-yaml';
const readFile = util.promisify(fs.readFile);

const createPrompt = async (userInput) => {
  const promptDescriptor = yaml.load(await readFile("prompt/prompt.yaml", "utf8"));
  
  const attention = await readAttention(promptDescriptor.attention);
  const task = await readFile(promptDescriptor.task, "utf8");
  const format = await readFile(promptDescriptor.format, "utf8");
  
  return `# Attention\n${attention}\n\n# Task\n${task}\n\n# Output Format\n${format}\n\n${userInput ? userInput : ""}`;
}

export default createPrompt
