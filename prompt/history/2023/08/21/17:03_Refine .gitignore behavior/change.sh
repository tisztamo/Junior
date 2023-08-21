#!/bin/sh
set -e
goal="Refine .gitignore behavior"
echo "Plan:"
echo "1. Update createGitignore.js to only gitignore prompt files and change.sh in the root folder"
echo "2. Use heredoc to overwrite the content of createGitignore.js with the refined behavior"

cat > src/git/createGitignore.js << 'EOF'
import { appendFileSync, existsSync, readFileSync } from 'fs';
import { join } from 'path';

function createGitignore() {
  const gitignorePath = join(process.cwd(), '.gitignore');
  const ignoreContent = ['/prompt.yaml', '/prompt.md', '/change.sh', 'node_modules'];

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

echo "\033[32mDone: $goal\033[0m\n"