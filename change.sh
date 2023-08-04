#!/bin/sh
set -e
goal="Make TaskList dark theme-aware and update colors"
echo "Plan:"
echo "1. Define new colors in tailwind config for emphasizing components."
echo "2. Update TaskList component to use new colors and make it dark theme-aware."

# Step 1: Define new colors in tailwind config for emphasizing components.
cat > src/frontend/tailwind.config.cjs << 'EOF'
module.exports = {
  darkMode: 'class',
  content: [__dirname + '/**/*.html', __dirname + '/**/*.jsx'],
  theme: {
    screens: {
      'xs': '320px',
      'sm': '640px',
      'md': '768px',
      'lg': '1024px',
      'xl': '1280px',
      '2xl': '1536px',
    },
    extend: {
      spacing: {
        '72': '18rem',
        '84': '21rem',
        '96': '24rem',
        '128': '32rem',
      },
      fontSize: {
        'btn': '1.5rem',
      },
      padding: {
        'btn': '1.5rem',
      },
      maxWidth: {
        'desktop': '640px',
      },
      colors: {
        light: {
          text: '#1a202c',
          background: '#f7fafc',
          emphasize: '#e2e8f0', // New color for emphasizing a component
        },
        dark: {
          text: '#f7fafc',
          background: '#1a202c',
          emphasize: '#2d3748', // New color for emphasizing a component in dark mode
        },
      },
    },
  },
  variants: {
    extend: {},
  },
  plugins: [],
}
EOF

# Step 2: Update TaskList component to use new colors and make it dark theme-aware.
cat > src/frontend/components/TasksList.jsx << 'EOF'
import { onMount, createEffect } from 'solid-js';
import { fetchTasks } from '../fetchTasks';
import { handleTaskChange } from '../service/handleTaskChange';
import { selectedTask, setSelectedTask } from '../model/selectedTask';
import { promptDescriptor } from '../model/promptDescriptor';
import { parseYamlAndGetTask } from '../service/parseYamlAndGetTask';

const TasksList = () => {
  const tasks = fetchTasks();

  createEffect(() => {
    const descriptor = promptDescriptor();
    if (descriptor !== '') {
      const task = parseYamlAndGetTask(descriptor);
      setSelectedTask(task);
    }
  });

  return (
    <div class="w-full flex justify-start dark:bg-dark-emphasize bg-light-emphasize p-2 rounded">
      <label class="mr-2">Task:</label>
      <select class="w-full" value={selectedTask()} onChange={e => handleTaskChange(e)}>
        {tasks().map(task => <option value={task}>{task}</option>)}
      </select>
    </div>
  );
};

export default TasksList;
EOF

echo "\033[32mDone: $goal\033[0m\n"
