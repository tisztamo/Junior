You are Junior, an AI system aiding developers.
You are working with a part of a large program called the "Working Set."
Before starting, check if you need more files to solve the task.
Do not edit files without knowing their contents!
Ask for them in normal conversational format instead.

# Working set

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
import promptDescriptorDefaults from './promptDescriptorDefaults.js';

const createPrompt = async (userInput, forceSystemPrompt) => {
  let promptDescriptor = yaml.load(await loadPromptDescriptor());
  let promptDescriptorDefaultsData = await promptDescriptorDefaults();

  promptDescriptor = { ...promptDescriptorDefaultsData, ...promptDescriptor };

  let templateVars = extractTemplateVars(promptDescriptor);
  templateVars = await resolveTemplateVariables(templateVars);

  const attention = await readAttention(promptDescriptor.attention);
  const task = await loadTaskTemplate(promptDescriptor.task, templateVars);

  const format = await loadFormatTemplate(promptDescriptor.format, templateVars);
  const system = await getSystemPromptIfNeeded(forceSystemPrompt);
  const saveto = promptDescriptor.saveto;
  return {
    prompt: `${system}# Working set\n\n${attention.join("\n")}\n\n# Task\n\n${task}\n\n# Output Format\n\n${format}\n\n${userInput ? userInput : ""}`,
    saveto
  };
}

export { createPrompt };

```

src/prompt/resolveTemplateVariables.js:
```
import fs from 'fs';
import util from 'util';
import path from 'path';
const readFile = util.promisify(fs.readFile);

async function resolveTemplateVariables(vars) {
  for (const key in vars) {
    if (typeof vars[key] === 'string' && fs.existsSync(vars[key]) && fs.lstatSync(vars[key]).isFile()) {
      vars[key] = await readFile(path.resolve(vars[key]), 'utf-8');
    }
  }
  return vars;
}

export { resolveTemplateVariables };

```

src/prompt/extractTemplateVars.js:
```
// Extracts template variables from the prompt descriptor.
function extractTemplateVars(promptDescriptor) {
  return Object.keys(promptDescriptor)
    .filter(key => ['task', 'format', 'attention', 'saveto'].indexOf(key) < 0)
    .reduce((obj, key) => {
      obj[key] = promptDescriptor[key];
      return obj;
    }, {});
}

export { extractTemplateVars };

```

src/prompt/loadTaskTemplate.js:
```
import { loadPromptFile } from './loadPromptFile.js';

const loadTaskTemplate = async (taskTemplatePath, templateVars) => {
  return await loadPromptFile(taskTemplatePath, templateVars);
};

export { loadTaskTemplate };

```

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


# Task

Fix the following issue!

Extra html encoding appears on injected variables int the generated prompt.


## Project Specifics

- Every js file should *only export a single function*!
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs* and Tailwind, edit .jsx file accordingly!


# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, avoid using sed in favor of heredoc-ing full files using 'EOF' to prevent substitution.

OS: OSX

Installed tools: npm, jq


Do NOT write any text outside the script!

EXAMPLE START

```sh
#!/bin/sh
set -e
goal=[Task description, max 7 words]
echo "Plan:"
echo "1. [...]"
[Commands solving the task]
echo "\033[32mDone: $goal\033[0m\n"
```

EXAMPLE END

