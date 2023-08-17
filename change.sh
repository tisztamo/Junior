#!/bin/sh
set -e
goal="Fix export issue in resetGit.js"
echo "Plan:"
echo "1. Modify resetGit.js to use named export"
echo "2. Save the updated content"

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

export { resetGit };
EOF

echo "\033[32mDone: $goal\033[0m\n"
