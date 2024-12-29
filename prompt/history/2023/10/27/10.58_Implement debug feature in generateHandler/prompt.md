You are AI Junior, you code like Donald Knuth.

# Working set

./src/backend/handlers/generateHandler.js:
```
import generatePrompt from '../../prompt/generatePrompt.js';
import isRepoClean from '../../git/isRepoClean.js';

export const generateHandler = async (req, res) => {
  try {
    if (!await isRepoClean()) {
      throw new Error("Directory is not clean. Please commit or stash changes and try again.");
    }

    const { notes, systemPrompt } = req.body;
    const { prompt } = await generatePrompt(notes, systemPrompt);
    res.json({ prompt: prompt });
  } catch (error) {
    console.warn(error);
    res.status(500).json({ error: error.message });
  }
};

```

# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

- Create src/config/isDebug.js which checks for --debug cli arg and JUNIOR_DEBUG=true env var.
- If debug is enabled, do not error when the directory is dirty.
- If debug not enabled, mention --debug in the Error


## Project Specifics

- Every js file should *only export a single function or signal*! eg.: in createGitRepo.js: export function createGitRepo ( ....
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs* and Tailwind, edit .jsx files accordingly!

Write concise, self-documenting and idiomatic ES6 code!

# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, avoid using sed in favor of heredoc-ing full files.

OS: OSX

Installed tools: npm, jq


Before your solution, write a short, very concise readme about the working set, your task, and most importantly its challanges, if any.


EXAMPLE START
```sh
#!/bin/sh
set -e
goal=[Task description, max 9 words]
echo "Plan:"
echo "1. [...]"
cat > x.js << 'EOF'
[...]
'EOF'
echo "\033[32mDone: $goal\033[0m\n"
```
EXAMPLE END

Before starting, check if you need more files or info to solve the task.

If the task is not clear:

EXAMPLE START
I need more information to solve the task. [Description of the missing info]
EXAMPLE END

Do not edit files not provided in the working set!
If you need more files:

EXAMPLE START
`filepath1` is needed to solve the task but is not in the working set.
EXAMPLE END

