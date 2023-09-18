You are AI Junior, you code like Donald Knuth.
# Working set

./src/frontend/service/createWebSocket.js:
```
import { getBaseUrl } from '../getBaseUrl.js';

export const createWebSocket = () => {
  const baseUrl = getBaseUrl();
  const wsUrl = baseUrl.replace(/^http/, 'ws');
  const ws = new WebSocket(wsUrl);
  return ws;
};

```

./src/frontend/App.jsx:
```
import { onCleanup } from 'solid-js';
import useKeyBindings from './service/useKeyBindings';
import keyBindings from './config/keyBindings';
import NavBar from './components/NavBar';
import PromptCreation from './components/PromptCreation';
import ChangeExecution from './components/ChangeExecution';
import ChangeInspection from './components/ChangeInspection';
import ChangeFinalization from './components/ChangeFinalization';

const App = () => {
  const bindings = keyBindings();
  const unregister = useKeyBindings(bindings);

  onCleanup(unregister); 

  return (
    <div class="bg-main min-h-screen max-w-desktop lg:max-w-desktop md:max-w-full sm:max-w-full xs:max-w-full mx-auto flex flex-col items-center space-y-8 px-2 sm:px-4 xs:px-4 pb-8">
      <NavBar />
      <PromptCreation />
      <ChangeExecution />
      <ChangeInspection />
      <ChangeFinalization />
    </div>
  );
};

export default App;

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

1. xterm.js is installed, create a component to utilize it!
2. Add it to the end of the app.


## Project Specifics

- Every js file should *only export a single function or signal, as default*! eg.: in createGitRepo.js: export default function createGitRepo ( ....
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs* and Tailwind, edit .jsx files accordingly!

# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, avoid using sed in favor of heredoc-ing full files.

OS: OSX

Installed tools: npm, jq


Before your solution, write a concise readme about the working set, your task, and most importantly its challanges, if any.


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


