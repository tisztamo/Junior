#!/bin/sh
set -e
goal="Eliminate the notes input feature"
echo "Starting: $goal"
# Plan:
# 1. Remove 'NotesInput' component import from 'App.jsx'.
# 2. Remove usage of 'NotesInput' component from 'App.jsx'.
# 3. Delete the 'NotesInput.jsx' component file as it's no longer needed.
# 4. Remove 'notes' and 'setNotes' import from 'notes.js' in 'App.jsx'.
# 5. Remove usage of 'notes' and 'setNotes' from the 'StartButton' component in 'App.jsx'.
# 6. Modify the 'StartButton.jsx' to remove the 'notes' prop and its usage in the 'handleGeneratePrompt' function.
# 7. Delete the 'notes.js' store file as it's no longer needed.

echo "Removing 'NotesInput' component import from 'App.jsx'"
cat <<'EOF' > src/frontend/App.jsx
import StartButton from './components/StartButton';
import ExecuteButton from './components/ExecuteButton';
import ResetButton from './components/ResetButton';
import PromptDisplay from './components/PromptDisplay';
import TasksList from './components/TasksList';
import PromptDescriptor from './components/PromptDescriptor';
import NavBar from './components/NavBar';
import { setPrompt } from './stores/prompt';

const App = () => {
  return (
    <div class="m-2">
      <div class="max-w-desktop lg:max-w-desktop md:max-w-full sm:max-w-full xs:max-w-full mx-auto flex flex-col items-center space-y-8 sm:p-0">
        <NavBar />
        <TasksList />
        <PromptDescriptor />
        <StartButton setPrompt={setPrompt} />
        <PromptDisplay />
        <ExecuteButton />
        <ResetButton />
      </div>
    </div>
  );
};

export default App;
EOF

echo "Deleting 'NotesInput.jsx' component"
rm src/frontend/components/NotesInput.jsx

echo "Removing 'notes' and 'setNotes' import from 'App.jsx'"
# Already done in the step of removing 'NotesInput' component import from 'App.jsx'.

echo "Removing usage of 'notes' and 'setNotes' from 'StartButton' component in 'App.jsx'"
# Already done in the step of removing 'NotesInput' component import from 'App.jsx'.

echo "Modifying 'StartButton.jsx' to remove 'notes' prop and its usage"
cat <<'EOF' > src/frontend/components/StartButton.jsx
import { generatePrompt } from '../generatePrompt';
import { marked } from 'marked';
import copy from 'clipboard-copy';

const StartButton = ({setPrompt}) => {
  const handleGeneratePrompt = async () => {
    const response = await generatePrompt();

    copy(response.prompt)
      .then(() => {
        console.log('Prompt copied to clipboard!');
      })
      .catch(err => {
        console.error('Failed to copy prompt: ', err);
      });

    const htmlPrompt = marked(response.prompt);

    setPrompt(htmlPrompt);
  };

  return (
    <button class="w-64 px-4 py-4 bg-blue-500 text-white rounded" onClick={handleGeneratePrompt}>Generate & Copy Prompt</button>
  );
};

export default StartButton;
EOF

echo "Deleting 'notes.js' store"
rm src/frontend/stores/notes.js

echo "Completed: $goal\n"
