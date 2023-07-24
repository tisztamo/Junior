# Working set

src/frontend/components/TasksList.jsx:
```
import { onMount } from 'solid-js';
import { fetchTasks } from '../fetchTasks';
import { handleTaskChange } from '../service/handleTaskChange';
import { selectedTask, setSelectedTask } from '../stores/selectedTask';

const TasksList = () => {
  const tasks = fetchTasks();

  onMount(async () => {
    const task = tasks[0]; // Set default task to the first in the list
    setSelectedTask(task);
  });

  return (
    // Align the tasklist to the left within a single column layout and add background color
    <div class="w-full flex justify-start bg-gray-100 p-2 rounded">
      <label class="mr-2">Task:</label>
      <select class="w-full" value={selectedTask()} onChange={e => handleTaskChange(e)}>
        {tasks().map(task => <option value={task}>{task}</option>)}
      </select>
    </div>
  );
};

export default TasksList;

```

src/frontend/fetchTasks.js:
```
import { createSignal } from 'solid-js';
import { getBaseUrl } from './getBaseUrl';

export const fetchTasks = () => {
    const [tasks, setTasks] = createSignal([]);
    const baseUrl = getBaseUrl();
    const response = fetch(`${baseUrl}/tasks`);
    response.then(r => r.json()).then(data => setTasks(data.tasks));

    return tasks;
};

```

src/frontend/stores/promptDescriptor.js:
```
import { createSignal } from 'solid-js';

export const [promptDescriptor, setPromptDescriptor] = createSignal('');

```

src/frontend/stores/selectedTask.js:
```
import { createSignal } from 'solid-js';

export const [selectedTask, setSelectedTask] = createSignal('');

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

Implement the following feature!

- Create a plan!
- Create new files when needed!
- Every js file should only export a single function!
- Use ES6 imports!

Requirements:

Instead of selecting the first task, listen to the promptDescriptor and if not empty, get the task from it!



# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, prefer heredoc-ing full files without substitution.
Assume OSX.
npm and jq are installed.
Do NOT write any text outside the script (the plan goes into it)!


EXAMPLE START

```sh
#!/bin/sh
# Goal: [Task description, max 7 words]
# Plan:
# 1. [...]

[Commands solving the task]
```

EXAMPLE END

