#!/bin/sh
set -e
goal="Fix TypeError by correctly fetching latest git tag"
echo "Plan:"
echo "1. Replace git.latestTag with a correct method to fetch the latest tag."
echo "2. Modify getGitHistory.js with the updated method to fetch the latest git tag."
cat > ./src/git/getGitHistory.js << 'EOF'
import simpleGit from 'simple-git';

const git = simpleGit();

const getGitHistory = async () => {
  try {
    const tags = await git.tags();
    const latestTag = tags.latest;
    const log = await git.log({ to: latestTag });
    return log.all.map(commit => commit.message).join('\n');
  } catch (err) {
    console.error(`An error occurred while fetching git history: ${err}`);
    return "";
  }
}

export default getGitHistory;
EOF
echo "\033[32mDone: $goal\033[0m\n"