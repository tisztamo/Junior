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
