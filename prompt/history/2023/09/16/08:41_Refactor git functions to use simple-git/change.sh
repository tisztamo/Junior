#!/bin/sh
set -e
goal="Refactor git functions to use simple-git"
echo "Plan:"
echo "1. Rewrite src/git/createGitignore.js to use ES6 import, default export, and improve readability."
echo "2. Rewrite src/git/getRepoInfo.js to use ES6 import, default export, and replace direct git execution with simple-git."
echo "3. Rewrite src/git/gitStatus.js to replace direct git execution with simple-git."
echo "4. Rewrite src/git/resetGit.js to replace direct git execution with simple-git."

# 1. src/git/createGitignore.js
cat > src/git/createGitignore.js << 'EOF'
import { appendFileSync, existsSync, readFileSync } from 'fs';
import { join } from 'path';

const createGitignore = () => {
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

export default createGitignore;
EOF

# 2. src/git/getRepoInfo.js
cat > src/git/getRepoInfo.js << 'EOF'
import simpleGit from 'simple-git';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const git = simpleGit();

const getRepoInfo = async () => {
    const remote = await git.getRemotes(true);
    const currentBranch = await git.revparse(['--abbrev-ref', 'HEAD']);
    const rootDir = await git.revparse(['--show-toplevel']);
    const packagePath = path.resolve(rootDir, 'package.json');

    let packageJSON = {};
    try {
        packageJSON = JSON.parse(fs.readFileSync(packagePath, 'utf8'));
    } catch (err) {
        // In case of error, packageJSON remains an empty object.
    }
    
    const tags = await git.tags();
    const workingDir = path.resolve(__dirname, '../../');

    return {
        url: remote[0]?.refs?.fetch || '',
        branch: currentBranch,
        name: packageJSON.name || '',
        description: packageJSON.description || '',
        tags: tags.all,
        workingDir: workingDir
    };
}

export default getRepoInfo;
EOF

# 3. src/git/gitStatus.js
cat > src/git/gitStatus.js << 'EOF'
import simpleGit from 'simple-git';

const git = simpleGit();

const gitStatus = async () => {
  try {
    const status = await git.status();
    return status;
  } catch (error) {
    console.error();
    throw error;
  }
}

export default gitStatus;
EOF

# 4. src/git/resetGit.js
cat > src/git/resetGit.js << 'EOF'
import simpleGit from 'simple-git';

const git = simpleGit();

const resetGit = async () => {
  try {
    console.log("Running command: git clean -f -d");
    await git.clean('f', ['-d']);
    console.log("Running command: git reset --hard");
    await git.reset('hard');
  } catch (err) {
    console.error(`An error occurred: ${err}`);
  }
}

export default resetGit;
EOF

echo "\033[32mDone: $goal\033[0m\n"