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
    <div className="w-full max-w-screen overflow-x-auto whitespace-normal markdown" ref={div}></div>
  );
};

export default PromptDisplay;
