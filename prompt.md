# Working set

src/prompt/getPromptDirectories.js:
```
import path from 'path';

const getPromptDirectories = () => {
  const rootDir = path.resolve();
  const workingDir = process.cwd();
  
  return [
    path.join(rootDir, 'prompt'),
    path.join(workingDir, 'prompt')
  ];
}

export { getPromptDirectories };

```


# Task

Fix the following issue!

use import.meta to get the dir of the source file. One directory is relative to the working dir, the other relative to the project root.

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

