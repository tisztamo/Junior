#!/bin/sh
set -e
goal="Fetch git status after code execution and websocket update"
echo "Plan:"
echo "1. Update 'executeChange.js' to fetch git status after code execution"
echo "2. Update 'PromptDescriptor.jsx' to fetch git status when a websocket update event is received"

cat << 'EOF' > src/frontend/service/executeChange.js
import { getBaseUrl } from '../getBaseUrl';
import { fetchGitStatus } from './fetchGitStatus';

const executeChange = async (change) => {
  const baseUrl = getBaseUrl();
  const response = await fetch(`${baseUrl}/execute`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ change })
  });

  const data = await response.json();

  // Fetch git status after code execution
  fetchGitStatus();

  return data;
};

export { executeChange };
EOF

cat << 'EOF' > src/frontend/components/PromptDescriptor.jsx
import { onMount, onCleanup } from 'solid-js';
import { fetchDescriptor } from '../service/fetchDescriptor';
import { fetchGitStatus } from '../service/fetchGitStatus';
import { useWebsocket } from '../service/useWebsocket';
import { promptDescriptor, setPromptDescriptor } from '../stores/promptDescriptor';

const PromptDescriptor = () => {

  onMount(async () => {
    const text = await fetchDescriptor();
    setPromptDescriptor(text);
  });

  useWebsocket(async (e) => {
    if (e.data === 'update') {
      const text = await fetchDescriptor();
      setPromptDescriptor(text);
      // Fetch git status when an update event is received
      fetchGitStatus();
    }
  });

  onCleanup(() => {
    setPromptDescriptor('');
  });

  return (
    <div class="overflow-auto max-w-full">
      <div class="whitespace-pre-wrap overflow-x-scroll overflow-y-auto font-mono">
        {promptDescriptor()}
      </div>
    </div>
  );
};

export default PromptDescriptor;
EOF

echo "\033[32mDone: $goal\033[0m\n"
