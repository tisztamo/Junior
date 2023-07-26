#!/bin/sh
set -e
goal="Fix GitStatusDisplay to handle missing status field and remove onCleanup"
echo "Plan:"
echo "1. Update GitStatusDisplay component to correctly handle potential missing status field."
echo "2. The gitStatus() function might now return an object that could potentially lack a status field. We should account for this case."
echo "3. We're also asked to remove the onCleanup function call as it's no longer necessary."

cat <<'EOF' > src/frontend/components/GitStatusDisplay.jsx
import { onMount, createEffect } from 'solid-js';
import { gitStatus, setGitStatus } from '../stores/gitStatus';
import { fetchGitStatus } from '../service/fetchGitStatus';

const GitStatusDisplay = () => {
  let statusContainer;

  onMount(async () => {
    const status = await fetchGitStatus();
    setGitStatus(status);
  });

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
