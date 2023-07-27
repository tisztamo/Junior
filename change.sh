#!/bin/sh
set -e
goal="Refactor prompt.yaml creation and create projectSpecifics.md"
echo "Plan:"
echo "1. Create src/prompt/createPromptYaml.js with its necessary function"
echo "2. Create src/prompt/createProjectSpecifics.js with its necessary function"
echo "3. Refactor src/init.js to use these new functions"

# Step 1: Create src/prompt/createPromptYaml.js
cat << 'EOF' > ./src/prompt/createPromptYaml.js
import { writeFileSync } from 'fs';

export function createPromptYaml() {
  const yamlContent = `task: prompt/task/feature/implement.md
attention:
  - ./
requirements: Create a Hello World in Node.js`;

  writeFileSync('prompt.yaml', yamlContent);
}
EOF

# Step 2: Create src/prompt/createProjectSpecifics.js
cat << 'EOF' > ./src/prompt/createProjectSpecifics.js
import { writeFileSync } from 'fs';

export function createProjectSpecifics() {
  const markdownContent = `## Project Specifics\n`;

  writeFileSync('./prompt/projectSpecifics.md', markdownContent);
}
EOF

# Step 3: Refactor src/init.js to use these new functions
cat << 'EOF' > ./src/init.js
#!/usr/bin/env node
import { execSync } from 'child_process';
import { join } from 'path';
import { createPromptYaml } from './prompt/createPromptYaml.js';
import { createProjectSpecifics } from './prompt/createProjectSpecifics.js';
import { createGitignore } from './git/createGitignore.js';

async function juniorInit() {
  execSync('git init', { stdio: 'inherit' });

  createGitignore();

  execSync('git add .gitignore', { stdio: 'inherit' });
  execSync('git commit -m "Junior init"', { stdio: 'inherit' });

  createPromptYaml();
  createProjectSpecifics();

  console.log('\x1b[32mRepo initialized for Junior development\x1b[0m');
}

juniorInit();
EOF

echo "\033[32mDone: $goal\033[0m\n"
