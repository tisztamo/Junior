# Working set

src/frontend/service/executeChange.js:
```
import { getBaseUrl } from '../getBaseUrl';

const executeChange = async (change) => {
  const baseUrl = getBaseUrl();
  const response = await fetch(`${baseUrl}/execute`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ change })
  });

  const data = await response.json();

  return data;
};

export { executeChange };

```

src/backend/handlers/executeHandler.js:
```
import { executeAndForwardOutput } from '../../execute/executeAndForwardOutput.js';

function executeHandler(req, res) {
  executeAndForwardOutput(req.body.change, (result) => {
    res.json({ result });
  });
}

export { executeHandler };

```

src/execute/executeAndForwardOutput.js:
```
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

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!
- Every js file should only export a single function!
- Use ES6 imports!

Requirements:

The execute api fails to return anything. It should return  { result: 0, output: &#39;output&#39;}
Do not append extra text to last_command_result, and rename it to commandOutput



# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, prefer heredoc-ing full files using 'EOF' to prevent substitution.
OS: OSX
Installed tools: npm, jq
Do NOT write any text outside the script!

EXAMPLE START

```sh
#!/bin/sh
set -e
goal=[Task description, max 7 words]
# Plan:
# 1. [...]
# ...
[Commands solving the task]
echo "\033[32mCompleted: $goal\033[0m\n"
```

EXAMPLE END

