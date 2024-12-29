#!/bin/sh
set -e

goal="Fix Windows path issues in Git repo"
echo "Plan:"
echo "1. Use sanitize-filename library for path sanitization."
echo "2. Update sanitizeFilename.js to leverage the library."
echo "3. Run the fixer script."

echo "Installing sanitize-filename..."
npm install sanitize-filename

echo "Updating sanitizeFilename.js..."
cat > src/utils/sanitizeFilename.js << 'EOF'
import sanitize from 'sanitize-filename';

/**
 * Sanitize a filename or directory name to be safe for Windows paths.
 *
 * @param {string} name - The filename or directory name to sanitize.
 * @returns {string} - The sanitized name.
 */
export function sanitizeFilename(name) {
    if (typeof name !== 'string') {
        throw new TypeError('Filename must be a string');
    }

    // Use the sanitize-filename library to sanitize the filename
    const sanitized = sanitize(name).replace(/\s+/g, '_').replace(/_+/g, '_'); // Optional: Additional cleanup

    return sanitized || '_'; // Ensure non-empty filename
}
EOF

echo "Updating fixPromptPathsForWindows.js..."
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

echo "Running the fixer script..."
node scripts/fixPromptPathsForWindows.js

echo "\033[32mDone: $goal\033[0m\n"
