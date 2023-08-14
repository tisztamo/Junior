#!/bin/sh
set -e
goal="Implement new border color for themes"
echo "Plan:"
echo "1. Introduce a new border color variable in styles/colors.css for both light and dark themes."
echo "2. Update tailwind.config.cjs to use the newly introduced border color variable."
echo "3. Modify the TasksList.jsx to apply the new border color."

# Step 1: Introduce a new border color variable in styles/colors.css
cat <<EOF > ./src/frontend/styles/colors.css
:root {
  --text-color: #1a202c;
  --background-color: #f7fafc;
  --emphasize-color: #16181f;
  --background-emphasize-color: #f2f4f6;
  --border-color: #d1d5db;
}

.dark {
  --text-color: #f7fafc;
  --background-color: #1a202c;
  --emphasize-color: #f2f4f6;
  --background-emphasize-color: #141618;
  --border-color: #4a5568;
}
EOF

# Step 2: Update tailwind.config.cjs to use the newly introduced border color variable
cat <<EOF > ./src/frontend/tailwind.config.cjs
module.exports = {
  darkMode: 'class',
  content: [__dirname + '/**/*.html', __dirname + '/**/*.jsx'],
  theme: {
    screens: {
      'xs': '320px',
      'sm': '640px',
      'md': '768px',
      'lg': '1024px',
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
        'lg': '1.125rem',
      },
      padding: {
        'btn': '1.5rem',
      },
      maxWidth: {
        'desktop': '640px',
      },
      colors: {
        text: "var(--text-color)",
        emphasize: "var(--emphasize-color)",
        bg: "var(--background-color)",
        border: "var(--border-color)",
      },
      backgroundColor: {
        main: "var(--background-color)",
        emphasize: "var(--background-emphasize-color)",
      },
    },
  },
  variants: {
    extend: {},
  },
  plugins: [],
}
EOF

# Step 3: Modify the TasksList.jsx to apply the new border color
cat <<EOF > ./src/frontend/components/TasksList.jsx
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
    <div class="w-full flex justify-start bg-emphasize text-emphasize p-2 rounded border border-border">
      <label class="text-lg mr-2">Task:</label>
      <select class="w-full bg-emphasize text-emphasize text-lg" value={selectedTask()} onChange={e => handleTaskChange(e)}>
        {tasks().map(task => <option value={task}>{task}</option>)}
      </select>
    </div>
  );
};

export default TasksList;
EOF

echo "\033[32mDone: $goal\033[0m\n"
