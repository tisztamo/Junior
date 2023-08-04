#!/bin/sh
set -e
goal="Setup text and bg colors for dark/light theme"
echo "Plan:"
echo "1. Modify the tailwind.config.cjs to extend the theme for dark and light mode colors."
echo "2. Update App.jsx file to apply the dark and light mode classes."
echo "3. Make sure the styles are applied correctly for both themes."

# Step 1: Modify the tailwind.config.cjs
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
        'desktop': '640px',
      },
      // Extend the colors for dark and light mode
      colors: {
        light: {
          text: '#1a202c',
          background: '#f7fafc',
        },
        dark: {
          text: '#f7fafc',
          background: '#1a202c',
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

# Step 2: Update App.jsx file
cat > src/frontend/App.jsx << 'EOF'
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
    <div id="app" class="m-2 dark:bg-dark-background bg-light-background dark:text-dark-text text-light-text">
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

echo "\033[32mDone: $goal\033[0m\n"
