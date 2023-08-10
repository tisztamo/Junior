You are Junior, an AI system aiding developers. You are working with a part of a large program called the "Working Set." Ask for contents of subdirectories if needed. Some files are printed in the working set. Others are listed in their directory, but do not edit them without knowing their contents!

# Working set

```
./
├── .git/...
├── .github/...
├── .gitignore
├── .vscode/...
├── README.md
├── change.sh
├── docs/...
├── integrations/...
├── node_modules/...
├── package-lock.json
├── package.json
├── prompt/...
├── prompt.md
├── prompt.yaml
├── scripts/...
├── src/...

```
```
./scripts/
├── deleteBranchesCommand.js
├── updateLogo.js

```
src/git/clearBranches.js:
```
import { promisify } from 'util';
import { exec as execCb } from 'child_process';

const exec = promisify(execCb);

export default async function clearBranches(exceptions = []) {
  try {
    const { stdout: currentBranch } = await exec('git rev-parse --abbrev-ref HEAD');
    const { stdout: allBranches } = await exec('git for-each-ref --format="%(refname:short)" refs/heads');

    const branches = allBranches.split('\n').filter(branch => branch !== currentBranch.trim() && !exceptions.includes(branch));

    for (const branch of branches) {
      await executeCommand(`git branch -d ${branch}`);
    }
  } catch (err) {
    console.error(`An error occurred: ${err}`);
  }
}

async function executeCommand(command) {
  try {
    console.log(`Running command: ${command}`);
    const { stdout } = await exec(command);
    console.log(`stdout: ${stdout}`);
  } catch (err) {
    throw err;
  }
}

```

src/git/clearBranchesCommand.js:
```
import clearBranches from './clearBranches';

const exceptions = process.argv.slice(2);

async function run() {
  try {
    await clearBranches(exceptions);
    console.log('Branches deleted successfully.');
  } catch (err) {
    console.error(`An error occurred while deleting branches: ${err}`);
    process.exit(1);
  }
}

run();


```


# Task

Move the following files to the specified target dirs!

Find out the best target dir if it is not specified!

You need to follow dependencies to maintain coherence.

Before executing, write a concise plan! The plan should show:
 - How do you avoid breaking other parts of the code.
 - If you had to choose, your way of thinking.

Move clearBranchesCommand.js to scripts/
Delete scripts/deleteBranchesCommand.js


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

