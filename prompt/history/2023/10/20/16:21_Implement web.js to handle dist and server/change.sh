#!/bin/sh
set -e
goal="Implement web.js to handle dist and server"
echo "Plan:"
echo "1. Create a new file named 'web.js'"
echo "2. Implement a function to check the existence of 'dist/' directory"
echo "3. If 'dist/' does not exist, log a message and run 'npm run build'"
echo "4. Start the backend server without starting Vite"

# Creating the web.js file
cat > ./scripts/web.js << 'EOF'
import fs from 'fs';
import { execSync } from 'child_process';
import { startServer } from '../src/backend/startServer.js';

async function main() {
    // Check for dist/ directory
    if (!fs.existsSync('./dist')) {
        console.log('Note: dist/ directory does not exist. Running npm run build...');
        execSync('npm run build', { stdio: 'inherit' });
    }

    // Start the server
    startServer();
}

main();
EOF

echo "\033[32mDone: $goal\033[0m\n"