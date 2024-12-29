#!/bin/sh
set -e
goal="Fix module import/export discrepancy"
echo "Plan:"
echo "1. Modify the import statement in init.js to use default import."

cat > ./src/init.js << 'EOF'
#!/usr/bin/env node
import { fileURLToPath } from 'url';
import createGitignore from './git/createGitignore.js';
import { createPromptYaml } from './prompt/createPromptYaml.js';
import { createPromptDir } from './prompt/createPromptDir.js';
import copyDefaults from './command/init/copyDefaults.js';
import checkAndInitRepo from './git/checkAndInitRepo.js';
import commitGit from './git/commitGit.js';
import path from 'path';
import isRepoClean from './git/isRepoClean.js';

const __dirname = path.dirname(fileURLToPath(import.meta.url));

async function juniorInit() {
  await checkAndInitRepo();

  if (!await isRepoClean()) {
    console.error("\x1b[31mDirectory is not clean. Please commit or stash changes and try again.\x1b[0m");
    process.exit(1);
  }

  createGitignore();
  await createPromptDir();
  createPromptYaml();

  const defaultsPath = path.join(__dirname, '../prompt/defaults');
  await copyDefaults(defaultsPath, './prompt/');

  await commitGit("Junior init");

  console.log('\x1b[32mRepo initialized for Junior development\x1b[0m');
}

juniorInit();
EOF

echo "\033[32mDone: $goal\033[0m\n"