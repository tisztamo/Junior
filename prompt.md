# Working set

src/execute/executeAndForwardOutput.js:
```
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

```

src/backend/handlers/executeHandler.js:
```
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

```


# Task

Fix the following issue!

TypeError: next is not a function
  at ChildProcess.&lt;anonymous&gt; (file:///Users/ko/projects-new/Junior/src/execute/executeAndForwardOutput.js:27:7)
  at ChildProcess.emit (node:events:537:28)
  at maybeClose (node:internal/child_process:1091:16)
  at Socket.&lt;anonymous&gt; (node:internal/child_process:449:11)
  at Socket.emit (node:events:537:28)
  at Pipe.&lt;anonymous&gt; (node:net:747:14)


# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, avoid using sed in favor of heredoc-ing full files using 'EOF' to prevent substitution.

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

