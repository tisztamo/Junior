#!/bin/sh
set -e
goal="Clear prompt and commit message after commit"
echo "Plan:"
echo "1. Modify CommitButton.jsx to include the clearing logic for the commit message and prompt after a successful commit."
echo "2. Import setPrompt from prompt.js into CommitButton.jsx."
echo "3. Update handleCommit function in CommitButton.jsx to clear the prompt and commit message."

# Step 1: Modify CommitButton.jsx
cat << 'EOF' > src/frontend/components/CommitButton.jsx
import { postCommit } from '../service/postCommit';
import { commitMessage, setCommitMessage } from '../stores/commitMessage';
import { fetchGitStatus } from '../service/fetchGitStatus';
import { setExecutionResult } from '../stores/executionResult'; // Importing the necessary function to clear execution result
import { setPrompt } from '../stores/prompt'; // Importing setPrompt to clear the prompt

const CommitButton = () => {
  const handleCommit = async () => {
    const response = await postCommit(commitMessage());
    console.log(response.message);
    const status = await fetchGitStatus();
    console.log(status);
    setExecutionResult(''); // Clearing the execution result after commit
    setCommitMessage(''); // Clearing the commit message after commit
    setPrompt(''); // Clearing the prompt after commit
  };

  return (
    <button className="w-64 px-4 py-4 bg-green-700 text-white rounded mt-2" onClick={handleCommit}>Commit</button>
  );
};

export default CommitButton;
EOF

# Step 2: Importing setPrompt from prompt.js, no change needed in file as setPrompt is already exported
# Step 3: handleCommit function updated to include the clearing of prompt and commit message, as shown in Step 1

echo "\033[32mDone: $goal\033[0m\n"
