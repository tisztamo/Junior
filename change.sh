#!/bin/sh
# Goal: Fix file path issue in the resetGit function
# Plan:
# 1. Update the path to the prompt.yaml file in the resetGit function.
# 2. The path should be fixed as './prompt.yaml'.

cat > ./src/git/resetGit.js << 'EOF'
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
