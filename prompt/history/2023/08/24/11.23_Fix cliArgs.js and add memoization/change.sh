#!/bin/sh
set -e

goal="Fix cliArgs.js and add memoization"
echo "Plan:"
echo "1. Delete src/frontend/service/cliArgsService.js"
echo "2. Update src/frontend/service/config/cliArgs.js to handle errors and add memoization"

# Step 1: Delete src/frontend/service/cliArgsService.js
rm -f src/frontend/service/cliArgsService.js

# Step 2: Update src/frontend/service/config/cliArgs.js
cat > src/frontend/service/config/cliArgs.js << 'EOF'
import { getBaseUrl } from '../../getBaseUrl';

let memoizedCliArgs = null;

const cliArgs = async () => {
  if (memoizedCliArgs !== null) {
    return memoizedCliArgs;
  }

  try {
    const baseUrl = getBaseUrl();
    const response = await fetch(`${baseUrl}/config`, {
      method: 'GET',
      headers: { 'Content-Type': 'application/json' },
    });

    if (!response.ok) {
      throw new Error('Failed to fetch CLI args');
    }

    const data = await response.json();
    memoizedCliArgs = data.cliargs || [];

    return memoizedCliArgs;
  } catch (error) {
    console.error(`Error fetching CLI args: ${error.message}`);
    return [];
  }
};

export default cliArgs;
EOF

echo "\033[32mDone: $goal\033[0m\n"