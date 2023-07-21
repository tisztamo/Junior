#!/bin/sh
# Goal: Refactor the mentioned files
# Plan:
# 1. Rename confirmAndWriteCode.js to confirmExecution.js
# 2. Remove the import of startInteractiveSession from executeAndForwardOutput.js and replace it with a "next" continuation
# 3. Update executeCode.js to pass startInteractiveSession as a continuation to executeAndForwardOutput

# Step 1: Rename confirmAndWriteCode.js to confirmExecution.js
mv src/execute/confirmAndWriteCode.js src/execute/confirmExecution.js

# Step 2: Update the contents of confirmExecution.js
cat << 'EOF' > src/execute/confirmExecution.js
import { rl } from '../config.js';

function confirmExecution(code, next) {
  rl.question('\x1b[1mEXECUTE? [y/n]\x1b[0m ', (answer) => {
    if (answer.toLowerCase() === 'y') {
      console.log("\x1b[33mExecuting...\x1b[0m");
      next();
    } else {
      console.log("\x1b[33mNot executing.\x1b[0m");
    }
  });
}

export { confirmExecution };
EOF

# Step 3: Update the contents of executeAndForwardOutput.js
cat << 'EOF' > src/execute/executeAndForwardOutput.js
import { spawn } from 'child_process';
import { rl } from '../config.js';

function executeAndForwardOutput(code, next) {
  const child = spawn(code, { shell: true });
  let last_command_result = '';

  child.stdout.on('data', (data) => {
    console.log(`${data}`);
    last_command_result += data;
  });

  child.stderr.on('data', (data) => {
    console.error(`${data}`);
    last_command_result += data;
  });

  child.on('close', (code) => {
    if (code !== 0) {
      console.log(`child process exited with code ${code}`);
      last_command_result = "Command failed. Output:\n" + last_command_result;
    } else {
      last_command_result = "Command executed. Output:\n" + last_command_result;
    }
    next();
  });
}

export { executeAndForwardOutput };
EOF

# Step 4: Update the contents of executeCode.js
cat << 'EOF' > src/execute/executeCode.js
import { confirmExecution } from './confirmExecution.js';
import { executeAndForwardOutput } from './executeAndForwardOutput.js';
import { startInteractiveSession } from "../interactiveSession/startInteractiveSession.js";

const executeCode = async (code) => {
  confirmExecution(code, () => executeAndForwardOutput(code, startInteractiveSession));
}

export { executeCode };
EOF
