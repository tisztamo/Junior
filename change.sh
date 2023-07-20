#!/bin/sh
# Goal: Add horizontal scrolling to PromptDescriptor
# Plan:
# 1. Wrap the pre tag in a div with a class of "overflow-auto" to add scrolling. 
# 2. Also add "max-w-full" to ensure that the div doesn't exceed the screen width.

cat > src/frontend/components/PromptDescriptor.jsx << 'EOF'
import { onMount, onCleanup } from 'solid-js';
import { fetchDescriptor } from '../service/fetchDescriptor';
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
    }
  });

  onCleanup(() => {
    setPromptDescriptor('');
  });

  return (
    <div class="overflow-auto max-w-full">
      <pre>{promptDescriptor()}</pre>
    </div>
  );
};

export default PromptDescriptor;
EOF
