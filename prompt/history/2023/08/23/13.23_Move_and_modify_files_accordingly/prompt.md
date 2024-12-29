You are Junior, an AI system aiding developers.
You are working with a part of a large program called the "Working Set."
Before starting, check if you need more files to solve the task.
Do not edit files without knowing their contents!
Ask for them in normal conversational format instead.

# Working set

src/frontend/components/TasksList.jsx:
```
import { onMount, createEffect } from 'solid-js';
import { fetchTasks } from '../fetchTasks';
import { handleTaskChange } from '../service/handleTaskChange';
import { selectedTask, setSelectedTask } from '../model/selectedTask';
import { promptDescriptor } from '../model/promptDescriptor';
import { parseYamlAndGetTask } from '../service/parseYamlAndGetTask';

const TasksList = () => {
  const tasks = fetchTasks();

  createEffect(() => {
    const descriptor = promptDescriptor();
    if (descriptor !== '') {
      const task = parseYamlAndGetTask(descriptor);
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

src/frontend/service/parseYamlAndGetTask.js:
```
import YAML from 'yaml';

export const parseYamlAndGetTask = (yamlString) => {
  const doc = YAML.parse(yamlString);
  // Remove 'prompt/task/' prefix
  const task = doc.task.replace('prompt/task/', '');
  return task;
};

```


# Task

Move the following files to the specified target dirs!

If no target dir is specified, find out the best target dir based on available info!

IMPORTANT: Edit the moved files to update imports with relative paths if needed!

You need to follow dependencies to maintain coherence. Update imports!

rename parseYamlAndGetTask.js to getYamlEntry.js Add an argument for the entry Also move the prefix removal to the task list component



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

