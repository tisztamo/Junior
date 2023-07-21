#!/bin/sh
# Goal: Implement Reset Git button
# Plan:
# 1. Create a new ResetButton.jsx component in the components directory.
# 2. In the ResetButton.jsx file, implement a handleReset function to call the reset git service, and a button that triggers this function when clicked.
# 3. Implement the resetGit function in a new resetGit.js file in the service directory that sends a POST request to the '/reset' endpoint.
# 4. Import the new ResetButton component in App.jsx and include it in the rendered JSX.

cat << EOF > ./src/frontend/components/ResetButton.jsx
import { resetGit } from '../service/resetGit';

const ResetButton = () => {
  const handleReset = async () => {
    const response = await resetGit();

    console.log(response.message);
  };

  return (
    <button class="px-8 py-4 bg-red-300 text-white rounded" onClick={handleReset}>Reset Git</button>
  );
};

export default ResetButton;
EOF

cat << EOF > ./src/frontend/service/resetGit.js
import { getBaseUrl } from '../getBaseUrl';

const resetGit = async () => {
  const baseUrl = getBaseUrl();
  const response = await fetch(\`\${baseUrl}/reset\`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
  });

  const data = await response.json();

  return data;
};

export { resetGit };
EOF

cat << EOF > ./src/frontend/App.jsx
import NotesInput from './components/NotesInput';
import StartButton from './components/StartButton';
import ExecuteButton from './components/ExecuteButton';
import ResetButton from './components/ResetButton';
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
      <ResetButton />
      <PromptDisplay />
    </div>
  );
};

export default App;
EOF
