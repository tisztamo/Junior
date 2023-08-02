# Working set

src/frontend/App.jsx:
```
import GenerateButton from './components/GenerateButton';
import ExecuteButton from './components/ExecuteButton';
import RollbackButton from './components/RollbackButton';
import CommitButton from './components/CommitButton';
import PromptDisplay from './components/PromptDisplay';
import TasksList from './components/TasksList';
import PromptDescriptor from './components/PromptDescriptor';
import NavBar from './components/NavBar';
import ExecutionResultDisplay from './components/ExecutionResultDisplay';
import GitStatusDisplay from './components/GitStatusDisplay';
import CommitMessageInput from './components/CommitMessageInput';

const App = () => {
  return (
    <div class="m-2">
      <div class="max-w-desktop lg:max-w-desktop md:max-w-full sm:max-w-full xs:max-w-full mx-auto flex flex-col items-center space-y-8 sm:p-0">
        <NavBar />
        <TasksList />
        <PromptDescriptor />
        <GenerateButton />
        <PromptDisplay />
        <ExecuteButton />
        <ExecutionResultDisplay />
        <GitStatusDisplay />
        <CommitMessageInput />
        <CommitButton />
        <RollbackButton />
      </div>
    </div>
  );
};

export default App;

```

src/frontend/components/ExecuteButton.jsx:
```
import { executeChange } from '../service/executeChange';
import { setExecutionResult } from '../stores/executionResult';

const ExecuteButton = () => {
  const handleExecuteChange = async () => {
    const change = await navigator.clipboard.readText();
    const response = await executeChange(change);
    setExecutionResult(response.output);
    console.log(response.output);
  };

  return (
    <button class="w-64 px-4 py-4 bg-orange-300 text-white rounded" onClick={handleExecuteChange}>Paste & Execute Change</button>
  );
};

export default ExecuteButton;

```

src/frontend/stores/executionResult.js:
```
import { createSignal } from 'solid-js';

export const [executionResult, setExecutionResult] = createSignal('');

```

src/frontend/components/CommitButton.jsx:
```
import { postCommit } from '../service/postCommit';
import { commitMessage, setCommitMessage } from '../stores/commitMessage';
import { fetchGitStatus } from '../service/fetchGitStatus';
import { setExecutionResult } from '../stores/executionResult'; // Importing the necessary function to clear execution result
import { setPrompt } from '../stores/prompt'; // Importing setPrompt to clear the prompt

const CommitButton = () => {
  const handleCommit = async () => {
    const response = await postCommit(commitMessage());
    console.log(response.message);
    const status = await fetchGitStatus();
    console.log(status);
    setExecutionResult(''); // Clearing the execution result after commit
    setCommitMessage(''); // Clearing the commit message after commit
    setPrompt(''); // Clearing the prompt after commit
  };

  return (
    <button className="w-64 px-4 py-4 bg-green-700 text-white rounded mt-2" onClick={handleCommit}>Commit</button>
  );
};

export default CommitButton;

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

- Create a signal in src/frontend/stores/change.js
- Save the pasted change after it was executed.
- Clear the change after commit.



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

