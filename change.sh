#!/bin/sh
# Goal: Make the app mobile friendly and add necessary headers to the HTML.
# Plan:
# 1. Configure Tailwind CSS to optimize for mobile by setting up "mobile-first" breakpoints.
# 2. Modify the CSS classes in App.jsx for responsive design.
# 3. Add necessary meta tags in the index.html for viewport control and mobile browser optimizations.

# Step 1: Configure Tailwind CSS for mobile optimization
# Since Tailwind CSS is a mobile-first framework, it's designed to build responsive designs from the smallest device first and then layer on styles for larger screens.
# This allows us to write mobile-optimized styles by default and then add any necessary modifications for larger screens as required.
# In the tailwind.config.js file, we'll add a 'xs' breakpoint to optimize for smaller mobile screens.

cat > tailwind.config.js << 'EOF'
module.exports = {
  content: ['./src/**/*.html', './src/**/*.js', './src/**/*.jsx', './src/**/*.tsx', './src/**/*.ts'],
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
    },
  },
  variants: {
    extend: {},
  },
  plugins: [],
}
EOF

# Step 2: Modify CSS classes in App.jsx for responsive design
# We'll add responsive design CSS classes in App.jsx file so that the components respond well to different screen sizes.

cat > src/frontend/App.jsx << 'EOF'
import NotesInput from './components/NotesInput';
import StartButton from './components/StartButton';
import PromptDisplay from './components/PromptDisplay';
import TasksList from './components/TasksList';
import PromptDescriptor from './components/PromptDescriptor';
import NavBar from './components/NavBar';
import { notes, setNotes } from './stores/notes';
import { setPrompt } from './stores/prompt';

const App = () => {
  return (
    <div class="max-w-desktop lg:max-w-desktop md:max-w-full sm:max-w-full xs:max-w-full mx-auto flex flex-col items-center space-y-8 sm:p-0">
      <NavBar />
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

# Step 3: Add necessary meta tags in index.html
# We'll add the viewport meta tag to control the layout on mobile browsers and make the app more mobile-friendly.
# The initial-scale property controls the zoom level when the page is first loaded. The maximum-scale, minimum-scale, and user-scalable properties control how users are allowed to zoom the page in or out.

cat > src/index.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <title>Junior</title>
</head>
<body>
  <div id="app"></div>
  <script type="module" src="/frontend/index.jsx"></script>
</body>
</html>
EOF

