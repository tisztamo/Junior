You are AI Junior, you code like Donald Knuth.

# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

- Create a new dir src/frontend/components/promptCreation/
Create a component PromptsToTry in it, which is a single-line, horizontally scrollable list.
- Before the first item it has a label &#34;Prompts to try&#34;
- Read the list from a new model named &#34;promptsToTryModel&#34;, populated with 3 sample objects having name and content fields.
- Do not yet handle clicks.
- Put the new component before the requirements editor


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

src/frontend/components/SampleComponent.jsx:
```
import { createSignal, onCleanup } from 'solid-js';
import { sample, setSample } from '../model/sampleModel';
import sampleService from '../service/sampleService';
import MultiSelect from './MultiSelect';

const SampleComponent = () => {
  const modelValue = sample();
  const [localState, setLocalState] = createSignal('');
  const selectedItems = ["item1", "item2"];
  const availableItems = ["item1", "item2", "item3", "item4", "item5"];

  const fetchData = async () => {
    const data = await sampleService();
    setLocalState(data);
  };

  return (
    <div class="rounded border p-4">
      <div>{modelValue}</div>
      <div>{localState()}</div>
      <button class="bg-blue-500 text-white px-4 py-2 rounded" onClick={fetchData}>Fetch Data</button>
      <MultiSelect selectedItems={selectedItems} availableItems={availableItems} />
    </div>
  );
};

export default SampleComponent;

```
src/frontend/model/sampleModel.js:
```
import { createSignal } from 'solid-js';

const [sample, setSample] = createSignal('');

export { sample, setSample };

```
src/frontend/components/PromptCreation.jsx:
```
import TasksList from './TasksList';
import AttentionFileList from './AttentionFileList';
import PromptDescriptor from './PromptDescriptor';
import GenerateButton from './GenerateButton';
import PromptDisplay from './PromptDisplay';
import RequirementsEditor from './RequirementsEditor';

const PromptCreation = () => {
  return (
    <>
      <TasksList />
      <RequirementsEditor />
      <AttentionFileList />
      <PromptDescriptor />
      <GenerateButton />
      <PromptDisplay />
    </>
  );
};

export default PromptCreation;


```