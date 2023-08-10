#!/bin/sh
set -e
goal="Fix junior-init to correctly locate prompt files"
echo "Plan:"
echo "1. Change the path in execSync to include the correct location of prompt/defaults in the installed version of Junior."
echo "2. Update the src/init.js file with the new changes."

cat > ./src/init.js << 'EOF'
#!/usr/bin/env node
import { execSync } from 'child_process';
import { createPromptYaml } from './prompt/createPromptYaml.js';
import { createGitignore } from './git/createGitignore.js';
import { createPromptDir } from './prompt/createPromptDir.js';
import { fileURLToPath } from 'url';
import path from 'path';

const __dirname = path.dirname(fileURLToPath(import.meta.url));

async function juniorInit() {
  execSync('git init', { stdio: 'inherit' });

  createGitignore();
  await createPromptDir();
  createPromptYaml();

  // Correcting the path to the prompt/defaults folder in the installed version of Junior
  const defaultsPath = path.join(__dirname, '../prompt/defaults');
  execSync(`cp -r ${defaultsPath}/* ./prompt/`, { stdio: 'inherit' });

  execSync('git add .', { stdio: 'inherit' });
  execSync('git commit -m "Junior init"', { stdio: 'inherit' });

  console.log('\x1b[32mRepo initialized for Junior development\x1b[0m');
}

juniorInit();
EOF

echo "\033[32mDone: $goal\033[0m\n"
