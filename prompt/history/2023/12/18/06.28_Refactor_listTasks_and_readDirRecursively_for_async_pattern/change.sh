#!/bin/sh
set -e
goal="Refactor listTasks and readDirRecursively for async pattern"
echo "Plan:"
echo "1. Refactor readDirRecursively to async function."
echo "2. Modify listTasks to be an async handler with deduplication."

# Refactor readDirRecursively to use async/await
cat > src/backend/fileutils/readDirRecursively.js << EOF
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
EOF

# Modify listTasks to be an async handler and deduplicate the task list
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
        // Ignore error and use empty list for tasksFromRoot
    }

    const cwd = process.cwd();
    const tasksDirCwd = path.join(cwd, 'prompt/task');
    const tasksFromCwd = (await readDirRecursively(tasksDirCwd)).map(file => path.relative(tasksDirCwd, file));

    const deduplicatedTasks = Array.from(new Set([...tasksFromCwd, ...tasksFromRoot]));
    res.json({ tasks: deduplicatedTasks });
};

EOF

# Update the route setup to use the modified listTasks function
cat > src/backend/routes/setupPromptRoutes.js << EOF
import { generateHandler } from '../handlers/generateHandler.js';
import { servePromptDescriptor } from '../handlers/servePromptDescriptor.js';
import { listTasks } from '../handlers/listTasks.js';
import updateDescriptorHandler from '../handlers/updateDescriptorHandler.js';
import { updateTaskHandler } from '../handlers/updateTaskHandler.js';
import { promptstotryHandler } from '../handlers/promptstotryHandler.js';

export function setupPromptRoutes(app) {
  app.get('/descriptor', servePromptDescriptor);
  app.get('/tasks', listTasks);
  app.post('/generate', generateHandler);
  app.post('/descriptor', updateDescriptorHandler);
  app.post('/updatetask', updateTaskHandler);
  app.get('/promptstotry', promptstotryHandler);
}
EOF

echo "\033[32mDone: $goal\033[0m\n"