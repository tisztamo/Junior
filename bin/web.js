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

