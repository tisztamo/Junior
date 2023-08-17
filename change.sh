#!/bin/sh
set -e
goal="Set empty requirements after commit"
echo "Plan:"
echo "1. Create postRequirements.js in service directory."
echo "2. Modify CommitButton.jsx to call postRequirements service after committing."

# Step 1: Create postRequirements.js in service directory
cat > src/frontend/service/postRequirements.js << 'EOF'
import { getBaseUrl } from '../getBaseUrl';

const postRequirements = async (requirements) => {
  const baseUrl = getBaseUrl();
  const response = await fetch(`${baseUrl}/requirements`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ requirements }),
  });

  return await response.json();
};

export default postRequirements;
EOF

# Step 2: Modify CommitButton.jsx to call postRequirements service after committing
cat > src/frontend/components/CommitButton.jsx << 'EOF'
import { postCommit } from '../service/postCommit';
import postRequirements from '../service/postRequirements';
import { commitMessage } from '../model/commitMessage';
import { fetchGitStatus } from '../service/fetchGitStatus';
import clearState from '../service/clearState';

const CommitButton = () => {
  const handleCommit = async () => {
    const response = await postCommit(commitMessage());
    console.log(response.message);
    
    await postRequirements('');
    
    const status = await fetchGitStatus();
    console.log(status);
    clearState();
  };

  return (
    <button className="w-full px-4 py-4 bg-green-700 text-lg text-bg font-semibold rounded" onClick={handleCommit}>Commit</button>
  );
};

export default CommitButton;
EOF

echo "\033[32mDone: $goal\033[0m\n"
