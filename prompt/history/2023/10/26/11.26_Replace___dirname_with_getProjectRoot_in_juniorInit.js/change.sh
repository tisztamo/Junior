#!/bin/sh
set -e
goal="Replace __dirname with getProjectRoot in juniorInit.js"
echo "Plan:"
echo "1. Import getProjectRoot function into juniorInit.js."
echo "2. Replace the use of __dirname with getProjectRoot for determining the path to the defaults directory."

# Modifying juniorInit.js
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
import getProjectRoot from '../backend/fileutils/getProjectRoot.js';

export async function juniorInit() {
  await checkAndInitRepo();

  if (!await isRepoClean()) {
    console.error("\x1b[31mDirectory is not clean. Please commit or stash changes and try again.\x1b[0m");
    process.exit(1);
  }

  createGitignore();
  await createPromptDir();
  createPromptYaml();

  const projectRoot = getProjectRoot();
  const defaultsPath = path.join(projectRoot, 'prompt/defaults/');
  await copyDefaults(defaultsPath, './prompt/');

  await commitGit("Junior init");

  console.log('\x1b[32mRepo initialized for Junior development\x1b[0m');
}
EOF

echo "\033[32mDone: $goal\033[0m\n"