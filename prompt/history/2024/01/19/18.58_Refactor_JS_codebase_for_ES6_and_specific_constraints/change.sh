#!/bin/sh
set -e
goal="Refactor JS codebase for ES6 and specific constraints"
echo "Plan:"
echo "1. Ensure each .js file exports only one function or signal."
echo "2. Refactor code to use ES6 imports."
echo "3. Implement async/await in place of promises where applicable."
echo "4. Modify .jsx files for Solidjs and Tailwind compatibility."
echo "5. Adjust error handling to ignore specific errors."

# Updating src/backend/handlers/listTasks.js
# This file will be modified to ensure it complies with the project specifics, especially the error handling part.
cat > src/backend/handlers/listTasks.js << EOF
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
        // Error handling: Ignore error and use empty list for tasksFromRoot
    }

    try {
        const cwd = process.cwd();
        const tasksDirCwd = path.join(cwd, 'prompt/task');
        const tasksFromCwd = (await readDirRecursively(tasksDirCwd)).map(file => path.relative(tasksDirCwd, file));
        const deduplicatedTasks = Array.from(new Set([...tasksFromCwd, ...tasksFromRoot]));
        res.json({ tasks: deduplicatedTasks });
    } catch (error) {
        // Error handling: Ignore error and return only tasks from root
        res.json({ tasks: tasksFromRoot });
    }
};
EOF

echo "\033[32mDone: $goal\033[0m\n"
