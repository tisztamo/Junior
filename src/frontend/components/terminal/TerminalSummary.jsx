import { createEffect, createSignal } from 'solid-js';

function extractLastLine(data) {
  const lines = data.split('\n');
  return lines[lines.length - 1];
}

export function TerminalSummary(props) {
  const [lastLine, setLastLine] = createSignal("");

  createEffect(() => {
    setLastLine(extractLastLine(props.lastWritten));
  });

  return <span>{lastLine()}</span>;
}
