You are AI Junior, you code like Donald Knuth.
# Working set

./src/backend/handlers/generateHandler.js:
```
import processPrompt from '../../prompt/processPrompt.js';
import isRepoClean from '../../git/isRepoClean.js';

export const generateHandler = async (req, res) => {
  try {
    if (!await isRepoClean()) {
      throw new Error("Directory is not clean. Please commit or stash changes and try again.");
    }

    const { notes, systemPrompt } = req.body;
    const { prompt } = await processPrompt(notes, systemPrompt);
    res.json({ prompt: prompt });
  } catch (error) {
    console.warn(error);
    res.status(500).json({ error: error.message });
  }
};

```

./src/interactiveSession/startInteractiveSession.js:
```
import { saveAndSendPrompt } from './saveAndSendPrompt.js';
import processPrompt from '../prompt/processPrompt.js';
import { loadPromptDescriptor } from '../prompt/loadPromptDescriptor.js';
import watchPromptDescriptor from '../prompt/watchPromptDescriptor.js';
import { rl } from '../config.js';

const startInteractiveSession = async () => {
  await loadPromptDescriptor(console.log);
watchPromptDescriptor(console.log);
  rl.question('Notes: ', async (task) => {
    let { prompt } = await processPrompt(task);
    console.log("Your prompt: ", prompt);
    rl.question('Do you want to send this prompt? (y/n): ', async (confirmation) => {
      if (confirmation.toLowerCase() === 'y') {
        await saveAndSendPrompt(prompt, task);
      } else {
        startInteractiveSession();
      }
    });
  });
};

export { startInteractiveSession };


```

./src/prompt/processPrompt.js:
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


# Task

Refactor!

- Rename processPrompt to generatePrompt (both filename and fn)
- In startInteractivesession, rename the task variable to notes


## Project Specifics

- Every js file should *only export a single function or signal*! eg.: in createGitRepo.js: export function createGitRepo ( ....
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs* and Tailwind, edit .jsx files accordingly!

# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, avoid using sed in favor of heredoc-ing full files.

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
[...]
'EOF'
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


