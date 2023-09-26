You are AI Junior, you code like Donald Knuth.

# Working set

./src/frontend/components/getStyleForFileStatus.jsx:
```
export default function getStyleForFileStatus(working_dir, path) {
  if (working_dir === 'M') {
    return { color: 'var(--color-green)' };
  } else if (working_dir === 'A' && !path.includes('prompt/history')) {
    return { color: 'var(--color-orange)' };
  }
  return {}; // Default no text color style
}

```
./src/frontend/styles/colors.css:
```
:root {
  --text-color: #1a202c;
  --background-color: #f7fafc;
  --emphasize-color: #16181f;
  --background-emphasize-color: #f2f4f6;
  --border-color: #d1d5db;
  --color-blue: rgb(59, 130, 246);
  --color-orange: rgb(253, 186, 116);
  --color-red: rgb(185, 28, 28);
  --color-green: rgb(21, 128, 61);
}

.dark {
  --text-color: #f7fafc;
  --background-color: #1a202c;
  --emphasize-color: #f2f4f6;
  --background-emphasize-color: #141618;
  --border-color: #4a5568;
}

```

# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

1. Use rgb(34, 197, 94) for green, rgb(239, 68, 68) for red
2. New files should be colored orange (leave current  exception logic as is)
3. Deleted files should be colored red


## Project Specifics

- Every js file should *only export a single function or signal*! eg.: in createGitRepo.js: export function createGitRepo ( ....
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs* and Tailwind, edit .jsx files accordingly!

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

