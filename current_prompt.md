You're the 'Contributor', an AI system aiding authors.

You are working on the source of a program, too large for your memory, so only part of it, the "Working Set" is provided here.

You will see a partial directory structure. Ask for the contents of subdirs marked with /... if needed.

Some files are printed in the working set.

Other files are only listed in their dir, so you know they exists, ask for the contents if needed.

# Working set

./
├── .DS_Store
├── .git/...
├── .gitignore
├── .vscode/...
├── current_prompt.md
├── current_prompt.yaml
├── doc/...
├── node_modules/...
├── package-lock.json
├── package.json
├── prompt/...
├── secret.sh
├── src/...
├── tmp/...

./src/
├── attention/...
├── config.js
├── execute/...
├── interactiveSession/...
├── main.js
├── prompt/...
├── utils/...

src/prompt/createPrompt.js:
// Returns an object containing the AI prompt and the save location. 
// The AI prompt is composed of the current attention, task description, and output format.

import { readAttention } from "../attention/readAttention.js"
import util from 'util';
import fs from 'fs';
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
    prompt: `${system}# Working set\n\n${attention.join("\n")}\n\n# Task\n\n${task}\n\n# Output Format\n\n${format}\n\n${userInput ? userInput : ""}`,
    saveto
  };
}

export { createPrompt };


src/attention/readAttention.js:
import { processPath } from './filesystem.js';
import { processInterfaceSection } from './processInterfaceSection.js';
import { printFolderStructure } from './printFolderStructure.js';

export const readAttention = async (attentionArray = [], attentionRootDir = '.') => {
  try {
    const processedLines = await Promise.all(attentionArray.map(line => {
      const trimmedLine = line.trim();
      if (trimmedLine.endsWith(' iface')) {
        const filePath = trimmedLine.slice(0, -6).trim();
        return processInterfaceSection(attentionRootDir, filePath);
      } else if (trimmedLine.endsWith('/')) {
        return printFolderStructure(attentionRootDir, trimmedLine.slice(0, -1).trim());
      } else {
        return processPath(attentionRootDir, trimmedLine);
      }
    }));
    return processedLines;
  } catch (error) {
    console.warn(error);
    throw new Error("Error processing attention lines!");
  }
};



# Task

Implement the following feature!

- Write a plan before the implementation!
- Create new files when needed!
- When a file is larger than 25 lines or can be splitted logically, split it!

The attention consists of files and listed directories.
We will improve it by printing a PARTIAL folder structure instead of listing all directories.

## Example

A sample prompt descriptor:

```yaml
task: prompt/task/feature/implement.md
format: prompt/format/new_file_version.md
attention:
  - ./
  - prompt/
  - src/
  - src/attention/readAttention.js
```

This should generate the following output:

```
/
├── doc/...
├── node_modules/...
├── package.json
├── prompt/
│   ├── attention-cache/...
│   ├── format/...
│   ├── prompt-drill.yaml
│   ├── prompt-list.yaml
│   ├── system.md
│   ├── system.md.old
│   └── task/...
├── secret.sh
├── src/
│   ├── attention/...
│   ├── config.js
│   ├── execute/...
│   ├── interactiveSession/
│   │   ├── handleApiResponse.js
│   │   ├── printNewtext.js
│   │   ├── saveAndSendPrompt.js
│   │   └── startInteractiveSession.js
│   ├── main.js
│   ├── prompt/...
│   └── utils/...
└── tmp/...

src/attention/readAttention.js:
[contents of readAttention.js]

Notes:

 - Use the special characters ├ and │ to show the levels of the hierarchy!
 - Only list directories mentioned in the descriptor, do not recurse!
 - While listing a dir, list both files and subdirs, but mark subdirs with / at the end of the line!
 - While listing a dir, if found a subdir not mentioned in the descriptor, mark it with /... at the end of the line!


# Output Format

Provide the new file(s) as code blocks, each prefixed with its path and a colon.
Avoid any explanatory text, as your output will be programmatically processed!

