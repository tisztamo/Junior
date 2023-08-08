# Working set

src/git/resetGit.js:
```
import { promisify } from 'util';
import { exec as execCb } from 'child_process';

const exec = promisify(execCb);

export default async function resetGit() {
  try {
    await executeCommand('git stash -u');

    await executeCommand('git clean -f -d && git reset --hard');

    await executeCommand('git checkout stash@{0} -- prompt.yaml');
    await executeCommand('git checkout stash@{0} -- prompt.md');

    await executeCommand('git stash drop');
  } catch (err) {
    console.error(`An error occurred: ${err}`);
  }
}

async function executeCommand(command) {
  console.log(`Running command: ${command}`);
  const { stdout } = await exec(command);
  console.log(`stdout: ${stdout}`);
}

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

- When checkouts fail, e.g. one of the prompt files is missing, continue.



## Project Specifics

- Every js file should *only export a single function*!
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs*, edit .jsx file accordingly


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

