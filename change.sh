#!/bin/sh
set -e
goal="Create prompt directory and commit it"
echo "Plan:"
echo "1. Create a new function called 'createPromptDir' in a new file 'src/prompt/createPromptDir.js'"
echo "2. The function will check if the 'prompt' directory exists, and if not, create it."
echo "3. Rewrite 'src/init.js' using heredoc, to include the import and use of 'createPromptDir' function, also adjusting the final commit command to include the 'prompt' directory."
echo "4. The creation of the 'prompt' directory and its commit to git will be included at the end of 'src/init.js'."

# Step 1: Create 'createPromptDir.js'
cat << 'EOF' > src/prompt/createPromptDir.js
import { existsSync, mkdirSync } from 'fs';

export async function createPromptDir() {
  if (!existsSync('./prompt')) {
    mkdirSync('./prompt');
  }
}
EOF

# Step 3: Rewrite 'init.js' to import and use 'createPromptDir', also commit all changes at the end
cat << 'EOF' > src/init.js
#!/usr/bin/env node
import { execSync } from 'child_process';
import { join } from 'path';
import { createPromptYaml } from './prompt/createPromptYaml.js';
import { createProjectSpecifics } from './prompt/createProjectSpecifics.js';
import { createGitignore } from './git/createGitignore.js';
import { createPromptDir } from './prompt/createPromptDir.js';

async function juniorInit() {
  execSync('git init', { stdio: 'inherit' });

  createGitignore();
  await createPromptDir();
  createPromptYaml();
  createProjectSpecifics();

  execSync('git add .', { stdio: 'inherit' });
  execSync('git commit -m "Junior init"', { stdio: 'inherit' });

  console.log('\x1b[32mRepo initialized for Junior development\x1b[0m');
}

juniorInit();
EOF

echo "\033[32mDone: $goal\033[0m\n"
