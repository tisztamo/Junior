# Working set

```
src/frontend/
├── App.jsx
├── assets/...
├── components/...
├── fetchTasks.js
├── generatePrompt.js
├── getBaseUrl.js
├── index.html
├── index.jsx
├── postcss.config.cjs
├── service/...
├── startVite.js
├── stores/...
├── styles/...
├── tailwind.config.cjs
├── vite.config.js

```
```
src/frontend/stores/
├── executionResult.js
├── gitStatus.js
├── prompt.js
├── promptDescriptor.js
├── selectedTask.js

```
src/frontend/components/RollbackButton.jsx:
```
import { resetGit } from '../service/resetGit';

const RollbackButton = () => {
  const handleReset = async () => {
    const response = await resetGit();

    console.log(response.message);
  };

  return (
    <button class="w-64 px-4 py-4 bg-red-700 text-white rounded" onClick={handleReset}>Roll Back to Last Commit</button>
  );
};

export default RollbackButton;

```

src/frontend/App.jsx:
```
import GenerateButton from './components/GenerateButton';
import ExecuteButton from './components/ExecuteButton';
import RollbackButton from './components/RollbackButton';
import PromptDisplay from './components/PromptDisplay';
import TasksList from './components/TasksList';
import PromptDescriptor from './components/PromptDescriptor';
import NavBar from './components/NavBar';
import ExecutionResultDisplay from './components/ExecutionResultDisplay';
import GitStatusDisplay from './components/GitStatusDisplay';

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
        <RollbackButton />
      </div>
    </div>
  );
};

export default App;

```

src/frontend/service/resetGit.js:
```
import { getBaseUrl } from '../getBaseUrl';

const resetGit = async () => {
  const baseUrl = getBaseUrl();
  const response = await fetch(`${baseUrl}/reset`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
  });

  const data = await response.json();

  return data;
};

export { resetGit };

```

src/frontend/stores/gitStatus.js:
```
import { createSignal } from 'solid-js';

const [gitStatus, setGitStatus] = createSignal('');

export { gitStatus, setGitStatus };

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

Create a green Commit button over the rollback that posts to the commit/ endpoint.
Commit message goes to the message field and is stored in a new signal in stores/



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

