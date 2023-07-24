#!/bin/sh
set -e
goal="Encapsulate markdown in details tag"
# Plan:
# 1. Modify the PromptDisplay component to wrap the markdown in a details tag with a summary tag displaying the character count
# 2. Change the placement of the PromptDisplay component in App.jsx to right under the StartButton component

echo "Modifying PromptDisplay component"
cat << 'EOF' > src/frontend/components/PromptDisplay.jsx
import { createSignal, onMount, createEffect } from "solid-js";
import { prompt } from '../stores/prompt';

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
    <details class="w-full max-w-screen overflow-x-auto whitespace-normal markdown">
      <summary ref={summary}></summary>
      <div ref={div}></div>
    </details>
  );
};

export default PromptDisplay;
EOF

echo "Repositioning PromptDisplay in App.jsx"
cat << 'EOF' > src/frontend/App.jsx
import NotesInput from './components/NotesInput';
import StartButton from './components/StartButton';
import ExecuteButton from './components/ExecuteButton';
import ResetButton from './components/ResetButton';
import PromptDisplay from './components/PromptDisplay';
import TasksList from './components/TasksList';
import PromptDescriptor from './components/PromptDescriptor';
import NavBar from './components/NavBar';
import { notes, setNotes } from './stores/notes';
import { setPrompt } from './stores/prompt';

const App = () => {
  return (
    <div class="m-2">
      <div class="max-w-desktop lg:max-w-desktop md:max-w-full sm:max-w-full xs:max-w-full mx-auto flex flex-col items-center space-y-8 sm:p-0">
        <NavBar />
        <TasksList />
        <PromptDescriptor />
        <NotesInput notes={notes} setNotes={setNotes} />
        <StartButton notes={notes} setPrompt={setPrompt} />
        <PromptDisplay />
        <ExecuteButton />
        <ResetButton />
      </div>
    </div>
  );
};

export default App;
EOF

echo "Completed: $goal\n"
