#!/bin/sh
set -e
goal="Modify PromptDescriptor summary"
echo "Plan:"
echo "1. Edit PromptDescriptor.jsx to add the new text with specified styling."

cat > src/frontend/components/PromptDescriptor.jsx << 'EOF'
import { onMount, onCleanup } from 'solid-js';
import { fetchDescriptor } from '../service/fetchDescriptor';
import { fetchGitStatus } from '../service/fetchGitStatus';
import { useWebsocket } from '../service/useWebsocket';
import { promptDescriptor, setPromptDescriptor } from '../model/promptDescriptor';
import { descriptorFileName } from '../../prompt/promptDescriptorConfig';

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
    <details class="w-full max-w-screen overflow-x-auto whitespace-normal">
      <summary class="font-mono">{descriptorFileName} <span class="text-sm font-normal">(Edit the attention manually)</span></summary>
      <div class="mt-4 overflow-auto max-w-full">
        <div class="whitespace-pre-wrap overflow-x-scroll overflow-y-auto font-mono">
          {promptDescriptor()}
        </div>
      </div>
    </details>
  );
};

export default PromptDescriptor;
EOF

echo "\033[32mDone: $goal\033[0m\n"