# Working set

```
./
├── .git/...
├── .gitignore
├── README.md
├── babel.config.js
├── change.sh
├── doc/...
├── node_modules/...
├── package-lock.json
├── package.json
├── prompt/...
├── prompt.md
├── prompt.yaml
├── secret.sh
├── src/...

```
```
src/
├── attention/...
├── backend/...
├── config.js
├── execute/...
├── frontend/...
├── index.html
├── interactiveSession/...
├── main.js
├── prompt/...
├── startServer.js
├── startVite.js
├── vite.config.js
├── web.js

```
```
src/execute/
├── executeCode.js
├── extractCode.js

```
src/execute/extractCode.js:
```
function extractCode(res) {
  const match = res.match(/```(sh|bash)([\s\S]*?)```/);
  return match ? match[2].trim() : null;
}

export { extractCode };

```

src/execute/executeCode.js:
```
#!/usr/bin/env node

import { startInteractiveSession } from "../interactiveSession/startInteractiveSession.js";
import { exec } from 'child_process';

const executeCode = async (cod, last_command_result, parent_message_id, rl) => {
  rl.question('\x1b[1mEXECUTE? [y/n]\x1b[0m ', async (answer) => {
    console.log("");
    if (answer.toLowerCase() === 'y' || answer === "") {
      exec(cod, (error, stdout, stderr) => {
        if (error) {
          console.error(`${error.message}`);
          last_command_result = "Command failed. Output:\n" + error.message + "\n";
        } else {
          if (stdout.length > 0) {
            console.log(`${stdout}`);
          }
          if (stderr.length > 0) {
            console.log(`${stderr}`);
          }
          last_command_result = "Command executed. Output:\n" + stdout + "\n" + stderr + "\n";
        }
        startInteractiveSession(last_command_result, parent_message_id, rl)
      });
    } else {
      last_command_result = "Command skipped.\n";
      startInteractiveSession(last_command_result, parent_message_id, rl);
    }
  });
}

export { executeCode };

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!
- Every js file should only export a single function!
- Use ES6 imports!

Requirements:

1. The executed code should be written to ./change.sh before executing. 2. While executing the code, I do not see output in the terminal. Forward it! 3. executeCode.js is too big. We need to split in two logically.



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

