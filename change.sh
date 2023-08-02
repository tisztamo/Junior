#!/bin/sh
set -e
goal="Implement signal to save and clear change"
echo "Plan:"
echo "1. Create change.js in the stores directory to define the signal for storing the change."
echo "2. Modify ExecuteButton.jsx to update the change signal with the pasted change after execution."
echo "3. Modify CommitButton.jsx to clear the change signal after commit."

# Step 1: Creating change.js in the stores directory to define the signal for storing the change
cat << 'EOF' > src/frontend/stores/change.js
import { createSignal } from 'solid-js';

export const [change, setChange] = createSignal('');
EOF

# Step 2: Modifying ExecuteButton.jsx to update the change signal with the pasted change after execution
cat << 'EOF' > src/frontend/components/ExecuteButton.jsx
import { executeChange } from '../service/executeChange';
import { setExecutionResult } from '../stores/executionResult';
import { setChange } from '../stores/change'; // Importing the necessary function to set the change

const ExecuteButton = () => {
  const handleExecuteChange = async () => {
    const change = await navigator.clipboard.readText();
    const response = await executeChange(change);
    setChange(change); // Saving the pasted change after execution
    setExecutionResult(response.output);
    console.log(response.output);
  };

  return (
    <button class="w-64 px-4 py-4 bg-orange-300 text-white rounded" onClick={handleExecuteChange}>Paste & Execute Change</button>
  );
};

export default ExecuteButton;
EOF

# Step 3: Modifying CommitButton.jsx to clear the change signal after commit
cat << 'EOF' > src/frontend/components/CommitButton.jsx
import { postCommit } from '../service/postCommit';
import { commitMessage, setCommitMessage } from '../stores/commitMessage';
import { fetchGitStatus } from '../service/fetchGitStatus';
import { setExecutionResult } from '../stores/executionResult';
import { setPrompt } from '../stores/prompt';
import { setChange } from '../stores/change'; // Importing setChange to clear the change

const CommitButton = () => {
  const handleCommit = async () => {
    const response = await postCommit(commitMessage());
    console.log(response.message);
    const status = await fetchGitStatus();
    console.log(status);
    setChange(''); // Clearing the change after commit
    setExecutionResult('');
    setCommitMessage('');
    setPrompt('');
  };

  return (
    <button className="w-64 px-4 py-4 bg-green-700 text-white rounded mt-2" onClick={handleCommit}>Commit</button>
  );
};

export default CommitButton;
EOF

echo "\033[32mDone: $goal\033[0m\n"
