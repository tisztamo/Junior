#!/usr/bin/env node

import fs from 'fs';
import path from 'path';
import { execSync } from 'child_process';
import { prepareDirForJunior } from '../src/prompt/prepareDirForJunior.js';
import getProjectRoot from '../src/backend/fileutils/getProjectRoot.js';

async function main() {
    // Prepare the directory for Junior
    await prepareDirForJunior();

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
