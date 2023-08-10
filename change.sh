#!/bin/sh
set -e
goal="Fix error in clearBranches.js by filtering empty branches"
echo "Plan:"
echo "1. Fix clearBranches.js by adding condition to filter out empty branch names."
echo "2. Test the changes."

# Step 1: Fix clearBranches.js by adding condition to filter out empty branch names.
cat > ./src/git/clearBranches.js << 'EOF'
import { promisify } from 'util';
import { exec as execCb } from 'child_process';

const exec = promisify(execCb);

export default async function clearBranches(exceptions = []) {
  try {
    const { stdout: currentBranch } = await exec('git rev-parse --abbrev-ref HEAD');
    const { stdout: allBranches } = await exec('git for-each-ref --format="%(refname:short)" refs/heads');

    const branches = allBranches.split('\n').filter(branch => branch !== currentBranch.trim() && !exceptions.includes(branch) && branch.trim() !== '');

    for (const branch of branches) {
      await executeCommand(`git branch -d ${branch}`);
    }
  } catch (err) {
    console.error(`An error occurred: ${err}`);
  }
}

async function executeCommand(command) {
  try {
    console.log(`Running command: ${command}`);
    const { stdout } = await exec(command);
    console.log(`stdout: ${stdout}`);
  } catch (err) {
    throw err;
  }
}
EOF

# Step 2: Test the changes (this is a placeholder; actual tests should be conducted as per project's testing strategy)
echo "Testing the changes..."
echo "Please manually run the 'npm run clear-branches' command to verify the fix."

echo "\033[32mDone: $goal\033[0m\n"
