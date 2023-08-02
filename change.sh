#!/bin/sh
set -e
goal="Implement commit message input update feature"
echo "Plan:"
echo "1. Update CommitMessageInput.jsx to bind the input value with the commitMessage state."
echo "2. The value will get updated when the commitMessage state changes."

cat <<EOF >src/frontend/components/CommitMessageInput.jsx
import { commitMessage, setCommitMessage } from '../stores/commitMessage';

const CommitMessageInput = (props) => {
  const handleChange = (e) => {
    setCommitMessage(e.target.value);
  };

  return (
    <input type="text" className="w-64 px-4 py-2 border rounded" placeholder="Commit message..." value={commitMessage()} onInput={handleChange} />
  );
};

export default CommitMessageInput;
EOF

echo "\033[32mDone: $goal\033[0m\n"
