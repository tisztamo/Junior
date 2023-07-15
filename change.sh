#!/bin/sh
# Goal: Split a file into parts to enhance manageability
# Plan:
# 1. Identify the reusable functions in the original file.
# 2. Create the necessary directory for the new file.
# 3. Create a new file for the reusable function.
# 4. Write the function in the new file.
# 5. Import the function in the original file and use it.

# Create necessary directory if it doesn't exist
mkdir -p ./src/backend/fileutils

cat > ./src/backend/fileutils/readDirRecursively.js << 'EOF'
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
EOF

cat > ./src/backend/listTasks.js << 'EOF'
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
EOF

echo "Code has been refactored successfully."
