#!/bin/sh

# Goal: Implement a responsive layout for the application
# Plan:
# 1. Extend the tailwind configuration file to include maxWidth property for desktop view.
# 2. Modify the main application container to apply responsiveness using tailwind utility classes.

cat << EOF > ./tailwind.config.js
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
    extend: {
      // Extend the spacing for larger gaps
      spacing: {
        '72': '18rem',
        '84': '21rem',
        '96': '24rem',
        '128': '32rem',
      },
      // Extend the button styles for larger buttons
      fontSize: {
        'btn': '1.5rem',
      },
      padding: {
        'btn': '1.5rem',
      },
      // Extend the maxWidth for desktop container
      maxWidth: {
        'desktop': '1000px',
      },
    },
  },
  variants: {
    extend: {},
  },
  plugins: [],
}
EOF

cat << EOF > ./src/frontend/App.jsx
import NotesInput from './components/NotesInput';
import StartButton from './components/StartButton';
import PromptDisplay from './components/PromptDisplay';
import TasksList from './components/TasksList';
import PromptDescriptor from './components/PromptDescriptor';
import { notes, setNotes } from './stores/notes';
import { setPrompt } from './stores/prompt';

const App = () => {
  return (
    // Added margins between the components
    // Applied maxWidth for desktop view and mx-auto to center the content
    // Applied padding on small screens to use the whole screen
    <div class="lg:m-8 m-4 flex flex-col items-center space-y-8 sm:p-0 lg:max-w-desktop mx-auto">
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

