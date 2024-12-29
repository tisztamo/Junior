#!/bin/sh
set -e
goal="Handle and sanitize file read paths"
echo "Plan:"
echo "1. Create a function in backend/fileutils to sanitize and resolve paths relative to cwd."
echo "2. Integrate the function into the fileReadHandler with correct module path."

# Step 1: Create the path resolver and sanitizer function in backend/fileutils
cat > ./src/backend/fileutils/sanitizeAndResolvePath.js << 'EOF'
import path from 'path';

export function sanitizeAndResolvePath(relativePath) {
  if (typeof relativePath !== 'string') {
    throw new Error('Invalid path provided');
  }
  
  // Normalize the path to resolve '..' and '.' segments
  let normalizedPath = path.normalize(relativePath);
  
  // Avoid any path that tries to go outside the current directory
  if (normalizedPath.startsWith('..') || normalizedPath === '..') {
    throw new Error('Invalid path provided');
  }
  
  return path.join(process.cwd(), normalizedPath);
}
EOF

# Step 2: Integrate the helper function into the fileReadHandler with corrected module path.
cat > ./src/backend/handlers/files/fileReadHandler.js << 'EOF'
import fs from 'fs';
import { promisify } from 'util';
import { sanitizeAndResolvePath } from '../../fileutils/sanitizeAndResolvePath.js';

const readFileAsync = promisify(fs.readFile);

export async function fileReadHandler(req, res) {
  const { filepath } = req.params;

  if (!filepath) {
    return res.status(400).send({ error: 'File path is required' });
  }

  try {
    const resolvedPath = sanitizeAndResolvePath(filepath);
    const fileContent = await readFileAsync(resolvedPath, 'utf8');
    res.send(fileContent);
  } catch (error) {
    res.status(500).send({ error: 'Unable to read file' });
  }
}
EOF

echo "\033[32mDone: $goal\033[0m\n"