#!/bin/sh
# Goal: Fix the issue of prompt display
# Plan:
# 1. Import prompt from the store directly into the PromptDisplay component instead of passing it from the App component.
# 2. Add a createEffect in PromptDisplay to listen to changes in the prompt and update the display accordingly.

cat << EOF > src/frontend/components/PromptDisplay.jsx
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
EOF

cat << EOF > src/frontend/App.jsx
import NotesInput from './components/NotesInput';
import StartButton from './components/StartButton';
import PromptDisplay from './components/PromptDisplay';
import TasksList from './components/TasksList';
import PromptDescriptor from './components/PromptDescriptor';
import { notes, setNotes } from './stores/notes';
import { setPrompt } from './stores/prompt';

const App = () => {
  return (
    <>
      <NotesInput notes={notes} setNotes={setNotes} />
      <StartButton notes={notes} setPrompt={setPrompt} />
      <PromptDisplay />
      <TasksList />
      <PromptDescriptor />
    </>
  );
};

export default App;
EOF
