# Working set

src/execute/executeAndForwardOutput.js:
```
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

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

Check if the code starts with a shebang and throw if not
Save the code to ./change.sh and the run ./change.sh instead of feeding the lines directly to the shell
remove the unused import &#34;rl&#34;



## Project Specifics

- Every js file should *only export a single function*!
- Use *ES6 imports*!
- The frontend uses *Solidjs*, edit .jsx file accordingly


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
echo "Plan:"
echo "1. [...]"
[Commands solving the task]
echo "\033[32mDone: $goal\033[0m\n"
```

EXAMPLE END

