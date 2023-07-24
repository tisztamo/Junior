#!/bin/sh
set -e
goal="Rename StartButton and remove setPrompt"
# Plan:
# 1. Rename the file from StartButton.jsx to GenerateButton.jsx
# 2. Modify the GenerateButton component not to accept setPrompt as a prop but import it from stores directly.
# 3. Update App.jsx to use GenerateButton instead of StartButton.

echo "Renaming StartButton.jsx to GenerateButton.jsx"
mv src/frontend/components/StartButton.jsx src/frontend/components/GenerateButton.jsx

echo "Modifying GenerateButton component to import setPrompt"
cat << 'EOF' > src/frontend/components/GenerateButton.jsx
import { generatePrompt } from '../generatePrompt';
import { marked } from 'marked';
import copy from 'clipboard-copy';
import { setPrompt } from '../stores/prompt';

const GenerateButton = () => {
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

export default GenerateButton;
EOF

echo "Updating App.jsx to use GenerateButton instead of StartButton"
cat << 'EOF' > src/frontend/App.jsx
import GenerateButton from './components/GenerateButton';
import ExecuteButton from './components/ExecuteButton';
import ResetButton from './components/ResetButton';
import PromptDisplay from './components/PromptDisplay';
import TasksList from './components/TasksList';
import PromptDescriptor from './components/PromptDescriptor';
import NavBar from './components/NavBar';

const App = () => {
  return (
    <div class="m-2">
      <div class="max-w-desktop lg:max-w-desktop md:max-w-full sm:max-w-full xs:max-w-full mx-auto flex flex-col items-center space-y-8 sm:p-0">
        <NavBar />
        <TasksList />
        <PromptDescriptor />
        <GenerateButton />
        <PromptDisplay />
        <ExecuteButton />
        <ResetButton />
      </div>
    </div>
  );
};

export default App;
EOF

echo "Completed: $goal\n"
