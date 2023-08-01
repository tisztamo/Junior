#!/bin/sh
set -e
goal="Style ExecutionResultDisplay as a terminal"
echo "Plan:"
echo "1. Update ExecutionResultDisplay.jsx to style the container like a terminal using Tailwind classes."
echo "2. Add a wrapper div to provide padding and other terminal-like characteristics."

# Updating ExecutionResultDisplay.jsx with terminal-like styling
cat > src/frontend/components/ExecutionResultDisplay.jsx << 'EOF'
import { createEffect } from 'solid-js';
import { executionResult } from '../stores/executionResult';
import ansi_up from 'ansi_up';

const ExecutionResultDisplay = () => {
  let container;

  createEffect(() => {
    if (container && executionResult() !== '') {
      const ansi_up_instance = new ansi_up();
      const convertedHtml = ansi_up_instance.ansi_to_html(executionResult()).replace(/\n/g, '<br />');
      container.innerHTML = convertedHtml;
    }
  });

  return (
    <div class="bg-gray-900 text-white p-4 rounded">
      <div class="font-mono text-sm">
        <div 
          ref={container} 
          class={`rounded overflow-auto max-w-full p-2 ${executionResult() !== '' ? 'block' : 'hidden'}`}
        />
      </div>
    </div>
  );
};

export default ExecutionResultDisplay;
EOF

echo "\033[32mDone: $goal\033[0m\n"
