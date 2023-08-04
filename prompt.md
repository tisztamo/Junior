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

  const handleExecuteChange = async () => {
    let change = changeInput();
    if (inputAvailable() && navigator.clipboard) {
      change = await navigator.clipboard.readText();
    }
    const response = await executeChange(change);
    setChange(change);
    setExecutionResult(response.output);
    console.log(response.output);
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
        <input
          type="text"
          class="w-full px-2 py-2 bg-white text-black"
          placeholder="Paste the change here to execute"
          value={changeInput()}
          onInput={(e) => setChangeInput(e.currentTarget.value)}
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

When navigator.clipboard.readText is unavailable,
then display an input box inside the button instead of the normal text.
The placeholder of the input is: &#34;Paste the change here to execute&#34;.
When the user pastes a text into the input, execute it just like the pasted text at button click.



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

