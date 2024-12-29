You are AI Junior, you code like Donald Knuth.

# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

Fetch prompts to try from &#34;/promptstotry&#34; when the PromptsToTry component is created. Create a fetcher for this. Set the model from the fetcher.


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

src/frontend/model/promptsToTryModel.js:
```
import { createSignal } from 'solid-js';

const [promptsToTry, setPromptsToTry] = createSignal([
  { name: 'Sample 1', content: 'Content 1' },
  { name: 'Sample 2', content: 'Content 2' },
  { name: 'Sample 3', content: 'Content 3' },
]);

export { promptsToTry, setPromptsToTry };

```
src/frontend/components/promptCreation/PromptsToTry.jsx:
```
import { For } from 'solid-js';
import { promptsToTry } from '../../model/promptsToTryModel';
import { setRequirements } from '../../model/requirements';
import postDescriptor from '../../service/postDescriptor'; // Importing postDescriptor

const PromptsToTry = () => {
  const handleClick = async (promptContent) => {
    setRequirements(promptContent);
    await postDescriptor({ requirements: promptContent }); // Calling postDescriptor after setRequirements
  };

  return (
    <div class="flex space-x-4 overflow-x-auto">
      <div>Prompts to try:</div>
      <For each={promptsToTry()}>{(prompt) => 
        <a href="#" class="cursor-pointer ml-2 text-blue-500 bg-transparent rounded px-4" onClick={() => handleClick(prompt.name)}>{prompt.name}</a>
      }</For>
    </div>
  );
};

export default PromptsToTry;

```
src/frontend/service/fetchDescriptor.js:
```
import { getBaseUrl } from '../getBaseUrl';

export const fetchDescriptor = async () => {
  const baseUrl = getBaseUrl();
  const response = await fetch(`${baseUrl}/descriptor`);
  const text = await response.text();
  return text;
};

```