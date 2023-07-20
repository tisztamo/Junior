#!/bin/sh
# Goal: Add "Junior" heading to the top of the screen
# Plan:
# 1. Create a new SolidJS component called 'TitleDisplay.jsx' that displays the title "Junior" at the top of the screen.
# 2. Import the 'TitleDisplay' component in 'App.jsx' and include it at the top of the rendered components.

# Step 1: Creating the new TitleDisplay component
cat > ./src/frontend/components/TitleDisplay.jsx << EOF
import { createSignal } from 'solid-js';

const TitleDisplay = () => {
  const [title] = createSignal('Junior');

  return (
    <h1 class="text-center text-3xl mt-6">{title}</h1>
  );
};

export default TitleDisplay;
EOF

# Step 2: Import the new component in 'App.jsx' and include it in the rendered components
cat > ./src/frontend/App.jsx << EOF
import NotesInput from './components/NotesInput';
import StartButton from './components/StartButton';
import PromptDisplay from './components/PromptDisplay';
import TasksList from './components/TasksList';
import PromptDescriptor from './components/PromptDescriptor';
import TitleDisplay from './components/TitleDisplay';
import { notes, setNotes } from './stores/notes';
import { setPrompt } from './stores/prompt';

const App = () => {
  return (
    <div class="lg:m-8 m-4 flex flex-col items-center space-y-8 sm:p-0 lg:max-w-desktop mx-auto">
      <TitleDisplay />
      <TasksList />
      <PromptDescriptor />
      <NotesInput notes={notes} setNotes={setNotes} />
      <StartButton notes={notes} setPrompt={setPrompt} />
      <PromptDisplay />
    </div>
  );
};

export default App;
EOF
