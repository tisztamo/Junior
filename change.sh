#!/bin/sh
# Goal: Implement margins and responsive layout
# Plan:
# 1. Update tailwind.config.js to include screens
# 2. Add the relevant TailwindCSS classes for responsiveness and margins in the App.jsx file
# 3. Change the order of components to match the described flow

# Step 1: Update tailwind.config.js
cat << EOF > tailwind.config.js
module.exports = {
  content: ['./src/**/*.html', './src/**/*.js', './src/**/*.jsx', './src/**/*.tsx', './src/**/*.ts'],
  theme: {
    screens: {
      'sm': '640px',
      'md': '768px',
      'lg': '1024px',
      'xl': '1280px',
      '2xl': '1536px',
    },
    extend: {},
  },
  variants: {
    extend: {},
  },
  plugins: [],
}
EOF

# Step 2 and 3: Update App.jsx
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
    <div class="lg:m-8 m-4 flex flex-col items-center">
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

# Rebuild TailwindCSS
npx tailwindcss build -o src/frontend/styles/tailwind.css
