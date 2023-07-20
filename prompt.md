# Working set

src/prompt/loadPromptFile.js:
```
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

```

src/prompt/createPrompt.js:
```
import { readAttention } from "../attention/readAttention.js"
import yaml from 'js-yaml';
import { getSystemPromptIfNeeded } from './getSystemPromptIfNeeded.js';
import { resolveTemplateVariables } from './resolveTemplateVariables.js';
import { extractTemplateVars } from './extractTemplateVars.js';
import { loadPromptDescriptor } from './loadPromptDescriptor.js';
import { loadTaskTemplate } from './loadTaskTemplate.js';
import { loadFormatTemplate } from './loadFormatTemplate.js';

const createPrompt = async (userInput) => {
  const promptDescriptor = yaml.load(await loadPromptDescriptor());
  let templateVars = extractTemplateVars(promptDescriptor);

  templateVars = await resolveTemplateVariables(templateVars);

  const attention = await readAttention(promptDescriptor.attention);
  const task = await loadTaskTemplate(promptDescriptor.task, templateVars);
  
  // Check if promptDescriptor.format is undefined. If it is, assign a default value
  if(!promptDescriptor.format) {
    promptDescriptor.format = "prompt/format/shell.md";
  }
  
  const format = await loadFormatTemplate(promptDescriptor.format, templateVars);
  const system = await getSystemPromptIfNeeded();
  const saveto = promptDescriptor.saveto;
  return {
    prompt: `${system}# Working set\n\n${attention.join("\n")}\n\n# Task\n\n${task}\n\n# Output Format\n\n${format}\n\n${userInput ? userInput : ""}`,
    saveto
  };
}

export { createPrompt };


```

src/prompt/promptProcessing.js:
```
import { createPrompt } from './createPrompt.js';
import fs from 'fs/promises';

const processPrompt = async (task, last_command_result, saveto = 'prompt.md', parent_message_id = null) => {
  const { prompt, saveto: newSaveto } = await createPrompt(task, last_command_result);
  await fs.writeFile(newSaveto || saveto, prompt);
  return { prompt, parent_message_id };
}

export default processPrompt;

```

src/backend/generateHandler.js:
```
import processPrompt from '../prompt/promptProcessing.js';

export const generateHandler = async (req, res) => {
  const { notes } = req.body;
  const { prompt } = await processPrompt(notes);
  res.json({ prompt: prompt });
};

```

tailwind.config.js:
```
export default {
  content: ['./src/**/*.html', './src/**/*.js', './src/**/*.jsx', './src/**/*.tsx', './src/**/*.ts'],
  theme: {
    extend: {},
  },
  variants: {
    extend: {},
  },
  plugins: [],
}

```

src/prompt/loadPromptDescriptor.js:
```
import fs from 'fs';
import util from 'util';

const readFile = util.promisify(fs.readFile);
import { descriptorFileName } from "./promptDescriptorConfig.js";

const loadPromptDescriptor = async (rawPrinter) => {
  const descriptorContent = await readFile(descriptorFileName, 'utf8');
  if (rawPrinter) {
    rawPrinter(descriptorFileName + ':\n' + descriptorContent);
  }
  return descriptorContent;
};

export { loadPromptDescriptor };

```

src/prompt/loadFormatTemplate.js:
```
import { loadPromptFile } from './loadPromptFile.js';

const loadFormatTemplate = async (formatTemplatePath, templateVars) => {
  return await loadPromptFile(formatTemplatePath, templateVars);
};

export { loadFormatTemplate };

```


# Task

Fix the following issue!

node:internal/errors:477
  ErrorCaptureStackTrace(err);
  ^
TypeError [ERR_INVALID_ARG_TYPE]: The &#34;path&#34; argument must be of type string. Received undefined
  at new NodeError (node:internal/errors:388:5)
  at validateString (node:internal/validators:114:11)
  at Object.resolve (node:path:1098:7)
  at loadPromptFile (file:///Users/ko/projects-new/Junior/src/prompt/loadPromptFile.js:14:27)
  at async loadFormatTemplate (file:///Users/ko/projects-new/Junior/src/prompt/loadFormatTemplate.js:4:10)
  at async createPrompt (file:///Users/ko/projects-new/Junior/src/prompt/createPrompt.js:18:18)
  at async processPrompt (file:///Users/ko/projects-new/Junior/src/prompt/promptProcessing.js:5:41)
  at async generateHandler (file:///Users/ko/projects-new/Junior/src/backend/generateHandler.js:5:22) {format: prompt/format/shell.md


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

