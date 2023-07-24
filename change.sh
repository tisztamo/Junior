#!/bin/sh
set -e
goal="Hide terminal div when execution result is empty"
echo "Plan:"
echo "1. Modify ExecutionResultDisplay.jsx to check if executionResult is empty before rendering the div."
echo "2. If executionResult is empty, do not render the div."

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
    if (term && executionResult() !== '') {
      term.write(executionResult());
    }
  });

  return (
    executionResult() !== '' && <div ref={container} class="rounded overflow-auto max-w-full"></div>
  );
};

export default ExecutionResultDisplay;
EOF

echo "\033[32mDone: $goal\033[0m\n"
