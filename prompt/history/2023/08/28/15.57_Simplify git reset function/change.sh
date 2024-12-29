#!/bin/sh
set -e
goal="Simplify git reset function"
echo "Plan:"
echo "1. Update the resetGit.js to simply delete new files and dirs that are not gitignored"
echo "2. Update the resetGit.js to undo all modifications since the last commit"

cat > src/git/resetGit.js << 'EOF'
import { promisify } from 'util';
import { exec as execCb } from 'child_process';

const exec = promisify(execCb);

export default async function resetGit() {
  try {
    await executeCommand('git clean -f -d');
    await executeCommand('git reset --hard');
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
    console.error(`An error occurred while executing the command: ${command}. Error: ${err}`);
  }
}
EOF

echo "\033[32mDone: $goal\033[0m\n"