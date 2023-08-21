#!/bin/sh
set -e
goal="Unregister key event listener on unmount"
echo "Plan:"
echo "1. Modify the App.jsx to utilize SolidJS lifecycle methods."
echo "2. Adjust the useKeyBindings hook to return the unregister function."
echo "3. Use the returned function in App.jsx to unregister the key event listener on component unmount."

# 1. Modify the App.jsx to utilize SolidJS lifecycle methods.
cat > src/frontend/App.jsx << 'EOF'
import { onCleanup } from 'solid-js';
import useKeyBindings from './service/useKeyBindings';
import keyBindings from './config/keyBindings';
import NavBar from './components/NavBar';
import PromptCreation from './components/PromptCreation';
import ChangeExecution from './components/ChangeExecution';
import ChangeInspection from './components/ChangeInspection';
import ChangeFinalization from './components/ChangeFinalization';

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
    </div>
  );
};

export default App;
EOF

# 2. Adjust the useKeyBindings hook to return the unregister function.
# (No changes needed as the current useKeyBindings.js already returns the unregister function)

# 3. Use the returned function in App.jsx to unregister the key event listener on component unmount.
# (Already handled in the modifications to App.jsx)

echo "\033[32mDone: $goal\033[0m\n"