import { onMount, createEffect } from 'solid-js';
import { Terminal } from 'xterm';
import 'xterm/css/xterm.css';
import { executionResult } from '../stores/executionResult';

const ExecutionResultDisplay = () => {
  let container;
  let term;

  onMount(() => {
    term = new Terminal({ convertEol: true });
    term.open(container);
  });

  createEffect(() => {
    if (term) {
 term.write(executionResult());
    }
  });

  return (
    <div ref={container} class="px-4 py-4 bg-gray-300 text-black rounded overflow-auto max-w-full"></div>
  );
};

export default ExecutionResultDisplay;
