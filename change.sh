#!/bin/sh
set -e
goal="Fix TypeError issue in executeAndForwardOutput"
echo "Plan:"
echo "1. Update the executeAndForwardOutput function to check if next is a function before calling it"
echo "2. Update executeHandler.js to ensure correct parameters are being passed"

cat << 'EOF' > src/execute/executeAndForwardOutput.js
import { writeFile } from 'fs/promises';
import { spawn } from 'child_process';
import { makeExecutable } from './makeExecutable.js';

async function executeAndForwardOutput(code, next) {
  try {
    if (code == null || !code.startsWith('#!')) {
      throw new Error('Code does not start with a shebang');
    }
    await writeFile('./change.sh', code);
    await makeExecutable('./change.sh');
    
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
      if (next && typeof next === 'function') {
        next(code, commandOutput);
      }
    });
  } catch (err) {
    console.log(err);
  }
}

export { executeAndForwardOutput };
EOF

echo "\033[32mDone: $goal\033[0m\n"
