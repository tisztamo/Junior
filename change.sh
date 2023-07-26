#!/bin/sh
set -e
goal="Implementing code validation and refactoring"
echo "Plan:"
echo "1. Remove the unused import 'rl' from executeAndForwardOutput.js"
echo "2. Update the executeAndForwardOutput function to check if the code starts with a shebang"
echo "3. Save the code to a file './change.sh' and run it instead of feeding the lines directly to the shell"

# Step 1, 2, and 3: Remove the unused import, validate shebang and write code to file
cat << 'EOF' > ./src/execute/executeAndForwardOutput.js
import { writeFile } from 'fs/promises';
import { spawn } from 'child_process';

async function executeAndForwardOutput(code, next) {
  // Check if the code starts with a shebang
  if (!code.startsWith('#!')) {
    throw new Error('Code does not start with a shebang');
  }

  try {
    // Write code to change.sh
    await writeFile('./change.sh', code);
    const child = spawn('./change.sh', [], { shell: true });
    let commandOutput = '';

    child.stdout.on('data', (data) => {
      console.log(`${data}`);
      commandOutput += data;
    });

    child.stderr.on('data', (data) => {
      console.error(`${data}`);
      commandOutput += data;
    });

    child.on('close', (code) => {
      next(code, commandOutput);
    });
  } catch (err) {
    console.error(err);
  }
}

export { executeAndForwardOutput };
EOF

echo "\033[32mDone: $goal\033[0m\n"
