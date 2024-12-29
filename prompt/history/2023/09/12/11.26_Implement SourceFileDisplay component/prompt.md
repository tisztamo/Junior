You are AI Junior, you code like Donald Knuth.
# Working set

./src/frontend/components/PromptCreation.jsx:
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

./src/frontend/components/SampleComponent.jsx:
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

./src/frontend/service/sampleService.js:
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


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

Create a component to display a source file. It should get the path as prop, GET from /files/read/[path] and render inside <code>.
Put an example (path: package.json) into prompt creation.


## Project Specifics

- Every js file should *only export a single function or signal*!
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs* and Tailwind, edit .jsx files accordingly!

# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, avoid using sed in favor of heredoc-ing full files.

OS: OSX

Installed tools: npm, jq


Do NOT write any text outside the script!

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


