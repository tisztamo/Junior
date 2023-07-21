#!/bin/sh
# Goal: Implement "Paste & Execute change" button feature with specific color
# Plan:
# 1. Create a new JavaScript file named "executeChange.js" in the "src/frontend/service/" directory. This file will contain a function to send the change to the backend for execution.
# 2. Modify the "App.jsx" file to include the new "Paste & Execute change" button.
# 3. Create a new JavaScript file named "ExecuteButton.jsx" in the "src/frontend/components/" directory. This file will define the new button and its functionality.

# Step 1: Create "executeChange.js"
cat << EOF > ./src/frontend/service/executeChange.js
import { getBaseUrl } from '../getBaseUrl';

const executeChange = async (change) => {
  const baseUrl = getBaseUrl();
  const response = await fetch(\`\${baseUrl}/execute\`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ change })
  });

  const data = await response.json();

  return data;
};

export { executeChange };
EOF

# Step 2: Modify "App.jsx"
cat << EOF > ./src/frontend/App.jsx
import NotesInput from './components/NotesInput';
import StartButton from './components/StartButton';
import ExecuteButton from './components/ExecuteButton';
import PromptDisplay from './components/PromptDisplay';
import TasksList from './components/TasksList';
import PromptDescriptor from './components/PromptDescriptor';
import NavBar from './components/NavBar';
import { notes, setNotes } from './stores/notes';
import { setPrompt } from './stores/prompt';

const App = () => {
  return (
    <div class="max-w-desktop lg:max-w-desktop md:max-w-full sm:max-w-full xs:max-w-full mx-auto flex flex-col items-center space-y-8 sm:p-0">
      <NavBar />
      <TasksList />
      <PromptDescriptor />
      <NotesInput notes={notes} setNotes={setNotes} />
      <StartButton notes={notes} setPrompt={setPrompt} />
      <ExecuteButton />
      <PromptDisplay />
    </div>
  );
};

export default App;
EOF

# Step 3: Create "ExecuteButton.jsx"
cat << EOF > ./src/frontend/components/ExecuteButton.jsx
import { executeChange } from '../service/executeChange';

const ExecuteButton = () => {
  const handleExecuteChange = async () => {
    const change = await navigator.clipboard.readText();
    const response = await executeChange(change);

    console.log(response.message);
  };

  return (
    // Updated button color to a less flashy orange
    <button class="px-8 py-4 bg-orange-300 text-white rounded" onClick={handleExecuteChange}>Paste & Execute Change</button>
  );
};

export default ExecuteButton;
EOF
