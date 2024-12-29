#!/bin/sh
set -e
goal="Setup prompt dir for Junior"
echo "Plan:"
echo "1. Create src/prompt/prepareDirForJunior.js"
echo "2. Update ./bin/web.js to use prepareDirForJunior"

# Create src/prompt/prepareDirForJunior.js
cat > src/prompt/prepareDirForJunior.js << EOF
import fs from 'fs';
import path from 'path';
import { createPromptYaml } from './createPromptYaml.js';
import { juniorInit } from '../git/juniorInit.js';

export async function prepareDirForJunior() {
  const promptDir = path.join(process.cwd(), 'prompt');

  if (!fs.existsSync(promptDir)) {
    console.warn('\x1b[33mWarning: prompt/ directory does not exist. Initializing Junior...\x1b[0m');
    await juniorInit();
  } else {
    const promptYaml = path.join(promptDir, 'prompt.yaml');
    if (!fs.existsSync(promptYaml)) {
      createPromptYaml();
    }
  }
}
EOF
echo "✓ Created src/prompt/prepareDirForJunior.js"

# Update ./bin/web.js to use prepareDirForJunior
cat > ./bin/web.js << EOF
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
EOF
echo "✓ Updated ./bin/web.js to use prepareDirForJunior"

echo "\033[32mDone: $goal\033[0m\n"