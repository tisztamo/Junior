import fs from 'fs';
import path from 'path';

import { fileURLToPath } from 'url';
import { dirname } from 'path';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

function readDirRecursively(dir) {
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
}

export const listTasks = () => {
    const tasksDir = path.join(__dirname, '../../prompt/task');
    return readDirRecursively(tasksDir).map(file => path.relative(tasksDir, file));
};
