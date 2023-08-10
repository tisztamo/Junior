#!/bin/sh
set -e
goal="Refactor copyDefaults, use fs instead of exec"
echo "Plan:"
echo "1. Create the src/command/init/copyDefaults.js file"
echo "2. Move the defaults copying logic into the new file"
echo "3. Replace the exec usage with nodejs fs for copying"
echo "4. Update the src/init.js to import and use the new function"

# Step 1: Create the src/command/init/copyDefaults.js file
mkdir -p src/command/init
cat << 'EOF' > src/command/init/copyDefaults.js
import fs from 'fs';
import path from 'path';

async function copyDefaults(src, dst) {
  if (!fs.existsSync(dst)) {
    fs.mkdirSync(dst, { recursive: true });
  }

  fs.readdirSync(src).forEach(async (file) => {
    const srcPath = path.join(src, file);
    const dstPath = path.join(dst, file);
    
    if (fs.lstatSync(srcPath).isDirectory()) {
      await copyDefaults(srcPath, dstPath);
    } else {
      fs.copyFileSync(srcPath, dstPath);
    }
  });
}

export default copyDefaults;
EOF

# Step 2 and 3: Moved the logic to new file, replaced exec with fs

# Step 4: Update src/init.js to import and use the new function
cat << 'EOF' > src/init.js
#!/usr/bin/env node
import { execSync } from 'child_process';
import { createPromptYaml } from './prompt/createPromptYaml.js';
import { createGitignore } from './git/createGitignore.js';
import { createPromptDir } from './prompt/createPromptDir.js';
import copyDefaults from './command/init/copyDefaults.js';
import path from 'path';

const __dirname = path.dirname(fileURLToPath(import.meta.url));

async function juniorInit() {
  execSync('git init', { stdio: 'inherit' });

  createGitignore();
  await createPromptDir();
  createPromptYaml();

  // Correcting the path to the prompt/defaults folder in the installed version of Junior
  const defaultsPath = path.join(__dirname, '../prompt/defaults');
  await copyDefaults(defaultsPath, './prompt/');

  execSync('git add .', { stdio: 'inherit' });
  execSync('git commit -m "Junior init"', { stdio: 'inherit' });

  console.log('\x1b[32mRepo initialized for Junior development\x1b[0m');
}

juniorInit();
EOF

echo "\033[32mDone: $goal\033[0m\n"
