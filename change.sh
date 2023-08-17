#!/bin/sh
set -e
goal="Add margin-top to the div"
echo "Plan:"
echo "1. Update PromptDisplay.jsx to add margin-top to the div."

cat > src/frontend/components/PromptDisplay.jsx << 'EOF'
import { createSignal, onMount, createEffect } from "solid-js";
import { prompt } from '../model/prompt';

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
      <div ref={div} class="mt-4"></div>
    </details>
  );
};

export default PromptDisplay;
EOF

echo "\033[32mDone: $goal\033[0m\n"
