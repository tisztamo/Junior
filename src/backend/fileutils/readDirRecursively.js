import fs from 'fs';
import path from 'path';

export const readDirRecursively = (dir) => {
    const files = [];

    fs.readdirSync(dir).forEach(file => {
        const filePath = path.join(dir, file);

        if (fs.statSync(filePath).isDirectory()) {
            files.push(...readDirRecursively(filePath));
        } else {
            files.push(filePath);
        }
    });

    return files;
};
