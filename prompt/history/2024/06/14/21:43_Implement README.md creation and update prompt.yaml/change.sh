#!/bin/sh
set -e
goal="Implement README.md creation and update prompt.yaml"
echo "Plan:"
echo "1. Update createPromptYaml.js to refer to README.md"
echo "2. Create createReadme.js to generate README.md"
echo "3. Update juniorInit.js to call createReadme"
echo "4. Generate and run this shell script to apply changes"

# Update createPromptYaml.js to refer to README.md
cat > src/prompt/createPromptYaml.js << 'EOF'
import { writeFileSync } from 'fs';

export function createPromptYaml() {
  const yamlContent = `task: prompt/task/feature/implement.md
attention:
  - ./README.md
requirements: |
  1. Create the src/ dir
  2. Create src/main.js with a Hello World in Node.js
  3. Update package.json to enable running it
  4. Print instructions on how to run it`;

  writeFileSync('prompt.yaml', yamlContent);
}
EOF

# Create createReadme.js to generate README.md
mkdir -p src/prompt
cat > src/prompt/createReadme.js << 'EOF'
import { writeFileSync } from 'fs';

export function createReadme() {
  const readmeContent = 'Project initialized with Junior';
  writeFileSync('README.md', readmeContent);
}
EOF

# Update juniorInit.js to call createReadme
cat > src/git/juniorInit.js << 'EOF'
import { fileURLToPath } from 'url';
import createGitignore from './createGitignore.js';
import { createPromptYaml } from '../prompt/createPromptYaml.js';
import { createPromptDir } from '../prompt/createPromptDir.js';
import copyDefaults from '../command/init/copyDefaults.js';
import checkAndInitRepo from './checkAndInitRepo.js';
import commitGit from './commitGit.js';
import path from 'path';
import isRepoClean from './isRepoClean.js';
import getProjectRoot from '../backend/fileutils/getProjectRoot.js';
import { createReadme } from '../prompt/createReadme.js';

export async function juniorInit() {
  await checkAndInitRepo();

  if (!await isRepoClean()) {
    console.error("\x1b[31mDirectory is not clean. Please commit or stash changes and try again.\x1b[0m");
    process.exit(1);
  }

  createGitignore();
  await createPromptDir();
  createPromptYaml();
  createReadme();

  const projectRoot = getProjectRoot();
  const defaultsPath = path.join(projectRoot, 'prompt/defaults/');
  await copyDefaults(defaultsPath, './prompt/');

  await commitGit("Junior init");

  console.log('\x1b[32mRepo initialized for Junior development\x1b[0m');
}
EOF

echo "\033[32mDone: $goal\033[0m\n"