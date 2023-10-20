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
