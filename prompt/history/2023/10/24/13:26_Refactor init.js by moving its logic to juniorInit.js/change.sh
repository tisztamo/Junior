#!/bin/sh
set -e

goal="Refactor init.js by moving its logic to juniorInit.js"
echo "Plan:"
echo "1. Create a new file src/git/juniorInit.js and move init logic from init.js to it."
echo "2. Modify init.js to import and call the function from src/git/juniorInit.js."

# Step 1: Create juniorInit.js and move logic
cat > ./src/git/juniorInit.js << 'EOF'
import { fileURLToPath } from 'url';
import createGitignore from './createGitignore.js';
import { createPromptYaml } from '../prompt/createPromptYaml.js';
import { createPromptDir } from '../prompt/createPromptDir.js';
import copyDefaults from '../command/init/copyDefaults.js';
import checkAndInitRepo from './checkAndInitRepo.js';
import commitGit from './commitGit.js';
import path from 'path';
import isRepoClean from './isRepoClean.js';

const __dirname = path.dirname(fileURLToPath(import.meta.url));

export async function juniorInit() {
  await checkAndInitRepo();

  if (!await isRepoClean()) {
    console.error("\x1b[31mDirectory is not clean. Please commit or stash changes and try again.\x1b[0m");
    process.exit(1);
  }

  createGitignore();
  await createPromptDir();
  createPromptYaml();

  const defaultsPath = path.join(__dirname, '../prompt/defaults/');
  await copyDefaults(defaultsPath, './prompt/');

  await commitGit("Junior init");

  console.log('\x1b[32mRepo initialized for Junior development\x1b[0m');
}
EOF

# Step 2: Modify init.js to import and use the function
cat > ./scripts/init.js << 'EOF'
#!/usr/bin/env node
import { juniorInit } from '../src/git/juniorInit.js';

juniorInit();
EOF

echo "\033[32mDone: $goal\033[0m\n"