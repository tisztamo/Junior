import path from 'path';
import getProjectRoot from '../fileutils/getProjectRoot.js';
import { readDirRecursively } from '../fileutils/readDirRecursively.js';

export const listTasks = async (req, res) => {
    const projectRoot = getProjectRoot();
    const tasksDirRoot = path.join(projectRoot, 'prompt/task');
    let tasksFromRoot = [];

    try {
        tasksFromRoot = (await readDirRecursively(tasksDirRoot)).map(file => path.relative(tasksDirRoot, file));
    } catch (error) {
        // Ignore error and use empty list for tasksFromRoot
    }

    const cwd = process.cwd();
    const tasksDirCwd = path.join(cwd, 'prompt/task');
    const tasksFromCwd = (await readDirRecursively(tasksDirCwd)).map(file => path.relative(tasksDirCwd, file));

    const deduplicatedTasks = Array.from(new Set([...tasksFromCwd, ...tasksFromRoot]));
    res.json({ tasks: deduplicatedTasks });
};

