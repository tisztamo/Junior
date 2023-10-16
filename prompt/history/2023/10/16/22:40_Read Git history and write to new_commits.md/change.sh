#!/bin/sh
set -e
goal="Read Git history and write to new_commits.md"
echo "Plan:"
echo "1. Create a function to fetch git commit history until the latest tag."
echo "2. Write the fetched comments directly to the specified file within the main script."
echo "3. Ensure the target directory exists and handle any exceptions gracefully."
echo "4. Create a new script to invoke the fetching and writing processes in sequence."

cat > ./src/git/getGitHistory.js << 'EOF'
import simpleGit from 'simple-git';

const git = simpleGit();

const getGitHistory = async () => {
  try {
    const log = await git.log({ to: await git.latestTag() });
    return log.all.map(commit => commit.message).join('\n');
  } catch (err) {
    console.error(`An error occurred while fetching git history: ${err}`);
    return "";
  }
}

export default getGitHistory;
EOF

cat > ./scripts/readGitHistoryToMd.js << 'EOF'
import fs from 'fs/promises';
import path from 'path';
import getGitHistory from '../src/git/getGitHistory.js';

async function executeGitHistoryRead() {
  try {
    const gitHistory = await getGitHistory();
    const filePath = './tmp/new_commits.md';
    const dir = path.dirname(filePath);
    await fs.mkdir(dir, { recursive: true });
    await fs.writeFile(filePath, gitHistory);
  } catch (err) {
    console.error();
  }
}

executeGitHistoryRead();
EOF

echo "\033[32mDone: $goal\033[0m\n"