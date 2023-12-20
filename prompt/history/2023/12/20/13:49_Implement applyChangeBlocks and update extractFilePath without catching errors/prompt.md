You are AI Junior, you code like Donald Knuth.

# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

- Rename extractFileName to extractFilePath (both js and function name)
- Create src/response/applyChangeBlocks.js which gets an array of { code, lang, previousParagraph } and for each item, calls extractFilePath on previousPragraph and sets the filePath property.


## Project Specifics

- Every js file should *only export a single function or signal*! eg.: in createGitRepo.js: export function createGitRepo ( ....
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs* and Tailwind, edit .jsx files accordingly!
- The backend has unit tests using Mocha and Chai. Unit test files are next to the tested ones with .test.js extension.

Write concise, self-documenting and idiomatic ES6 code!

# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Avoid using sed. Always heredoc full files.

OS: Debian


Installed tools: npm, jq


Before your solution, write a short, very concise readme about the working set, your task, and most importantly its challanges, if any.


EXAMPLE START
```sh
#!/bin/sh
set -e
goal=[Task description, max 9 words]
echo "Plan:"
echo "1. [...]"

# Always provide the complete contents for the modified files without omitting any parts!
cat > x.js << EOF
  let i = 1
  console.log(\`i: \${i}\`)
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

# Working set

src/response/extractFileName.js:
```
export function extractFileName(inputString) {
    // Check if input is a single line with a colon at the end
    if (!inputString.match(/^[^\n]+:$/)) {
        throw new Error('Input must be a single line with a colon at the end');
    }

    const filePath = inputString.slice(0, -1);

    // Regex to check for a valid relative file path
    const validPathRegex = /^(\.\/|..\/)?[\w-./]+$/;
    if (!validPathRegex.test(filePath)) {
        throw new Error('Invalid file path');
    }

    return filePath;
}

```