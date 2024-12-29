#!/bin/sh
set -e
goal="Style TerminalSummary component"
echo "Plan:"
echo "1. Update TerminalSummary.jsx with TailwindCSS classes to add styles."

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

  return (
    <span className="font-mono pl-4 whitespace-nowrap overflow-ellipsis overflow-hidden">
      {lastLineSignal()}
    </span>
  );
}
EOF

echo "\033[32mDone: $goal\033[0m\n"