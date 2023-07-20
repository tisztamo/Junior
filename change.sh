#!/bin/sh
# Goal: Refactor to separate prompt descriptor into a new component
# Plan:
# 1. Create a new file `src/frontend/components/PromptDescriptor.jsx` for the new PromptDescriptor component.
# 2. Remove the rendering of the prompt descriptor and related hooks from `TasksList.jsx`
# 3. Update `App.jsx` to use the new `PromptDescriptor` component.
# 4. Delete the unneeded `src/frontend/components/TasksList.jsx.bak` file.
# 5. Update `src/frontend/service/handleTaskChange.js` to import `setPromptDescriptor` from the store.

# Step 1: Create a new file `src/frontend/components/PromptDescriptor.jsx` for the new PromptDescriptor component.
cat > src/frontend/components/PromptDescriptor.jsx << EOF
import { onMount, onCleanup } from 'solid-js';
import { fetchDescriptor } from '../service/fetchDescriptor';
import { useWebsocket } from '../service/useWebsocket';
import { promptDescriptor, setPromptDescriptor } from '../stores/promptDescriptor';

const PromptDescriptor = () => {

  onMount(async () => {
    const text = await fetchDescriptor();
    setPromptDescriptor(text);
  });

  useWebsocket(async (e) => {
    if (e.data === 'update') {
      const text = await fetchDescriptor();
      setPromptDescriptor(text);
    }
  });

  onCleanup(() => {
    setPromptDescriptor('');
  });

  return (
    <pre>{promptDescriptor()}</pre>
  );
};

export default PromptDescriptor;
EOF

# Step 2: Remove the rendering of the prompt descriptor and related hooks from `TasksList.jsx`
cat > src/frontend/components/TasksList.jsx << EOF
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
    <div>
      <label>Task:</label>
      <select value={selectedTask()} onChange={e => handleTaskChange(e)}>
        {tasks().map(task => <option value={task}>{task}</option>)}
      </select>
    </div>
  );
};

export default TasksList;
EOF

# Step 3: Update `App.jsx` to use the new `PromptDescriptor` component.
cat > src/frontend/App.jsx << EOF
import NotesInput from './components/NotesInput';
import StartButton from './components/StartButton';
import PromptDisplay from './components/PromptDisplay';
import TasksList from './components/TasksList';
import PromptDescriptor from './components/PromptDescriptor';
import { notes, setNotes } from './stores/notes';
import { prompt, setPrompt } from './stores/prompt';

const App = () => {
  return (
    <>
      <NotesInput notes={notes} setNotes={setNotes} />
      <StartButton notes={notes} setPrompt={setPrompt} />
      <PromptDisplay prompt={prompt} />
      <TasksList />
      <PromptDescriptor />
    </>
  );
};

export default App;
EOF

# Step 4: Delete the unneeded `src/frontend/components/TasksList.jsx.bak` file.
rm src/frontend/components/TasksList.jsx.bak

# Step 5: Update `src/frontend/service/handleTaskChange.js` to import `setPromptDescriptor` from the store.
cat > src/frontend/service/handleTaskChange.js << EOF
import { getBaseUrl } from '../getBaseUrl';
import { fetchDescriptor } from './fetchDescriptor';
import { setPromptDescriptor } from '../stores/promptDescriptor';

export const handleTaskChange = async (e) => {
  const baseUrl = getBaseUrl();
  const selectedTask = e.target.value;

  const response = await fetch(\`\${baseUrl}/updatetask\`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({ task: selectedTask })
  });

  if (response.ok) {
    const text = await fetchDescriptor();
    setPromptDescriptor(text);
  }
};
EOF
