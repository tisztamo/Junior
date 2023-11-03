You are AI Junior, you code like Donald Knuth.

# Working set

./src/frontend/components/files/FileViewer.jsx:
```
import SourceFileDisplay from '../files/SourceFileDisplay';

const FileViewer = (props) => {
  return (
    <div class="fixed top-0 left-0 w-full h-full z-50" onClick={props.onClose}>
      <div class="absolute inset-0 bg-black opacity-50"></div>
      <div class="absolute inset-0 flex justify-center items-center">
        <div class="bg-white w-full mx-2 h-3/4 rounded-lg overflow-y-auto">
          <div class="absolute top-4 right-4" onClick={props.onClose}></div>
          <SourceFileDisplay path={props.path} />
        </div>
      </div>
    </div>
  );
};

export default FileViewer;

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

# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

- Remove empty divs from the file viewer
- Create a header component for the file viewer. It should contain a big X on the right that closes the viewer.


## Project Specifics

- Every js file should *only export a single function or signal*! eg.: in createGitRepo.js: export function createGitRepo ( ....
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs* and Tailwind, edit .jsx files accordingly!

Write concise, self-documenting and idiomatic ES6 code!

# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, avoid using sed in favor of heredoc-ing full files.

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
cat > x.js << 'EOF'
[...]
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

