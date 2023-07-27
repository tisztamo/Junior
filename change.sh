#!/bin/sh
set -e
goal="Refactor .gitignore creation and check duplicates"
echo "Plan:"
echo "1. Create a new file named createGitignore.js in src/git/"
echo "2. Move .gitignore related code to createGitignore.js"
echo "3. Modify .gitignore creation code to only add unique entries"
echo "4. Update the init.js file to import and call the function from createGitignore.js"

# Step 1: Create a new file in src/git/
cat > src/git/createGitignore.js << 'EOF'
import { appendFileSync, writeFileSync, existsSync, readFileSync } from 'fs';
import { join } from 'path';

function createGitignore() {
  const gitignorePath = join(process.cwd(), '.gitignore');
  const ignoreContent = ['prompt.yaml', 'prompt.md', 'change.sh', 'node_modules'];

  let existingIgnores = [];

  if (existsSync(gitignorePath)) {
    const gitignoreFileContent = readFileSync(gitignorePath, 'utf-8');
    existingIgnores = gitignoreFileContent.split('\n');
  }

  ignoreContent.forEach((item) => {
    if (!existingIgnores.includes(item)) {
      appendFileSync(gitignorePath, `\n${item}`);
    }
  });
}

export { createGitignore };
EOF

# Step 2,3,4: Update init.js
cat > src/init.js << 'EOF'
#!/usr/bin/env node
import { execSync } from 'child_process';
import { writeFileSync } from 'fs';
import { join } from 'path';
import { createGitignore } from './git/createGitignore.js';

function juniorInit() {
  execSync('git init', { stdio: 'inherit' });

  createGitignore();

  execSync('git add .gitignore', { stdio: 'inherit' });
  execSync('git commit -m "Junior init"', { stdio: 'inherit' });

  const yamlContent = `task: prompt/task/feature/implement.md
attention:
  - ./
requirements: Create a Hello World in Node.js`;

  writeFileSync('prompt.yaml', yamlContent);

  console.log('\x1b[32mRepo initialized for Junior development\x1b[0m');
}

juniorInit();
EOF

echo "\033[32mDone: $goal\033[0m\n"
