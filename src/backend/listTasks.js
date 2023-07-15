import path from 'path';

import { fileURLToPath } from 'url';
import { dirname } from 'path';

import { readDirRecursively } from './fileutils/readDirRecursively.js';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

export const listTasks = () => {
    const tasksDir = path.join(__dirname, '../../prompt/task');
    return readDirRecursively(tasksDir).map(file => path.relative(tasksDir, file));
};
