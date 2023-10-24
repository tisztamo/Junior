#!/bin/sh
set -e
goal="Refactor to add .js in import path of getProjectRoot"
echo "Plan:"
echo "1. Change the import path of getProjectRoot to include .js extension"

cat > ./src/backend/routes/setupStaticRoutes.js << 'EOF'
import path from 'path';
import express from 'express';
import getProjectRoot from '../fileutils/getProjectRoot.js';

export function setupStaticRoutes(app) {
    const projectRoot = getProjectRoot();
    const frontendDistPath = path.join(projectRoot, 'dist', 'frontend');
    app.use('/', express.static(frontendDistPath));
}
EOF

echo "\033[32mDone: $goal\033[0m\n"