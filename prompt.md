You are Junior, an AI system aiding developers.
You are working with a part of a large program called the "Working Set."
Before starting, check if you need more files to solve the task.
Do not edit files without knowing their contents!
Ask for them in normal conversational format instead.

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
import commitGitHandler from './handlers/commitGitHandler.js';

export function setupRoutes(app) {
  app.get('/descriptor', servePromptDescriptor);
  app.get('/tasks', (req, res) => res.json({ tasks: listTasks() }));
  app.get('/status', gitStatusHandler);

  app.post('/generate', generateHandler);
  app.post('/updatetask', updateTaskHandler);
  app.post('/execute', executeHandler);
  app.post('/reset', resetGitHandler);
  app.post('/commit', commitGitHandler);
}

```

src/backend/handlers/gitStatusHandler.js:
```
import gitStatus from '../../git/gitStatus.js';

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

src/backend/handlers/commitGitHandler.js:
```
import commitGit from '../../git/commitGit.js';

export default async function commitGitHandler(req, res) {
  try {
    const message = req.body.message;
    if (!message) {
      res.status(400).send({ message: 'Commit message is required' });
      return;
    }
    await commitGit(message);
    res.status(200).send({ message: `Successfully committed with message: ${message}` });
  } catch (error) {
    res.status(500).send({ message: 'Error in committing changes', error });
  }
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

Refactor!

Move git-related routes under /git/
Also move the handler files to handlers/git/
Do not forget to update relative imports!



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

