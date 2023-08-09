You're the 'Junior', an AI system aiding authors.

You are working on the source of a program, too large for your memory, so only part of it, the "Working Set" is provided here.

You will see a partial directory structure. Ask for the contents of subdirs marked with /... if needed.

Some files are printed in the working set.

Other files are only listed in their dir, so you know they exists. Do not edit files without knowing their current content, ask for their contents instead!

# Working set

src/backend/handlers/generateHandler.js:
```
import processPrompt from '../../prompt/processPrompt.js';

export const generateHandler = async (req, res) => {
  const { notes, systemPrompt } = req.body;
  const { prompt } = await processPrompt(notes, systemPrompt);
  res.json({ prompt: prompt });
};

```

src/prompt/processPrompt.js:
```
import { createPrompt } from './createPrompt.js';
import fs from 'fs/promises';

const processPrompt = async (task, forceSystemPrompt = false, saveto = 'prompt.md', parent_message_id = null) => {
  const { prompt, saveto: newSaveto } = await createPrompt(task, forceSystemPrompt);
  await fs.writeFile(newSaveto || saveto, prompt);
  return { prompt, parent_message_id };
}

export default processPrompt;

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

src/prompt/getSystemPromptIfNeeded.js:
```
import { getSystemPrompt } from "./getSystemPrompt.js";

async function getSystemPromptIfNeeded(force = false) {
  if (force || process.argv.includes("--system-prompt") || process.argv.includes("-s")) {
    return `${await getSystemPrompt()}\n`;
  }
  return "";
}

export { getSystemPromptIfNeeded };

```

src/frontend/generatePrompt.js:
```
import { getBaseUrl } from './getBaseUrl';

const generatePrompt = async (notes) => {
  const baseUrl = getBaseUrl();
  const response = await fetch(`${baseUrl}/generate`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ notes, systemPrompt: true })
  });

  const data = await response.json();

  return data;
};

export { generatePrompt };

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

When generating the prompt from the web, send &#34;systemPrompt&#34;: true with the request. Add a force=false argument to getSystemPromptIfNeeded Make sure the handler forwards the systemPrompt value to processPrompt. Create a new argument &#34;forceSystemPrompt = false&#34; for processPrompt as its _second_ argument. Also update createPrompt to forward the value.



## Project Specifics

- Every js file should *only export a single function*!
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs*, edit .jsx file accordingly


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

