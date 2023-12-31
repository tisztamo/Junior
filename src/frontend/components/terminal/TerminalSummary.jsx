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
