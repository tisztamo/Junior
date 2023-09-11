You are AI Junior, you code like Donald Knuth.
# Working set

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

src/frontend/components/SampleComponent.jsx:
```
import { createSignal, onCleanup } from 'solid-js';
import { sampleModel } from '../model/sampleModel';
import { sampleService } from '../service/sampleService';

const SampleComponent = () => {
  const modelValue = sampleModel();
  const [localState, setLocalState] = createSignal('');

  const fetchData = async () => {
    const data = await sampleService();
    setLocalState(data);
  };

  onCleanup(() => {});

  return (
    <div class="rounded border p-4">
      <div>{modelValue}</div>
      <div>{localState()}</div>
      <button class="bg-blue-500 text-white px-4 py-2 rounded" onClick={fetchData}>Fetch Data</button>
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

src/frontend/service/sampleService.js:
```
import { getBaseUrl } from '../getBaseUrl';

async function sampleService() { 
  const baseUrl = getBaseUrl();
  const response = await fetch(`${baseUrl}/sample`);
  const text = await response.text();
  return text;
};

export default sampleService;

```

src/frontend/components/PromptCreation.jsx:
```
import TasksList from './TasksList';
import PromptDescriptor from './PromptDescriptor';
import GenerateButton from './GenerateButton';
import PromptDisplay from './PromptDisplay';
import RequirementsEditor from './RequirementsEditor';

const PromptCreation = () => {
  return (
    <>
      <TasksList />
      <RequirementsEditor />
      <PromptDescriptor />
      <GenerateButton />
      <PromptDisplay />
    </>
  );
};

export default PromptCreation;

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

Create <AttentionFileList>, model/fileList.js and service/fetchFileList.js that
loads files from files/list endpoint which returns like:

{
  "type": "dir",
  "name": "src"
  "children": [
    { 
      "type": "file"
      "name": "main.js"
    }
  ]
}

Flat this out to filepaths in the component and print them to a div

Put the new component after RequirementsEditor



## Project Specifics

- Every js file should *only export a single function or signal*!
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs* and Tailwind, edit .jsx files accordingly!
- Remove _all existing comments_ from the code!
- Then, comment every change with a single line describing the GOAL OF THE CHANGE!


# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, avoid using sed in favor of heredoc-ing full files using 'EOF' to prevent substitution.

OS: OSX

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

Before starting, check if you need more files to solve the task.
Do not edit any file not provided in the working set!
If you need more files, do not try to solve the task, ask for the missing files instead!

EXAMPLE START

`filepath1` is needed to solve the task but is not in the working set.

EXAMPLE END

