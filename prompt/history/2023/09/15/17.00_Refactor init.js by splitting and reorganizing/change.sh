#!/bin/sh
set -e
goal="Refactor init.js by splitting and reorganizing"
echo "Plan:"
echo "1. Create isRepo.js in the git directory."
echo "2. Create getStatus.js in the git directory."
echo "3. Create initRepo.js in the git directory."
echo "4. Update commitGit.js to only commit with given message."
echo "5. Refactor init.js to utilize these new modules."

# Create isRepo.js in the git directory
cat > ./src/git/isRepo.js << 'EOF'
import simpleGit from 'simple-git';

const git = simpleGit();

export default async function isRepo() {
    return await git.checkIsRepo();
}
EOF

# Create getStatus.js in the git directory
cat > ./src/git/getStatus.js << 'EOF'
import simpleGit from 'simple-git';

const git = simpleGit();

export default async function getStatus() {
    return await git.status();
}
EOF

# Create initRepo.js in the git directory
cat > ./src/git/initRepo.js << 'EOF'
import simpleGit from 'simple-git';

const git = simpleGit();

export default async function initRepo() {
    await git.init();
}
EOF

# Update commitGit.js to only commit with given message
cat > ./src/git/commitGit.js << 'EOF'
import simpleGit from 'simple-git';

const git = simpleGit();

export default async function commitGit(message) {
    await git.add('.');
    await git.commit(message);
    console.log(`Committed with message: ${message}`);
}
EOF

# Refactor init.js
cat > ./src/init.js << 'EOF'
#!/usr/bin/env node
import { fileURLToPath } from 'url';
import { createPromptYaml } from './prompt/createPromptYaml.js';
import { createGitignore } from './git/createGitignore.js';
import { createPromptDir } from './prompt/createPromptDir.js';
import copyDefaults from './command/init/copyDefaults.js';
import isRepo from './git/isRepo.js';
import getStatus from './git/getStatus.js';
import initRepo from './git/initRepo.js';
import commitGit from './git/commitGit.js';
import path from 'path';

const __dirname = path.dirname(fileURLToPath(import.meta.url));

async function juniorInit() {
  const repoExists = await isRepo();

  if (repoExists) {
    const status = await getStatus();
    if (!status.isClean()) {
      console.error("\x1b[31mDirectory is not clean. Please commit or stash changes and try again.\x1b[0m");
      process.exit(1);
    }
  } else {
    await initRepo();
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