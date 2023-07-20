#!/bin/sh
# Goal: Enhance UI for the solid app
# Plan:
# 1. Change the label of Start button to "Generate & Copy Prompt" in StartButton.jsx
# 2. Increase the size of the Start button using tailwind styles in StartButton.jsx
# 3. Add a background color to the tasklist in TasksList.jsx
# 4. Align the tasklist to the left within a single column layout in TasksList.jsx
# 5. Add margins between the components in App.jsx
# 6. Update tailwind configuration file to extend the button styles for larger buttons and spacing for larger gaps

cat <<'EOF' >src/frontend/components/StartButton.jsx
import { generatePrompt } from '../generatePrompt';
import { marked } from 'marked';
import copy from 'clipboard-copy';

const StartButton = ({notes, setPrompt}) => {
  const handleGeneratePrompt = async () => {
    const response = await generatePrompt(notes());

    copy(response.prompt)
      .then(() => {
        console.log('Prompt copied to clipboard!');
      })
      .catch(err => {
        console.error('Failed to copy prompt: ', err);
      });

    const htmlPrompt = marked(response.prompt);

    setPrompt(htmlPrompt);
  };

  return (
    // Updated button label and added tailwind classes for larger button size
    <button class="px-8 py-4 bg-blue-500 text-white rounded" onClick={handleGeneratePrompt}>Generate & Copy Prompt</button>
  );
};

export default StartButton;
EOF

cat <<'EOF' >src/frontend/components/TasksList.jsx
import { onMount } from 'solid-js';
import { fetchTasks } from '../fetchTasks';
import { handleTaskChange } from '../service/handleTaskChange';
import { selectedTask, setSelectedTask } from '../stores/selectedTask';

const TasksList = () => {
  const tasks = fetchTasks();

  onMount(async () => {
    const task = tasks[0]; // Set default task to the first in the list
    setSelectedTask(task);
  });

  return (
    // Align the tasklist to the left within a single column layout and add background color
    <div class="w-full flex justify-start bg-gray-100 p-2 rounded">
      <label class="mr-2">Task:</label>
      <select class="w-full" value={selectedTask()} onChange={e => handleTaskChange(e)}>
        {tasks().map(task => <option value={task}>{task}</option>)}
      </select>
    </div>
  );
};

export default TasksList;
EOF

cat <<'EOF' >src/frontend/App.jsx
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
    <div class="lg:m-8 m-4 flex flex-col items-center space-y-8">
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

cat <<'EOF' >tailwind.config.js
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
    },
  },
  variants: {
    extend: {},
  },
  plugins: [],
}
EOF
