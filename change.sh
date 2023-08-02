#!/bin/sh
set -e
goal="Implement Commit button feature"
echo "Plan:"
echo "1. Create a new signal in the stores for the commit message."
echo "2. Create a new service function to make a POST request to the commit/ endpoint."
echo "3. Create a new CommitButton component that includes an input field for the commit message and a button to trigger the commit."
echo "4. Modify App.jsx to include the new CommitButton component above the RollbackButton component."

# Step 1: Create a new signal in the stores for the commit message
cat <<EOF >src/frontend/stores/commitMessage.js
import { createSignal } from 'solid-js';

const [commitMessage, setCommitMessage] = createSignal('');

export { commitMessage, setCommitMessage };
EOF

# Step 2: Create a new service function to make a POST request to the commit/ endpoint
cat <<EOF >src/frontend/service/postCommit.js
import { getBaseUrl } from '../getBaseUrl';

const postCommit = async (message) => {
  const baseUrl = getBaseUrl();
  const response = await fetch(\`\${baseUrl}/commit\`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ message }),
  });

  const data = await response.json();

  return data;
};

export { postCommit };
EOF

# Step 3: Create a new CommitButton component
cat <<EOF >src/frontend/components/CommitButton.jsx
import { postCommit } from '../service/postCommit';
import { commitMessage, setCommitMessage } from '../stores/commitMessage';

const CommitButton = () => {
  const handleCommit = async () => {
    const response = await postCommit(commitMessage());
    console.log(response.message);
  };

  const handleChange = (e) => {
    setCommitMessage(e.target.value);
  };

  return (
    <div>
      <input type="text" class="w-64 px-4 py-2 border rounded" placeholder="Commit message..." onInput={handleChange} />
      <button class="w-64 px-4 py-4 bg-green-700 text-white rounded mt-2" onClick={handleCommit}>Commit</button>
    </div>
  );
};

export default CommitButton;
EOF

# Step 4: Modify App.jsx to include the new CommitButton component
cat <<EOF >src/frontend/App.jsx
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
        <CommitButton />
        <RollbackButton />
      </div>
    </div>
  );
};

export default App;
EOF

echo "\033[32mDone: $goal\033[0m\n"
