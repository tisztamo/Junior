#!/bin/sh
set -e
goal="Integrate ANSI to HTML in TerminalSummary"
echo "Plan:"
echo "1. Modify TerminalSummary.jsx to correctly import ansiToHtml."
echo "2. Use ansiToHtml on the last line before setting the signal."
echo "3. Set the result to innerHTML of the span tag in TerminalSummary component."

cat > ./src/frontend/components/terminal/TerminalSummary.jsx << 'EOF'
import { createEffect, createSignal } from 'solid-js';
import ansiToHtml from '../../../execute/ansiToHtml'; // corrected path
import { prependAndExtractLastLine } from './prependAndExtractLastLine';

export function TerminalSummary(props) {
  const [lastLineSignal, setLastLineSignal] = createSignal("");
  let localLastLine = "";

  createEffect(() => {
    localLastLine = prependAndExtractLastLine(localLastLine, props.lastWritten);
    if (localLastLine !== "") {
      const coloredLastLine = ansiToHtml(localLastLine);
      setLastLineSignal(coloredLastLine);
    }
  });

  return (
    <span className="font-mono pl-4 whitespace-nowrap overflow-ellipsis overflow-hidden" innerHTML={lastLineSignal()} />
  );
}
EOF

echo "\033[32mDone: $goal\033[0m\n"