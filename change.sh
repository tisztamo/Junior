#!/bin/sh
set -e
goal="Refactor code to fetch git status after commit"
echo "Plan:"
echo "1. Update CommitButton.jsx to include fetchGitStatus call"
echo "2. Update CommitMessageInput.jsx with the correct class attribute name in SolidJS"

# Updating CommitButton.jsx to include the new functionality
cat << 'EOF' > src/frontend/components/CommitButton.jsx
import { postCommit } from '../service/postCommit';
import { commitMessage } from '../stores/commitMessage';
import { fetchGitStatus } from '../service/fetchGitStatus';

const CommitButton = () => {
  const handleCommit = async () => {
    const response = await postCommit(commitMessage());
    console.log(response.message);
    const status = await fetchGitStatus();
    console.log(status);
  };

  return (
    <button className="w-64 px-4 py-4 bg-green-700 text-white rounded mt-2" onClick={handleCommit}>Commit</button>
  );
};

export default CommitButton;
EOF

# Updating CommitMessageInput.jsx to use correct attribute name className
cat << 'EOF' > src/frontend/components/CommitMessageInput.jsx
import { commitMessage, setCommitMessage } from '../stores/commitMessage';

const CommitMessageInput = (props) => {
  const handleChange = (e) => {
    setCommitMessage(e.target.value);
  };

  return (
    <input type="text" className="w-64 px-4 py-2 border rounded" placeholder="Commit message..." onInput={handleChange} />
  );
};

export default CommitMessageInput;
EOF

echo "\033[32mDone: $goal\033[0m\n"
