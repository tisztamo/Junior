#!/bin/sh
set -e
goal="Fix newline handling in Terminal"
echo "Plan:"
echo "1. Update Terminal initialization with convertEol option"

cat > src/frontend/components/ExecutionResultDisplay.jsx << 'EOF'
import { onMount, createEffect } from 'solid-js';
import { Terminal } from 'xterm';
import 'xterm/css/xterm.css';
import { executionResult } from '../stores/executionResult';

const ExecutionResultDisplay = () => {
  let container;
  let term;

  onMount(() => {
    term = new Terminal({ convertEol: true });
    term.open(container);
  });

  createEffect(() => {
    if (term) {
 term.write(executionResult());
    }
  });

  return (
    <div ref={container} class="px-4 py-4 bg-gray-300 text-black rounded overflow-auto max-w-full"></div>
  );
};

export default ExecutionResultDisplay;
EOF

echo "\033[32mDone: $goal\033[0m\n"
