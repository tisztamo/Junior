#!/bin/sh
set -e
goal="Refactor commit functionality and handle Enter press"
echo "Plan:"
echo "1. Create a new service directory named 'service/lifecycle/'."
echo "2. Move the handleCommit function into the newly created directory under a file named 'handleCommitService.js'."
echo "3. Update the import paths in the original files to reference the new location of the handleCommit function."
echo "4. Implement the Enter key press logic in the CommitMessageInput component."

# Step 1: Create a new service directory named 'service/lifecycle/'.
mkdir -p ./src/frontend/service/lifecycle/

# Step 2: Move the handleCommit function into the new directory.
cat > ./src/frontend/service/lifecycle/handleCommitService.js << 'EOF'
import { postCommit } from '../postCommit';
import postDescriptor from '../postDescriptor';
import { commitMessage } from '../../model/commitMessage';
import { fetchGitStatus } from '../fetchGitStatus';
import clearState from '../clearState';

export default async function handleCommitService() {
  const response = await postCommit(commitMessage());
  console.log(response.message);
    
  await postDescriptor({ requirements: '' });
    
  const status = await fetchGitStatus();
  console.log(status);
  clearState();
}
EOF

# Step 3: Update the import paths in the original files.
cat > ./src/frontend/components/CommitButton.jsx << 'EOF'
import handleCommitService from '../service/lifecycle/handleCommitService';

const CommitButton = () => {
  return (
    <button className="w-full px-4 py-4 bg-green-500 text-lg text-bg font-semibold rounded" onClick={handleCommitService}>Commit</button>
  );
};

export default CommitButton;
EOF

# Step 4: Implement the Enter key press logic in the CommitMessageInput component.
cat > ./src/frontend/components/CommitMessageInput.jsx << 'EOF'
import { commitMessage, setCommitMessage } from '../model/commitMessage';
import monitorChange from '../model/monitorChange';
import handleCommitService from '../service/lifecycle/handleCommitService';

const CommitMessageInput = () => {
  monitorChange();

  const handleChange = (e) => {
    setCommitMessage(e.target.value);
  };

  const handleKeyPress = (e) => {
    if(e.key === 'Enter') {
      handleCommitService();
    }
  }

  return (
    <input type="text" className="w-full px-4 py-2 border rounded bg-emphasize text-emphasize border-border" placeholder="Commit message..." value={commitMessage()} onInput={handleChange} onKeyPress={handleKeyPress} />
  );
};

export default CommitMessageInput;
EOF

echo "\033[32mDone: $goal\033[0m\n"
