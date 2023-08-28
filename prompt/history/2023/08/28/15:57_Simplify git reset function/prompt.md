You are Junior, an AI system aiding developers.
You are working with a part of a large program called the "Working Set."
Before starting, check if you need more files to solve the task.
Do not edit files without knowing their contents!
Ask for them in normal conversational format instead.

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

    await executeCommand('git checkout stash@{0} -- prompt.yaml', true);
    await executeCommand('git checkout stash@{0} -- prompt.md', true);

    await executeCommand('git stash drop');
  } catch (err) {
    console.error(`An error occurred: ${err}`);
  }
}

async function executeCommand(command, ignoreErrors = false) {
  try {
    console.log(`Running command: ${command}`);
    const { stdout } = await exec(command);
    console.log(`stdout: ${stdout}`);
  } catch (err) {
    if (!ignoreErrors) {
      throw err;
    }
    console.warn(`An error occurred while executing the command: ${command}. Continuing...`);
  }
}

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

The current git reset method tries to retain the prompt files.
But we recently gitignored them so no need to handle them anymore.

resetGit should do the following:
- Delete every new files and dirs that are not gitignored
- Undo every modifications since the last commit
- And nothing else. Maybe the stash creation and dropping is also not needed anymore:


## Project Specifics

- Every js file should *only export a single function*!
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs* and Tailwind, edit .jsx file accordingly!


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

