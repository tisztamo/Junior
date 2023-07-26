#!/bin/sh
set -e
goal="Implement Git status information display"
echo "Plan:"
echo "1. Create a new service for fetching git status information"
echo "2. Create a new store for git status"
echo "3. Create a new component to display the git status"
echo "4. Update the App.jsx file to include the new component after the ExecutionResultDisplay"

# Step 1: Create a new service for fetching git status information
cat << 'EOF' > ./src/frontend/service/fetchGitStatus.js
import { getBaseUrl } from '../getBaseUrl';

const fetchGitStatus = async () => {
  const baseUrl = getBaseUrl();
  const response = await fetch(`${baseUrl}/status`);

  const data = await response.json();

  return data;
};

export { fetchGitStatus };
EOF

# Step 2: Create a new signal for git status
cat << 'EOF' > ./src/frontend/stores/gitStatus.js
import { createSignal } from 'solid-js';

const [gitStatus, setGitStatus] = createSignal('');

export { gitStatus, setGitStatus };
EOF

# Step 3: Create a new component to display the git status
cat << 'EOF' > ./src/frontend/components/GitStatusDisplay.jsx
import { onMount, createEffect, onCleanup } from 'solid-js';
import { gitStatus, setGitStatus } from '../stores/gitStatus';
import { fetchGitStatus } from '../service/fetchGitStatus';

const GitStatusDisplay = () => {
  let statusContainer;

  onMount(async () => {
    const status = await fetchGitStatus();
    setGitStatus(status);
  });

  createEffect(() => {
    if (gitStatus() !== '') {
      statusContainer.innerText = gitStatus();
    }
  });

  onCleanup(() => {
    setGitStatus('');
  });

  return (
    <pre
      ref={statusContainer}
      class={`rounded overflow-auto max-w-full ${gitStatus() !== '' ? 'block' : 'hidden'}`}
    />
  );
};

export default GitStatusDisplay;
EOF

# Step 4: Update the App.jsx file to include the new component after the ExecutionResultDisplay
cat << 'EOF' > ./src/frontend/App.jsx
import GenerateButton from './components/GenerateButton';
import ExecuteButton from './components/ExecuteButton';
import RollbackButton from './components/RollbackButton';
import PromptDisplay from './components/PromptDisplay';
import TasksList from './components/TasksList';
import PromptDescriptor from './components/PromptDescriptor';
import NavBar from './components/NavBar';
import ExecutionResultDisplay from './components/ExecutionResultDisplay';
import GitStatusDisplay from './components/GitStatusDisplay';

const App = () => {
  return (
    <div class="m-2">
      <div class="max-w-desktop lg:max-w-desktop md:max-w-full sm:max-w-full xs:max-w-full mx-auto flex flex-col items-center space-y-8 sm:p-0">
        <NavBar />
        <TasksList />
        <PromptDescriptor />
        <GenerateButton />
        <PromptDisplay />
        <ExecuteButton />
        <ExecutionResultDisplay />
        <GitStatusDisplay />
        <RollbackButton />
      </div>
    </div>
  );
};

export default App;
EOF

echo "\033[32mDone: $goal\033[0m\n"
