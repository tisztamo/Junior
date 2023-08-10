#!/bin/sh
set -e
goal="Pass arguments from npm run clear-branches"
echo "Plan:"
echo "1. Modify the 'clear-branches' script in package.json to accept arguments"
echo "2. Modify 'scripts/clearBranchesCommand.js' to pass arguments to the clearBranches function"
echo "3. Modify 'src/git/clearBranches.js' to accept the arguments and utilize them in the clear branches logic"

# Step 1: Modify the 'clear-branches' script in package.json to accept arguments
jq '.scripts["clear-branches"] = "node ./scripts/clearBranchesCommand.js $@"' package.json > package.json.tmp
mv package.json.tmp package.json

# Step 2: Modify 'scripts/clearBranchesCommand.js' to pass arguments to the clearBranches function
cat > scripts/clearBranchesCommand.js << 'EOF'
import clearBranches from '../src/git/clearBranches.js';

const exceptions = process.argv.slice(2);
clearBranches(exceptions).catch(err => {
  console.error(`Failed to clear branches: ${err}`);
});
EOF

# Step 3: Modify 'src/git/clearBranches.js' to accept the arguments and utilize them in the clear branches logic
cat > src/git/clearBranches.js << 'EOF'
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

echo "\033[32mDone: $goal\033[0m\n"
