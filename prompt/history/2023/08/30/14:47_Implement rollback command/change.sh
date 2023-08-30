#!/bin/sh
set -e
goal="Implement rollback command"
echo "Plan:"
echo "1. Create a new file 'rollbackCommand.js' in the 'scripts' directory."
echo "2. Within 'rollbackCommand.js', import and call the 'resetGit' function."
echo "3. Update 'package.json' to add a new script named 'rollback' that will call the new 'rollbackCommand.js'."

# Step 1: Create 'rollbackCommand.js' in the 'scripts' directory
cat << EOF > ./scripts/rollbackCommand.js
import resetGit from '../src/git/resetGit.js';

async function executeRollback() {
  try {
    await resetGit();
  } catch (err) {
    console.error(`Failed to execute rollback: ${err}`);
  }
}

executeRollback();
EOF

# Step 2: Update 'package.json' to add the new script
jq '.scripts += {"rollback": "node ./scripts/rollbackCommand.js"}' package.json > tmp.$$.json && mv tmp.$$.json package.json

echo "\033[32mDone: $goal\033[0m\n"