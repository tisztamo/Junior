#!/bin/sh
set -e
goal="Move and rename XtermComponent"
echo "Plan:"
echo "1. Create frontend/components/terminal directory."
echo "2. Move XtermComponent.jsx to the new directory and rename it."
echo "3. Update App.jsx to reflect the new component name and path."

# Create the new directory
mkdir -p ./src/frontend/components/terminal/

# Move and rename XtermComponent.jsx to TerminalComponent.jsx
mv ./src/frontend/components/XtermComponent.jsx ./src/frontend/components/terminal/TerminalComponent.jsx

# Update App.jsx to reflect the new component name and path
cat > ./src/frontend/App.jsx << 'EOF'
import { onCleanup } from 'solid-js';
import useKeyBindings from './service/useKeyBindings';
import keyBindings from './config/keyBindings';
import NavBar from './components/NavBar';
import PromptCreation from './components/PromptCreation';
import ChangeExecution from './components/ChangeExecution';
import ChangeInspection from './components/ChangeInspection';
import ChangeFinalization from './components/ChangeFinalization';
import TerminalComponent from './components/terminal/TerminalComponent'; // Updated import path and name

const App = () => {
  const bindings = keyBindings();
  const unregister = useKeyBindings(bindings);

  onCleanup(unregister); 

  return (
    <div class="bg-main min-h-screen max-w-desktop lg:max-w-desktop md:max-w-full sm:max-w-full xs:max-w-full mx-auto flex flex-col items-center space-y-8 px-2 sm:px-4 xs:px-4 pb-8">
      <NavBar />
      <PromptCreation />
      <ChangeExecution />
      <ChangeInspection />
      <ChangeFinalization />
      <TerminalComponent /> {/* Updated component name */}
    </div>
  );
};

export default App;
EOF

echo "\033[32mDone: $goal\033[0m\n"