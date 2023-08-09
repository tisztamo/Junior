#!/bin/sh
set -e
goal="Rename deleteBranches to clearBranches and move files"
echo "Plan:"
echo "1. Rename deleteBranches.js to clearBranches.js and update references."
echo "2. Rename import deleteBranches in deleteBranchesCommand.js to import clearBranches."
echo "3. Update all corresponding references and paths to make sure nothing breaks."

# Rename deleteBranches.js to clearBranches.js
mv src/git/deleteBranches.js src/git/clearBranches.js

# Update the import statement in deleteBranchesCommand.js
cat > src/git/deleteBranchesCommand.js <<EOF
import clearBranches from './clearBranches';

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

echo "\033[32mDone: $goal\033[0m\n"
