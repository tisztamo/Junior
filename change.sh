#!/bin/sh
# Goal: Fix resetGit.js to properly reset modified files.
# Plan:
# 1. Stash all changes including untracked files.
# 2. Clean the repository and reset it to the latest commit.
# 3. Checkout only prompt.yaml from stash.
# 4. Drop the stash.

cat > src/git/resetGit.js << 'EOF'
import git from 'simple-git';

export default async function resetGit() {
  const gitInstance = git();

  // Stash all changes including untracked files
  await gitInstance.stash(['-u']);

  // Clean the repository and reset to the latest commit
  await gitInstance.clean('f', ['-d']);
  await gitInstance.reset('hard');

  // Checkout only prompt.yaml from stash
  await gitInstance.checkout('stash@{0} -- prompt.yaml');

  // Drop the stash
  await gitInstance.stash(['drop']);
}
EOF
