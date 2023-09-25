#!/bin/sh
set -e
goal="Fix workingDir in getRepoInfo.js"
echo "Plan:"
echo "1. Modify getRepoInfo.js to use process.cwd() for the workingDir."
cat > ./src/git/getRepoInfo.js << 'EOF'
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
    const workingDir = process.cwd();  // Fixed the working directory to use the current working directory

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
echo "\033[32mDone: $goal\033[0m\n"