#!/bin/sh
# Goal: Listen to promptDescriptor and set task if not empty
# Plan:
# 1. Modify the TasksList component to listen to the promptDescriptor store.
# 2. If promptDescriptor is not empty, get the task from it using parseYamlAndGetTask and set it as the selected task.
# 3. If promptDescriptor is empty, do nothing.

# Step 1: Modify the TasksList.jsx component

cat > src/frontend/components/TasksList.jsx << EOF
import { onMount, createEffect } from 'solid-js';
import { fetchTasks } from '../fetchTasks';
import { handleTaskChange } from '../service/handleTaskChange';
import { selectedTask, setSelectedTask } from '../stores/selectedTask';
import { promptDescriptor } from '../stores/promptDescriptor';
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
    <div class="w-full flex justify-start bg-gray-100 p-2 rounded">
      <label class="mr-2">Task:</label>
      <select class="w-full" value={selectedTask()} onChange={e => handleTaskChange(e)}>
        {tasks().map(task => <option value={task}>{task}</option>)}
      </select>
    </div>
  );
};

export default TasksList;
EOF

# TasksList.jsx component is updated.
# Note: You might need to restart your application to see the changes take effect.
echo "TasksList.jsx component has been updated. You might need to restart your application to see the changes take effect."
