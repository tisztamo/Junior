#!/bin/bash

# Remove unused file
rm ./src/frontend/components/PromptDescriptorViewer.jsx

# Update App.jsx to eliminate reference to PromptDescriptorViewer.jsx
cat >./src/frontend/App.jsx <<'EOF'
import { createSignal } from 'solid-js';
import NotesInput from './components/NotesInput';
import StartButton from './components/StartButton';
import PromptDisplay from './components/PromptDisplay';
import TasksList from './components/TasksList';

const App = () => {
  const [notes, setNotes] = createSignal('');
  const [prompt, setPrompt] = createSignal('');

  return (
    <>
      <NotesInput notes={notes} setNotes={setNotes} />
      <StartButton notes={notes} setPrompt={setPrompt} />
      <PromptDisplay prompt={prompt} />
      <TasksList />
    </>
  );
};

export default App;
EOF
