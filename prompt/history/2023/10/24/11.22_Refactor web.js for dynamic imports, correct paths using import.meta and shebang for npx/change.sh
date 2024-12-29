#!/bin/sh
set -e
goal="Refactor web.js for dynamic imports, correct paths using import.meta and shebang for npx"
echo "Plan:"
echo "1. Add a shebang for npx execution."
echo "2. Modify web.js to use paths relative to project root using import.meta."
echo "3. Adjust project root to be one level up from the script's directory."
echo "4. Dynamically import startServer from dist/backend/startServer.js."

cat > ./scripts/web.js << 'EOF'
#!/usr/bin/env node

import fs from 'fs';
import { execSync } from 'child_process';
import path from 'path';

async function main() {
    // Determine the project root based on the current script location using import.meta
    const scriptDir = path.dirname(import.meta.url).replace('file://', '');
    const projectRoot = path.join(scriptDir, '..');

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