#!/bin/sh
set -e
goal="Move clearBranchesCommand.js, update import, delete deleteBranchesCommand.js"
echo "Plan:"
echo "1. Move clearBranchesCommand.js from src/git/ to scripts/, and update the import path for clearBranches.js within the moved file."
echo "2. Delete deleteBranchesCommand.js from scripts/ as it's no longer needed."

# Moving clearBranchesCommand.js to the scripts directory
mv ./src/git/clearBranchesCommand.js ./scripts/clearBranchesCommand.js

# Updating the import path for clearBranches.js within the moved file
cat <<EOF > ./scripts/clearBranchesCommand.js
import clearBranches from '../src/git/clearBranches';

const exceptions = process.argv.slice(2);

async function run() {
  try {
    await clearBranches(exceptions);
    console.log('Branches deleted successfully.');
  } catch (err) {
    console.error(\`An error occurred while deleting branches: \${err}\`);
    process.exit(1);
  }
}

run();
EOF

# Deleting deleteBranchesCommand.js from the scripts directory
rm ./scripts/deleteBranchesCommand.js

echo "\033[32mDone: $goal\033[0m\n"
