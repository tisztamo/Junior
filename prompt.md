# Working set

```
./
├── .DS_Store
├── .git/...
├── .gitignore
├── .vscode/...
├── README.md
├── babel.config.js
├── change.sh
├── dist/...
├── doc/...
├── node_modules/...
├── package-lock.json
├── package.json
├── prompt/...
├── prompt.md
├── prompt.yaml
├── secret.sh
├── src/...
├── tmp/...

```
```
./prompt/
├── archive/...
├── format/...
├── system.md
├── task/...

```
```
./src/
├── attention/...
├── backend/...
├── config.js
├── execute/...
├── frontend/...
├── index.html
├── interactiveSession/...
├── main.js
├── prompt/...
├── vite.config.js

```
```
./src/prompt/
├── createPrompt.js
├── extractTemplateVars.js
├── getPromptFlag.js
├── getSystemPromptIfNeeded.js
├── loadFormatTemplate.js
├── loadPromptDescriptor.js
├── loadTaskTemplate.js
├── promptProcessing.js
├── resolveTemplateVariables.js

```
./src/prompt/loadPromptDescriptor.js:
```
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

```

./src/prompt/createPrompt.js:
```
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


```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!
- Every js file should only export a single function!
- Use ES6 imports!

Requirements:

When loading the task, try to load it relative to the current directory, but if not found, load the file relative to the project root (calculated from the source file location).



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

