#!/bin/sh
set -e
goal="Fix TypeError issue by handling callback properly"
echo "Plan:"
echo "1. Change the function executeAndForwardOutput in executeAndForwardOutput.js to accept a next callback"
echo "2. Modify the executeHandler.js to provide a proper callback to executeAndForwardOutput"

# Step 1: Update executeAndForwardOutput.js to correct the usage of next
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
      if (typeof next === 'function') {
        next(code, commandOutput);
      }
    });
  } catch (err) {
    console.log(err);
  }
}

export { executeAndForwardOutput };
EOF

# Step 2: Update executeHandler.js to provide the proper callback to executeAndForwardOutput
cat > src/backend/handlers/executeHandler.js << 'EOF'
import { executeAndForwardOutput } from '../../execute/executeAndForwardOutput.js';
import { extractCode } from '../../execute/extractCode.js';

async function executeHandler(req, res) {
  let code = req.body.change;

  // Check if code starts with shebang
  if (!code.startsWith("#!")) {
    code = extractCode(code);
  }
  
  await executeAndForwardOutput(code, (code, output) => {
    res.json(output);
  });
}

export { executeHandler };
EOF

echo "\033[32mDone: $goal\033[0m\n"
