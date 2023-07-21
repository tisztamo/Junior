# Working set

src/execute/executeCode.js:
```
import { confirmAndWriteCode } from './confirmAndWriteCode.js';
import { executeAndForwardOutput } from './executeAndForwardOutput.js';

const executeCode = async (code) => {
  confirmAndWriteCode(code, () => executeAndForwardOutput(code));
}

export { executeCode };

```

src/execute/executeAndForwardOutput.js:
```
import { spawn } from 'child_process';
import { startInteractiveSession } from "../interactiveSession/startInteractiveSession.js";
import { rl } from '../config.js';

function executeAndForwardOutput(code) {
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
    startInteractiveSession()
  });
}

export { executeAndForwardOutput };

```

src/execute/confirmAndWriteCode.js:
```
import { rl } from '../config.js';

function confirmAndWriteCode(code, next) {
  rl.question('\x1b[1mEXECUTE? [y/n]\x1b[0m ', (answer) => {
    if (answer.toLowerCase() === 'y') {
      console.log("\x1b[33mExecuting...\x1b[0m");
      next();
    } else {
      console.log("\x1b[33mNot executing.\x1b[0m");
    }
  });
}

export { confirmAndWriteCode };

```


# Task

Refactor the mentioned files!

Look for
  - unused imports
  - unneeded comments
  - ugly names
  - misplaced files
  - code repetition
  - code smell

When a file is bigger than 40 lines, split it: Identify the possible parts and create separate files!

1. Rename confirmAndWriteCode.js to confirmExecution.js
Maintain dependencies and imports!
2. executeAndForwardOutput should not import startInteractiveSession,
give it a &#34;next&#34; continuation instead.


# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, prefer heredoc-ing full files without substitution.
Assume OSX.
npm and jq are installed.
Do NOT write any text outside the script (the plan goes into it)!


EXAMPLE START

```sh
#!/bin/sh
# Goal: [Task description, max 7 words]
# Plan:
# 1. [...]

[Commands solving the task]
```

EXAMPLE END

