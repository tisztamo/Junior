# Working set

src/git/resetGit.js:
```
import git from 'simple-git';

export default async function resetGit() {
  const gitInstance = git();

  // Stash changes in prompt.yaml
  await gitInstance.add('./src/prompt.yaml');
  await gitInstance.stash();

  // Clean the repository and reset to the latest commit
  await gitInstance.clean('f', ['-d']);
  await gitInstance.reset('hard');

  // Apply stashed changes to prompt.yaml
  await gitInstance.stash(['pop']);
}

```

src/backend/handlers/resetGitHandler.js:
```
import resetGit from '../../git/resetGit.js';

export default async function resetGitHandler(req, res) {
  try {
    await resetGit();
    res.status(200).send({ message: 'Git successfully reset' });
  } catch (error) {
    res.status(500).send({ message: 'Error in resetting Git', error });
  }
}

```


# Task

Fix the following issue!

File path is ./prompt.yaml


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

