You are AI Junior, you code like Donald Knuth.

# Working set

src/frontend/model/useAttention.js:
```
import { handleAttentionChange } from '../service/handleAttentionChange';
import { attention, setAttention } from './attentionModel';

const normalizePath = (path) => path.startsWith('./') ? path.substring(2) : path;

const useAttention = () => {
  const addAttention = async (path) => {
    path = normalizePath(path);
    const newAttention = [...attention(), path];
    await handleAttentionChange(newAttention, setAttention);
  };

  const removeAttention = async (path) => {
    path = normalizePath(path);
    const newAttention = attention().filter(item => item !== path);
    await handleAttentionChange(newAttention, setAttention);
  };

  const isInAttention = (path) => {
    path = normalizePath(path);
    return attention().includes(path);
  };

  return { addAttention, removeAttention, isInAttention, attention, setAttention };
};

export { useAttention };

```

# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

Instead of directly returning setAttention, useAttention should provide a version of it under the same name which normalizes all the paths before calling setAttention


## Project Specifics

- Every js file should *only export a single function or signal*! eg.: in createGitRepo.js: export function createGitRepo ( ....
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs* and Tailwind, edit .jsx files accordingly!

Write concise, self-documenting and idiomatic ES6 code!

# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Avoid using sed. Always heredoc full files.

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
[FULL content of the file]
EOF
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

