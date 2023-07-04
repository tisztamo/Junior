You're the 'Contributor', an AI system aiding authors.

You are working on the source of a program, too large for your memory, so only part of it, the "Working Set" is provided here.

You will see a partial directory structure. Ask for the contents of subdirs marked with /... if needed.

Some files are printed in the working set.

Other files are only listed in their dir, so you know they exists, ask for the contents if needed.

# Working set

src/interactiveSession/startInteractiveSession.js:
```
import { createPrompt } from '../prompt/createPrompt.js';
import { saveAndSendPrompt } from './saveAndSendPrompt.js';

const startInteractiveSession = async (last_command_result = "", parent_message_id = null, rl, api) => {
  rl.question('$ ', async (task) => {
    const { prompt, saveto } = await createPrompt(task, last_command_result);
    await saveAndSendPrompt(prompt, saveto, parent_message_id, api, rl, last_command_result, startInteractiveSession);
  });
};

export { startInteractiveSession };

```

src/prompt/createPrompt.js:
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
const readFile = util.promisify(fs.readFile);

const createPrompt = async (userInput) => {
  const promptDescriptor = yaml.load(await readFile(getPromptFlag() || "prompt/prompt-list.yaml", "utf8"));
  let templateVars = extractTemplateVars(promptDescriptor);

  templateVars = await resolveTemplateVariables(templateVars);

  const attention = await readAttention(promptDescriptor.attention);
  const task = await ejs.renderFile(promptDescriptor.task, templateVars, {async: true});
  const format = await ejs.renderFile(promptDescriptor.format, templateVars, {async: true});
  const system = await getSystemPromptIfNeeded();
  const saveto = promptDescriptor.saveto;
  return {
    prompt: `${system}# Working set\n\n${attention.join("\n")}\n\n# Task\n\n${task}\n\n# Output Format\n\n${format}\n\n${userInput ? userInput : ""}`,
    saveto
  };
}

export { createPrompt };

```

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

current_prompt.yaml:
```
task: prompt/task/feature/implement.md
attention:
  - src/interactiveSession/startInteractiveSession.js
  - src/prompt/createPrompt.js
  - src/attention/readAttention.js
  - current_prompt.yaml
  - prompt/system.md
requirements: >
  Write a README.md for this _exploratory_ project!
  Project oneliner: Your AI contributor which writes itself.
  The goal of the project is to allow the programmer to communicate only
  with the AI, and only supervise the development process, similarly to
  how Linus Thorwalds supervises the kernel development without writing code (mention this!).

  Describe the followings to the end user!
    - What is the prompt descriptor (current_prompt.yaml, or specified by --prompt=myprompt.yaml),
      and how it is used to generate a prompt. Provide a simple example yaml!
    - How the attention mechanism works (files are printed, dirs listed)
format: prompt/format/new_file_version.md

```

prompt/system.md:
```
You're the 'Contributor', an AI system aiding authors.

You are working on the source of a program, too large for your memory, so only part of it, the "Working Set" is provided here.

You will see a partial directory structure. Ask for the contents of subdirs marked with /... if needed.

Some files are printed in the working set.

Other files are only listed in their dir, so you know they exists, ask for the contents if needed.

```


# Task

Implement the following feature!

- Write a plan first, only implement after the plan is ready!
- Create new files when needed!
- Every js js file should only export a single function!

Requirements:

Write a README.md for this _exploratory_ project! Project oneliner: Your AI contributor which writes itself. The goal of the project is to allow the programmer to communicate only with the AI, and only supervise the development process, similarly to how Linus Thorwalds supervises the kernel development without writing code (mention this!).
Describe the followings to the end user!
  - What is the prompt descriptor (current_prompt.yaml, or specified by --prompt=myprompt.yaml),
    and how it is used to generate a prompt. Provide a simple example yaml!
  - How the attention mechanism works (files are printed, dirs listed)



# Output Format

Provide the new or modified file(s) as code blocks, each prefixed with its path and a colon.
Always output full files, copying unchanged content.

E.g.:

texts/sample.txt:
```
A sample text file.
```


