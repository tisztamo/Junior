#!/bin/sh
set -e
goal="Implement Working Set task changes"
echo "Plan:"
echo "1. Edit CommitMessageInput.jsx to modify classes and remove unwanted code."
echo "2. Verify all changes match the requirements."

# Step 1: Edit CommitMessageInput.jsx
cat << 'EOF' > src/frontend/components/CommitMessageInput.jsx
import { commitMessage, setCommitMessage } from '../model/commitMessage';
import monitorChange from '../model/monitorChange';

const CommitMessageInput = () => {
  monitorChange();

  const handleChange = (e) => {
    setCommitMessage(e.target.value);
  };

  return (
    <input type="text" className="w-full px-4 py-2 border rounded bg-emphasize text-emphasize border-border" placeholder="Commit message..." value={commitMessage()} onInput={handleChange} />
  );
};

export default CommitMessageInput;
EOF

# Completion message
echo "\033[32mDone: $goal\033[0m\n"
