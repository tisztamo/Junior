#!/bin/bash

# Creating directory for api services
mkdir -p src/frontend/service

# Creating fetchDescriptor.js in service directory
cat << EOF > src/frontend/service/fetchDescriptor.js
export const fetchDescriptor = async () => {
  const response = await fetch('http://localhost:3000/descriptor');
  const text = await response.text();
  return text;
};
EOF

# handleTaskChange.js refactor and move to service directory
cat << EOF > src/frontend/service/handleTaskChange.js
import { fetchDescriptor } from './fetchDescriptor';

export const handleTaskChange = async (e, setPromptDescriptor) => {
  const selectedTask = e.target.value;

  const response = await fetch('http://localhost:3000/updatetask', {
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

# TasksList.jsx refactor with updated import paths
cat << EOF > src/frontend/components/TasksList.jsx
import { createSignal, onCleanup, onMount } from 'solid-js';
import { fetchTasks } from '../fetchTasks';
import { handleTaskChange } from '../service/handleTaskChange';
import { fetchDescriptor } from '../service/fetchDescriptor';

const TasksList = () => {
  const tasks = fetchTasks();
  const [promptDescriptor, setPromptDescriptor] = createSignal('');

  onMount(async () => {
    const text = await fetchDescriptor();
    setPromptDescriptor(text);
  });

  onCleanup(() => {
    setPromptDescriptor('');
  });

  return (
    <div>
      <label>Tasks:</label>
      <select onChange={e => handleTaskChange(e, setPromptDescriptor)}>
        {tasks().map(task => <option value={task}>{task}</option>)}
      </select>
      <pre>{promptDescriptor()}</pre>
    </div>
  );
};

export default TasksList;
EOF

# PromptDescriptorViewer.jsx refactor with updated import paths
cat << EOF > src/frontend/components/PromptDescriptorViewer.jsx
import { createSignal, onMount } from 'solid-js';
import { fetchDescriptor } from '../service/fetchDescriptor';

const PromptDescriptorViewer = () => {
  const [descriptorContent, setDescriptorContent] = createSignal('');

  onMount(async () => {
    const text = await fetchDescriptor();
    setDescriptorContent(text);
  });

  return (
    <pre>{descriptorContent()}</pre>
  );
};

export default PromptDescriptorViewer;
EOF

#!/bin/bash

cat << EOF > src/frontend/App.jsx
import { createSignal } from 'solid-js';
import PromptDescriptorViewer from './components/PromptDescriptorViewer'; // updated this line
import NotesInput from './components/NotesInput';
import StartButton from './components/StartButton';
import PromptDisplay from './components/PromptDisplay';
import TasksList from './components/TasksList';

const App = () => {
  const [notes, setNotes] = createSignal('');
  const [prompt, setPrompt] = createSignal('');

  return (
    <>
      <PromptDescriptorViewer />
      <NotesInput notes={notes} setNotes={setNotes} />
      <StartButton notes={notes} setPrompt={setPrompt} />
      <PromptDisplay prompt={prompt} />
      <TasksList />
    </>
  );
};

export default App;
EOF
