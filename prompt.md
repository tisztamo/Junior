# Working set

src/backend/setupRoutes.js:
```
import { generateHandler } from './handlers/generateHandler.js';
import { servePromptDescriptor } from './handlers/servePromptDescriptor.js';
import { updateTaskHandler } from './handlers/updateTaskHandler.js';
import { listTasks } from './handlers/listTasks.js';
import { executeHandler } from './handlers/executeHandler.js';
import resetGitHandler from './handlers/resetGitHandler.js';
import gitStatusHandler from './handlers/gitStatusHandler.js';

export function setupRoutes(app) {
  app.get('/descriptor', servePromptDescriptor);
  app.get('/tasks', (req, res) => res.json({ tasks: listTasks() }));
  app.get('/status', gitStatusHandler);

  app.post('/generate', generateHandler);
  app.post('/updatetask', updateTaskHandler);
  app.post('/execute', executeHandler);
  app.post('/reset', resetGitHandler);
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

src/git/resetGit.js:
```
import { exec } from 'child_process';

export default function resetGit() {
  // Stash all changes including untracked files
  exec('git stash -u', (err, stdout, stderr) => {
    if (err) {
      console.error(`exec error: ${err}`);
      return;
    }
    console.log(`stdout: ${stdout}`);

    // Clean the repository and reset to the latest commit
    exec('git clean -f -d && git reset --hard', (err, stdout, stderr) => {
      if (err) {
        console.error(`exec error: ${err}`);
        return;
      }
      console.log(`stdout: ${stdout}`);

      // Checkout prompt.yaml from stash
      exec('git checkout stash@{0} -- prompt.yaml', (err, stdout, stderr) => {
        if (err) {
          console.error(`exec error: ${err}`);
          return;
        }
        console.log(`stdout: ${stdout}`);

        // Drop the stash
        exec('git stash drop', (err, stdout, stderr) => {
          if (err) {
            console.error(`exec error: ${err}`);
            return;
          }
          console.log(`stdout: ${stdout}`);
        });
      });
    });
  });
}

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

Create the commit/ endpoint which commits all new files and changes!
Commit message comes in the message field.



## Project Specifics

- Every js file should *only export a single function*!
- Use *ES6 imports*!
- Prefer *async/await* over promises!
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

