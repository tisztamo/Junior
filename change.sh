#!/bin/sh
set -e
goal="Factor out commit message to separate component"
echo "Plan:"
echo "1. Create a new file CommitMessageInput.jsx that will contain the input logic for the commit message."
echo "2. Update CommitButton.jsx to import and utilize the new CommitMessageInput component."
echo "3. Update App.jsx to include the new component if necessary."

# Step 1: Creating new CommitMessageInput.jsx component
cat > src/frontend/components/CommitMessageInput.jsx << 'EOF'
import { commitMessage, setCommitMessage } from '../stores/commitMessage';

const CommitMessageInput = (props) => {
  const handleChange = (e) => {
    setCommitMessage(e.target.value);
  };

  return (
    <input type="text" class="w-64 px-4 py-2 border rounded" placeholder="Commit message..." onInput={handleChange} />
  );
};

export default CommitMessageInput;
EOF

# Step 2: Updating CommitButton.jsx to include new component
cat > src/frontend/components/CommitButton.jsx << 'EOF'
import { postCommit } from '../service/postCommit';
import CommitMessageInput from './CommitMessageInput';
import { commitMessage } from '../stores/commitMessage';

const CommitButton = () => {
  const handleCommit = async () => {
    const response = await postCommit(commitMessage());
    console.log(response.message);
  };

  return (
    <div>
      <CommitMessageInput />
      <button class="w-64 px-4 py-4 bg-green-700 text-white rounded mt-2" onClick={handleCommit}>Commit</button>
    </div>
  );
};

export default CommitButton;
EOF

echo "\033[32mDone: $goal\033[0m\n"
