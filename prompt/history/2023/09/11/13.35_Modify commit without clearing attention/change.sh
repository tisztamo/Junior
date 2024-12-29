#!/bin/sh
set -e
goal="Modify commit without clearing attention"
echo "Plan:"
echo "1. Modify handleCommit in CommitButton.jsx to not clear the attention after commit."
echo "2. Adjust the postDescriptor method call."

cat > ./src/frontend/components/CommitButton.jsx << 'EOF'
import { postCommit } from '../service/postCommit';
import postDescriptor from '../service/postDescriptor';
import { commitMessage } from '../model/commitMessage';
import { fetchGitStatus } from '../service/fetchGitStatus';
import clearState from '../service/clearState';

const CommitButton = () => {
  const handleCommit = async () => {
    const response = await postCommit(commitMessage());
    console.log(response.message);
    
    await postDescriptor({ requirements: '' });
    
    const status = await fetchGitStatus();
    console.log(status);
    clearState();
  };

  return (
    <button className="w-full px-4 py-4 bg-green-500 text-lg text-bg font-semibold rounded" onClick={handleCommit}>Commit</button>
  );
};

export default CommitButton;
EOF

echo "\033[32mDone: $goal\033[0m\n"