#!/bin/sh
set -e
goal="Implement git diff route with colorized HTML output"
echo "Plan:"
echo "1. Install Diff2Html using npm."
echo "2. Create the handler for the git diff request in the backend."
echo "3. Integrate the new handler into the existing route setup."
echo "4. Adjust the git functions to use Diff2Html to get a colorized word diff in HTML."

npm install diff2html

cat > ./src/git/gitDiff.js << 'EOF'
import simpleGit from 'simple-git';
import { parse } from 'diff2html';

const git = simpleGit();

const gitDiff = async () => {
  try {
    const diff = await git.diff(['--word-diff=color']);
    const htmlOutput = parse(diff);
    return htmlOutput;
  } catch (error) {
    console.error();
    throw error;
  }
}

export default gitDiff;
EOF

cat > ./src/backend/handlers/git/gitDiffHandler.js << 'EOF'
import gitDiff from '../../../git/gitDiff.js';

export default async function gitDiffHandler(req, res) {
  try {
    const diff = await gitDiff();
    res.status(200).send({ data: diff });
  } catch (error) {
    let errorMessage = 'Error in getting Git diff';
    res.status(500).send({ message: errorMessage, error });
  }
}
EOF

cat > ./src/backend/routes/setupGitRoutes.js << 'EOF'
import gitStatusHandler from '../handlers/git/gitStatusHandler.js';
import commitGitHandler from '../handlers/git/commitGitHandler.js';
import resetGitHandler from '../handlers/git/resetGitHandler.js';
import gitRepoInfoHandler from '../handlers/git/gitRepoInfoHandler.js';
import gitDiffHandler from '../handlers/git/gitDiffHandler.js';

export function setupGitRoutes(app) {
    app.get('/git/status', gitStatusHandler);
    app.get('/git/repoinfo', gitRepoInfoHandler);
    app.get('/git/diff', gitDiffHandler);
    app.post('/git/reset', resetGitHandler);
    app.post('/git/commit', commitGitHandler);
}
EOF

echo "\033[32mDone: $goal\033[0m\n"