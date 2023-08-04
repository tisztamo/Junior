# Working set

src/frontend/components/ExecuteButton.jsx:
```
import { createEffect, createSignal } from 'solid-js';
import { executeChange } from '../service/executeChange';
import { setExecutionResult } from '../model/executionResult';
import { setChange } from '../model/change';

const ExecuteButton = () => {
  const [inputAvailable, setInputAvailable] = createSignal(true);
  const [changeInput, setChangeInput] = createSignal('');

  const handleExecuteChange = async (change) => {
    const response = await executeChange(change);
    setChange(change);
    setExecutionResult(response.output);
    console.log(response.output);
  };

  const handlePaste = async (e) => {
    const paste = (e.clipboardData || window.clipboardData).getData('text');
    setChangeInput(paste);
    handleExecuteChange(paste);
  };

  // Check if clipboard reading is available
  createEffect(() => {
    if (!navigator.clipboard || !navigator.clipboard.readText) {
      setInputAvailable(false);
    }
  });

  return (
    <button class="w-64 px-4 py-4 bg-orange-300 text-white rounded" onClick={handleExecuteChange}>
      {inputAvailable() ? (
        'Paste & Execute Change'
      ) : (
        <textarea
          rows="1"
          class="w-full px-2 py-2 bg-white text-black resize-none"
          placeholder="Paste here to execute"
          value={changeInput()}
          onPaste={handlePaste}
        />
      )}
    </button>
  );
};

export default ExecuteButton;

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

The change text should be read from navigator.clipboard.readText if available, or from the current value of the input otherwise.



## Project Specifics

- Every js file should *only export a single function*!
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs*, edit .jsx file accordingly


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

