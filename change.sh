#!/bin/sh
set -e
goal="Make CommitButton look same as rollback except color"
echo "Plan:"
echo "1. Update CommitButton.jsx to make it look exactly like RollbackButton but with different color."

cat > src/frontend/components/CommitButton.jsx << 'EOF'
import { postCommit } from '../service/postCommit';
import { commitMessage, setCommitMessage } from '../model/commitMessage';
import { fetchGitStatus } from '../service/fetchGitStatus';
import { setExecutionResult } from '../model/executionResult';
import { setPrompt } from '../model/prompt';
import { setChange } from '../model/change';

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
    <button className="w-full px-4 py-4 bg-green-700 text-white rounded" onClick={handleCommit}>Commit</button>
  );
};

export default CommitButton;
EOF

echo "\033[32mDone: $goal\033[0m\n"
