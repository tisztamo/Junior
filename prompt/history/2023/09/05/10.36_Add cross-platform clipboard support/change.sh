#!/bin/sh
set -e
goal="Add cross-platform clipboard support"
echo "Plan:"
echo "1. Create service/copyToClipboard.js to handle copying text"
echo "2. Integrate the new service into the existing files"

# 1. Create service/copyToClipboard.js to handle copying text
cat << 'EOF' > ./src/frontend/service/copyToClipboard.js
const copyToClipboardFallback = (text) => {
  const textarea = document.createElement('textarea');
  textarea.value = text;
  document.body.appendChild(textarea);
  textarea.select();
  try {
    document.execCommand('copy');
    return true;
  } catch (err) {
    return false;
  } finally {
    document.body.removeChild(textarea);
  }
};

const copyToClipboard = async (text) => {
  if (navigator.clipboard && navigator.clipboard.writeText) {
    await navigator.clipboard.writeText(text);
  } else {
    const success = copyToClipboardFallback(text);
    if (!success) {
      throw new Error('Failed to copy text');
    }
  }
};

export default copyToClipboard;
EOF

# 2. Integrate the new service into the existing files
# Integrate into ExecutionResultDisplay.jsx
cat << 'EOF' > ./src/frontend/components/ExecutionResultDisplay.jsx
import { createEffect, createSignal } from 'solid-js';
import { executionResult } from '../model/executionResult';
import ansiToHtml from '../../execute/ansiToHtml';
import copyToClipboard from '../service/copyToClipboard';

const ExecutionResultDisplay = () => {
  let container;
  const [copyText, setCopyText] = createSignal('copy');

  const copyHandler = async (e) => {
    e.preventDefault(); // Prevent page load on click
    try {
      await copyToClipboard(executionResult());
      setCopyText('copied');
      setTimeout(() => setCopyText('copy'), 2000);
    } catch (err) {
      alert("Failed to copy text!");
      console.warn("Copy operation failed:", err);
    }
  };

  createEffect(() => {
    if (container && executionResult() !== undefined && executionResult() !== '') {
      const convertedHtml = ansiToHtml(executionResult());
      container.innerHTML = convertedHtml;
    }
  });

  return (
    <div class={`relative bg-gray-900 text-white p-4 rounded ${executionResult() !== undefined && executionResult() !== '' ? 'block' : 'hidden'}`}>
      <a href="#" class="underline absolute top-0 right-0 m-4" onClick={copyHandler}>{copyText()}</a>
      <div class="font-mono text-sm">
        <div ref={container} class="rounded overflow-auto max-w-full p-2" />
      </div>
    </div>
  );
};

export default ExecutionResultDisplay;
EOF

# Integrate into handleGeneratePrompt.js
cat << 'EOF' > ./src/frontend/service/handleGeneratePrompt.js
import { generatePrompt } from '../generatePrompt';
import { marked } from 'marked';
import { setPrompt } from '../model/prompt';
import postDescriptor from '../service/postDescriptor';
import { requirements } from '../model/requirements';
import copyToClipboard from './copyToClipboard';

const handleGeneratePrompt = async () => {
  try {
    await postDescriptor({ requirements: requirements() });

    const response = await generatePrompt();

    try {
      await copyToClipboard(response.prompt);
      console.log('Prompt copied to clipboard!');
    } catch (err) {
      console.error('Failed to copy prompt: ', err);
    }

    const htmlPrompt = marked(response.prompt);
    setPrompt(htmlPrompt);
  } catch (error) {
    alert(error.message);
  }
};

export default handleGeneratePrompt;
EOF

echo "\033[32mDone: $goal\033[0m\n"