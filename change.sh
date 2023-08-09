#!/bin/sh
set -e
goal="Move useKeyBindings to src/frontend/service/"
echo "Plan:"
echo "1. Move the useKeyBindings.js file to the src/frontend/service/ directory."
echo "2. Update the import path of useKeyBindings in the App.jsx file to reflect the new location."

# Move the file useKeyBindings.js to the target directory
mv src/frontend/useKeyBindings.js src/frontend/service/useKeyBindings.js

# Heredoc-ing the App.jsx with the updated import path
cat << 'EOF' > src/frontend/App.jsx
import useKeyBindings from './service/useKeyBindings';
import keyBindings from './config/keyBindings';
import NavBar from './components/NavBar';
import PromptCreation from './components/PromptCreation';
import ChangeExecution from './components/ChangeExecution';
import ChangeInspection from './components/ChangeInspection';
import ChangeFinalization from './components/ChangeFinalization';

const App = () => {
  // Define key bindings
  const bindings = keyBindings();

  // Use key bindings
  useKeyBindings(bindings);

  return (
    <div id="app" class="p-2">
      <div class="max-w-desktop lg:max-w-desktop md:max-w-full sm:max-w-full xs:max-w-full mx-auto flex flex-col items-center space-y-8 sm:p-0">
        <NavBar />
        <PromptCreation />
        <ChangeExecution />
        <ChangeInspection />
        <ChangeFinalization />
      </div>
    </div>
  );
};

export default App;
EOF

echo "\033[32mDone: $goal\033[0m\n"
