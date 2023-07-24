#!/bin/sh
set -e
goal="Hide details tag when prompt is empty"
echo "Plan:"
echo "1. Modify PromptDisplay.jsx to conditionally render the details tag based on the prompt content."

cat > src/frontend/components/PromptDisplay.jsx << 'EOF'
import { createSignal, onMount, createEffect } from "solid-js";
import { prompt } from '../stores/prompt';

const PromptDisplay = () => {
  let div;
  let summary;

  createEffect(() => {
    if (div) {
      div.innerHTML = prompt();
      summary.innerHTML = `prompt length: ${prompt().length} chars`;
    }
  });

  return (
    <details class="w-full max-w-screen overflow-x-auto whitespace-normal markdown" style={{ display: prompt().length > 0 ? 'block' : 'none' }}>
      <summary ref={summary}></summary>
      <div ref={div}></div>
    </details>
  );
};

export default PromptDisplay;
EOF

echo "\033[32mDone: $goal\033[0m\n"
