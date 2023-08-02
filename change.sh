#!/bin/sh
set -e
goal="Replace ansi_up with custom ansiToHtml function"
echo "Plan:"
echo "1. Create a new file src/execute/ansiToHtml.js with the ansiToHtml function."
echo "2. Modify src/frontend/components/ExecutionResultDisplay.jsx to use the new ansiToHtml function instead of ansi_up."
echo "3. Uninstall ansi_up from the project."
echo "4. Modify the JSX to hide the most external wrapping div when there's no content."

# Step 1: Create a new file src/execute/ansiToHtml.js with the ansiToHtml function
cat << 'EOF' > src/execute/ansiToHtml.js
const ANSI_COLORS = {
  '30': 'black',
  '31': 'red',
  '32': 'green',
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

# Step 2: Modify src/frontend/components/ExecutionResultDisplay.jsx to use the new ansiToHtml function
cat << 'EOF' > src/frontend/components/ExecutionResultDisplay.jsx
import { createEffect } from 'solid-js';
import { executionResult } from '../stores/executionResult';
import ansiToHtml from '../../execute/ansiToHtml';

const ExecutionResultDisplay = () => {
  let container;

  createEffect(() => {
    if (container && executionResult() !== '') {
      const convertedHtml = ansiToHtml(executionResult());
      container.innerHTML = convertedHtml;
    }
  });

  return (
    <div class={`bg-gray-900 text-white p-4 rounded ${executionResult() !== '' ? 'block' : 'hidden'}`}>
      <div class="font-mono text-sm">
        <div ref={container} class="rounded overflow-auto max-w-full p-2" />
      </div>
    </div>
  );
};

export default ExecutionResultDisplay;
EOF

# Step 3: Uninstall ansi_up from the project
npm uninstall ansi_up

echo "\033[32mDone: $goal\033[0m\n"
