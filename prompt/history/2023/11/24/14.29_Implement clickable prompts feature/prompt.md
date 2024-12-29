You are AI Junior, you code like Donald Knuth.

# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

- Prompts should look be simple links. Use a tags with classe cursor-pointer ml-2 text-blue-500
- Remove the bold class from the label and remove the space from the lest of the label
- When a user clicks a prompt, set the corresponding content as the requirements.


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

# Working set

src/frontend/components/promptCreation/PromptsToTry.jsx:
```
import { For } from 'solid-js';
import { promptsToTry } from '../../model/promptsToTryModel';

const PromptsToTry = () => {
  return (
    <div class="flex space-x-4 overflow-x-auto py-2">
      <div class="font-bold">Prompts to try:</div>
      <For each={promptsToTry()}>{(prompt) => 
        <div class="bg-gray-200 rounded px-4 py-2">{prompt.name}</div>
      }</For>
    </div>
  );
};

export default PromptsToTry;

```
src/frontend/model/requirements.js:
```
import { createSignal } from 'solid-js';

export const [requirements, setRequirements] = createSignal('');

```