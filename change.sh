#!/bin/sh
set -e
goal="Refactor ExecutionResultDisplay, handle colors and newlines"
echo "Plan:"
echo "1. Uninstall xterm.js using npm"
echo "2. Install ansi_up using npm"
echo "3. Modify ExecutionResultDisplay.jsx to use a div and handle ansi color codes, including newlines"

# 1. Uninstall xterm.js using npm
npm uninstall xterm

# 2. Install ansi_up using npm
npm install ansi_up

# 3. Modify ExecutionResultDisplay.jsx to use a div and handle ansi color codes, including newlines
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
    <div 
      ref={container} 
      class={`rounded overflow-auto max-w-full ${executionResult() !== '' ? 'block' : 'hidden'}`}
    />
  );
};

export default ExecutionResultDisplay;
EOF

echo "\033[32mDone: $goal\033[0m\n"
