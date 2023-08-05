#!/bin/sh
set -e
goal="Change layout for commit and rollback buttons"
echo "Plan:"
echo "1. Modify the styling of the CommitButton and RollbackButton components to fill the available space."
echo "2. Simplify ChangeFinalization component to distribute the available space between the two buttons equally, filling the entire width."

# Modify CommitButton.jsx to fill half the available space without overflowing horizontally
cat << 'EOF' > src/frontend/components/CommitButton.jsx
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
    <button className="w-full px-4 py-4 bg-green-700 text-white rounded mt-2" onClick={handleCommit}>Commit</button>
  );
};

export default CommitButton;
EOF

# Modify RollbackButton.jsx to fill half the available space without overflowing horizontally
cat << 'EOF' > src/frontend/components/RollbackButton.jsx
import { resetGit } from '../service/resetGit';

const RollbackButton = () => {
  const handleReset = async () => {
    const response = await resetGit();

    console.log(response.message);
  };

  return (
    <button className="w-full px-4 py-4 bg-red-700 text-white rounded mt-2" onClick={handleReset}>Roll Back</button>
  );
};

export default RollbackButton;
EOF

# Update ChangeFinalization.jsx to remove unnecessary div and ensure the buttons equally share the available space, filling the entire width
cat << 'EOF' > src/frontend/components/ChangeFinalization.jsx
import CommitMessageInput from './CommitMessageInput';
import CommitButton from './CommitButton';
import RollbackButton from './RollbackButton';

const ChangeFinalization = () => {
  return (
    <>
      <CommitMessageInput />
      <div className="flex w-full mt-2 space-x-4">
        <CommitButton />
        <RollbackButton />
      </div>
    </>
  );
};

export default ChangeFinalization;
EOF

echo "\033[32mDone: $goal\033[0m\n"
