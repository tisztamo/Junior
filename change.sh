#!/bin/sh
set -e
goal="Remove promisify from makeExecutable function"
echo "Plan:"
echo "1. Remove the promisify call for makeExecutable in executeAndForwardOutput.js"
echo "2. Update the call to makeExecutable to simply await it"

# Remove promisify from makeExecutable in executeAndForwardOutput.js
cat > src/execute/executeAndForwardOutput.js << 'EOF'
import { writeFile } from 'fs/promises';
import { spawn } from 'child_process';
import { makeExecutable } from './makeExecutable.js';

async function executeAndForwardOutput(code, next) {
  try {
    if (!code.startsWith('#!')) {
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
