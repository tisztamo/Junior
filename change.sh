#!/bin/sh
set -e
goal="Move and rename ResetButton component"
echo "Plan:"
echo "1. Rename ResetButton.jsx to RollbackButton.jsx and update its content."
echo "2. Update App.jsx to import RollbackButton instead of ResetButton."

# Step 1: Rename ResetButton.jsx to RollbackButton.jsx and update its content.
cat > src/frontend/components/RollbackButton.jsx << 'EOF'
import { resetGit } from '../service/resetGit';

const RollbackButton = () => {
  const handleReset = async () => {
    const response = await resetGit();

    console.log(response.message);
  };

  return (
    <button class="w-64 px-4 py-4 bg-red-700 text-white rounded" onClick={handleReset}>Roll Back to Last Commit</button>
  );
};

export default RollbackButton;
EOF

# Remove the old ResetButton.jsx file
rm src/frontend/components/ResetButton.jsx

# Step 2: Update App.jsx to import RollbackButton instead of ResetButton.
cat > src/frontend/App.jsx << 'EOF'
import GenerateButton from './components/GenerateButton';
import ExecuteButton from './components/ExecuteButton';
import RollbackButton from './components/RollbackButton';
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
        <RollbackButton />
      </div>
    </div>
  );
};

export default App;
EOF

echo "\033[32mDone: $goal\033[0m\n"
