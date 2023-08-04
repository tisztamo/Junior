#!/bin/sh
set -e
goal="Coloring select tag and inputs to be dark theme-aware"
echo "Plan:"
echo "1. Modify CommitMessageInput.jsx to add the emphasize tailwind color class for dark and light modes."
echo "2. Modify TasksList.jsx to add the emphasize tailwind color class for dark and light modes to the select tag."

# Modifying CommitMessageInput.jsx to add dark theme-aware classes
cat << 'EOF' > src/frontend/components/CommitMessageInput.jsx
import { commitMessage, setCommitMessage } from '../model/commitMessage';
import monitorChange from '../model/monitorChange';

const CommitMessageInput = (props) => {
  // Start monitoring when mounting
  monitorChange();

  const handleChange = (e) => {
    setCommitMessage(e.target.value);
  };

  return (
    <input type="text" className="w-full px-4 py-2 border rounded dark:bg-dark-emphasize bg-light-emphasize" placeholder="Commit message..." value={commitMessage()} onInput={handleChange} />
  );
};

export default CommitMessageInput;
EOF

# Modifying TasksList.jsx to add dark theme-aware classes to the select tag
cat << 'EOF' > src/frontend/components/TasksList.jsx
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
    <div class="w-full flex justify-start dark:bg-dark-emphasize bg-light-emphasize p-2 rounded">
      <label class="mr-2">Task:</label>
      <select class="w-full dark:bg-dark-emphasize bg-light-emphasize" value={selectedTask()} onChange={e => handleTaskChange(e)}>
        {tasks().map(task => <option value={task}>{task}</option>)}
      </select>
    </div>
  );
};

export default TasksList;
EOF

echo "\033[32mDone: $goal\033[0m\n"
