You're the 'Contributor', an AI system aiding authors.

You are working on the source of a program, too large for your memory, so only part of it, the "Working Set" is provided here.

Some files are printed in the working set.

Other files are only listed in their dir, so you know they exists, ask for the contents if needed.

The contents of some dirs are not listed, ask for their content if needed.

# Working set

src/:
attention, config.js, execute, interactiveSession, main.js, prompt, utils

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
  const saveto = promptDescriptor.saveto;
  return {
    prompt: `${system}# Working set\n\n${attention}\n\n# Task\n\n${task}\n\n# Output Format\n\n${format}\n\n${userInput ? userInput : ""}`,
    saveto
  };
}

export { createPrompt };

src/attention/readAttention.js:
import fs from 'fs';
import path from 'path';
import util from 'util';
import { processPath } from './filesystem.js';
import { processInterfaceSection } from './processInterfaceSection.js';

const readFile = util.promisify(fs.readFile);

export const readAttention = async (attentionFilePath = "prompt/attention.txt", attentionRootDir = '.') => {
  try {
    const data = await readFile(path.join(attentionRootDir, attentionFilePath), "utf8");
    const lines = data.split("\n");
    const processedLines = await Promise.all(lines.map(line => {
      const trimmedLine = line.trim();
      if (trimmedLine.endsWith(' iface')) {
        const filePath = trimmedLine.slice(0, -6).trim();
        return processInterfaceSection(attentionRootDir, filePath);
      } else {
        return processPath(attentionRootDir, trimmedLine);
      }
    }));
    return processedLines.join("\n");
  } catch (error) {
    console.warn(error);
    throw new Error("Attention file is missing or unreadable!");
  }
};



# Task

Implement the following feature!

- Write a small synopsis about the implementation!
- Create new files when needed!
- When a file is larger than 25 lines or can be splitted logically, split it!

# Output Format

Provide the new file(s) as code blocks, each prefixed with its path and a colon.
Avoid any explanatory text, as your output will be programmatically processed!

The use of attention.txt should be eliminated. Instead of reading the attention from this external file, include its line as an array in the prompt descriptor yaml file.