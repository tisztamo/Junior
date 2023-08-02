# Working set

src/frontend/components/CommitButton.jsx:
```
import { postCommit } from '../service/postCommit';
import { commitMessage } from '../stores/commitMessage';
import { fetchGitStatus } from '../service/fetchGitStatus';

const CommitButton = () => {
  const handleCommit = async () => {
    const response = await postCommit(commitMessage());
    console.log(response.message);
    const status = await fetchGitStatus();
    console.log(status);
  };

  return (
    <button className="w-64 px-4 py-4 bg-green-700 text-white rounded mt-2" onClick={handleCommit}>Commit</button>
  );
};

export default CommitButton;

```

src/frontend/components/CommitMessageInput.jsx:
```
import { commitMessage, setCommitMessage } from '../stores/commitMessage';

const CommitMessageInput = (props) => {
  const handleChange = (e) => {
    setCommitMessage(e.target.value);
  };

  return (
    <input type="text" className="w-64 px-4 py-2 border rounded" placeholder="Commit message..." onInput={handleChange} />
  );
};

export default CommitMessageInput;

```

src/frontend/components/ExecutionResultDisplay.jsx:
```
import { createEffect, createSignal } from 'solid-js';
import { executionResult } from '../stores/executionResult';
import ansiToHtml from '../../execute/ansiToHtml';

const ExecutionResultDisplay = () => {
  let container;
  const [copyText, setCopyText] = createSignal('copy');

  const copyToClipboard = async (e) => {
    e.preventDefault(); // Prevent page load on click
    try {
      await navigator.clipboard.writeText(executionResult());
      setCopyText('copied');
      setTimeout(() => setCopyText('copy'), 2000);
    } catch (err) {
      alert("Failed to copy text!");
      console.warn("Copy operation failed:", err);
    }
  };

  createEffect(() => {
    if (container && executionResult() !== '') {
      const convertedHtml = ansiToHtml(executionResult());
      container.innerHTML = convertedHtml;
    }
  });

  return (
    <div class={`relative bg-gray-900 text-white p-4 rounded ${executionResult() !== '' ? 'block' : 'hidden'}`}>
      <a href="#" class="underline absolute top-0 right-0 m-4" onClick={copyToClipboard}>{copyText()}</a>
      <div class="font-mono text-sm">
        <div ref={container} class="rounded overflow-auto max-w-full p-2" />
      </div>
    </div>
  );
};

export default ExecutionResultDisplay;

```


# Task

Refactor!

After commit, clear execution result.



## Project Specifics

- Every js file should *only export a single function*!
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs*, edit .jsx file accordingly


# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, prefer heredoc-ing full files using 'EOF' to prevent substitution.

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

