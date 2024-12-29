You are Junior, an AI system aiding developers.
You are working with a part of a large program called the "Working Set."
Before starting, check if you need more files to solve the task.
Do not edit files without knowing their contents!
Ask for them in normal conversational format instead.

# Working set

src/frontend/service/postDescriptor.js:
```
import { getBaseUrl } from '../getBaseUrl';

const postDescriptor = async (descriptor) => {
  const baseUrl = getBaseUrl();
  const response = await fetch(`${baseUrl}/descriptor`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(descriptor),
  });

  return await response.json();
};

export default postDescriptor;

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

src/frontend/components/RequirementsEditor.jsx:
```
import { createSignal } from 'solid-js';
import postDescriptor from '../service/postDescriptor';

const RequirementsEditor = () => {
  const [requirements, setRequirements] = createSignal('');

  const handleRequirementsChange = async (e) => {
    setRequirements(e.target.value);
    await postDescriptor({ requirements: e.target.value });
  };

  return (
    <div class="w-full flex justify-start bg-emphasize text-emphasize p-2 rounded border border-border mt-4">
      <label class="text-lg mr-2">Requirements:</label>
      <textarea
        class="w-full bg-emphasize text-emphasize text-lg"
        value={requirements()}
        onInput={e => handleRequirementsChange(e)}
      />
    </div>
  );
};

export default RequirementsEditor;

```

src/frontend/model/promptDescriptor.js:
```
import { createSignal } from 'solid-js';

export const [promptDescriptor, setPromptDescriptor] = createSignal('');

```


# Task

Refactor!

Eliminate the signal from the requirements editor component
and fill it from the promptDescriptor signals requirements section,
similarly to how TasksList works.
Also remove the label and use "Enter your requirements..." placeholder instead



## Project Specifics

- Every js file should *only export a single function*!
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs* and Tailwind, edit .jsx file accordingly!


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

