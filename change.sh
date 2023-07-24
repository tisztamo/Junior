#!/bin/sh
set -e
goal="Implement execution result signal and component"
# Plan:
# 1. Create a new file named "executionResult.js" in the "stores" directory to keep track of the execution result.
# 2. Update the ExecuteButton component to set the execution result.
# 3. Create a new component named "ExecutionResultDisplay" in the "components" directory to display the execution result.
# 4. Update the App component to include the ExecutionResultDisplay component below the ExecuteButton.

echo "Creating the executionResult signal"
cat << 'EOF' > ./src/frontend/stores/executionResult.js
import { createSignal } from 'solid-js';

export const [executionResult, setExecutionResult] = createSignal('');
EOF

echo "Updating ExecuteButton component to set the execution result"
cat << 'EOF' > ./src/frontend/components/ExecuteButton.jsx
import { executeChange } from '../service/executeChange';
import { setExecutionResult } from '../stores/executionResult';

const ExecuteButton = () => {
  const handleExecuteChange = async () => {
    const change = await navigator.clipboard.readText();
    const response = await executeChange(change);
    setExecutionResult(response.message);
    console.log(response.message);
  };

  return (
    <button class="w-64 px-4 py-4 bg-orange-300 text-white rounded" onClick={handleExecuteChange}>Paste & Execute Change</button>
  );
};

export default ExecuteButton;
EOF

echo "Creating ExecutionResultDisplay component"
cat << 'EOF' > ./src/frontend/components/ExecutionResultDisplay.jsx
import { executionResult } from '../stores/executionResult';

const ExecutionResultDisplay = () => {
  return (
    <div class="w-64 px-4 py-4 bg-gray-300 text-black rounded">
      {executionResult()}
    </div>
  );
};

export default ExecutionResultDisplay;
EOF

echo "Updating App component to include ExecutionResultDisplay"
cat << 'EOF' > ./src/frontend/App.jsx
import GenerateButton from './components/GenerateButton';
import ExecuteButton from './components/ExecuteButton';
import ResetButton from './components/ResetButton';
import PromptDisplay from './components/PromptDisplay';
import TasksList from './components/TasksList';
import PromptDescriptor from './components/PromptDescriptor';
import NavBar from './components/NavBar';
import ExecutionResultDisplay from './components/ExecutionResultDisplay';

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
        <ExecutionResultDisplay />
        <ResetButton />
      </div>
    </div>
  );
};

export default App;
EOF

echo "\033[32mCompleted: $goal\033[0m\n"
