#!/bin/sh
set -e
goal="Fix terminal parent element error"
echo "Plan:"
echo "1. Edit ExecutionResultDisplay.jsx to ensure that the div always exists."
echo "2. Instead of conditionally rendering the div, render it always but control its visibility using CSS."

cat > src/frontend/components/ExecutionResultDisplay.jsx << 'EOF'
import { onMount, createEffect, onCleanup } from 'solid-js';
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

  onCleanup(() => {
    if (term) {
      term.dispose();
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
