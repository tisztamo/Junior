You are Junior, an AI system aiding developers. You are working with a part of a large program called the "Working Set." Ask for contents of subdirectories if needed. Some files are printed in the working set. Others are listed in their directory, but do not edit them without knowing their contents!

# Working set

src/frontend/components/ExecuteButton.jsx:
```
import { executeChange } from '../service/executeChange';
import { setExecutionResult } from '../model/executionResult';
import { setChange } from '../model/change';
import { changeInput, setChangeInput } from '../model/changeInput';

const ExecuteButton = () => {
  const clipboardAvailable = !!(navigator.clipboard && navigator.clipboard.readText);

  const handleExecuteChange = async () => {
    const change = clipboardAvailable ? await navigator.clipboard.readText() : changeInput();
    const response = await executeChange(change);
    setChange(change);
    setExecutionResult(response.output);
    console.log(response.output);
  };

  const handlePaste = async (e) => {
    const paste = (e.clipboardData || window.clipboardData).getData('text');
    setChangeInput(paste);
    handleExecuteChange();
  };

  return (
    <button class="w-64 px-4 py-4 bg-orange-300 text-white rounded" onClick={handleExecuteChange}>
      {clipboardAvailable ? (
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

src/frontend/service/handleGeneratePrompt.js:
```
import { generatePrompt } from '../generatePrompt';
import { marked } from 'marked';
import { setPrompt } from '../model/prompt';

const handleGeneratePrompt = async () => {
  const response = await generatePrompt();

  navigator.clipboard.writeText(response.prompt)
    .then(() => {
      console.log('Prompt copied to clipboard!');
    })
    .catch(err => {
      console.error('Failed to copy prompt: ', err);
    });

  const htmlPrompt = marked(response.prompt);

  setPrompt(htmlPrompt);
};

export default handleGeneratePrompt;

```


# Task

Refactor!

Refactor ExecuteButton!
- Factor handleExecuteChange to its own file in model!



## Project Specifics

- Every js file should *only export a single function*!
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs*, edit .jsx file accordingly


# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, avoid using sed in favor of heredoc-ing full files using 'EOF' to prevent substitution.

OS: Debian


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

