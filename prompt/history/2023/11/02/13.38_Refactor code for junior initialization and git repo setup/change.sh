#!/bin/sh
set -e
goal="Refactor code for junior initialization and git repo setup"
echo "Plan:"
echo "1. Update initRepo.js to include console log with yellow text for 'Initializing git repo'"
echo "2. Reword the warning in prepareDirForJunior.js"
echo "3. Test the changes"

# Updating initRepo.js
cat > ./src/git/initRepo.js << 'EOF'
import simpleGit from 'simple-git';

const git = simpleGit();

export default async function initRepo() {
    console.warn('\x1b[33mInitializing git repo\x1b[0m');
    await git.init();
}
EOF
echo "Updated initRepo.js"

# Updating prepareDirForJunior.js
cat > ./src/prompt/prepareDirForJunior.js << 'EOF'
import fs from 'fs';
import path from 'path';
import { createPromptYaml } from './createPromptYaml.js';
import { juniorInit } from '../git/juniorInit.js';

export async function prepareDirForJunior() {
  const promptDir = path.join(process.cwd(), 'prompt');

  if (!fs.existsSync(promptDir)) {
    console.warn('\x1b[33mWarning: Initializing Junior...\x1b[0m');
    await juniorInit();
  } else {
    const promptYaml = path.join(promptDir, 'prompt.yaml');
    if (!fs.existsSync(promptYaml)) {
      createPromptYaml();
    }
  }
}
EOF
echo "Updated prepareDirForJunior.js"

echo "\033[32mDone: $goal\033[0m\n"