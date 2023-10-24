#!/bin/sh
set -e
goal="Adjust static route setup considering filename in path"
echo "Plan:"
echo "1. Modify setupStaticRoutes.js to adjust the path by removing the filename and then determine the projectRoot"

cat > ./src/backend/routes/setupStaticRoutes.js << 'EOF'
import path from 'path';
import express from 'express';

export function setupStaticRoutes(app) {
    const currentFilePath = new URL(import.meta.url).pathname;
    const currentDirPath = path.dirname(currentFilePath);

    let levelsUp = currentFilePath.includes('dist/backend/') ? 2 : 4;
    const projectRoot = path.resolve(currentDirPath, ...Array(levelsUp).fill('..'));
    const frontendDistPath = path.join(projectRoot, 'dist', 'frontend');
    app.use('/', express.static(frontendDistPath));
}

EOF

echo "\033[32mDone: $goal\033[0m\n"