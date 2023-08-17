#!/bin/sh
set -e
goal="Refactor git-related routes"
echo "Plan:"
echo "1. Refactor fetchGitStatus.js to point to the updated /git/ route"
echo "2. Refactor resetGit.js to point to the updated /git/ route"
echo "3. Refactor postCommit.js to point to the updated /git/ route"

# 1. Refactor fetchGitStatus.js
cat > src/frontend/service/fetchGitStatus.js << 'EOF'
import { getBaseUrl } from '../getBaseUrl';
import { setGitStatus } from '../model/gitStatus';

const fetchGitStatus = async () => {
  const baseUrl = getBaseUrl();
  const response = await fetch(`${baseUrl}/git/status`);

  const data = await response.json();

  setGitStatus(data);
};

export default fetchGitStatus;
EOF

# 2. Refactor resetGit.js
cat > src/frontend/service/resetGit.js << 'EOF'
import { getBaseUrl } from '../getBaseUrl';

const resetGit = async () => {
  const baseUrl = getBaseUrl();
  const response = await fetch(`${baseUrl}/git/reset`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
  });

  const data = await response.json();

  return data;
};

export default resetGit;
EOF

# 3. Refactor postCommit.js
cat > src/frontend/service/postCommit.js << 'EOF'
import { getBaseUrl } from '../getBaseUrl';

const postCommit = async (message) => {
  const baseUrl = getBaseUrl();
  const response = await fetch(`${baseUrl}/git/commit`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ message }),
  });

  const data = await response.json();

  return data;
};

export default postCommit;
EOF

echo "\033[32mDone: $goal\033[0m\n"
