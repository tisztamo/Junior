# Working set

src/execute/executeAndForwardOutput.js:
```
import { writeFile } from 'fs/promises';
import { spawn } from 'child_process';
import { makeExecutable } from './makeExecutable.js';
import {promisify} from 'util';

const writeFileAsync = promisify(writeFile);
const makeExecutableAsync = promisify(makeExecutable)

async function executeAndForwardOutput(code, next) {
  try {
    if (!code.startsWith('#!')) {
      throw new Error('Code does not start with a shebang');
    }
    await writeFileAsync('./change.sh', code);
    await makeExecutableAsync('./change.sh');
    
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
    console.log(err);
  }
}

export { executeAndForwardOutput };

src/backend/handlers/executeHandler.js:
```
import { executeAndForwardOutput } from '../../execute/executeAndForwardOutput.js';

function executeHandler(req, res) {
  executeAndForwardOutput(req.body.change, (result, output) => {
    res.json({ result, output });
  });
}

export { executeHandler };
```

src/execute/makeExecutable.js:
```
import { chmod } from 'fs/promises';

async function makeExecutable(filepath) {
  try {
    await chmod(filepath, '755');
  } catch (err) {
    console.error(`Failed to make ${filepath} executable: ${err}`);
  }
}

export { makeExecutable };
```


# Task

Fix the following issue!

Do not promisify makeExecutable, just await it.

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

