#!/bin/sh
# Goal: Replace pre tag with monospace font
# Plan:
# 1. Replace the pre tag in PromptDescriptor.jsx with a div tag.
# 2. Add the Tailwind CSS class "font-mono" to the new div to apply monospace font.

cat << EOF > ./src/frontend/components/PromptDescriptor.jsx
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
      <div class="whitespace-pre-wrap overflow-x-scroll overflow-y-auto font-mono">
        {promptDescriptor()}
      </div>
    </div>
  );
};

export default PromptDescriptor;
EOF
