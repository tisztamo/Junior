#!/bin/sh
set -e
goal="Fix defaults path in init.js"
echo "Plan:"
echo "1. Modify defaultsPath in init.js to the correct relative path."
cat > ./scripts/init.js << 'EOF'
#!/usr/bin/env node
import { fileURLToPath } from 'url';
import createGitignore from '../src/git/createGitignore.js';
import { createPromptYaml } from '../src/prompt/createPromptYaml.js';
import { createPromptDir } from '../src/prompt/createPromptDir.js';
import copyDefaults from '../src/command/init/copyDefaults.js';
import checkAndInitRepo from '../src/git/checkAndInitRepo.js';
import commitGit from '../src/git/commitGit.js';
import path from 'path';
import isRepoClean from '../src/git/isRepoClean.js';

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

  const defaultsPath = path.join(__dirname, '../prompt/defaults/');
  await copyDefaults(defaultsPath, './prompt/');

  await commitGit("Junior init");

  console.log('\x1b[32mRepo initialized for Junior development\x1b[0m');
}

juniorInit();
EOF
echo "\033[32mDone: $goal\033[0m\n"