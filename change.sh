#!/bin/bash
set -e

# Create a backup before modifying the files
cp src/frontend/components/TasksList.jsx src/frontend/components/TasksList.jsx.bak

# Create parseYamlAndGetTask.js file in frontend/service with parseYamlAndGetTask function
cat > src/frontend/service/parseYamlAndGetTask.js << 'EOF'
import YAML from 'yaml';

export const parseYamlAndGetTask = (yamlString) => {
  const doc = YAML.parse(yamlString);
  // Remove 'prompt/task/' prefix
  const task = doc.task.replace('prompt/task/', '');
  return task;
};
EOF

# Edit the TasksList.jsx file
cat > src/frontend/components/TasksList.jsx << 'EOF'
import { createSignal, onCleanup, onMount } from 'solid-js';
import { fetchTasks } from '../fetchTasks';
import { handleTaskChange } from '../service/handleTaskChange';
import { fetchDescriptor } from '../service/fetchDescriptor';
import { parseYamlAndGetTask } from '../service/parseYamlAndGetTask';

const TasksList = () => {
  const tasks = fetchTasks();
  const [promptDescriptor, setPromptDescriptor] = createSignal('');
  const [selectedTask, setSelectedTask] = createSignal('');

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

# Print out the diff to check the changes
echo "Changes made in TasksList.jsx:"
diff src/frontend/components/TasksList.jsx.bak src/frontend/components/TasksList.jsx

# Clean up backup file
rm src/frontend/components/TasksList.jsx.bak

echo "Done!"
