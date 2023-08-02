#!/bin/sh
set -e
goal="Move commit message input right before the commit button without unnecessary complexity"
echo "Plan:"
echo "1. Refactor App.jsx to include the CommitMessageInput component just above the CommitButton component."
echo "2. Modify CommitButton.jsx to remove the wrapper div and CommitMessageInput."

# Refactoring App.jsx to include the CommitMessageInput component just above the CommitButton
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
    <div class="m-2">
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

# Modifying CommitButton.jsx to remove the wrapper div and CommitMessageInput
cat > src/frontend/components/CommitButton.jsx << 'EOF'
import { postCommit } from '../service/postCommit';
import { commitMessage } from '../stores/commitMessage';

const CommitButton = () => {
  const handleCommit = async () => {
    const response = await postCommit(commitMessage());
    console.log(response.message);
  };

  return (
    <button class="w-64 px-4 py-4 bg-green-700 text-white rounded mt-2" onClick={handleCommit}>Commit</button>
  );
};

export default CommitButton;
EOF

# CommitMessageInput remains unchanged as it will handle the change event directly
echo "\033[32mDone: $goal\033[0m\n"
