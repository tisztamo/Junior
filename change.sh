#!/bin/sh
set -e
goal="Rename delete-branches to clear-branches"
echo "Plan:"
echo "1. Update the function name deleteBranches to clearBranches in src/git/clearBranches.js file."
echo "2. Update the 'delete-branches' script command in package.json to 'clear-branches'."

# Update the function name deleteBranches to clearBranches in the renamed clearBranches.js file
cat > src/git/clearBranches.js << 'EOF'
import { promisify } from 'util';
import { exec as execCb } from 'child_process';

const exec = promisify(execCb);

export default async function clearBranches(exceptions = []) {
  try {
    const { stdout: currentBranch } = await exec('git rev-parse --abbrev-ref HEAD');
    const { stdout: allBranches } = await exec('git for-each-ref --format="%(refname:short)" refs/heads');

    const branches = allBranches.split('\n').filter(branch => branch !== currentBranch.trim() && !exceptions.includes(branch));

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

# Update the 'delete-branches' script command in package.json to 'clear-branches'
jq '.scripts."clear-branches" = .scripts."delete-branches" | del(.scripts."delete-branches")' package.json > package.json.tmp && mv package.json.tmp package.json

echo "\033[32mDone: $goal\033[0m\n"
