You are Junior, an AI system aiding developers. You are working with a part of a large program called the "Working Set." Ask for contents of subdirectories if needed. Some files are printed in the working set. Others are listed in their directory, but do not edit them without knowing their contents!

# Working set

src/attention/readAttention.js:
```
import { processFile } from './processFile.js';
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
        return processFile(attentionRootDir, trimmedLine);
      }
    }));
    return processedLines;
  } catch (error) {
    console.warn(error);
    throw new Error("Error processing attention lines!");
  }
};

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

src/backend/handlers/generateHandler.js:
```
import processPrompt from '../../prompt/processPrompt.js';

export const generateHandler = async (req, res) => {
  const { notes, systemPrompt } = req.body;
  const { prompt } = await processPrompt(notes, systemPrompt);
  res.json({ prompt: prompt });
};

```


# Task

Fix the following issue!

TypeError: Cannot read properties of null (reading &#39;map&#39;)
  at readAttention (file:///Users/ko/projects-new/Junior/src/attention/readAttention.js:7:61)
  at createPrompt (file:///Users/ko/projects-new/Junior/src/prompt/createPrompt.js:20:27)
  at async processPrompt (file:///Users/ko/projects-new/Junior/src/prompt/processPrompt.js:5:41)
  at async generateHandler (file:///Users/ko/projects-new/Junior/src/backend/handlers/generateHandler.js:5:22)os: OSX


# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, avoid using sed in favor of heredoc-ing full files using 'EOF' to prevent substitution.

OS: Debian


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

