You are AI Junior, you code like Donald Knuth.
# Working set

src/frontend/components/PromptCreation.jsx:
```
import TasksList from './TasksList';
import PromptDescriptor from './PromptDescriptor';
import GenerateButton from './GenerateButton';
import PromptDisplay from './PromptDisplay';
import RequirementsEditor from './RequirementsEditor';

const PromptCreation = () => {
  return (
    <>
      <TasksList />
      <RequirementsEditor />
      <PromptDescriptor />
      <GenerateButton />
      <PromptDisplay />
    </>
  );
};

export default PromptCreation;

```

src/frontend/components/TasksList.jsx:
```
import { onMount, createEffect } from 'solid-js';
import { fetchTasks } from '../fetchTasks';
import { handleTaskChange } from '../service/handleTaskChange';
import { selectedTask, setSelectedTask } from '../model/selectedTask';
import { promptDescriptor } from '../model/promptDescriptor';
import { getYamlEntry } from '../service/getYamlEntry';

const TasksList = () => {
  const tasks = fetchTasks();

  createEffect(() => {
    const descriptor = promptDescriptor();
    if (descriptor !== '') {
      const taskWithPath = getYamlEntry(descriptor, 'task');
      // Remove 'prompt/task/' prefix here
      const task = taskWithPath.replace('prompt/task/', '');
      setSelectedTask(task);
    }
  });

  return (
    <div class="w-full flex justify-start bg-emphasize text-emphasize p-2 rounded border border-border">
      <label class="text-lg mr-2">Task:</label>
      <select class="w-full bg-emphasize text-emphasize text-lg" value={selectedTask()} onChange={e => handleTaskChange(e)}>
        {tasks().map(task => <option value={task}>{task}</option>)}
      </select>
    </div>
  );
};

export default TasksList;

```

src/frontend/components/NavBar.jsx:
```
import ThemeSwitcher from './ThemeSwitcher';
import SubTitle from './SubTitle';

const NavBar = () => {
  const title = 'Junior';

  return (
    <div class="relative w-full">
      <div class="absolute top-0 right-0 m-4">
        <ThemeSwitcher />
      </div>
      <div class="flex flex-col items-center justify-center">
        <a href="https://github.com/tisztamo/Junior" class="text-center text-3xl mt-6 no-underline">{title}</a>
        <SubTitle />
      </div>
    </div>
  );
};

export default NavBar;

```

src/frontend/components/RollbackButton.jsx:
```
import { createSignal } from "solid-js";
import { resetGit } from '../service/resetGit';
import RollbackConfirmationDialog from './RollbackConfirmationDialog';
import clearState from '../service/clearState';

const RollbackButton = () => {
  const [showConfirmation, setShowConfirmation] = createSignal(false);

  const handleReset = async () => {
    const response = await resetGit();
    console.log(response.message);
    clearState();
  };

  const handleConfirm = () => {
    setShowConfirmation(false);
    handleReset();
  };

  const handleRollbackClick = () => {
    const disableConfirmation = localStorage.getItem('Junior.disableRollbackConfirmation') === 'true';
    if (disableConfirmation) {
      handleReset();
    } else {
      setShowConfirmation(true);
    }
  };

  return (
    <>
      <button className="w-full px-4 py-4 bg-red-700 text-lg text-bg font-semibold rounded" onClick={handleRollbackClick}>Roll Back</button>
      <RollbackConfirmationDialog visible={showConfirmation()} onConfirm={handleConfirm} onCancel={() => setShowConfirmation(false)} />
    </>
  );
};

export default RollbackButton;

```

src/frontend/components/ChangeExecution.jsx:
```
import ExecuteButton from './ExecuteButton';
import ExecutionResultDisplay from './ExecutionResultDisplay';

const ChangeExecution = () => {
  return (
    <>
      <ExecuteButton />
      <ExecutionResultDisplay />
    </>
  );
};

export default ChangeExecution;

```

src/frontend/components/GitStatusDisplay.jsx:
```
import { onMount, createEffect } from 'solid-js';
import { gitStatus } from '../model/gitStatus';
import { fetchGitStatus } from '../service/fetchGitStatus';

const GitStatusDisplay = () => {
  let statusContainer;

  onMount(fetchGitStatus);

  createEffect(() => {
    const gitStatusValue = gitStatus();
    if (gitStatusValue) {
      if (gitStatusValue.error) {
        statusContainer.innerText = `${gitStatusValue.message}\n${gitStatusValue.error.stderr}`;
      } else if (gitStatusValue.message && gitStatusValue.message !== '') {
        statusContainer.innerText = gitStatusValue.message;
      }
    }
  });

  return (
    <pre
      ref={statusContainer}
      class={`rounded overflow-auto max-w-full ${gitStatus() && gitStatus().message && gitStatus().message !== '' ? 'block' : 'hidden'}`}
    />
  );
};

export default GitStatusDisplay;

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

We need a Sample Component, which is short but shows
how we write our components.
We need to show: - How the model is used - How local state is managed - How services are called - etc.
Imagine a sample service and model, use it in the sample component, but do not write it.
Write a comprehensive and concise sample to src/frontend/components/SampleComponent.jsx


## Project Specifics

- Every js file should *only export a single function*!
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs* and Tailwind, edit .jsx files accordingly!
- Remove _all existing comments_ from the code!
- Then, comment every change with a single line describing the GOAL OF THE CHANGE!


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

Before starting, check if you need more files to solve the task.
Do not edit any file not provided in the working set!
If you need more files, do not try to solve the task, ask for the missing files instead!

EXAMPLE START

`filepath1` is needed to solve the task but is not in the working set.

EXAMPLE END

