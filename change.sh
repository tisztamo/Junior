#!/bin/sh
set -e
goal="Update class attributes in specific components"
echo "Plan:"
echo "1. Add 'text-text' class to the app div in App.jsx"
echo "2. Remove coloring classes from CommitMessageInput and replace them with 'bg-emphasize text-emphasize'"
echo "3. Remove coloring classes from TasksList and replace them with 'bg-emphasize text-emphasize'"

# Step 1: Add 'text-text' class to the app div in App.jsx
cat > src/frontend/App.jsx << 'EOF'
import GenerateButton from './components/GenerateButton';
import ExecuteButton from './components/ExecuteButton';
import RollbackButton from './components/RollbackButton';
import CommitButton from './components/CommitButton';
import PromptDisplay from './components/PromptDisplay';
import TasksList from './components/TasksList';
import PromptDescriptor from './components/PromptDescriptor';
import NavBar from './components/NavBar';
import ExecutionResultDisplay from './components/ExecutionResultDisplay';
import GitStatusDisplay from './components/GitStatusDisplay';
import CommitMessageInput from './components/CommitMessageInput';

const App = () => {
  return (
    <div id="app" class="p-2 bg-main text-text">
      <div class="max-w-desktop lg:max-w-desktop md:max-w-full sm:max-w-full xs:max-w-full mx-auto flex flex-col items-center space-y-8 sm:p-0">
        <NavBar />
        <TasksList />
        <PromptDescriptor />
        <GenerateButton />
        <PromptDisplay />
        <ExecuteButton />
        <ExecutionResultDisplay />
        <GitStatusDisplay />
        <CommitMessageInput />
        <CommitButton />
        <RollbackButton />
      </div>
    </div>
  );
};

export default App;
EOF

# Step 2: Remove coloring classes from CommitMessageInput and replace them with 'bg-emphasize text-emphasize'
cat > src/frontend/components/CommitMessageInput.jsx << 'EOF'
import { commitMessage, setCommitMessage } from '../model/commitMessage';
import monitorChange from '../model/monitorChange';

const CommitMessageInput = (props) => {
  // Start monitoring when mounting
  monitorChange();

  const handleChange = (e) => {
    setCommitMessage(e.target.value);
  };

  return (
    <input type="text" className="w-full px-4 py-2 border rounded bg-emphasize text-emphasize" placeholder="Commit message..." value={commitMessage()} onInput={handleChange} />
  );
};

export default CommitMessageInput;
EOF

# Step 3: Remove coloring classes from TasksList and replace them with 'bg-emphasize text-emphasize'
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
      <label class="mr-2">Task:</label>
      <select class="w-full bg-emphasize text-emphasize" value={selectedTask()} onChange={e => handleTaskChange(e)}>
        {tasks().map(task => <option value={task}>{task}</option>)}
      </select>
    </div>
  );
};

export default TasksList;
EOF

echo "\033[32mDone: $goal\033[0m\n"
