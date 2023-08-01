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
    <div class="bg-gray-900 text-white p-4 rounded">
      <div class="font-mono text-sm">
        <div 
          ref={container} 
          class={`rounded overflow-auto max-w-full p-2 ${executionResult() !== '' ? 'block' : 'hidden'}`}
        />
      </div>
    </div>
  );
};

export default ExecutionResultDisplay;
