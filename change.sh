#!/bin/sh
# Goal: Exclude prompt.yaml from the git reset operation
# Plan:
# 1. Modify the resetGit function to stash prompt.yaml separately.
# 2. Then, reset the git repository to the latest commit.
# 3. After the reset, checkout prompt.yaml from the separate stash.
# 4. Drop the stash.

cat << 'EOF' > src/git/resetGit.js
import git from 'simple-git';

export default async function resetGit() {
  const gitInstance = git();

  // Stash all changes including untracked files
  await gitInstance.stash(['-u']);

  // Clean the repository and reset to the latest commit
  await gitInstance.clean('f', ['-d']);
  await gitInstance.reset('hard');

  // Checkout prompt.yaml from stash
  await gitInstance.checkout('stash@{0} -- prompt.yaml');

  // Drop the stash
  await gitInstance.stash(['drop']);
}
EOF

# Restart the server to apply changes
killall node
npm start
