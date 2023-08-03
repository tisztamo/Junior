import { createSignal, onMount, createEffect } from "solid-js";
import { prompt } from '../model/prompt';

const PromptDisplay = () => {
  let div;
  let summary;

  createEffect(() => {
    if (div) {
      div.innerHTML = prompt();
      summary.innerHTML = `prompt length: ${prompt().length} chars`;
    }
  });

  return (
    <details class="w-full max-w-screen overflow-x-auto whitespace-normal markdown" style={{ display: prompt().length > 0 ? 'block' : 'none' }}>
      <summary ref={summary}></summary>
      <div ref={div}></div>
    </details>
  );
};

export default PromptDisplay;
