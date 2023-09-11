#!/bin/sh
set -e
goal="Fix path in getRepoInfo.js"
echo "Plan:"
echo "1. Update the path in getRepoInfo.js to use correct amount of dotdots."

cat <<EOF > src/git/getRepoInfo.js
import simpleGit from 'simple-git';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const git = simpleGit();
const packagePath = path.resolve(__dirname, '../../package.json');

export default async function getRepoInfo() {
    const remote = await git.getRemotes(true);
    const currentBranch = await git.revparse(['--abbrev-ref', 'HEAD']);
    const packageJSON = JSON.parse(fs.readFileSync(packagePath, 'utf8'));

    return {
        url: remote[0]?.refs?.fetch || '',
        branch: currentBranch,
        name: packageJSON.name || '',
        description: packageJSON.description || ''
    };
}
EOF

echo "\033[32mDone: $goal\033[0m\n"