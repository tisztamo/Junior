#!/bin/sh
set -e
goal="Integrate xterm.js with SolidJS"
echo "Plan:"
echo "1. Create an XtermComponent that uses xterm.js correctly"
echo "2. Import and utilize the XtermComponent in the main App"

# Step 1: Revise XtermComponent to initialize terminal correctly
cat > ./src/frontend/components/XtermComponent.jsx << 'EOF'
import { onCleanup, onMount } from 'solid-js';
import { Terminal } from 'xterm';
import 'xterm/css/xterm.css';

const XtermComponent = () => {
  let container;
  const term = new Terminal();
  
  onMount(() => {
    term.open(container);
  });
  
  // Ensure terminal instance gets destroyed on component cleanup
  onCleanup(() => {
    term.dispose();
  });

  return (
    <div class="rounded border p-4" ref={container}>
      {/* The terminal will be rendered inside this div */}
    </div>
  );
};

export default XtermComponent;
EOF

# Step 2: Integrate XtermComponent into App.jsx
cat > ./src/frontend/App.jsx << 'EOF'
import { onCleanup } from 'solid-js';
import useKeyBindings from './service/useKeyBindings';
import keyBindings from './config/keyBindings';
import NavBar from './components/NavBar';
import PromptCreation from './components/PromptCreation';
import ChangeExecution from './components/ChangeExecution';
import ChangeInspection from './components/ChangeInspection';
import ChangeFinalization from './components/ChangeFinalization';
import XtermComponent from './components/XtermComponent'; // Newly added import

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
      <XtermComponent /> {/* Newly added component */}
    </div>
  );
};

export default App;
EOF

echo "\033[32mDone: $goal\033[0m\n"