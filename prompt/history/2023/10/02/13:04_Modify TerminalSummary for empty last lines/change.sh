#!/bin/sh
set -e
goal="Modify TerminalSummary for empty last lines"
echo "Plan:"
echo "1. Update TerminalSummary.jsx to check if the new line is empty before updating the signal."
echo "2. Clean up any comments from the provided source files."

# Step 1: Modify TerminalSummary.jsx
cat > ./src/frontend/components/terminal/TerminalSummary.jsx << 'EOF'
import { createEffect, createSignal } from 'solid-js';
import { prependAndExtractLastLine } from './prependAndExtractLastLine';

export function TerminalSummary(props) {
  const [lastLineSignal, setLastLineSignal] = createSignal("");
  let localLastLine = "";

  createEffect(() => {
    localLastLine = prependAndExtractLastLine(localLastLine, props.lastWritten);
    if (localLastLine !== "") {
      setLastLineSignal(localLastLine);
    }
  });

  return <span>{lastLineSignal()}</span>;
}
EOF

# Step 2: Clean up prependAndExtractLastLine.js
cat > ./src/frontend/components/terminal/prependAndExtractLastLine.js << 'EOF'
export function prependAndExtractLastLine(lastLine, currentData) {
  const combinedData = `${lastLine}${currentData}`;
  const cleanedData = combinedData.replace(/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]?/g, '');

  const lines = cleanedData.split(/\r(?!\n)|\n/);

  return getValidLastLine(lines);
}

function getValidLastLine(lines) {
  if (lines.length === 0) return '';

  const lastLine = lines[lines.length - 1].trim();
  if (lastLine === '' || lastLine.endsWith('$') || lastLine.endsWith('%')) {
    return getValidLastLine(lines.slice(0, -1));
  }
  
  return lastLine;
}
EOF

echo "\033[32mDone: $goal\033[0m\n"