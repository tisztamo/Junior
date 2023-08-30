#!/bin/sh
set -e
goal="Refactor clear-branches with better error handling"
echo "Plan:"
echo "1. Refactor clearBranches.js to better handle not fully merged branches"
echo "2. Handle the exception during branch deletion and continue with the next branch"

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
      try {
        const isMerged = await git.raw(['branch', '--merged', branch]);
        if (isMerged.includes(branch)) {
          await git.branch(['-d', branch]);
        } else {
          console.log(`Branch ${branch} is not merged, skipping...`);
        }
      } catch (err) {
        console.log(`Failed to delete branch ${branch}: ${err.message}. Skipping...`);
      }
    }
  } catch (err) {
    console.error(`An error occurred: ${err}`);
  }
}
EOF

echo "\033[32mDone: $goal\033[0m\n"