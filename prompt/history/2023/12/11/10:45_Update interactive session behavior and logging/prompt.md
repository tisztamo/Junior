You are AI Junior, you code like Donald Knuth.

# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

- Make y the default when asking for prompt sending
- Instead of passing console.log directly to watchPromptDescriptor, create a function that wraps console.log and prints the sentence starting with &#34;Press Enter...&#34; again with green after the content.


## Project Specifics

- Every js file should *only export a single function or signal*! eg.: in createGitRepo.js: export function createGitRepo ( ....
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs* and Tailwind, edit .jsx files accordingly!

Write concise, self-documenting and idiomatic ES6 code!

# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Avoid using sed. Always heredoc full files.

OS: Debian


Installed tools: npm, jq


Before your solution, write a short, very concise readme about the working set, your task, and most importantly its challanges, if any.


EXAMPLE START
```sh
#!/bin/sh
set -e
goal=[Task description, max 9 words]
echo "Plan:"
echo "1. [...]"

# Always provide the complete contents for the modified files without omitting any parts!
cat > x.js << EOF
  let i = 1
  console.log(\`i: \${i}\`)
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

# Working set

src/interactiveSession/startInteractiveSession.js:
```
import { saveAndSendPrompt } from './saveAndSendPrompt.js';
import generatePrompt from '../prompt/generatePrompt.js';
import { loadPromptDescriptor } from '../prompt/loadPromptDescriptor.js';
import watchPromptDescriptor from '../prompt/watchPromptDescriptor.js';
import { rl } from '../config.js';

const startInteractiveSession = async () => {
  await loadPromptDescriptor(console.log);
  watchPromptDescriptor(console.log);

  // Using ANSI escape codes for green text
  console.log("\x1b[32mWatching for changes in prompt.yaml. Press Enter to generate prompt\x1b[0m");

  rl.question('', async () => {
    let { prompt } = await generatePrompt('');
    console.log("Your prompt: ", prompt);
    rl.question('Do you want to send this prompt? (y/n): ', async (confirmation) => {
      if (confirmation.toLowerCase() === 'y') {
        await saveAndSendPrompt(prompt, '');
      } else {
        startInteractiveSession();
      }
    });
  });
};

export { startInteractiveSession };

```
src/prompt/watchPromptDescriptor.js:
```
import fs from 'fs';
import { loadPromptDescriptor } from './loadPromptDescriptor.js';
import { descriptorFileName } from './promptDescriptorConfig.js';

const watchPromptDescriptor = (rawPrinter) => {
  fs.watchFile(descriptorFileName, async (curr, prev) => {
    if (curr.mtime !== prev.mtime) {
      await loadPromptDescriptor(rawPrinter);
    }
  });
};

export default watchPromptDescriptor;

```