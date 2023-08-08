#!/bin/sh
set -e
goal="Refactor resetGit.js to use async/await and updated instructions"
echo "Plan:"
echo "1. Backup the existing resetGit.js"
echo "2. Modify the resetGit.js to use async/await and handle both prompt.yaml and prompt.md"
echo "3. Replace the content of resetGit.js with the refactored version"

# Step 1: Backup the existing resetGit.js
cp src/git/resetGit.js src/git/resetGit.js.bak

# Step 2: Modify the resetGit.js to use async/await and handle both prompt.yaml and prompt.md
# Step 3: Replace the content of resetGit.js with the refactored version
cat > src/git/resetGit.js << 'EOF'
import { promisify } from 'util';
import { exec as execCb } from 'child_process';

const exec = promisify(execCb);

export default async function resetGit() {
  try {
    await executeCommand('git stash -u');

    await executeCommand('git clean -f -d && git reset --hard');

    await executeCommand('git checkout stash@{0} -- prompt.yaml');
    await executeCommand('git checkout stash@{0} -- prompt.md');

    await executeCommand('git stash drop');
  } catch (err) {
    console.error(`An error occurred: ${err}`);
  }
}

async function executeCommand(command) {
  console.log(`Running command: ${command}`);
  const { stdout } = await exec(command);
  console.log(`stdout: ${stdout}`);
}
EOF

echo "\033[32mDone: $goal\033[0m\n"
