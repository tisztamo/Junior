# Working set

```
./
├── .DS_Store
├── .git/...
├── .github/...
├── .gitignore
├── .vscode/...
├── README.md
├── change.sh
├── doc/...
├── integrations/...
├── node_modules/...
├── package-lock.json
├── package.json
├── prompt/...
├── prompt.md
├── prompt.yaml
├── src/...

```
```
./src/
├── .DS_Store
├── attention/...
├── backend/...
├── config.js
├── doc/...
├── execute/...
├── frontend/...
├── git/...
├── interactiveSession/...
├── llm/...
├── main.js
├── prompt/...
├── web.js

```
```
./src/prompt/
├── createPrompt.js
├── extractTemplateVars.js
├── getPromptDirectories.js
├── getPromptFlag.js
├── getSystemPrompt.js
├── getSystemPromptIfNeeded.js
├── loadFormatTemplate.js
├── loadPromptDescriptor.js
├── loadPromptFile.js
├── loadTaskTemplate.js
├── promptDescriptorConfig.js
├── promptDescriptorDefaults.js
├── promptProcessing.js
├── resolveTemplateVariables.js
├── watchPromptDescriptor.js

```
src/prompt/promptDescriptorDefaults.js:
```
import { loadPromptFile } from './loadPromptFile.js';

const loadDefaults = async () => {
  let promptDescriptorDefaults = {};
  const files = ['format', 'os', 'installedTools'];
  for (let file of files) {
    promptDescriptorDefaults[file] = await loadPromptFile(`prompt/${file}.md`);
  }
  return promptDescriptorDefaults;
}

export default loadDefaults;

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
import loadDefaults from './promptDescriptorDefaults.js';

const createPrompt = async (userInput) => {
  let promptDescriptorDefaults = await loadDefaults();
  let promptDescriptor = yaml.load(await loadPromptDescriptor());

  // Fill in the defaults from promptDescriptorDefaults.js
  promptDescriptor = { ...promptDescriptorDefaults, ...promptDescriptor };

  let templateVars = extractTemplateVars(promptDescriptor);
  templateVars = await resolveTemplateVariables(templateVars);

  const attention = await readAttention(promptDescriptor.attention);
  const task = await loadTaskTemplate(promptDescriptor.task, templateVars);

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


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!
- Every js file should only export a single function!
- Use ES6 imports!

Requirements:

1. Rename the loadDefaults function to promptDescriptorDefaults 2. Instead of the constant array read the .md files from prompt/ directories to generate the list of defaults. Load both the prompt/ dir relative to the working dir and relative to the project root and merge them. Note that __dirname is not automatically available in es6 modules.



# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, prefer heredoc-ing full files using 'EOF' to prevent substitution.
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

