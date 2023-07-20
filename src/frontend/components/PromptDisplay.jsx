import { createSignal, onMount } from "solid-js";

const PromptDisplay = ({prompt}) => {
  let div;
  onMount(() => {
    div.innerHTML = prompt();
  });

  return (
    <div className="markdown" ref={div}></div>
  );
};

export default PromptDisplay;
