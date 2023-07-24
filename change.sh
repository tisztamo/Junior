#!/bin/sh
set -e
goal="Modify ExecutionResultDisplay component"
echo "Plan:"
echo "1. Remove padding and color setup from the ExecutionResultDisplay component."
echo "2. Set its height to 7 lines using the xterm.js api."

cat > src/frontend/components/ExecutionResultDisplay.jsx << 'EOF'
import { onMount, createEffect } from 'solid-js';
import { Terminal } from 'xterm';
import 'xterm/css/xterm.css';
import { executionResult } from '../stores/executionResult';

const ExecutionResultDisplay = () => {
  let container;
  let term;

  onMount(() => {
    term = new Terminal({ convertEol: true, rows: 7 });
    term.open(container);
  });

  createEffect(() => {
    if (term) {
 term.write(executionResult());
    }
  });

  return (
    <div ref={container} class="rounded overflow-auto max-w-full"></div>
  );
};

export default ExecutionResultDisplay;
EOF

echo "\033[32mDone: $goal\033[0m\n"
