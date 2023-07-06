#!/bin/bash

# Modify TasksList.jsx to include a function for parsing yaml and setting initial task.
cat << EOF > ./src/frontend/components/TasksList.jsx
import { createSignal, onCleanup, onMount } from 'solid-js';
import { fetchTasks } from '../fetchTasks';
import { handleTaskChange } from '../service/handleTaskChange';
import { fetchDescriptor } from '../service/fetchDescriptor';
import YAML from 'yaml';

const TasksList = () => {
  const tasks = fetchTasks();
  const [promptDescriptor, setPromptDescriptor] = createSignal('');
  const [selectedTask, setSelectedTask] = createSignal('');

  const parseYamlAndGetTask = (yamlString) => {
    const doc = YAML.parse(yamlString);
    return doc.task;
  };

  onMount(async () => {
    const text = await fetchDescriptor();
    const task = parseYamlAndGetTask(text);
    setPromptDescriptor(text);
    setSelectedTask(task);
  });

  onCleanup(() => {
    setPromptDescriptor('');
  });

  return (
    <div>
      <label>Task:</label>
      <select value={selectedTask()} onChange={e => handleTaskChange(e, setPromptDescriptor)}>
        {tasks().map(task => <option value={task}>{task}</option>)}
      </select>
      <pre>{promptDescriptor()}</pre>
    </div>
  );
};

export default TasksList;
EOF

# Modify TasksList.jsx to update the label
sed -i '' 's/label>Tasks:/label>Task:/' ./src/frontend/components/TasksList.jsx

# Run npm install to update the dependencies
npm install
