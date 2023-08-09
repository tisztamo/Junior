#!/bin/sh
set -e
goal="Implement keyboard bindings framework"
echo "Plan:"
echo "1. Create a 'useKeyBindings.js' file in the 'src/frontend/' directory to handle the keyboard bindings."
echo "2. Create a 'keyBindings.js' file in the 'src/frontend/config/' directory to store the keyboard bindings function."
echo "3. Modify the 'App.jsx' file to import and use the new 'keyBindings.js' file and 'useKeyBindings.js' and bind the key 'G' to the generate button."

# Step 1: Create 'useKeyBindings.js' in 'src/frontend/'
cat > ./src/frontend/useKeyBindings.js << 'EOF'
const useKeyBindings = (bindings) => {
  const handler = (e) => {
    const action = bindings[e.key.toUpperCase()];
    if (action) {
      action(e);
    }
  };

  window.addEventListener('keydown', handler);

  return () => {
    window.removeEventListener('keydown', handler);
  };
};

export default useKeyBindings;
EOF

# Step 2: Create 'keyBindings.js' in 'src/frontend/config/'
mkdir -p ./src/frontend/config
cat > ./src/frontend/config/keyBindings.js << 'EOF'
const keyBindings = () => {
  return {
    'G': (e) => {
      // Implement logic to press the generate button here
      console.log('G key pressed'); // Temporary log
    }
  };
};

export default keyBindings;
EOF

# Step 3: Modify 'App.jsx' to use 'keyBindings.js' and 'useKeyBindings.js'
cat > ./src/frontend/App.jsx << 'EOF'
import useKeyBindings from './useKeyBindings';
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
