#!/bin/sh
set -e
goal="Create a command to delete git branches"
echo "Plan:"
echo "1. Create a new file deleteBranchesCommand.js in ./scripts/ to encapsulate the deleteBranches function as a command-line utility."
echo "2. Modify package.json to add the new command."

# Step 1: Create deleteBranchesCommand.js file in ./scripts/
cat > ./scripts/deleteBranchesCommand.js << 'EOF'
import deleteBranches from '../src/git/deleteBranches.js';

const exceptions = process.argv.slice(2);

async function run() {
  try {
    await deleteBranches(exceptions);
    console.log('Branches deleted successfully.');
  } catch (err) {
    console.error(`An error occurred while deleting branches: ${err}`);
    process.exit(1);
  }
}

run();
EOF

# Step 2: Modify package.json to add the new command
jq '.scripts += {"delete-branches": "node ./scripts/deleteBranchesCommand.js"}' ./package.json > ./package.json.tmp && mv ./package.json.tmp ./package.json

echo "\033[32mDone: $goal\033[0m\n"
