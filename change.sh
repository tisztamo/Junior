#!/bin/sh
# Goal: Move files to handlers directory without breaking dependencies
# Plan:
# 1. Move all the files except setupRoutes.js to the handlers directory.
# 2. Update the import paths in setupRoutes.js to reflect the new locations of the moved files.
# 3. Update the import paths in the moved files to reflect their new locations and maintain their dependencies.

# Step 1: Move files
mv src/backend/servePromptDescriptor.js src/backend/handlers/
mv src/backend/updateTaskHandler.js src/backend/handlers/
mv src/backend/listTasks.js src/backend/handlers/

# Step 2: Update import paths in setupRoutes.js
cat << EOF > src/backend/setupRoutes.js
import { generateHandler } from './handlers/generateHandler.js';
import { servePromptDescriptor } from './handlers/servePromptDescriptor.js';
import { updateTaskHandler } from './handlers/updateTaskHandler.js';
import { listTasks } from './handlers/listTasks.js';

export function setupRoutes(app) {
  app.get('/descriptor', servePromptDescriptor);
  app.get('/tasks', (req, res) => res.json({ tasks: listTasks() }));

  app.post('/generate', generateHandler);
  app.post('/updatetask', updateTaskHandler);
}
EOF

# Step 3: Update import paths in moved files

# servePromptDescriptor.js
cat << EOF > src/backend/handlers/servePromptDescriptor.js
import { readFile } from 'fs/promises';
import path from 'path';

import { fileURLToPath } from 'url';
import { dirname } from 'path';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

export const servePromptDescriptor = async (req, res) => {
  const file = await readFile(path.resolve(__dirname, '../../../prompt.yaml'), 'utf-8');
  res.send(file);
};
EOF

# updateTaskHandler.js
cat << EOF > src/backend/handlers/updateTaskHandler.js
import { readFile, writeFile } from 'fs/promises';
import path from 'path';
import yaml from 'js-yaml';

import { fileURLToPath } from 'url';
import { dirname } from 'path';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

export const updateTaskHandler = async (req, res) => {
  const task = req.body.task;
  const filePath = path.resolve(__dirname, '../../../prompt.yaml');

  try {
    const fileContent = await readFile(filePath, 'utf-8');
    const document = yaml.load(fileContent);

    // assuming 'task' is a field in the yaml document
    document.task = path.join("prompt", "task", task);

    const newYamlStr = yaml.dump(document);
    await writeFile(filePath, newYamlStr, 'utf-8');
    
    res.status(200).json({ message: "Task updated successfully" });
  } catch (error) {
    console.log(error);
    res.status(500).json({ message: "Internal server error" });
  }
};
EOF

# listTasks.js
cat << EOF > src/backend/handlers/listTasks.js
import path from 'path';

import { fileURLToPath } from 'url';
import { dirname } from 'path';

import { readDirRecursively } from '../fileutils/readDirRecursively.js';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

export const listTasks = () => {
    const tasksDir = path.join(__dirname, '../../../prompt/task');
    return readDirRecursively(tasksDir).map(file => path.relative(tasksDir, file));
};
EOF
