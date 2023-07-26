# Working set

src/prompt/promptDescriptorDefaults.js:
```
const promptDescriptorDefaults = {
  format: "prompt/format/shell.md",
  os: "Debian",
  installedTools: "npm, jq"
};

export default promptDescriptorDefaults;

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

const createPrompt = async (userInput) => {
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

Instead of a defaults object, defaults should be filled
with properties representing files in the prompt dir.
E.g. if the prompt/ dir contains 2 files, a.md and b.md, then
the defaults object should look like {&#34;a&#34;: &#34;the content of a.md&#34;, &#34;b&#34;: &#34;the content of b.md&#34;}
Use loadPromptFile for loading the files.
Also create the format.md, os.md etc. in prompt/ in order to have the same defaults.



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

