#!/bin/sh
set -e
goal="Modify fetchGitStatus to write data to store"
echo "Plan:"
echo "1. Modify fetchGitStatus.js to import setGitStatus from gitStatus.js"
echo "2. Use setGitStatus to write data to the store inside fetchGitStatus"
echo "3. Modify GitStatusDisplay.jsx to remove fetchGitStatus call, since fetchGitStatus itself will update the store"

cat << 'EOF' > ./src/frontend/service/fetchGitStatus.js
import { getBaseUrl } from '../getBaseUrl';
import { setGitStatus } from '../stores/gitStatus';

const fetchGitStatus = async () => {
  const baseUrl = getBaseUrl();
  const response = await fetch(`${baseUrl}/status`);

  const data = await response.json();

  setGitStatus(data);
};

export { fetchGitStatus };
EOF

cat << 'EOF' > ./src/frontend/components/GitStatusDisplay.jsx
import { onMount, createEffect } from 'solid-js';
import { gitStatus } from '../stores/gitStatus';
import { fetchGitStatus } from '../service/fetchGitStatus';

const GitStatusDisplay = () => {
  let statusContainer;

  onMount(fetchGitStatus);

  createEffect(() => {
    const gitStatusValue = gitStatus();
    if (gitStatusValue && gitStatusValue.status && gitStatusValue.status !== '') {
      statusContainer.innerText = gitStatusValue.status;
    }
  });

  return (
    <pre
      ref={statusContainer}
      class={`rounded overflow-auto max-w-full ${gitStatus() && gitStatus().status && gitStatus().status !== '' ? 'block' : 'hidden'}`}
    />
  );
};

export default GitStatusDisplay;
EOF

echo "\033[32mDone: $goal\033[0m\n"
