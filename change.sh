#!/bin/sh
# Goal: Reset git repository while preserving prompt.yaml
# Plan:
# 1. Create a new directory named 'git' to hold git related utility scripts.
# 2. Install the 'simple-git' npm package to interact with the git commands.
# 3. In 'git', create a new JavaScript file named 'resetGit.js' that will implement the required function. 
#    This function will make use of the 'simple-git' package to execute git commands.
#    a. Stash the changes of prompt.yaml file to keep them safe.
#    b. Clean the repository and reset to the latest commit.
#    c. Pop the stashed changes to restore the changes made to the prompt.yaml file.

mkdir -p git

# Install the simple-git npm package
npm install simple-git

cat << EOF > git/resetGit.js
import git from 'simple-git';

export default async function resetGit() {
  const gitInstance = git();

  // Stash changes in prompt.yaml
  await gitInstance.add('./prompt.yaml');
  await gitInstance.stash();

  // Clean the repository and reset to the latest commit
  await gitInstance.clean('f', ['-d']);
  await gitInstance.reset('hard');

  // Apply stashed changes to prompt.yaml
  await gitInstance.stash(['pop']);
}
EOF
