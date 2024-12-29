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
