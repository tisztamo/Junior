#!/bin/sh
set -e

goal="Refine TerminalSummary: Improved cleaning of control sequences"
echo "Plan:"
echo "1. Update the cleaning method to remove ANSI escape codes."
echo "2. Reapply the logic in TerminalSummary with the updated cleaning method."

# 1. Update the prependAndExtractLastLine function to remove ANSI escape codes
cat > ./src/frontend/components/terminal/prependAndExtractLastLine.js << 'EOF'
export function prependAndExtractLastLine(lastLine, currentData) {
  const combinedData = `${lastLine}${currentData}`;
  // Remove ANSI escape codes
  const cleanedData = combinedData.replace(/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]?/g, '');
  const lines = cleanedData.split('\n');
  return lines[lines.length - 1];
}
EOF

# 2. Reapply the logic in TerminalSummary component
cat > ./src/frontend/components/terminal/TerminalSummary.jsx << 'EOF'
import { createEffect, createSignal } from 'solid-js';
import { prependAndExtractLastLine } from './prependAndExtractLastLine';

export function TerminalSummary(props) {
  const [lastLineSignal, setLastLineSignal] = createSignal("");
  let localLastLine = "";

  createEffect(() => {
    localLastLine = prependAndExtractLastLine(localLastLine, props.lastWritten);
    setLastLineSignal(localLastLine);
  });

  return <span>{lastLineSignal()}</span>;
}
EOF

echo "\033[32mDone: $goal\033[0m\n"