#!/bin/sh
set -e
goal="Implement RepoInfo feature enhancements"
echo "Plan:"
echo "1. Modify getRepoInfo.js to also return the current working directory."
echo "2. Update RepoInfo.jsx to handle click event that toggles detailed information view."
echo "3. Implement the detailed view for RepoInfo component, displaying working dir and other info with labels."
echo "4. Add cursor style to signify clickability on the RepoInfo component."

# Step 1: Modify getRepoInfo.js to also return the current working directory
cat > src/git/getRepoInfo.js <<EOF
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

# Step 2: Update RepoInfo.jsx to handle click event that toggles detailed information view
# Step 3: Implement the detailed view for RepoInfo component, displaying working dir and other info with labels
# Step 4: Add cursor style to signify clickability on the RepoInfo component
cat > src/frontend/components/RepoInfo.jsx <<EOF
import { createSignal, onCleanup } from 'solid-js';
import fetchRepoInfo from '../service/fetchers/fetchRepoInfo';

const RepoInfo = () => {
    const [repoInfo, setRepoInfo] = createSignal({});
    const [expanded, setExpanded] = createSignal(false);

    // Fetch the repo info on component mount and set it to state
    const fetchAndSetRepoInfo = async () => {
        const data = await fetchRepoInfo();
        setRepoInfo(data);
    }

    fetchAndSetRepoInfo();

    const toggleExpand = () => {
        setExpanded(!expanded());
    }

    return (
        <span 
            class="text-sm font-mono bg-gray-200 dark:bg-gray-700 px-1 py-0.5 mt-2 rounded cursor-pointer" 
            onClick={toggleExpand}
        >
            {expanded() ? (
                <>
                    <div>Working Dir: {repoInfo().workingDir}</div>
                    <div>URL: {repoInfo().url}</div>
                    <div>Branch: {repoInfo().branch}</div>
                    <div>Name: {repoInfo().name}</div>
                    <div>Description: {repoInfo().description}</div>
                </>
            ) : (
                <>
                    {repoInfo().name} {repoInfo().branch}
                </>
            )}
        </span>
    );
};

export default RepoInfo;
EOF

echo "\033[32mDone: $goal\033[0m\n"