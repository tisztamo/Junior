import { onMount, createEffect, onCleanup } from 'solid-js';
import { Terminal } from 'xterm';
import 'xterm/css/xterm.css';
import { executionResult } from '../stores/executionResult';

const ExecutionResultDisplay = () => {
  let container;
  let term;

  onMount(() => {
    term = new Terminal({ convertEol: true, rows: 7 });
    term.open(container);
  });

  createEffect(() => {
    if (term && executionResult() !== '') {
      term.write(executionResult());
    }
  });

  onCleanup(() => {
    if (term) {
      term.dispose();
    }
  });

  return (
    <div 
      ref={container} 
      class={`rounded overflow-auto max-w-full ${executionResult() !== '' ? 'block' : 'hidden'}`}
    />
  );
};

export default ExecutionResultDisplay;
