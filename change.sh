#!/bin/sh
set -e
goal="Fix execute API to return command output"
# Plan:
# 1. Update src/execute/executeAndForwardOutput.js to remove extra text and change last_command_result to commandOutput
# 2. Update src/backend/handlers/executeHandler.js to pass the commandOutput as the result to res.json

# Step 1
cat << 'EOF' > src/execute/executeAndForwardOutput.js
import { spawn } from 'child_process';
import { rl } from '../config.js';

function executeAndForwardOutput(code, next) {
  const child = spawn(code, { shell: true });
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
}

export { executeAndForwardOutput };
EOF

# Step 2
cat << 'EOF' > src/backend/handlers/executeHandler.js
import { executeAndForwardOutput } from '../../execute/executeAndForwardOutput.js';

function executeHandler(req, res) {
  executeAndForwardOutput(req.body.change, (result, output) => {
    res.json({ result, output });
  });
}

export { executeHandler };
EOF

echo "\033[32mCompleted: $goal\033[0m\n"
