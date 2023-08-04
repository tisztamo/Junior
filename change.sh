#!/bin/sh
set -e
goal="Move bg-main text-text to the body, preserve classes on theme switch"
echo "Plan:"
echo "1. Update the App.jsx file to remove classes 'bg-main' and 'text-text' from the main div."
echo "2. Modify ThemeSwitcher.jsx to add/remove 'bg-main' and 'text-text' classes to the body along with the theme class."

# Step 1: Update App.jsx
cat << 'EOF' > src/frontend/App.jsx
import GenerateButton from './components/GenerateButton';
import ExecuteButton from './components/ExecuteButton';
import RollbackButton from './components/RollbackButton';
import CommitButton from './components/CommitButton';
import PromptDisplay from './components/PromptDisplay';
import TasksList from './components/TasksList';
import PromptDescriptor from './components/PromptDescriptor';
import NavBar from './components/NavBar';
import ExecutionResultDisplay from './components/ExecutionResultDisplay';
import GitStatusDisplay from './components/GitStatusDisplay';
import CommitMessageInput from './components/CommitMessageInput';

const App = () => {
  return (
    <div id="app" class="p-2">
      <div class="max-w-desktop lg:max-w-desktop md:max-w-full sm:max-w-full xs:max-w-full mx-auto flex flex-col items-center space-y-8 sm:p-0">
        <NavBar />
        <TasksList />
        <PromptDescriptor />
        <GenerateButton />
        <PromptDisplay />
        <ExecuteButton />
        <ExecutionResultDisplay />
        <GitStatusDisplay />
        <CommitMessageInput />
        <CommitButton />
        <RollbackButton />
      </div>
    </div>
  );
};

export default App;
EOF

# Step 2: Modify ThemeSwitcher.jsx
cat << 'EOF' > src/frontend/components/ThemeSwitcher.jsx
import { createEffect, createSignal } from 'solid-js';

const ThemeSwitcher = () => {
  const [theme, setTheme] = createSignal(window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light');

  createEffect(() => {
    const currentTheme = theme();
    const themeClass = currentTheme === 'dark' ? 'dark' : 'light';
    document.body.className = [themeClass, 'bg-main', 'text-text'].join(' '); // Adding classes 'bg-main' and 'text-text' to the body
    localStorage.setItem('theme', currentTheme);
  });

  const toggleTheme = () => {
    setTheme(theme() === 'dark' ? 'light' : 'dark');
  };

  return (
    <button onClick={toggleTheme} class="text-xl cursor-pointer">
      {theme() === 'dark' ? '🌙' : '☀️'} {/* Unicode symbols for dark and light modes */}
    </button>
  );
};

export default ThemeSwitcher;
EOF

echo "\033[32mDone: $goal\033[0m\n"
