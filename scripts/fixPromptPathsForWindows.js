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
