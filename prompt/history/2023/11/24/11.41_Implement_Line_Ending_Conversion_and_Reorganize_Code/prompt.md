You are AI Junior, you code like Donald Knuth.

# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

- Create src/frontend/service/execute/ and move handleExecuteChange there.
- Before executing the change, replace windows-style newlines to unix-style ones in it. Create a new file for this in the new dir.



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

src/frontend/service/handleExecuteChange.js:
```
import executeChange from './executeChange';
import { setExecutionResult } from '../model/executionResult';
import { setChange } from '../model/change';
import { changeInput } from '../model/changeInput';
import { fetchGitStatus } from './fetchGitStatus';

const handleExecuteChange = async () => {
  const clipboardAvailable = !!(navigator.clipboard && navigator.clipboard.readText);
  const change = clipboardAvailable ? await navigator.clipboard.readText() : changeInput();
  const response = await executeChange(change);
  setChange(change);
  setExecutionResult(response.output);
  console.log(response.output);

  // Fetch git status after code execution
  fetchGitStatus();
};

export default handleExecuteChange;

```
src/frontend/components/ExecuteButton.jsx:
```
import { createEffect } from 'solid-js';
import handleExecuteChange from '../service/handleExecuteChange';
import { setChangeInput, changeInput } from '../model/changeInput';

const ExecuteButton = () => {
  const clipboardAvailable = !!(navigator.clipboard && navigator.clipboard.readText);

  const handlePaste = async (e) => {
    const paste = (e.clipboardData || window.clipboardData).getData('text');
    setChangeInput(paste);
    await handleExecuteChange();
    setChangeInput(''); // To clear the input after execution
  };

  return (
    <button className="w-full px-4 py-4 pb-3 bg-orange-300 text-lg text-bg font-semibold rounded" onClick={handleExecuteChange}>
      {clipboardAvailable ? (
        'Paste & Execute Change [X]'
      ) : (
        <textarea
          rows="1"
          className="w-full px-2 py-2 bg-orange-200 text-lg text-bg font-semibold resize-none"
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