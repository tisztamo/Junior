#!/bin/sh
set -e
goal="Adjust commit and rollback buttons style"
echo "Plan:"
echo "1. Modify the RollbackButton.jsx file to update the label, width and to make the height same as commit."
echo "2. Modify the CommitButton.jsx file to update the width and to make sure there is space between it and the Rollback button."
echo "3. Update ChangeFinalization.jsx to ensure proper space between the buttons."

# Modify RollbackButton.jsx
cat > src/frontend/components/RollbackButton.jsx << 'EOF'
import { resetGit } from '../service/resetGit';

const RollbackButton = () => {
  const handleReset = async () => {
    const response = await resetGit();

    console.log(response.message);
  };

  return (
    <button className="w-48 px-4 py-4 bg-red-700 text-white rounded mt-2" onClick={handleReset}>Roll Back</button>
  );
};

export default RollbackButton;
EOF

# Modify CommitButton.jsx
cat > src/frontend/components/CommitButton.jsx << 'EOF'
import { postCommit } from '../service/postCommit';
import { commitMessage, setCommitMessage } from '../model/commitMessage';
import { fetchGitStatus } from '../service/fetchGitStatus';
import { setExecutionResult } from '../model/executionResult';
import { setPrompt } from '../model/prompt';
import { setChange } from '../model/change'; // Importing setChange to clear the change

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
    <button className="w-48 px-4 py-4 bg-green-700 text-white rounded mt-2" onClick={handleCommit}>Commit</button>
  );
};

export default CommitButton;
EOF

# Update ChangeFinalization.jsx
cat > src/frontend/components/ChangeFinalization.jsx << 'EOF'
import CommitMessageInput from './CommitMessageInput';
import CommitButton from './CommitButton';
import RollbackButton from './RollbackButton';

const ChangeFinalization = () => {
  return (
    <>
      <CommitMessageInput />
      <div className="flex justify-between mt-2 space-x-4">
        <CommitButton />
        <RollbackButton />
      </div>
    </>
  );
};

export default ChangeFinalization;
EOF

echo "\033[32mDone: $goal\033[0m\n"
