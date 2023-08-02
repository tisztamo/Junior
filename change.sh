#!/bin/sh
set -e
goal="Refactor code to clear execution result after commit"
echo "Plan:"
echo "1. Import the setExecutionResult function from the executionResult store."
echo "2. Modify the handleCommit function in CommitButton.jsx to clear execution result after a successful commit."

# CommitButton.jsx modification
cat << 'EOF' > src/frontend/components/CommitButton.jsx
import { postCommit } from '../service/postCommit';
import { commitMessage } from '../stores/commitMessage';
import { fetchGitStatus } from '../service/fetchGitStatus';
import { setExecutionResult } from '../stores/executionResult'; // Importing the necessary function to clear execution result

const CommitButton = () => {
  const handleCommit = async () => {
    const response = await postCommit(commitMessage());
    console.log(response.message);
    const status = await fetchGitStatus();
    console.log(status);
    setExecutionResult(''); // Clearing the execution result after commit
  };

  return (
    <button className="w-64 px-4 py-4 bg-green-700 text-white rounded mt-2" onClick={handleCommit}>Commit</button>
  );
};

export default CommitButton;
EOF

echo "\033[32mDone: $goal\033[0m\n"
