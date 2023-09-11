#!/bin/sh
set -e
goal="Integrate simple-git, fix fileURLToPath issue"
echo "Plan:"
echo "1. Import the necessary fileURLToPath function from the 'url' module in init.js."
echo "2. Rewrite init.js to utilize simple-git for Git operations."
echo "3. Check if the current directory is a git repository."
echo "4. If it's a git repo, validate if the repository is clean."
echo "5. If not clean, abort the process."
echo "6. If not a repo, initialize git, and commit the setup."

# Modify init.js to fix the fileURLToPath issue and utilize simple-git
cat > src/init.js << 'EOF'
#!/usr/bin/env node
import simpleGit from 'simple-git';
import { fileURLToPath } from 'url';
import { createPromptYaml } from './prompt/createPromptYaml.js';
import { createGitignore } from './git/createGitignore.js';
import { createPromptDir } from './prompt/createPromptDir.js';
import copyDefaults from './command/init/copyDefaults.js';
import path from 'path';

const git = simpleGit();

const __dirname = path.dirname(fileURLToPath(import.meta.url));

async function juniorInit() {
  const isRepo = await git.checkIsRepo();

  if (isRepo) {
    const status = await git.status();
    if (!status.isClean()) {
      console.error("\x1b[31mDirectory is not clean. Please commit or stash changes and try again.\x1b[0m");
      process.exit(1);
    }
  } else {
    await git.init();
    await git.add('.');
    await git.commit("Junior init");
  }

  createGitignore();
  await createPromptDir();
  createPromptYaml();

  const defaultsPath = path.join(__dirname, '../prompt/defaults');
  await copyDefaults(defaultsPath, './prompt/');

  console.log('\x1b[32mRepo initialized for Junior development\x1b[0m');
}

juniorInit();

EOF

echo "\033[32mDone: $goal\033[0m\n"