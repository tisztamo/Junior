#!/bin/sh
set -e
goal="Implement synchronous getProjectRoot and update static routes"
echo "Plan:"
echo "1. Modify getProjectRoot.js to use synchronous filesystem functions and ensure it is synchronous."
echo "2. Update setupStaticRoutes.js to use the modified synchronous getProjectRoot function."

# Create the modified file `getProjectRoot.js` with the function to get the project root.
cat > ./src/backend/fileutils/getProjectRoot.js << 'EOF'
import path from 'path';
import fs from 'fs';

let memoizedRoot = null;

function getProjectRoot() {
    if (memoizedRoot) {
        return memoizedRoot;
    }

    let currentDir = path.dirname(new URL(import.meta.url).pathname);
    
    while (currentDir !== path.parse(currentDir).root) {
        if (fs.existsSync(path.join(currentDir, 'package.json'))) {
            memoizedRoot = currentDir;
            return memoizedRoot;
        }
        currentDir = path.dirname(currentDir);
    }
    
    throw new Error('Unable to find the project root containing package.json');
}

export default getProjectRoot;
EOF

# Update `setupStaticRoutes.js` to use the new synchronous `getProjectRoot` function.
cat > ./src/backend/routes/setupStaticRoutes.js << 'EOF'
import path from 'path';
import express from 'express';
import getProjectRoot from '../fileutils/getProjectRoot';

export function setupStaticRoutes(app) {
    const projectRoot = getProjectRoot();
    const frontendDistPath = path.join(projectRoot, 'dist', 'frontend');
    app.use('/', express.static(frontendDistPath));
}
EOF

echo "\033[32mDone: $goal\033[0m\n"