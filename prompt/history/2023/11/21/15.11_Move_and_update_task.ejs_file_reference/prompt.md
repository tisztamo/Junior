You are AI Junior, you code like Donald Knuth.

# Working set

src/prompt/createPrompt.js:
```
import { readAttention } from "../attention/readAttention.js";
import yaml from 'js-yaml';
import { getSystemPromptIfNeeded } from './getSystemPromptIfNeeded.js';
import { resolveTemplateVariables } from './resolveTemplateVariables.js';
import { extractTemplateVars } from './extractTemplateVars.js';
import { loadPromptFile } from './loadPromptFile.js';
import { loadTaskTemplate } from './loadTaskTemplate.js';  // Added missing import
import { loadFormatTemplate } from './loadFormatTemplate.js';  // Added missing import
import promptDescriptorDefaults from './promptDescriptorDefaults.js';
import { loadPromptDescriptor } from './loadPromptDescriptor.js';

const createPrompt = async (userInput, forceSystemPrompt) => {
  let promptDescriptor = yaml.load(await loadPromptDescriptor());
  let promptDescriptorDefaultsData = await promptDescriptorDefaults();

  promptDescriptor = { ...promptDescriptorDefaultsData, ...promptDescriptor };

  let templateVars = extractTemplateVars(promptDescriptor);
  templateVars = await resolveTemplateVariables(templateVars);

  const attention = (await readAttention(promptDescriptor.attention)).map(str => str.trim());
  const task = (await loadTaskTemplate(promptDescriptor.task, templateVars)).trim();
  const format = (await loadFormatTemplate(promptDescriptor.format, templateVars)).trim();
  const system = (await getSystemPromptIfNeeded(forceSystemPrompt)).trim();

  templateVars = { ...templateVars, attention, task, format, system, userInput };

  const filledTemplate = await loadPromptFile('src/prompt/task.ejs', templateVars);
  const saveto = promptDescriptor.saveto;

  return {
    prompt: filledTemplate.trim(),
    saveto
  };
}

export { createPrompt };

```

# Task

Fix the following issue!

Move ./src/prompt/task.ejs to ./prompt/layout/task.md relative to the project root. Create the dir.


## Project Specifics

- Every js file should *only export a single function or signal*! eg.: in createGitRepo.js: export function createGitRepo ( ....
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs* and Tailwind, edit .jsx files accordingly!

Write concise, self-documenting and idiomatic ES6 code!

# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Avoid using sed. Always heredoc full files.

OS: OSX

Installed tools: npm, jq


Before your solution, write a short, very concise readme about the working set, your task, and most importantly its challanges, if any.


EXAMPLE START
```sh
#!/bin/sh
set -e
goal=[Task description, max 9 words]
echo "Plan:"
echo "1. [...]"
cat > x.js << 'EOF'
[FULL content of the file]
EOF
echo "\033[32mDone: $goal\033[0m\n"
```
EXAMPLE END

Before starting, check if you need more files or info to solve the task.

If the task is not clear:

EXAMPLE START
I need more information to solve the task. [Description of the missing info]
EXAMPLE END

Do not edit files not provided in the working set!
If you need more files:

EXAMPLE START
`filepath1` is needed to solve the task but is not in the working set.
EXAMPLE END