#!/bin/sh
set -e
goal="Fix getRepoInfo package.json issue"
echo "Plan:"
echo "1. Modify the way we get the root directory using git.revparse."
echo "2. Modify the path for the package.json using the corrected root directory."
echo "3. Handle the scenario where the file might not be found."

cat <<EOF >src/git/getRepoInfo.js
import simpleGit from 'simple-git';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const git = simpleGit();

export default async function getRepoInfo() {
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
    
    const workingDir = path.resolve(__dirname, '../../');

    return {
        url: remote[0]?.refs?.fetch || '',
        branch: currentBranch,
        name: packageJSON.name || '',
        description: packageJSON.description || '',
        workingDir: workingDir
    };
}
EOF

echo "\033[32mDone: $goal\033[0m\n"