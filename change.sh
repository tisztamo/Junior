#!/bin/sh
# Goal: Refactor files and move signals and stores
# Plan:
# 1. Create a new directory "src/frontend/stores".
# 2. Create a separate file for each signal and store.
# 3. Move the respective signals and stores to the newly created files.
# 4. Update the import statements in the original files to reflect the changes.

mkdir -p src/frontend/stores

# src/frontend/stores/notes.js
cat > src/frontend/stores/notes.js << 'EOF'
import { createSignal } from 'solid-js';

export const [notes, setNotes] = createSignal('');
EOF

# src/frontend/stores/prompt.js
cat > src/frontend/stores/prompt.js << 'EOF'
import { createSignal } from 'solid-js';

export const [prompt, setPrompt] = createSignal('');
EOF

# src/frontend/stores/promptDescriptor.js
cat > src/frontend/stores/promptDescriptor.js << 'EOF'
import { createSignal } from 'solid-js';

export const [promptDescriptor, setPromptDescriptor] = createSignal('');
EOF

# src/frontend/stores/selectedTask.js
cat > src/frontend/stores/selectedTask.js << 'EOF'
import { createSignal } from 'solid-js';

export const [selectedTask, setSelectedTask] = createSignal('');
EOF

# Update App.jsx file
cat > src/frontend/App.jsx << 'EOF'
import NotesInput from './components/NotesInput';
import StartButton from './components/StartButton';
import PromptDisplay from './components/PromptDisplay';
import TasksList from './components/TasksList';
import { notes, setNotes } from './stores/notes';
import { prompt, setPrompt } from './stores/prompt';

const App = () => {
  return (
    <>
      <NotesInput notes={notes} setNotes={setNotes} />
      <StartButton notes={notes} setPrompt={setPrompt} />
      <PromptDisplay prompt={prompt} />
      <TasksList />
    </>
  );
};

export default App;
EOF

# Update TasksList.jsx file
cat > src/frontend/components/TasksList.jsx << 'EOF'
import { onCleanup, onMount } from 'solid-js';
import { fetchTasks } from '../fetchTasks';
import { handleTaskChange } from '../service/handleTaskChange';
import { fetchDescriptor } from '../service/fetchDescriptor';
import { parseYamlAndGetTask } from '../service/parseYamlAndGetTask';
import { useWebsocket } from '../service/useWebsocket';
import { promptDescriptor, setPromptDescriptor } from '../stores/promptDescriptor';
import { selectedTask, setSelectedTask } from '../stores/selectedTask';

const TasksList = () => {
  const tasks = fetchTasks();

  onMount(async () => {
    const text = await fetchDescriptor();
    const task = parseYamlAndGetTask(text);
    setPromptDescriptor(text);
    setSelectedTask(task);
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
