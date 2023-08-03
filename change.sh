#!/bin/sh
set -e
goal="Make CommitMessageInput full width"
echo "Plan:"
echo "1. Modify the class to 'w-full' in CommitMessageInput.jsx to make the input field take full width."

cat > src/frontend/components/CommitMessageInput.jsx << 'EOF'
import { commitMessage, setCommitMessage } from '../model/commitMessage';
import monitorChange from '../model/monitorChange';

const CommitMessageInput = (props) => {
  // Start monitoring when mounting
  monitorChange();

  const handleChange = (e) => {
    setCommitMessage(e.target.value);
  };

  return (
    <input type="text" className="w-full px-4 py-2 border rounded" placeholder="Commit message..." value={commitMessage()} onInput={handleChange} />
  );
};

export default CommitMessageInput;
EOF

echo "\033[32mDone: $goal\033[0m\n"
