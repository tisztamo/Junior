import fs from 'fs/promises';
import path from 'path';

export const readDirRecursively = async (dir) => {
    const files = [];
    const items = await fs.readdir(dir, { withFileTypes: true });

    for (const item of items) {
        const filePath = path.join(dir, item.name);
        if (item.isDirectory()) {
            files.push(...(await readDirRecursively(filePath)));
        } else {
            files.push(filePath);
        }
    }
    return files;
};
