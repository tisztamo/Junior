#!/bin/sh
set -e
goal="Fix module export issue"
echo "Plan:"
echo "1. Update the fetchGitStatus.js to use named export."

# Change fetchGitStatus.js to use named export
cat > src/frontend/service/fetchGitStatus.js << 'EOF'
import { getBaseUrl } from '../getBaseUrl';
import { setGitStatus } from '../model/gitStatus';

const fetchGitStatus = async () => {
  const baseUrl = getBaseUrl();
  const response = await fetch(`${baseUrl}/git/status`);

  const data = await response.json();

  setGitStatus(data);
};

export { fetchGitStatus };
EOF

echo "\033[32mDone: $goal\033[0m\n"
