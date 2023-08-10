#!/bin/sh
set -e
goal="Create prompt/defaults dir, copy files on init"
echo "Plan:"
echo "1. Create prompt/defaults directory."
echo "2. Modify src/init.js to recursively copy files from prompt/defaults to newly created repo."
echo "3. Remove createProjectSpecifics from src/prompt/createProjectSpecifics.js and src/init.js."
echo "4. Add necessary files to the prompt/defaults directory."

# Step 1: Create prompt/defaults directory.
mkdir -p ./prompt/defaults

# Step 2: Modify src/init.js to recursively copy files from prompt/defaults.
cat << 'EOF' > ./src/init.js
#!/usr/bin/env node
import { execSync } from 'child_process';
import { createPromptYaml } from './prompt/createPromptYaml.js';
import { createGitignore } from './git/createGitignore.js';
import { createPromptDir } from './prompt/createPromptDir.js';

async function juniorInit() {
  execSync('git init', { stdio: 'inherit' });

  createGitignore();
  await createPromptDir();
  createPromptYaml();

  // Copying all files from prompt/defaults to the new repo
  execSync('cp -r ./prompt/defaults/* ./prompt/', { stdio: 'inherit' });

  execSync('git add .', { stdio: 'inherit' });
  execSync('git commit -m "Junior init"', { stdio: 'inherit' });

  console.log('\x1b[32mRepo initialized for Junior development\x1b[0m');
}

juniorInit();
EOF

# Step 3: Remove createProjectSpecifics.js file as it's no longer required.
rm ./src/prompt/createProjectSpecifics.js

# Step 4: Add necessary files to the prompt/defaults directory if needed.
# This step would typically involve copying the required files or creating them as needed in the prompt/defaults directory.

echo "\033[32mDone: $goal\033[0m\n"