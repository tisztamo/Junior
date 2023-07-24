# Working set

src/frontend/components/ResetButton.jsx:
```
import { resetGit } from '../service/resetGit';

const ResetButton = () => {
  const handleReset = async () => {
    const response = await resetGit();

    console.log(response.message);
  };

  return (
    <button class="w-64 px-4 py-4 bg-red-700 text-white rounded" onClick={handleReset}>Reset Git</button>
  );
};

export default ResetButton;

```

src/frontend/App.jsx:
```
import GenerateButton from './components/GenerateButton';
import ExecuteButton from './components/ExecuteButton';
import ResetButton from './components/ResetButton';
import PromptDisplay from './components/PromptDisplay';
import TasksList from './components/TasksList';
import PromptDescriptor from './components/PromptDescriptor';
import NavBar from './components/NavBar';
import ExecutionResultDisplay from './components/ExecutionResultDisplay';

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
        <ResetButton />
      </div>
    </div>
  );
};

export default App;

```


# Task

Move the following files to the specified target dirs!

Find out the best target dir if it is not specified!

You need to follow dependencies to maintain coherence.

Before executing, write a concise plan! The plan should show:
 - How do you avoid breaking other parts of the code.
 - If you had to choose, your way of thinking.

Rename the reset git button to RollbackButton with label &#34;Roll Back to Last Commit&#34;.


# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, prefer heredoc-ing full files using 'EOF' to prevent substitution.
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

