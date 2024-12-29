You are AI Junior, you code like Donald Knuth.
# Working set

src/frontend/components/RepoInfo.jsx:
```
import { createSignal } from 'solid-js';

const RepoInfo = () => {
  return (
    <span class="text-sm font-mono bg-gray-200 dark:bg-gray-700 px-1 py-0.5 mt-2 rounded">
      @aijunior/dev main
    </span>
  );
};

export default RepoInfo;

```

src/backend/handlers/git/gitStatusHandler.js:
```
import gitStatus from '../../../git/gitStatus.js';

export default async function gitStatusHandler(req, res) {
  try {
    const status = await gitStatus();
    res.status(200).send({ message: status });
  } catch (error) {
    let errorMessage = 'Error in getting Git status';
    if (error.stderr && error.stderr.includes('Not a git repository')) {
      errorMessage = 'Not a git repo. Run \'npx junior-init\' to initialize!';
    }
    res.status(500).send({ message: errorMessage, error });
  }
}

```

src/git/clearBranches.js:
```
import simpleGit from 'simple-git';

const git = simpleGit();

export default async function clearBranches(exceptions = []) {
  let deletedCount = 0;
  let skippedCount = 0;
  
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
          deletedCount++;
        } else {
          console.log(`Branch ${branch} is not merged, skipping...`);
          skippedCount++;
        }
      } catch (err) {
        console.log(`Failed to delete branch ${branch}: ${err.message}. Skipping...`);
        skippedCount++;
      }
    }
  } catch (err) {
    console.error(`An error occurred: ${err}`);
  }

  console.log(`Deleted branches: ${deletedCount}`);
  console.log(`Skipped branches: ${skippedCount}`);
}

```

src/backend/routes/setupGitRoutes.js:
```
import gitStatusHandler from '../handlers/git/gitStatusHandler.js';
import commitGitHandler from '../handlers/git/commitGitHandler.js';
import resetGitHandler from '../handlers/git/resetGitHandler.js';

export function setupGitRoutes(app) {
  app.get('/git/status', gitStatusHandler);
  app.post('/git/reset', resetGitHandler);
  app.post('/git/commit', commitGitHandler);
}

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

Create a new route "/git/repoinfo" which returns an object with fields:
  - url: The repository url
  - branch: Current branch
  - name: Project name read out of package.json
  - description: Description read out of package.json

Put the git and package.json logic to src/git/



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

