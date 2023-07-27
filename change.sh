#!/bin/sh
set -e
goal="Simplify GitStatusDisplay and gitStatusHandler logic"
echo "Plan:"
echo "1. Update gitStatusHandler.js to send git status in 'message' field instead of 'status'"
echo "2. Update gitStatusHandler.js to send specific error message when stderr includes 'Not a git repository'"
echo "3. Update GitStatusDisplay.jsx to simply display the message, and if an error exists, error.stderr"

cat > ./src/backend/handlers/gitStatusHandler.js << 'EOF'
import gitStatus from '../../git/gitStatus.js';

export default async function gitStatusHandler(req, res) {
  try {
    const status = await gitStatus();
    res.status(200).send({ message: status });
  } catch (error) {
    let errorMessage = 'Error in getting Git status';
    if (error.stderr && error.stderr.includes('Not a git repository')) {
      errorMessage = 'Not a git repo. Run \'npx junior-init\' to initialize!';
    }
    res.status(500).send({ message: errorMessage, error });
  }
}
EOF

cat > ./src/frontend/components/GitStatusDisplay.jsx << 'EOF'
import { onMount, createEffect } from 'solid-js';
import { gitStatus } from '../stores/gitStatus';
import { fetchGitStatus } from '../service/fetchGitStatus';

const GitStatusDisplay = () => {
  let statusContainer;

  onMount(fetchGitStatus);

  createEffect(() => {
    const gitStatusValue = gitStatus();
    if (gitStatusValue) {
      if (gitStatusValue.error) {
        statusContainer.innerText = `${gitStatusValue.message}\n${gitStatusValue.error.stderr}`;
      } else if (gitStatusValue.message && gitStatusValue.message !== '') {
        statusContainer.innerText = gitStatusValue.message;
      }
    }
  });

  return (
    <pre
      ref={statusContainer}
      class={`rounded overflow-auto max-w-full ${gitStatus() && gitStatus().message && gitStatus().message !== '' ? 'block' : 'hidden'}`}
    />
  );
};

export default GitStatusDisplay;
EOF

echo "\033[32mDone: $goal\033[0m\n"
