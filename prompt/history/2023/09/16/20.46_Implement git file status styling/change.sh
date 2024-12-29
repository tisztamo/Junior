#!/bin/sh
set -e
goal="Implement git file status styling"
echo "Plan:"
echo "1. Create a utility function in the components directory to determine the background color based on file status and path."
echo "2. Modify GitStatusDisplay.jsx to apply the styling rules as described."

# Utility function to determine the background color based on file status and path
cat > ./src/frontend/components/getBackgroundColorForFile.jsx << 'EOF'
export default function getBackgroundColorForFile(index, path) {
  if (index === 'M') { // Modified files
    return 'rgb(34 197 94)';
  } else if (index === 'A' && !path.includes('prompt/history')) { // New files excluding ones with 'prompt/history' in path
    return 'rgb(253 186 116)';
  }
  return ''; // Default no background color
}
EOF

# Modifying GitStatusDisplay.jsx to apply the styling rules
cat > ./src/frontend/components/GitStatusDisplay.jsx << 'EOF'
import { onMount, createEffect } from 'solid-js';
import getBackgroundColorForFile from './getBackgroundColorForFile';
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
          const bgColor = getBackgroundColorForFile(index, path);
          return `<div class="grid grid-cols-3 ${bgColor ? 'bg-' + bgColor : ''}">
                    <span class="col-span-1 w-50px">${index}</span>
                    <span class="col-span-1 w-60%">${path}</span>
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