You are AI Junior, you code like Donald Knuth.

# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

- Remove background and vertical padding from the PromptsToTry links
- In RequirementsEditor, in the last createEffect, instead of calling requirements() in the if directly, call untrack(requirements) instead to avoid loopholes. Import untrack from solidjs


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
import { setRequirements } from '../../model/requirements';

const PromptsToTry = () => {
  const handleClick = (promptContent) => {
    setRequirements(promptContent);
  };

  return (
    <div class="flex space-x-4 overflow-x-auto py-2">
      <div>Prompts to try:</div>
      <For each={promptsToTry()}>{(prompt) => 
        <a href="#" class="cursor-pointer ml-2 text-blue-500 bg-gray-200 rounded px-4 py-2" onClick={() => handleClick(prompt.name)}>{prompt.name}</a>
      }</For>
    </div>
  );
};

export default PromptsToTry;

```
src/frontend/components/RequirementsEditor.jsx:
```
import { createSignal, createEffect } from 'solid-js';
import postDescriptor from '../service/postDescriptor';
import { promptDescriptor, setPromptDescriptor } from '../model/promptDescriptor'; 
import { requirements, setRequirements } from '../model/requirements';
import { getYamlEntry } from '../service/getYamlEntry';
import jsyaml from 'js-yaml'; 
import AutoGrowingTextarea from './AutoGrowingTextarea';

const RequirementsEditor = () => {
  const handleInput = (e) => {
    const descriptor = promptDescriptor();
    const parsed = jsyaml.load(descriptor);
    parsed.requirements = e.target.value; 
    const updatedDescriptor = jsyaml.dump(parsed);
    setPromptDescriptor(updatedDescriptor);

    // After setting the updated descriptor, trigger an update on the multiselect component
    // Assumption: The multiselect component listens to changes on the requirements signal and updates itself accordingly.
    setRequirements(e.target.value);
  };

  const handleChange = async (e) => {
    handleInput(e);
    const currentRequirements = e.target.value;
    await postDescriptor({ requirements: currentRequirements });
  };

  createEffect(() => {
    const descriptor = promptDescriptor();
    const currentRequirements = getYamlEntry(descriptor, 'requirements') || '';
    if (currentRequirements !== requirements()) {
      setRequirements(currentRequirements);
    }
  });

  return (
    <div class="w-full flex justify-start bg-emphasize text-emphasize p-1 rounded border border-border mt-2">
      <AutoGrowingTextarea
        class="w-full bg-emphasize text-emphasize text-lg px-2"
        placeholder="Enter your requirements..."
        valueSignal={requirements}
        onInput={e => handleInput(e)}
        onChange={e => handleChange(e)}
        disabled={false}
      />
    </div>
  );
};

export default RequirementsEditor;

```