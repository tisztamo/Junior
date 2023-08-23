#!/bin/sh
set -e
goal="Move and modify files accordingly"
echo "Plan:"
echo "1. Rename parseYamlAndGetTask.js to getYamlEntry.js and move it."
echo "2. Update getYamlEntry.js to accept an additional argument for the entry and return the entry."
echo "3. Update TasksList.jsx to use the renamed function and move the prefix removal logic."

# Step 1: Rename and move
mv src/frontend/service/parseYamlAndGetTask.js src/frontend/service/getYamlEntry.js

cat << 'EOF' > src/frontend/service/getYamlEntry.js
import YAML from 'yaml';

export const getYamlEntry = (yamlString, entry) => {
  const doc = YAML.parse(yamlString);
  return doc[entry];
};
EOF

# Step 2: Update the import in TasksList.jsx
# and modify the prefix removal logic accordingly.

cat << 'EOF' > src/frontend/components/TasksList.jsx
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
EOF

echo "\033[32mDone: $goal\033[0m\n"