#!/bin/sh
set -e
goal="Refactor clear-branches with simple-git"
echo "Plan:"
echo "1. Install simple-git package"
echo "2. Refactor clearBranches.js to use simple-git and check for merged branches before deleting"
echo "3. Refactor clearBranchesCommand.js to handle exceptions and call clearBranches.js"

npm install simple-git

cat > src/git/clearBranches.js << 'EOF'
import simpleGit from 'simple-git';

const git = simpleGit();

export default async function clearBranches(exceptions = []) {
  try {
    const currentBranch = await git.revparse(['--abbrev-ref', 'HEAD']);
    const allBranches = await git.branchLocal();

    const branchesToDelete = allBranches.all.filter(branch => {
      return branch !== currentBranch && !exceptions.includes(branch);
    });

    for (const branch of branchesToDelete) {
      const isMerged = await git.raw(['branch', '--merged', branch]);
      if (isMerged.includes(branch)) {
        await git.branch(['-d', branch]);
      } else {
        console.log(`Branch ${branch} is not merged, skipping...`);
      }
    }
  } catch (err) {
    console.error(`An error occurred: ${err}`);
  }
}
EOF

cat > scripts/clearBranchesCommand.js << 'EOF'
import clearBranches from '../src/git/clearBranches.js';

const exceptions = process.argv.slice(2);
clearBranches(exceptions).catch(err => {
  console.error(`Failed to clear branches: ${err}`);
});
EOF

echo "\033[32mDone: $goal\033[0m\n"