#!/bin/sh
set -e
goal="Implement /git/repoinfo route"
echo "Plan:"
echo "1. Create getRepoInfo function in src/git which returns the repository info"
echo "2. Create gitRepoInfoHandler in src/backend/handlers/git"
echo "3. Add the new route in src/backend/routes/setupGitRoutes.js"
echo "4. Modify frontend to display the fetched repo info"

# Step 1: Create getRepoInfo function in src/git
cat << EOF > src/git/getRepoInfo.js
import simpleGit from 'simple-git';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const git = simpleGit();
const packagePath = path.resolve(__dirname, '../../../package.json');

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

# Step 2: Create gitRepoInfoHandler in src/backend/handlers/git
cat << EOF > src/backend/handlers/git/gitRepoInfoHandler.js
import getRepoInfo from '../../../git/getRepoInfo.js';

export default async function gitRepoInfoHandler(req, res) {
    try {
        const repoInfo = await getRepoInfo();
        res.status(200).send(repoInfo);
    } catch (error) {
        res.status(500).send({ message: 'Error fetching repo info', error });
    }
}
EOF

# Step 3: Add the new route in src/backend/routes/setupGitRoutes.js
cat << EOF > src/backend/routes/setupGitRoutes.js
import gitStatusHandler from '../handlers/git/gitStatusHandler.js';
import commitGitHandler from '../handlers/git/commitGitHandler.js';
import resetGitHandler from '../handlers/git/resetGitHandler.js';
import gitRepoInfoHandler from '../handlers/git/gitRepoInfoHandler.js';

export function setupGitRoutes(app) {
    app.get('/git/status', gitStatusHandler);
    app.get('/git/repoinfo', gitRepoInfoHandler);
    app.post('/git/reset', resetGitHandler);
    app.post('/git/commit', commitGitHandler);
}
EOF

# Step 4: Modify frontend to display the fetched repo info (assuming we just fetch and display, without styling for simplicity)
cat << EOF > src/frontend/components/RepoInfo.jsx
import { createSignal, onCleanup } from 'solid-js';

const RepoInfo = () => {
    const [repoInfo, setRepoInfo] = createSignal({});

    // Fetch the repo info on component mount and set it to state
    const fetchRepoInfo = async () => {
        const response = await fetch('/git/repoinfo');
        const data = await response.json();
        setRepoInfo(data);
    }

    fetchRepoInfo();

    return (
        <span class="text-sm font-mono bg-gray-200 dark:bg-gray-700 px-1 py-0.5 mt-2 rounded">
            {repoInfo().name} {repoInfo().branch}
        </span>
    );
};

export default RepoInfo;
EOF

echo "\033[32mDone: $goal\033[0m\n"