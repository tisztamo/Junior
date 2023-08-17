#!/bin/sh
set -e
goal="Fix export as named"
echo "Plan:"
echo "1. Change default export to named export in postCommit.js"

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

export { postCommit };
EOF

echo "\033[32mDone: $goal\033[0m\n"
