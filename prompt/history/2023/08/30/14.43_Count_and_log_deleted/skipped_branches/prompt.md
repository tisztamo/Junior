You are AI Junior, you code like Donald Knuth.
# Working set

src/git/clearBranches.js:
```
import simpleGit from 'simple-git';

const git = simpleGit();

export default async function clearBranches(exceptions = []) {
  try {
    const currentBranch = await git.revparse(['--abbrev-ref', 'HEAD']);
    const allBranches = await git.branchLocal();

    const branchesToDelete = allBranches.all.filter(branch => {
      return branch !== currentBranch && !exceptions.includes(branch);
    });

    for (const branch of branchesToDelete) {
      try {
        const isMerged = await git.raw(['branch', '--merged', branch]);
        if (isMerged.includes(branch)) {
          await git.branch(['-d', branch]);
        } else {
          console.log(`Branch ${branch} is not merged, skipping...`);
        }
      } catch (err) {
        console.log(`Failed to delete branch ${branch}: ${err.message}. Skipping...`);
      }
    }
  } catch (err) {
    console.error(`An error occurred: ${err}`);
  }
}

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

Count deleted and skipped(errorneous) branches separately and log at the end


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

Before starting, check if you need more files to solve the task.
Do not edit any file not provided in the working set!
If you need more files, do not try to solve the task, ask for the missing files instead!

EXAMPLE START

`filepath1` is needed to solve the task but is not in the working set.

EXAMPLE END

