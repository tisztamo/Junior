import { onMount, createEffect } from 'solid-js';
import { Terminal } from 'xterm';
import 'xterm/css/xterm.css';
import { executionResult } from '../stores/executionResult';

const ExecutionResultDisplay = () => {
  let container;
  let term;

  onMount(() => {
    term = new Terminal();
    term.open(container);
  });

  createEffect(() => {
    if (term) {
      term.write(executionResult());
    }
  });

  return (
    <div ref={container} class="w-64 px-4 py-4 bg-gray-300 text-black rounded"></div>
  );
};

export default ExecutionResultDisplay;
