#!/bin/sh
set -e
goal="Fix ReferenceError in web.js by importing path module"
echo "Plan:"
echo "1. Update web.js to import the path module."

cat > ./bin/web.js << 'EOF'
#!/usr/bin/env node

import fs from 'fs';
import path from 'path';
import { execSync } from 'child_process';
import getProjectRoot from '../src/backend/fileutils/getProjectRoot.js';

async function main() {
    // Determine the project root based on the getProjectRoot function
    const projectRoot = getProjectRoot();

    // Check for dist/ directory
    const distDir = path.join(projectRoot, 'dist');
    if (!fs.existsSync(distDir)) {
        console.log('Note: dist/ directory does not exist. Running npm run build...');
        execSync('npm run build', { stdio: 'inherit', cwd: projectRoot });
    }

    // Dynamically import startServer from dist/backend/startServer.js
    const { startServer } = await import(path.join(distDir, 'backend/startServer.js'));
    startServer();
}

main();
EOF

echo "\033[32mDone: $goal\033[0m\n"
