#!/bin/sh
set -e
goal="Count and log deleted/skipped branches"
echo "Plan:"
echo "1. Modify the clearBranches.js to track the count of deleted and skipped branches."
echo "2. Log the count of deleted and skipped branches at the end of the clearBranches function."

# Step 1: Modify clearBranches.js to track the count of deleted and skipped branches
cat > src/git/clearBranches.js << 'EOF'
import simpleGit from 'simple-git';

const git = simpleGit();

export default async function clearBranches(exceptions = []) {
  let deletedCount = 0;
  let skippedCount = 0;
  
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
          deletedCount++;
        } else {
          console.log(`Branch ${branch} is not merged, skipping...`);
          skippedCount++;
        }
      } catch (err) {
        console.log(`Failed to delete branch ${branch}: ${err.message}. Skipping...`);
        skippedCount++;
      }
    }
  } catch (err) {
    console.error(`An error occurred: ${err}`);
  }

  console.log(`Deleted branches: ${deletedCount}`);
  console.log(`Skipped branches: ${skippedCount}`);
}
EOF

echo "\033[32mDone: $goal\033[0m\n"