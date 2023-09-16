#!/bin/sh
set -e
goal="Update git status display"
echo "Plan:"
echo "1. Modify the backend handler to return data instead of message."
echo "2. Update the frontend GitStatusDisplay component to display the git status output in the desired format."
echo "3. Apply styling to the frontend component."

# 1. Modify the backend handler
cat > ./src/backend/handlers/git/gitStatusHandler.js << 'EOF'
import gitStatus from '../../../git/gitStatus.js';

export default async function gitStatusHandler(req, res) {
  try {
    const status = await gitStatus();
    res.status(200).send({ data: status });
  } catch (error) {
    let errorMessage = 'Error in getting Git status';
    if (error.stderr && error.stderr.includes('Not a git repository')) {
      errorMessage = 'Not a git repo. Run \'npx junior-init\' to initialize!';
    }
    res.status(500).send({ message: errorMessage, error });
  }
}
EOF

# 2. Update the frontend component
cat > ./src/frontend/components/GitStatusDisplay.jsx << 'EOF'
import { onMount, createEffect } from 'solid-js';
import { gitStatus } from '../model/gitStatus';
import { fetchGitStatus } from '../service/fetchGitStatus';

const GitStatusDisplay = () => {
  let statusContainer;

  onMount(fetchGitStatus);

  createEffect(() => {
    const gitStatusValue = gitStatus();
    if (gitStatusValue) {
      if (gitStatusValue.error) {
        statusContainer.innerText = `${gitStatusValue.message}\n${gitStatusValue.error.stderr}`;
      } else if (gitStatusValue.data && gitStatusValue.data.files && gitStatusValue.data.files.length > 0) {
        statusContainer.innerHTML = gitStatusValue.data.files.map(entry => {
          const { index, path, working_dir } = entry;
          return `<div class="grid grid-cols-3">
                    <span class="col-span-1">${index}</span>
                    <span class="col-span-1">${path}</span>
                    <span class="col-span-1">${working_dir}</span>
                  </div>`;
        }).join('');
      }
    }
  });

  return (
    <pre
      ref={statusContainer}
      class={`rounded overflow-auto max-w-full ${gitStatus() && gitStatus().data && gitStatus().data.files && gitStatus().data.files.length > 0 ? 'block' : 'hidden'}`}
    />
  );
};

export default GitStatusDisplay;
EOF

echo "\033[32mDone: $goal\033[0m\n"