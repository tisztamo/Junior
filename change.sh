#!/bin/sh
set -e
goal="Make change.sh executable after writing"
echo "Plan:"
echo "1. Create a new file named 'makeExecutable.js' in src/execute directory."
echo "2. Write a function in 'makeExecutable.js' that makes a file executable."
echo "3. Import and call the function in 'executeAndForwardOutput.js' after the file is written."

cat << 'EOF' > ./src/execute/makeExecutable.js
import { chmod } from 'fs/promises';

async function makeExecutable(filepath) {
  try {
    await chmod(filepath, '755');
  } catch (err) {
    console.error(`Failed to make ${filepath} executable: ${err}`);
  }
}

export { makeExecutable };
EOF

# modify the 'executeAndForwardOutput.js' to call the 'makeExecutable' function after writing 'change.sh'
cat << 'EOF' > ./src/execute/executeAndForwardOutput.js
import { writeFile } from 'fs/promises';
import { spawn } from 'child_process';
import { makeExecutable } from './makeExecutable.js';

async function executeAndForwardOutput(code, next) {
  if (!code.startsWith('#!')) {
    throw new Error('Code does not start with a shebang');
  }

  try {
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
    console.error(err);
  }
}

export { executeAndForwardOutput };
EOF

echo "\033[32mDone: $goal\033[0m\n"
