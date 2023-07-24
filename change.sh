#!/bin/sh
# Goal: Add small margin around content with Tailwind CSS
# Plan:
# 1. Identify the div that encompasses the entire content in the `App.jsx` file.
# 2. Wrap the existing div into a new parent div.
# 3. Apply the tailwind CSS class for margin to the new parent div.
#    Here, we will use `m-2` to add a small margin around the entire content.

cat > src/frontend/App.jsx << EOF
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
        <ExecuteButton />
        <ResetButton />
        <PromptDisplay />
      </div>
    </div>
  );
};

export default App;
EOF
