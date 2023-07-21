#!/bin/sh
# Goal: Fix the resetGit.js script to properly reset modified files.
# Plan:
# 1. In resetGit function, I will adjust the sequence of commands:
#    - First, I will add all changes (not just prompt.yaml), and stash them.
#    - Then, I will clean the repository and hard reset it, to revert all files to the state of the latest commit.
#    - Lastly, I will apply stashed changes only to prompt.yaml, so other files won't get their modifications back.

cat > src/git/resetGit.js << 'EOF'
import git from 'simple-git';

export default async function resetGit() {
  const gitInstance = git();

  // Stash all changes
  await gitInstance.add('./*');
  await gitInstance.stash();

  // Clean the repository and reset to the latest commit
  await gitInstance.clean('f', ['-d']);
  await gitInstance.reset('hard');

  // Checkout only prompt.yaml from stash
  await gitInstance.stash(['apply']);
  await gitInstance.checkout('stash@{0} -- prompt.yaml');

  // Remove stash
  await gitInstance.stash(['drop']);
}
EOF
