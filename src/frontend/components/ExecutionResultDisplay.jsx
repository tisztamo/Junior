import { createEffect } from 'solid-js';
import { executionResult } from '../stores/executionResult';
import ansi_up from 'ansi_up';

const ExecutionResultDisplay = () => {
  let container;

  createEffect(() => {
    if (container && executionResult() !== '') {
      const ansi_up_instance = new ansi_up();
      const convertedHtml = ansi_up_instance.ansi_to_html(executionResult()).replace(/\n/g, '<br />');
      container.innerHTML = convertedHtml;
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
