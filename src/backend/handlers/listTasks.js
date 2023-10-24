import path from 'path';
import getProjectRoot from '../fileutils/getProjectRoot.js';
import { readDirRecursively } from '../fileutils/readDirRecursively.js';

export const listTasks = () => {
    const projectRoot = getProjectRoot();
    const tasksDir = path.join(projectRoot, 'prompt/task');
    return readDirRecursively(tasksDir).map(file => path.relative(tasksDir, file));
};
