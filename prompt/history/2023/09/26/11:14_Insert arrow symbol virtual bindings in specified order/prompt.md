You are AI Junior, you code like Donald Knuth.

# Working set

./src/frontend/config/terminalVirtualKeyBindings.js:
```
const terminalVirtualKeyBindings = () => {
  return [
    { label: 'Tab', action: '\t' },
    { label: 'Esc', action: '\x1B' },
    { label: 'Ctrl-Z', action: '\x1A' },
    { label: 'Ctrl-Y', action: '\x19' },
    { label: 'Ctrl-X', action: '\x18' },
    { label: 'Ctrl-V', action: '\x16' },
    { label: 'F1', action: '\x1BOP' },
    { label: 'F5', action: '\x1B[15~' },
    { label: 'F6', action: '\x1B[17~' },
    { label: 'F7', action: '\x1B[18~' }
  ];
};

export default terminalVirtualKeyBindings;

```

# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

Add virt keys after esc for arrow keys


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

