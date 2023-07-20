import { createSignal, onMount, createEffect } from "solid-js";
import { prompt } from '../stores/prompt';

const PromptDisplay = () => {
  let div;

  createEffect(() => {
    if (div) {
      div.innerHTML = prompt();
    }
  });

  return (
    <div className="markdown" ref={div}></div>
  );
};

export default PromptDisplay;
