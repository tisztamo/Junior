#!/bin/sh
set -e
goal="Increase font of task list input and label"
echo "Plan:"
echo "1. Modify the CSS classes for the task list input and its label to increase their font size"
echo "2. Save the changes to src/frontend/components/TasksList.jsx"

cat > src/frontend/components/TasksList.jsx << 'EOF'
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
    <div class="w-full flex justify-start bg-emphasize text-emphasize p-2 rounded">
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
