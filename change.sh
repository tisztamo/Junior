#!/bin/sh
# Goal: Limit width of div in PromptDisplay to screen size and allow text wrap
# Plan:
# 1. Add tailwind utility classes to the div in PromptDisplay.jsx to make the div responsive and allow text wrapping

cat << 'EOF' > ./src/frontend/components/PromptDisplay.jsx
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
EOF
