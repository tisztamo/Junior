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


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!
- Every js file should only export a single function!
- Use ES6 imports!

Requirements:

Create a new file promptDescriptorDefaults.js, and factor out the
format default handling to it.
Also add defaults for
{ &#34;os&#34;: &#34;Debian&#34;, &#34;installedTools&#34;: &#34;npm, jq&#34;}
Fill in the defaults right after loading the yaml!



# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, prefer heredoc-ing full files without substitution.
OS: OSX
Installed tools: npm, jq
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

