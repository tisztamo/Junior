#!/bin/sh
set -e
goal="Implement delete branches function"
echo "Plan:"
echo "1. Create a new file 'deleteBranches.js' inside the 'src/git' directory"
echo "2. Implement the function to delete all branches except the current one and optionally listed ones"
echo "3. Update any necessary files to include the new function"

cat <<EOF >src/git/deleteBranches.js
import { promisify } from 'util';
import { exec as execCb } from 'child_process';

const exec = promisify(execCb);

export default async function deleteBranches(exceptions = []) {
  try {
    const { stdout: currentBranch } = await exec('git rev-parse --abbrev-ref HEAD');
    const { stdout: allBranches } = await exec('git for-each-ref --format="%(refname:short)" refs/heads');

    const branches = allBranches.split('\\n').filter(branch => branch !== currentBranch.trim() && !exceptions.includes(branch));

    for (const branch of branches) {
      await executeCommand(\`git branch -d \${branch}\`);
    }
  } catch (err) {
    console.error(\`An error occurred: \${err}\`);
  }
}

async function executeCommand(command) {
  try {
    console.log(\`Running command: \${command}\`);
    const { stdout } = await exec(command);
    console.log(\`stdout: \${stdout}\`);
  } catch (err) {
    throw err;
  }
}
EOF

echo "\033[32mDone: $goal\033[0m\n"
