#!/bin/sh
set -e
goal="Fix TypeError in executeAndForwardOutput function"
echo "Plan:"
echo "1. Add a check to see if 'code' is null or undefined before calling startsWith on it."
echo "2. Modify executeAndForwardOutput.js file to include the null or undefined check for the 'code' parameter."

cat > src/execute/executeAndForwardOutput.js << 'EOF'
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
      next(code, commandOutput);
    });
  } catch (err) {
    console.log(err);
  }
}

export { executeAndForwardOutput };
EOF

echo "\033[32mDone: $goal\033[0m\n"
