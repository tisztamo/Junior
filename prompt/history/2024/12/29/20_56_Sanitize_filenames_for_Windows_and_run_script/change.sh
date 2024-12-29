#!/bin/sh
set -e

goal="Sanitize filenames for Windows and run script"

echo "Plan:"
echo "1. Update fixPromptPathsForWindows.js to use sanitizeFilename."
echo "2. Ensure sanitizeFilename is correctly imported and used in path processing."
echo "3. Update logic to sanitize both filenames and folder names recursively."
echo "4. Run the script at the end to verify changes."

echo "Step 1: Modifying fixPromptPathsForWindows.js"

cat > scripts/fixPromptPathsForWindows.js << 'EOF'
import { readdir, rename } from 'fs/promises';
import { join } from 'path';
import { sanitizeFilename } from '../src/utils/sanitizeFilename.js';

/**
 * Recursively sanitize and fix paths for Windows compatibility.
 *
 * @param {string} dir - The directory to process.
 */
async function fixPaths(dir) {
    const entries = await readdir(dir, { withFileTypes: true });

    for (const entry of entries) {
        const oldPath = join(dir, entry.name);
        const sanitizedName = sanitizeFilename(entry.name);
        const newPath = join(dir, sanitizedName);

        if (sanitizedName !== entry.name) {
            await rename(oldPath, newPath);
            console.log(`Renamed: ${oldPath} -> ${newPath}`);
        }

        if (entry.isDirectory()) {
            await fixPaths(newPath);
        }
    }
}

(async function () {
    try {
        await fixPaths('./prompt/history');
        console.log('All paths sanitized for Windows compatibility.');
    } catch (err) {
        console.error('Error fixing paths:', err);
        process.exit(1);
    }
})();
EOF

echo "Step 2: Ensuring sanitizeFilename.js is correctly implemented"
cat > src/utils/sanitizeFilename.js << 'EOF'
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
EOF

echo "Step 3: Running the script to validate changes"
node scripts/fixPromptPathsForWindows.js

if [ $? -eq 0 ]; then
  echo "\033[32mDone: $goal\033[0m\n"
else
  echo "\033[31mError occurred while running the script.\033[0m\n"
  exit 1
fi
