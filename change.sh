#!/bin/sh
set -e
goal="Modify color, add copy link with underline, no page load, and error handling"
echo "Plan:"
echo "1. Modify the green color to lightgreen in ansiToHtml.js"
echo "2. Add an underlined 'copy' link in ExecutionResultDisplay.jsx relative to the outer div, changing the link text on success"
echo "3. Prevent page load on click and handle error with alert and console warning"

# Step 1: Modify the green color to lightgreen in ansiToHtml.js
cat > src/execute/ansiToHtml.js << 'EOF'
const ANSI_COLORS = {
  '30': 'black',
  '31': 'red',
  '32': 'lightgreen',
  '33': 'yellow',
  '34': 'blue',
  '35': 'magenta',
  '36': 'cyan',
  '37': 'white',
};

const ansiToHtml = (terminalOutputStr) => {
  let result = '<span>' + terminalOutputStr.replace(/\033\[([0-9]+)m/g, (match, p1) => {
    const color = ANSI_COLORS[p1];
    return color ? `</span><span style="color:${color}">` : '</span><span>';
  });
  result += '</span>';
  return result.replace(/\n/g, '<br />');
};

export default ansiToHtml;
EOF

# Step 2: Add an underlined 'copy' link in ExecutionResultDisplay.jsx to copy the original execution result
cat > src/frontend/components/ExecutionResultDisplay.jsx << 'EOF'
import { createEffect, createSignal } from 'solid-js';
import { executionResult } from '../stores/executionResult';
import ansiToHtml from '../../execute/ansiToHtml';

const ExecutionResultDisplay = () => {
  let container;
  const [copyText, setCopyText] = createSignal('copy');

  const copyToClipboard = async (e) => {
    e.preventDefault(); // Prevent page load on click
    try {
      await navigator.clipboard.writeText(executionResult());
      setCopyText('copied');
      setTimeout(() => setCopyText('copy'), 2000);
    } catch (err) {
      alert("Failed to copy text!");
      console.warn("Copy operation failed:", err);
    }
  };

  createEffect(() => {
    if (container && executionResult() !== '') {
      const convertedHtml = ansiToHtml(executionResult());
      container.innerHTML = convertedHtml;
    }
  });

  return (
    <div class={`relative bg-gray-900 text-white p-4 rounded ${executionResult() !== '' ? 'block' : 'hidden'}`}>
      <a href="#" class="underline absolute top-0 right-0 m-4" onClick={copyToClipboard}>{copyText()}</a>
      <div class="font-mono text-sm">
        <div ref={container} class="rounded overflow-auto max-w-full p-2" />
      </div>
    </div>
  );
};

export default ExecutionResultDisplay;
EOF

echo "\033[32mDone: $goal\033[0m\n"
