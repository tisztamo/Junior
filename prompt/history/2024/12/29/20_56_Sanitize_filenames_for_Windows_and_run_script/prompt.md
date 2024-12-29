You are a senior software developer, you code like Donald Knuth.

# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

When fixing a path, sanitize filenames for windows. Also run the script at the end of the change


## Project Specifics

- Every js file should *only export a single function or signal*! eg.: in createGitRepo.js: export function createGitRepo ( ....
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs* and Tailwind, edit .jsx files accordingly!

Write concise, self-documenting and idiomatic ES6 code!

# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Avoid using sed. Always heredoc full files.

OS: Debian


Installed tools: npm, jq




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

scripts/fixPromptPathsForWindows.js:
```
import { readdir, rename } from 'fs/promises';
import { join } from 'path';

async function fixPaths(dir) {
    const entries = await readdir(dir, { withFileTypes: true });

    for (const entry of entries) {
        const oldPath = join(dir, entry.name);

        if (entry.isDirectory()) {
            const newName = entry.name.replace(/:/g, '.');
            const newPath = join(dir, newName);

            if (newName !== entry.name) {
                await rename(oldPath, newPath);
                console.log(`Renamed: ${oldPath} -> ${newPath}`);
            }

            await fixPaths(newPath);
        }
    }
}

(async function () {
    try {
        await fixPaths('./prompt/history');
        console.log('Directory paths fixed for Windows compatibility.');
    } catch (err) {
        console.error('Error fixing paths:', err);
        process.exit(1);
    }
})();

```
src/utils/sanitizeFilename.js:
```
/**
 * Sanitize a filename or directory name to be safe for Windows paths.
 * Replaces any disallowed characters with underscores (_).
 *
 * @param {string} name - The filename or directory name to sanitize.
 * @returns {string} - The sanitized name.
 */
export function sanitizeFilename(name) {
    if (typeof name !== 'string') {
        throw new TypeError('Filename must be a string');
    }

    // Define a regex for characters not allowed in Windows filenames
    const disallowedChars = /[<>:"/\\|?*]/g;
    const sanitized = name.replace(disallowedChars, '_');

    // Ensure the name is not empty or only underscores
    return sanitized || '_';
}

```