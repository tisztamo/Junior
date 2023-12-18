#!/bin/sh
set -e
goal="Resolve race condition in task list"
echo "Plan:"
echo "1. Modify TasksList.jsx to use the 'selected' attribute."
echo "2. Test the updated component to ensure the race condition is resolved."

cat > src/frontend/components/TasksList.jsx << EOF
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
      const task = taskWithPath.replace('prompt/task/', '');
      setSelectedTask(task);
    }
  });

  return (
    <div class="w-full flex justify-start bg-emphasize text-emphasize p-2 rounded border border-border">
      <label class="text-lg mr-2">Task:</label>
      <select class="w-full bg-emphasize text-emphasize text-lg" onChange={e => handleTaskChange(e)}>
        {tasks().map(task => <option value={task} selected={selectedTask() === task}>{task}</option>)}
      </select>
    </div>
  );
};

export default TasksList;
EOF
echo "\033[32mDone: $goal\033[0m\n"