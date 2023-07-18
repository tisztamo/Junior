#!/bin/sh
# Goal: Improve code execution and output forwarding with real-time streaming, logical separation of concerns, and preserving original function signature
# Plan:
# 1. Create confirmAndWriteCode.js for handling user confirmation and writing code to file
# 2. Create executeAndForwardOutput.js for executing the command and forwarding output
# 3. Modify executeCode.js to import and use the new functions

# Step 1: Create confirmAndWriteCode.js
cat << 'EOF' > src/execute/confirmAndWriteCode.js
import { writeFile } from 'fs';
import { executeAndForwardOutput } from './executeAndForwardOutput.js';

function confirmAndWriteCode(code, rl, execute) {
  rl.question('\x1b[1mEXECUTE? [y/n]\x1b[0m ', (answer) => {
    console.log("");
    if (answer.toLowerCase() === 'y' || answer === "") {
      writeFile('./change.sh', code, (err) => {
        if (err) {
          console.error(err.message);
          return;
        }
        execute();
      });
    }
  });
}

export { confirmAndWriteCode };
EOF

# Step 2: Create executeAndForwardOutput.js
cat << 'EOF' > src/execute/executeAndForwardOutput.js
import { spawn } from 'child_process';
import { startInteractiveSession } from "../interactiveSession/startInteractiveSession.js";

function executeAndForwardOutput(code, last_command_result, parent_message_id, rl) {
  const child = spawn(code, { shell: true });

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
    startInteractiveSession(last_command_result, parent_message_id, rl)
  });
}

export { executeAndForwardOutput };
EOF

# Step 3: Modify executeCode.js
cat << 'EOF' > src/execute/executeCode.js
#!/usr/bin/env node

import { confirmAndWriteCode } from './confirmAndWriteCode.js';
import { executeAndForwardOutput } from './executeAndForwardOutput.js';

const executeCode = async (code, last_command_result, parent_message_id, rl) => {
  confirmAndWriteCode(code, rl, () => executeAndForwardOutput(code, last_command_result, parent_message_id, rl));
}

export { executeCode };
EOF
