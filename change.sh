#!/bin/sh
set -e
goal="Add bottom padding to App"
echo "Plan:"
echo "1. Modify src/frontend/App.jsx to add bottom padding"

cat > src/frontend/App.jsx << 'EOF'
import useKeyBindings from './service/useKeyBindings';
import keyBindings from './config/keyBindings';
import NavBar from './components/NavBar';
import PromptCreation from './components/PromptCreation';
import ChangeExecution from './components/ChangeExecution';
import ChangeInspection from './components/ChangeInspection';
import ChangeFinalization from './components/ChangeFinalization';

const App = () => {
  const bindings = keyBindings();
  useKeyBindings(bindings);

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

echo "\033[32mDone: $goal\033[0m\n"