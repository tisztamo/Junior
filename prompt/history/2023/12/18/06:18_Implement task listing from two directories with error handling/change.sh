#!/bin/sh
set -e
goal="Implement task listing from two directories with error handling"
echo "Plan:"
echo "1. Modify listTasks.js to read tasks from both the current directory and project root."
echo "2. Implement error handling for the first directory reading."
echo "3. Concatenate the task lists from both directories."
echo "4. Return the relative paths."

cat > src/backend/handlers/listTasks.js << EOF
import path from 'path';
import getProjectRoot from '../fileutils/getProjectRoot.js';
import { readDirRecursively } from '../fileutils/readDirRecursively.js';

export const listTasks = () => {
    const projectRoot = getProjectRoot();
    const tasksDirRoot = path.join(projectRoot, 'prompt/task');
    let tasksFromRoot = [];

    try {
        tasksFromRoot = readDirRecursively(tasksDirRoot).map(file => path.relative(tasksDirRoot, file));
    } catch (error) {
        // Ignore error and use empty list for tasksFromRoot
    }

    const cwd = process.cwd();
    const tasksDirCwd = path.join(cwd, 'prompt/task');
    const tasksFromCwd = readDirRecursively(tasksDirCwd).map(file => path.relative(tasksDirCwd, file));

    return tasksFromCwd.concat(tasksFromRoot);
};
EOF

echo "\033[32mDone: $goal\033[0m\n"