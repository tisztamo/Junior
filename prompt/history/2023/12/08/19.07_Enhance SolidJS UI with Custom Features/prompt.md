You are AI Junior, you code like Donald Knuth.

# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

- Use the information emoji instead of the question mark
- change the help to the following (rephrase if needed):

These are sample prompts you can use with Junior. Run through them from an empty repo to build a sample project with Junior. To override this list: create a prompt/totry folder in your project directory and add files to have them displayed here.


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

src/frontend/components/promptCreation/PromptsToTry.jsx:
```
import { For, onMount } from 'solid-js';
import { promptsToTry, setPromptsToTry } from '../../model/promptsToTryModel';
import { fetchPromptsToTry } from '../../service/fetchPromptsToTry';
import PromptsToTryHelp from './PromptsToTryHelp';

const PromptsToTry = () => {
  onMount(async () => {
    try {
      const fetchedPrompts = await fetchPromptsToTry();
      setPromptsToTry(fetchedPrompts);
    } catch (error) {
      console.error('Error fetching prompts to try:', error);
    }
  });

  return (
    <div class="w-full flex flex-nowrap p-2 overflow-x-auto">
      <div class="shrink-0">Prompts to try: <PromptsToTryHelp /></div>
      <For each={promptsToTry()}>{(prompt) => 
        <a href="#" class="ml-2 cursor-pointer text-blue-500 bg-transparent rounded px-4 whitespace-nowrap">{prompt.name}</a>
      }</For>
    </div>
  );
};

export default PromptsToTry;

```
src/frontend/components/promptCreation/PromptsToTryHelp.jsx:
```
const PromptsToTryHelp = () => {
  const showAlert = () => {
    alert('These are sample prompts you can use with Junior. Create a prompt/totry folder in your project directory and add files to have them displayed here.');
  };

  return (
    <span class="inline-block cursor-pointer text-blue-500" onClick={showAlert}>❓</span>
  );
};

export default PromptsToTryHelp;

```