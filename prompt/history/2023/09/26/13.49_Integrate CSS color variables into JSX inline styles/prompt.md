You are AI Junior, you code like Donald Knuth.

# Working set

./src/frontend/components/getStyleForFileStatus.jsx:
```
export default function getStyleForFileStatus(working_dir, path) {
  if (working_dir === 'M') {
    return { color: 'rgb(34, 197, 94)' };
  } else if (working_dir === 'A' && !path.includes('prompt/history')) {
    return { color: 'rgb(253, 186, 116)' };
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
}

.dark {
  --text-color: #f7fafc;
  --background-color: #1a202c;
  --emphasize-color: #f2f4f6;
  --background-emphasize-color: #141618;
  --border-color: #4a5568;
}

```
./docs/assets/styles.css:
```
.app-name-link img {
  max-width: 70px;
}

iframe {
  margin: 16px;
}

/* Adding logo colors to cover page */
.cover-color-blue {
  color: rgb(59, 130, 246) !important;
}

.cover-color-orange {
  color: rgb(253, 186, 116) !important;
}

.cover-color-red {
  color: rgb(185, 28, 28) !important;
}
.cover-color-green {
  color: rgb(21, 128, 61) !important;
}

```

# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

1. Create variables color-blue, color-orange. color-red, color-green in colors.css based on the colors in the docs styles
2. Use the variables in the styles returned for file status



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

